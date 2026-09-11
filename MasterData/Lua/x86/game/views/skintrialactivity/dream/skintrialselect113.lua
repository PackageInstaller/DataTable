local SkinTrialSelect113 = class("SkinTrialSelect113", (import("game.views.skinTrialActivity.Factory.SkinTrialSelect110")))

function SkinTrialSelect113:UIName()
	return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialUI_" .. self.params_.skinTrialID
end

function SkinTrialSelect113:GetRewardItem()
	return CommonItem
end

function SkinTrialSelect113:GetCommonItem(arg_3_1)
	return arg_3_1
end

function SkinTrialSelect113:IndexItem(arg_4_1, arg_4_2)
	local var_4_0 = self.rewardCfg_[arg_4_1]
	local var_4_1 = self:GetCommonItem(arg_4_2)

	var_4_1:RefreshData(formatReward(self.rewardCfg_[arg_4_1]))
	var_4_1:RegistCallBack(function()
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, var_4_0)
			end
		else
			ShowPopItem(self.popType_, var_4_0)
		end
	end)

	if self.receivedControllerList_[arg_4_1] == nil then
		self.receivedControllerList_[arg_4_1] = ControllerUtil.GetController(var_4_1.transform_, "received")
	end

	if SkinTrialData:IsCompleted(self.skinTrialID_) then
		self.receivedControllerList_[arg_4_1]:SetSelectedState("true")
	end
end

return SkinTrialSelect113
