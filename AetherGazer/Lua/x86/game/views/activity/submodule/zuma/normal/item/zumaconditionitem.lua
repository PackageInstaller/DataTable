local var_0_0 = class("ZumaConditionItem", ReduxView)
local var_0_1 = {
	showState = {
		unFinish = "state0",
		name = "clear",
		finish = "state1"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.showStateController = arg_2_0.controllerEx_:GetController(var_0_1.showState.name)
end

function var_0_0.RefreshConditionState(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ActivityPointRewardCfg[arg_3_1]
	local var_3_1 = var_3_0.need

	arg_3_0.descText_.text = string.format(GetTips("ACTIVITY_ZUMA_LEVEL_TARGET_DESC"), var_3_1)

	if arg_3_0.rewardValueText_ then
		arg_3_0.rewardValueText_.text = var_3_0.reward_item_list[1][2]
	end

	if arg_3_0.imageImg_ then
		arg_3_0.imageImg_.sprite = ItemTools.getItemSprite(var_3_0.reward_item_list[1][1])
	end

	arg_3_0.showStateController:SetSelectedState(arg_3_2 < var_3_1 and var_0_1.showState.unFinish or var_0_1.showState.finish)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
