local var_0_0 = import("game.views.skinTrialActivity.Factory.FactorySkinTrialRewardItem")
local var_0_1 = class("FactorySoloChallengeRewardCommonItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	var_0_1.super.OnCtor(arg_1_0, arg_1_1)
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_1.SetData(arg_2_0, arg_2_1, arg_2_2)
	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.data_ = arg_2_1
	arg_2_0.popType_ = arg_2_2

	arg_2_0.commonItem_:RefreshData(formatReward(arg_2_1))
	arg_2_0.commonItem_:RegistCallBack(function()
		if arg_2_0.clickCallback_ then
			if arg_2_0.clickCallback_() then
				ShowPopItem(arg_2_0.popType_, arg_2_1)
			end
		else
			ShowPopItem(arg_2_0.popType_, arg_2_1)
		end
	end)
	arg_2_0.commonItem_:Show(true)
	arg_2_0:RefreshText()
end

return var_0_1
