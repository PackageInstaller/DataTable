FactorySkinTrialRewardItem = import("game.views.skinTrialActivity.Factory.FactorySkinTrialRewardItem")

local DreamSkinTrialRewardItem = class("DreamSkinTrialRewardItem", ReduxView)

function DreamSkinTrialRewardItem:SetData(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.popType_ = arg_1_2

	self.commonItem_:RefreshData(formatReward(arg_1_1))
	self.commonItem_:RegistCallBack(function()
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, arg_1_1)
			end
		else
			ShowPopItem(self.popType_, arg_1_1)
		end
	end)

	if self.receivedControllerList_ == nil then
		self.receivedControllerList_ = ControllerUtil.GetController(self.commonItem_.transform_, "received")
	end

	if SkinTrialData:IsCompleted(arg_1_3) then
		self.receivedControllerList_:SetSelectedState("true")
	else
		self.receivedControllerList_:SetSelectedState("false")
	end

	self.commonItem_:Show(true)
end

return DreamSkinTrialRewardItem
