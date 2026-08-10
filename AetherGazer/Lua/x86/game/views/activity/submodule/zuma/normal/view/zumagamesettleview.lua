local var_0_0 = class("ZumaGameSettleView", ReduxView)
local var_0_1 = {
	progress = {
		noStar = "noStar",
		name = "Progress",
		star2 = "state3",
		star1 = "state2",
		star0 = "state1",
		star3 = "state4"
	},
	state = {
		lose = "state0",
		name = "state",
		win = "state1"
	},
	gameState = {
		haveReward = "state0",
		name = "default",
		noReward = "state2"
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaResultPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnTop(arg_3_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.progressController = arg_5_0.controllerexcollection_:GetController(var_0_1.progress.name)
	arg_5_0.stateController = arg_5_0.controllerexcollection_:GetController(var_0_1.state.name)
	arg_5_0.gameStateController = arg_5_0.controllerexcollection_:GetController(var_0_1.gameState.name)
	arg_5_0.iconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.confirmbtnBtn_, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0.params_.isWin or false
	local var_10_1 = var_10_0 and var_0_1.state.win or var_0_1.state.lose

	arg_10_0.stateController:SetSelectedState(var_10_1)

	local var_10_2 = ZumaData:GetZumaScore()

	arg_10_0.scoreTxt_.text = var_10_2

	if var_10_0 then
		arg_10_0:RefreshWinUi()
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	else
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end

	local var_10_3 = ZumaData:GetZumaGameId()
	local var_10_4 = ActivityZumaLevelCfg[var_10_3]
	local var_10_5 = ZumaToLuaBridge.GetZumaGamePlayTime()

	ZumaAction.QueryZumaCompelet(var_10_4.main_activity_id, var_10_3, var_10_0 and 1 or 2, var_10_2, var_10_5)
end

function var_0_0.RefreshWinUi(arg_11_0)
	local var_11_0 = ZumaData:GetZumaScore()
	local var_11_1 = ZumaData:GetZumaGameId()
	local var_11_2 = ActivityZumaLevelCfg[var_11_1]
	local var_11_3 = var_11_2.activity_point_reward
	local var_11_4, var_11_5 = ZumaData:GetZumaFinishPointList(var_11_0, var_11_3)
	local var_11_6 = #var_11_4
	local var_11_7 = ZumaData:GetZumaStageScore(var_11_1)
	local var_11_8, var_11_9 = ZumaData:GetZumaFinishPointList(var_11_7 or 0, var_11_3)
	local var_11_10 = math.max(var_11_5 - var_11_9, 0)

	if var_11_2.difficult == 3 then
		arg_11_0.progressController:SetSelectedState(var_0_1.progress.noStar)
	elseif var_11_6 == 0 then
		arg_11_0.progressController:SetSelectedState(var_0_1.progress.star0)
	elseif var_11_6 == 1 then
		arg_11_0.progressController:SetSelectedState(var_0_1.progress.star1)
	elseif var_11_6 == 2 then
		arg_11_0.progressController:SetSelectedState(var_0_1.progress.star2)
	elseif var_11_6 == 3 then
		arg_11_0.progressController:SetSelectedState(var_0_1.progress.star3)
	end

	local var_11_11 = 0

	if var_11_7 == nil then
		var_11_11 = var_11_2.first_reward + var_11_10
	else
		var_11_11 = var_11_2.repeat_reward + var_11_10
	end

	if var_11_11 ~= 0 then
		arg_11_0.gameStateController:SetSelectedState(var_0_1.gameState.haveReward)
	else
		arg_11_0.gameStateController:SetSelectedState(var_0_1.gameState.noReward)
	end

	arg_11_0.rewardNumsTxt_.text = var_11_11
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
