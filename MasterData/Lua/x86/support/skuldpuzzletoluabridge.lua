return {
	UpdatePuzzleConditionData = function(arg_1_0, arg_1_1)
		manager.notify:Invoke(SKULD_PUZZLE_CONDITION_UPDATE, arg_1_0, arg_1_1)
	end,
	InitPuzzleStageMapData = function(arg_2_0, arg_2_1, arg_2_2)
		manager.notify:Invoke(SKULD_PUZZLE_INIT_PUZZLE_STAGE, arg_2_0, arg_2_1, arg_2_2)
	end
}
