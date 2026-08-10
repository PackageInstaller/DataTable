local var_0_0 = import("game.views.skinTrialActivity.Factory.SkinTrialSelect110")
local var_0_1 = class("SkinTrialSelect113", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialUI_" .. arg_1_0.params_.skinTrialID
end

function var_0_1.GetRewardItem(arg_2_0)
	return CommonItem
end

function var_0_1.GetCommonItem(arg_3_0, arg_3_1)
	return arg_3_1
end

function var_0_1.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.rewardCfg_[arg_4_1]
	local var_4_1 = arg_4_0:GetCommonItem(arg_4_2)

	var_4_1:RefreshData(formatReward(var_4_0))
	var_4_1:RegistCallBack(function()
		if arg_4_0.clickCallback_ then
			if arg_4_0.clickCallback_() then
				ShowPopItem(arg_4_0.popType_, var_4_0)
			end
		else
			ShowPopItem(arg_4_0.popType_, var_4_0)
		end
	end)

	if arg_4_0.receivedControllerList_[arg_4_1] == nil then
		arg_4_0.receivedControllerList_[arg_4_1] = ControllerUtil.GetController(var_4_1.transform_, "received")
	end

	if SkinTrialData:IsCompleted(arg_4_0.skinTrialID_) then
		arg_4_0.receivedControllerList_[arg_4_1]:SetSelectedState("true")
	end
end

return var_0_1
