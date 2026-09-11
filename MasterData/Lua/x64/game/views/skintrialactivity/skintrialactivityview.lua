local SkinTrialActivityView = class("SkinTrialActivityView", ReduxView)

function SkinTrialActivityView:UIName()
	return "UI/OsirisUI/OsirisSkinTrialMainUI"
end

function SkinTrialActivityView:UIParent()
	return manager.ui.uiMain.transform
end

function SkinTrialActivityView:Init()
	self:BindCfgUI()

	self.skinItemList_ = {}
end

function SkinTrialActivityView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = self.params_.activityID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
	self:AddTimer()
end

function SkinTrialActivityView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function SkinTrialActivityView:Dispose()
	SkinTrialActivityView.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.skinItemList_) do
		iter_6_1:Dispose()
	end

	self.skinItemList_ = nil
end

function SkinTrialActivityView:RefreshUI()
	self.skinTrialIDList_ = self:GetskinTrialIDList()

	self:RefreshSkinItem()
end

function SkinTrialActivityView:RefreshSkinItem()
	for iter_8_0, iter_8_1 in ipairs(self.skinTrialIDList_) do
		if self.skinItemList_[iter_8_0] then
			self.skinItemList_[iter_8_0]:SetSkinTrialID(iter_8_1)
		else
			self.skinItemList_[iter_8_0] = self:GetItemClass().New(self.skinItem_, self.skinItemPanel_, iter_8_1, self.activityID_)
		end
	end

	for iter_8_2 = #self.skinItemList_, #self.skinTrialIDList_ + 1, -1 do
		self.skinItemList_[iter_8_2]:Dispose()

		self.skinItemList_[iter_8_2] = nil
	end
end

function SkinTrialActivityView:GetskinTrialIDList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(ActivityData:GetActivityData(self.activityID_).subActivityIdList) do
		for iter_9_2, iter_9_3 in ipairs(ActivitySkinTrialCfg.get_id_list_by_activity_id[iter_9_1]) do
			table.insert(var_9_0, iter_9_3)
		end
	end

	return var_9_0
end

function SkinTrialActivityView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	for iter_10_0, iter_10_1 in ipairs(self.skinTrialIDList_) do
		if self.skinItemList_[iter_10_0] and self.skinItemList_[iter_10_0].RefreshTime ~= nil then
			self.skinItemList_[iter_10_0]:RefreshTime()
		end
	end

	self.textTime_.text = string.format(GetTips("LEFT_TIME"), GetI18NText(manager.time:GetLostTimeStr(self.stopTime_)))
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		for iter_11_0, iter_11_1 in ipairs(self.skinTrialIDList_) do
			if self.skinItemList_[iter_11_0] and self.skinItemList_[iter_11_0].RefreshTime ~= nil then
				self.skinItemList_[iter_11_0]:RefreshTime()
			end
		end

		self.textTime_.text = string.format(GetTips("LEFT_TIME"), GetI18NText(manager.time:GetLostTimeStr(self.stopTime_)))
	end, 1, -1)

	self.timer_:Start()
end

function SkinTrialActivityView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkinTrialActivityView:GetItemClass()
	return SkinTrialActivityItem
end

return SkinTrialActivityView
