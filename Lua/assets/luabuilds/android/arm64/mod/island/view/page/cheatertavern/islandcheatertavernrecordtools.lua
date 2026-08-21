local var_0_0 = {}

;({}).LOST = 0
;({}).WIN = 1
;({}).LEAVE = 2
;({}).StartGame = function()
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildCheaterTavernGame(0, 0))

	var_0_0.startTime = pg.TimeMgr.GetInstance():GetServerTime()
	var_0_0.scoreBefore = PlayRoomTools.GetPtScrore(PlayRoomTools.GetGameTypeID())
	var_0_0.turnCnt = 0
	var_0_0.roundCnt = 0
	var_0_0.duration = 0

	return
end
;({}).StopPlayTime = function()
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildCheaterTavernGame(1, pg.TimeMgr.GetInstance():GetServerTime() - var_0_0.startTime))

	return
end
;({}).RecordResult = function(arg_3_0)
	var_0_0.StopPlayTime()
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildCheaterTavernResult(arg_3_0, var_0_0.scoreBefore, PlayRoomTools.GetPtScrore(PlayRoomTools.GetGameTypeID()), var_0_0.turnCnt, var_0_0.roundCnt, var_0_0.duration))

	return
end
;({}).AddTurnCnt = function()
	var_0_0.turnCnt = var_0_0.turnCnt + 1

	return
end
;({}).AddRoundCnt = function()
	var_0_0.roundCnt = var_0_0.roundCnt + 1

	return
end
;({}).StartPutCardTime = function()
	var_0_0.putCardTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end
;({}).StopPutCardTime = function()
	var_0_0.duration = var_0_0.duration + (pg.TimeMgr.GetInstance():GetServerTime() - var_0_0.putCardTime)

	return
end

return {}
