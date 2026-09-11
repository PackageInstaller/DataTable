function StartTangramGameStage(arg_1_0)
	return
end

function FinishTangramGame()
	manager.notify:Invoke(TANGRAM_GAME_FINISH_STAGE)
end

function FinishTangramGameChip(arg_3_0)
	manager.notify:Invoke(TANGRAM_GAME_FINISH_CHIP, arg_3_0)
end
