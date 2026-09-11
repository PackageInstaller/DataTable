function InitWaterPipeEventList(arg_1_0)
	manager.notify:Invoke(WATER_PIPE_EVENT_INIT, arg_1_0)
end

function UpdateWaterPipeEventLinkData(arg_2_0)
	manager.notify:Invoke(WATER_PIPE_EVENT_UPDATE, arg_2_0)
end

function BeginWaterPipePerformance()
	manager.notify:Invoke(WATER_PIPE_GAME_PERFORMANCE)
end

function FinishWaterPipeGame()
	manager.notify:Invoke(WATER_PIPE_GAME_SETTLE)
end

function GetWaterPipeEventSortList(arg_5_0)
	return ActivityWaterPipeStageCfg[arg_5_0].event_sort
end
