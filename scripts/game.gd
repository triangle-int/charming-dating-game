extends Node

@export var levels: Array[PackedScene]

var current_level: Level = null
var current_index: int = -1

@onready var radiuses = $Rings

# For debugging
func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		if ComponentsSignals.is_simulating:
			ComponentsSignals.stop_simulation()
		else:
			ComponentsSignals.start_simulation()

	if event.is_action_released("ui_focus_next"):
		load_level((current_index + 1) % len(levels))

func load_level(index: int):
	ComponentsSignals.stop_simulation()
	ComponentsSignals.detach_all_components()

	if current_level != null:
		current_level.queue_free()
	
	current_index = index
	current_level = levels[index].instantiate() as Level
	add_child(current_level)
	current_level.start_level(radiuses)