local var_0_0 = class("HanafudaGameOverPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaWinUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.wincontroller_ = ControllerUtil.GetController(arg_4_0.transform_, "result")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.callback_ = arg_8_0.params_.callback
	arg_8_0.playerScore = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
	arg_8_0.enemyScore = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = KagutsuchiWorkData:GetStamina()
	local var_9_1 = math.min(GameSetting.activity_kagutsuchi_fatigue_hanafuda_card_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - var_9_0)
	local var_9_2 = math.max(0, var_9_1)

	arg_9_0.rewardText_.text = var_9_2
	arg_9_0.currencyImg_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
	arg_9_0.playerScoreText_.text = arg_9_0.playerScore
	arg_9_0.enemyScoreText_.text = arg_9_0.enemyScore

	if arg_9_0.playerScore >= arg_9_0.enemyScore then
		SDKTools.SendMessageToSDK("activity_kagutsuchi_hanafuda_card", {
			result = 1,
			reach_group_id = table.toString(HanafudaData:GetPlayerCombineIDList()),
			activity_id = HanafudaData:GetActivityID()
		})
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_win", "")
		arg_9_0.wincontroller_:SetSelectedState("win")
	elseif arg_9_0.playerScore < arg_9_0.enemyScore then
		SDKTools.SendMessageToSDK("activity_kagutsuchi_hanafuda_card", {
			result = 2,
			reach_group_id = table.toString(HanafudaData:GetPlayerCombineIDList()),
			activity_id = HanafudaData:GetActivityID()
		})
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_fail", "")
		arg_9_0.wincontroller_:SetSelectedState("lose")
	end
end

function var_0_0.OnExit(arg_10_0)
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	arg_10_0.callback_()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
