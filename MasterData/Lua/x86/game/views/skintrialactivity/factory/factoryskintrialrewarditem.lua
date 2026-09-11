local FactorySkinTrialRewardItem = class("FactorySkinTrialRewardItem", ReduxView)

function FactorySkinTrialRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FactorySkinTrialRewardItem:Init()
	self:BindCfgUI()

	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function FactorySkinTrialRewardItem:GetCommonItem()
	return self.commonItem_
end

function FactorySkinTrialRewardItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.data_ = arg_4_1
	self.popType_ = arg_4_2

	self.commonItem_:RefreshData(formatReward(arg_4_1))
	self.commonItem_:RegistCallBack(function()
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, arg_4_1)
			end
		else
			ShowPopItem(self.popType_, arg_4_1)
		end
	end)

	if self.receivedControllerList_ == nil then
		self.receivedControllerList_ = ControllerUtil.GetController(self.commonItem_.transform_, "received")
	end

	if SkinTrialData:IsCompleted(arg_4_3) then
		self.receivedControllerList_:SetSelectedState("true")
	else
		self.receivedControllerList_:SetSelectedState("false")
	end

	self.commonItem_:Show(true)
	self:RefreshText()
end

function FactorySkinTrialRewardItem:RefreshText()
	self.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	self.commonItem_:HideNum()

	self.num_.text = self.data_[2]
end

return FactorySkinTrialRewardItem
