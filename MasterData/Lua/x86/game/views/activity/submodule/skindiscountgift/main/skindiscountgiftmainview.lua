local SkinDiscountGiftMainView = class("SkinDiscountGiftMainView", ReduxView)

function SkinDiscountGiftMainView:UIName()
	return "Widget/System/Recharge/RechargeSkinEventUI"
end

function SkinDiscountGiftMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SkinDiscountGiftMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.signController_ = self.signControllerEx_:GetController("state")
	self.signItemList_ = {}
	self.discountItemList_ = {}
end

function SkinDiscountGiftMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SKIN_DISCOUNT_GIFT_DESC")

	self.activityID_ = self.params_.activityID
	self.signActivityID_ = SkinDiscountGiftTools.GetSignActivityID(self.activityID_)

	self:RefreshSignItemList()
	self:RefreshDiscountItemList()
	self:AutoGetReward()
	SkinDiscountGiftAction.ClearRedPointNewTag(self.activityID_)
	self:AddTimer()
end

function SkinDiscountGiftMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function SkinDiscountGiftMainView:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.signItemList_) do
		iter_6_1:Dispose()
	end

	self.signItemList_ = nil

	for iter_6_2, iter_6_3 in ipairs(self.discountItemList_) do
		iter_6_3:Dispose()
	end

	self.discountItemList_ = nil

	SkinDiscountGiftMainView.super.Dispose(self)
end

function SkinDiscountGiftMainView:AddListeners()
	return
end

function SkinDiscountGiftMainView:RefreshSignItemList()
	local var_8_0 = 1

	for iter_8_0, iter_8_1 in ipairs(ActivityCumulativeSignCfg[self.signActivityID_].config_list) do
		self.signItemList_[iter_8_0] = self.signItemList_[iter_8_0] or SkinDiscountGiftMainSignItem.New(self[string.format("signRewardGo%s_", iter_8_0)])

		self.signItemList_[iter_8_0]:SetData(self.signActivityID_, iter_8_0, iter_8_1)

		if SkinDiscountGiftTools.GetSignState(self.signActivityID_, iter_8_0) ~= ActivityConst.SIGN_STATE.NONE then
			var_8_0 = iter_8_0
		end
	end

	self.signController_:SetSelectedState(string.format("state%s", var_8_0 - 1))
end

function SkinDiscountGiftMainView:RefreshDiscountItemList()
	for iter_9_0, iter_9_1 in ipairs(ActivitySkinDiscountCfg.get_id_list_by_activity_id[self.activityID_]) do
		self.discountItemList_[iter_9_0] = self.discountItemList_[iter_9_0] or SkinDiscountGiftMainItem.New(self[string.format("discountGo%s_", iter_9_0)])

		self.discountItemList_[iter_9_0]:SetData(iter_9_1)
	end
end

function SkinDiscountGiftMainView:AutoGetReward()
	self.signIndex_ = SignTools.GetSevenDaySignIndex(self.signActivityID_)
end

function SkinDiscountGiftMainView:OnSign(arg_11_1)
	if isSuccess(arg_11_1.result) then
		if self.signIndex_ <= 0 then
			return
		end

		getReward2(arg_11_1.item_list)
		self:RefreshSignItemList()
	end
end

function SkinDiscountGiftMainView:AddTimer()
	self:StopTimer()

	local var_12_0 = ActivityData:GetActivityData(self.activityID_).stopTime

	self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_12_0)
	self.timer_ = Timer.New(function()
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_12_0)
	end, 1, -1)

	self.timer_:Start()
end

function SkinDiscountGiftMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SkinDiscountGiftMainView
