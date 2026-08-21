local var_0_0 = class("IslandSeekGameView", import("Mod.Island.Core.View.IslandView"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.state = var_0_1

	arg_1_0:Op("NotifiyIsland", ISLAND_EX_EVT.SEEK_GAME_START)

	return
end

function var_0_0.OnSceneInited(arg_2_0)
	arg_2_0:InitFocusCamera()
	arg_2_0:DisableOp()

	local var_2_0 = arg_2_0:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID)

	arg_2_0.resultView = IslandSeekGameResultView.New(arg_2_0, var_2_0.data:GetResultUIName())

	var_2_0:OnSceneInitEnd()

	arg_2_0.isInit = true

	arg_2_0:OnGameStart()

	return
end

function var_0_0.AddListeners(arg_3_0)
	var_0_0.super.AddListeners(arg_3_0)
	arg_3_0:AddListener(ISLAND_EVT.SEEK_GAME_FAILED, arg_3_0.OnGameFailed)
	arg_3_0:AddListener(ISLAND_EVT.SEEK_GAME_SUCCESS, arg_3_0.OnGameSuccess)

	return
end

function var_0_0.RemoveListeners(arg_4_0)
	var_0_0.super.RemoveListeners(arg_4_0)
	arg_4_0:RemoveListener(ISLAND_EVT.SEEK_GAME_FAILED, arg_4_0.OnGameFailed)
	arg_4_0:RemoveListener(ISLAND_EVT.SEEK_GAME_SUCCESS, arg_4_0.OnGameSuccess)

	return
end

function var_0_0.OnGameStart(arg_5_0)
	if arg_5_0.state ~= var_0_1 then
		return
	end

	arg_5_0.state = var_0_2

	IslandCameraMgr.instance:LookAt(arg_5_0.player._tf)
	arg_5_0:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):StartGame()
	arg_5_0:EnableOp()

	return
end

function var_0_0.OnGameFailed(arg_6_0)
	if arg_6_0.state ~= var_0_2 then
		return
	end

	arg_6_0.state = var_0_3

	arg_6_0:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):StopGame()
	arg_6_0:DisableOp()
	arg_6_0.resultView:Execute("Show")

	return
end

function var_0_0.OnGameSuccess(arg_7_0)
	if arg_7_0.state ~= var_0_2 then
		return
	end

	arg_7_0.state = var_0_4

	arg_7_0:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):StopGame()

	return
end

function var_0_0.RestartGame(arg_8_0)
	if arg_8_0.state ~= var_0_3 then
		return
	end

	arg_8_0.state = var_0_2

	arg_8_0:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):RestartGame()
	arg_8_0.player:ResetPosition()
	arg_8_0:EnableOp()

	return
end

function var_0_0.OnEndPerformance(arg_9_0)
	var_0_0.super.OnEndPerformance(arg_9_0)
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_30")

	return
end

function var_0_0.DisableOp(arg_10_0)
	arg_10_0.player:StopMoveHandle()
	arg_10_0:GetSubView(IslandOpView):TryDisablePlayerOp()
	arg_10_0:GetSubView(IslandInteractionView):DisableInteraction()
	arg_10_0:GetSubView(IslandOpView):TryDisable()

	return
end

function var_0_0.EnableOp(arg_11_0)
	arg_11_0:GetSubView(IslandOpView):TryEnablePlayerOp()
	arg_11_0:GetSubView(IslandInteractionView):EnableInteraction()
	arg_11_0:GetSubView(IslandOpView):TryEnable()

	return
end

function var_0_0.OnDispose(arg_12_0)
	arg_12_0:Op("NotifiyIsland", ISLAND_EX_EVT.SEEK_GAME_END)
	var_0_0.super.OnDispose(arg_12_0)

	if arg_12_0.resultView then
		arg_12_0.resultView:Dispose()

		arg_12_0.resultView = nil
	end

	return
end

return var_0_0
