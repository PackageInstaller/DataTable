local FactorySoloChallengeRewardCommonItem = class("FactorySoloChallengeRewardCommonItem", (import("game.views.skinTrialActivity.Factory.FactorySkinTrialRewardItem")))

function FactorySoloChallengeRewardCommonItem:OnCtor(arg_1_1)
	FactorySoloChallengeRewardCommonItem.super.OnCtor(self, arg_1_1)
	SetActive(self.gameObject_, true)
end

function FactorySoloChallengeRewardCommonItem:SetData(arg_2_1, arg_2_2)
	SetActive(self.gameObject_, true)

	self.data_ = arg_2_1
	self.popType_ = arg_2_2

	self.commonItem_:RefreshData(formatReward(arg_2_1))
	self.commonItem_:RegistCallBack(function()
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, arg_2_1)
			end
		else
			ShowPopItem(self.popType_, arg_2_1)
		end
	end)
	self.commonItem_:Show(true)
	self:RefreshText()
end

return FactorySoloChallengeRewardCommonItem
