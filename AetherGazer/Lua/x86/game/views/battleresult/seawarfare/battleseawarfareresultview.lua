local var_0_0 = class("BattleSeaWarfareResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NabigationBattleResult"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.resultController_ = arg_4_0.controllerEx_:GetController("battleResult")
	arg_4_0.stageTypeController_ = arg_4_0.controllerEx_:GetController("stageType")
	arg_4_0.successText_.text = GetTips("SUCCESS")
	arg_4_0.failText_.text = GetTips("FAIL")
	arg_4_0.reChallengeBtnText_.text = GetTips("CHALLENGE_AGAIN")
	arg_4_0.comfirmBtnText_.text = GetTips("ROGUE_TEAM_BUTTON_CONFIRM")
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		BattleInstance.QuitBattle(arg_5_0.params_.stageData, not arg_5_0.isSuccess_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.onceMoreBtn_, nil, function()
		BattleInstance.OnceMoreBattle(arg_5_0.params_.stageData)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.stageData_ = arg_8_0.params_.stageData
	arg_8_0.isSuccess_ = arg_8_0.params_.isSuccess

	arg_8_0:RefreshUI()
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0.anim_:Play("UI_Tag1_loop 1", -1, 0)
	arg_9_0.anim_:Update(0)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0.stageData_:GetStageId()

	arg_10_0.stageTitle_.text = BattleSeaWarfareStageCfg[var_10_0].name

	arg_10_0.resultController_:SetSelectedState(arg_10_0.isSuccess_ == true and "win" or "lose")

	arg_10_0.resultText_.text = GetTips(arg_10_0.isSuccess_ == true and "CHALLENGE_SUCCESS" or "CHALLENGE_FAIL")

	arg_10_0:RefreshStageType()
	arg_10_0:RefreshPopReward()
end

function var_0_0.RefreshStageType(arg_11_0)
	arg_11_0.seaWarfareStageID_ = arg_11_0.stageData_:GetDest()

	if SeaWarfareStageCfg[arg_11_0.seaWarfareStageID_].type == SeaWarfareConst.STAGE_TYPE.NORMAL then
		arg_11_0.stageTypeController_:SetSelectedState("normal")
	else
		arg_11_0.stageTypeController_:SetSelectedState("challenge")
	end
end

function var_0_0.RefreshPopReward(arg_12_0)
	local var_12_0 = SeaWarfareTools.GetNeedPopFirstRewardStageID()

	if var_12_0 then
		SeaWarfareTools.SetNeedPopFirstRewardStageID(nil)

		local var_12_1 = SeaWarfareStageCfg[var_12_0].reward
		local var_12_2 = getRewardFromDropCfg(var_12_1, true)

		showRewardUI(var_12_2)
	end
end

return var_0_0
