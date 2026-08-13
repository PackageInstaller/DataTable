class = var_0_10000

local var_0_0 = "IslandSeekGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandView"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.state = var_0_2

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.Op
	local var_1_2 = "NotifiyIsland"

	ISLAND_EX_EVT = var_1_10005

	var_1_1(var_1_0, var_1_2, var_1_10005.SEEK_GAME_START)

	return
end

function var_0_1.OnSceneInited(arg_2_0)
	arg_2_0:InitFocusCamera()
	arg_2_0:DisableOp()

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetSystemModule

	IslandConst = var_1_10004

	local var_2_2 = var_2_1(var_2_0, var_1_10004.SEEK_GAME_SYSTEM_ID)

	IslandSeekGameResultView = var_1_10002

	local var_2_3 = var_1_10002.New
	local var_2_4 = arg_2_0
	local var_2_5 = var_2_2.data

	arg_2_0.resultView = var_2_3(var_2_4, var_5.GetResultUIName(var_2_5))

	var_2_2:OnSceneInitEnd()

	arg_2_0.isInit = true

	arg_2_0:OnGameStart()

	return
end

function var_0_1.AddListeners(arg_3_0)
	var_0_1.super.AddListeners(arg_3_0)

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.AddListener

	ISLAND_EVT = var_1_10004

	var_3_1(var_3_0, var_1_10004.SEEK_GAME_FAILED, arg_3_0.OnGameFailed)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.AddListener

	ISLAND_EVT = var_4

	var_3_3(var_3_2, var_4.SEEK_GAME_SUCCESS, arg_3_0.OnGameSuccess)

	return
end

function var_0_1.RemoveListeners(arg_4_0)
	var_0_1.super.RemoveListeners(arg_4_0)

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.RemoveListener

	ISLAND_EVT = var_1_10004

	var_4_1(var_4_0, var_1_10004.SEEK_GAME_FAILED, arg_4_0.OnGameFailed)

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.RemoveListener

	ISLAND_EVT = var_4

	var_4_3(var_4_2, var_4.SEEK_GAME_SUCCESS, arg_4_0.OnGameSuccess)

	return
end

function var_0_1.OnGameStart(arg_5_0)
	if arg_5_0.state ~= var_0_2 then
		return
	end

	arg_5_0.state = var_0_3
	IslandCameraMgr = var_1

	local var_5_0 = var_1.instance

	var_1.LookAt(var_5_0, arg_5_0.player._tf)

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.GetSystemModule

	IslandConst = var_4

	local var_5_3 = var_5_2(var_5_1, var_4.SEEK_GAME_SYSTEM_ID)

	var_1.StartGame(var_5_3)
	arg_5_0:EnableOp()

	return
end

function var_0_1.OnGameFailed(arg_6_0)
	if arg_6_0.state ~= var_0_3 then
		return
	end

	arg_6_0.state = var_0_4

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetSystemModule

	IslandConst = var_1_10004

	local var_6_2 = var_6_1(var_6_0, var_1_10004.SEEK_GAME_SYSTEM_ID)

	var_1.StopGame(var_6_2)
	arg_6_0:DisableOp()

	local var_6_3 = arg_6_0.resultView

	var_2.Execute(var_6_3, "Show")

	return
end

function var_0_1.OnGameSuccess(arg_7_0)
	if arg_7_0.state ~= var_0_3 then
		return
	end

	arg_7_0.state = var_0_5

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.GetSystemModule

	IslandConst = var_1_10004

	local var_7_2 = var_7_1(var_7_0, var_1_10004.SEEK_GAME_SYSTEM_ID)

	var_1.StopGame(var_7_2)

	return
end

function var_0_1.RestartGame(arg_8_0)
	if arg_8_0.state ~= var_0_4 then
		return
	end

	arg_8_0.state = var_0_3

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GetSystemModule

	IslandConst = var_1_10004

	local var_8_2 = var_8_1(var_8_0, var_1_10004.SEEK_GAME_SYSTEM_ID)

	var_1.RestartGame(var_8_2)

	local var_8_3 = arg_8_0.player

	var_2.ResetPosition(var_8_3)
	arg_8_0:EnableOp()

	return
end

function var_0_1.OnEndPerformance(arg_9_0)
	var_0_1.super.OnEndPerformance(arg_9_0)

	IslandGuideChecker = var_1

	var_1.CheckGuide("ISLAND_GUIDE_30")

	return
end

function var_0_1.DisableOp(arg_10_0)
	local var_10_0 = arg_10_0.player

	var_1.StopMoveHandle(var_10_0)

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.GetSubView

	IslandOpView = var_1_10004

	local var_10_3 = var_10_2(var_10_1, var_1_10004)

	var_1.TryDisablePlayerOp(var_10_3)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.GetSubView

	IslandInteractionView = var_1_10004

	local var_10_6 = var_10_5(var_10_4, var_1_10004)

	var_1.DisableInteraction(var_10_6)

	local var_10_7 = arg_10_0
	local var_10_8 = arg_10_0.GetSubView

	IslandOpView = var_1_10004

	local var_10_9 = var_10_8(var_10_7, var_1_10004)

	var_1.TryDisable(var_10_9)

	return
end

function var_0_1.EnableOp(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.GetSubView

	IslandOpView = var_1_10004

	local var_11_2 = var_11_1(var_11_0, var_1_10004)

	var_1.TryEnablePlayerOp(var_11_2)

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.GetSubView

	IslandInteractionView = var_1_10004

	local var_11_5 = var_11_4(var_11_3, var_1_10004)

	var_1.EnableInteraction(var_11_5)

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.GetSubView

	IslandOpView = var_1_10004

	local var_11_8 = var_11_7(var_11_6, var_1_10004)

	var_1.TryEnable(var_11_8)

	return
end

function var_0_1.OnDispose(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.Op
	local var_12_2 = "NotifiyIsland"

	ISLAND_EX_EVT = var_1_10005

	var_12_1(var_12_0, var_12_2, var_1_10005.SEEK_GAME_END)
	var_0_1.super.OnDispose(arg_12_0)

	if arg_12_0.resultView then
		local var_12_3 = arg_12_0.resultView

		var_1.Dispose(var_12_3)

		arg_12_0.resultView = nil
	end

	return
end

return var_0_1
