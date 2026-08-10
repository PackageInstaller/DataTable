local var_0_0 = class("OperationRushPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationRushPopUI"
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
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.chapterID_ = arg_5_0.params_.chapterID
	arg_5_0.stageID_ = arg_5_0.params_.stageID
	arg_5_0.stageType_ = arg_5_0.params_.stageType
	arg_5_0.multiple_ = arg_5_0.params_.multiple
	arg_5_0.activityID_ = arg_5_0.params_.activityID

	local var_5_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

	arg_5_0.curDunDunText_.text = var_5_0

	local var_5_1

	if arg_5_0.params_.cost then
		var_5_1 = arg_5_0.params_.cost
	else
		var_5_1 = BattleStageTools.GetStageCfg(arg_5_0.stageType_, arg_5_0.stageID_).cost
	end

	local var_5_2 = var_5_1 * arg_5_0.multiple_

	arg_5_0.nextDunDunText_.text = var_5_0 - var_5_2
	arg_5_0.multipleText_.text = string.format(GetTips("QUICK_BATTLE_TIPS1"), var_5_2, arg_5_0.multiple_)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.yesBtn_, nil, function()
		BattleStageAction.OperationRush(arg_6_0.chapterID_, arg_6_0.stageID_, arg_6_0.stageType_, arg_6_0.multiple_, arg_6_0.activityID_, function()
			JumpTools.Back()
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.noBtn_, nil, function()
		arg_6_0:Back()
	end)
end

return var_0_0
