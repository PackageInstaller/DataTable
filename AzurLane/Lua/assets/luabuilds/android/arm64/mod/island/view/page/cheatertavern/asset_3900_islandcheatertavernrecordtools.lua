local var_0_0 = {}

var_0_0.LOST = 0
var_0_0.WIN = 1
var_0_0.LEAVE = 2

function var_0_0.StartGame()
	pg = var_1_10000

	local var_1_0 = var_1_10000.GameTrackerMgr.GetInstance()
	local var_1_1 = var_0.Record

	GameTrackerBuilder = var_1_10003

	var_1_1(var_1_0, var_1_10003.BuildCheaterTavernGame(0, 0))

	local var_1_2 = var_0_0

	pg = var_1_10001

	local var_1_3 = var_1_10001.TimeMgr.GetInstance()

	var_1_2.startTime = var_1.GetServerTime(var_1_3)

	local var_1_4 = var_0_0

	PlayRoomTools = var_1

	local var_1_5 = var_1.GetPtScrore

	PlayRoomTools = var_1_3
	var_1_4.scoreBefore = var_1_5(var_1_3.GetGameTypeID())
	var_0_0.turnCnt = 0
	var_0_0.roundCnt = 0
	var_0_0.duration = 0

	return
end

function var_0_0.StopPlayTime()
	pg = var_1_10000

	local var_2_0 = var_1_10000.TimeMgr.GetInstance()
	local var_2_1 = var_0.GetServerTime(var_2_0) - var_0_0.startTime

	pg = var_1

	local var_2_2 = var_1.GameTrackerMgr.GetInstance()
	local var_2_3 = var_1.Record

	GameTrackerBuilder = var_1_10004

	var_2_3(var_2_2, var_1_10004.BuildCheaterTavernGame(1, var_2_1))

	return
end

function var_0_0.RecordResult(arg_3_0)
	var_0_0.StopPlayTime()

	PlayRoomTools = var_1

	local var_3_0 = var_1.GetPtScrore

	PlayRoomTools = var_1_10003

	local var_3_1 = var_3_0(var_1_10003.GetGameTypeID())

	pg = var_1_10002

	local var_3_2 = var_1_10002.GameTrackerMgr.GetInstance()
	local var_3_3 = var_2.Record

	GameTrackerBuilder = var_1_10005

	var_3_3(var_3_2, var_1_10005.BuildCheaterTavernResult(arg_3_0, var_0_0.scoreBefore, var_3_1, var_0_0.turnCnt, var_0_0.roundCnt, var_0_0.duration))

	return
end

function var_0_0.AddTurnCnt()
	var_0_0.turnCnt = var_0_0.turnCnt + 1

	return
end

function var_0_0.AddRoundCnt()
	var_0_0.roundCnt = var_0_0.roundCnt + 1

	return
end

function var_0_0.StartPutCardTime()
	local var_6_0 = var_0_0

	pg = var_1_10001

	local var_6_1 = var_1_10001.TimeMgr.GetInstance()

	var_6_0.putCardTime = var_1.GetServerTime(var_6_1)

	return
end

function var_0_0.StopPutCardTime()
	local var_7_0 = var_0_0
	local var_7_1 = var_0_0.duration

	pg = var_1_10002

	local var_7_2 = var_1_10002.TimeMgr.GetInstance()

	var_7_0.duration = var_7_1 + (var_2.GetServerTime(var_7_2) - var_0_0.putCardTime)

	return
end

return var_0_0
