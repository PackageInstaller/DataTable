local ActivityMainToggleItem = class("ActivityMainToggleItem", ReduxView)

function ActivityMainToggleItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.toggleID_ = arg_1_3
	self.activityID_ = arg_1_4
	self.redPointActivityID_ = arg_1_5 or arg_1_4

	self:BindCfgUI()
	self:AddListeners()

	if self.itemCon_ then
		self.controller_ = self.itemCon_:GetController("lock")
	end

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.subTitleController_ = ControllerUtil.GetController(self.transform_, "subTitle")
	self.updateHandler_ = handler(self, self.UpdateActivity)

	self:RefreshUI()
end

function ActivityMainToggleItem:OnEnter()
	self.activiteData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activiteData_.startTime
	self.stopTime_ = ActivityShopCfg[self.activityID_] and ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[self.activityID_].shop_id].activity_id).stopTime or self.activiteData_.stopTime

	self:UpdateResidentTime()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.updateHandler_)
	manager.redPoint:bindUIandKey(self.transform_, ActivityTools.GetRedPointKey(self.redPointActivityID_) .. self.redPointActivityID_)
	self:AddTimer()
end

function ActivityMainToggleItem:UpdateResidentTime()
	local var_3_0, var_3_1 = ChapterResidentTools.GetResidentMainActTime(self.activityID_)

	if var_3_0 and var_3_1 then
		self.startTime_ = var_3_0
		self.stopTime_ = var_3_1
	end
end

function ActivityMainToggleItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, ActivityTools.GetRedPointKey(self.redPointActivityID_) .. self.redPointActivityID_)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.updateHandler_)
	self:StopTimer()
end

function ActivityMainToggleItem:Dispose()
	ActivityMainToggleItem.super.Dispose(self)

	self.updateHandler_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
end

function ActivityMainToggleItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if manager.time:GetServerTime() < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_CLICK, self.activityID_)
	end)
end

function ActivityMainToggleItem:SdkRecord()
	if not manager.time:IsToday(getData("activity_last_click", "activity_" .. self.activityID_) or 0) then
		OperationRecorder.RecordButtonTouch("activity_homepage_" .. self.activityID_)
		saveData("activity_last_click", "activity_" .. self.activityID_, (manager.time:GetServerTime()))
	end
end

function ActivityMainToggleItem:OnSelect(arg_9_1)
	self.selectController_:SetSelectedState(tostring(arg_9_1))

	if arg_9_1 then
		if self.redPointActivityID_ and self.redPointActivityID_ ~= self.activityID_ then
			ActivityRedPoint:CancelSubActivityNewTag(self.redPointActivityID_)
			manager.redPoint:setTip(ActivityTools.GetRedPointKey(self.redPointActivityID_) .. self.redPointActivityID_, 0, RedPointStyle.SHOW_NEW_TAG)
		else
			local var_9_0 = ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_

			ActivityRedPoint:CancelSubActivityNewTag(self.activityID_)
			manager.redPoint:setTip(var_9_0, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end

	if arg_9_1 then
		self:SdkRecord()
	end
end

function ActivityMainToggleItem:RefreshLock()
	local var_10_0 = manager.time:GetServerTime() < self.startTime_
	local var_10_1 = manager.time:GetServerTime() >= self.stopTime_

	if self.controller_ then
		if var_10_1 then
			self.controller_:SetSelectedState("true")
		elseif ActivityData:GetActivityData(self.activityID_).template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN then
			self.controller_:SetSelectedState("true")
		else
			self.controller_:SetSelectedState("false")
		end
	end

	if var_10_0 or var_10_1 then
		if self.gameObject_.activeSelf == true then
			SetActive(self.gameObject_, false)
		end
	elseif self.gameObject_.activeSelf == false then
		SetActive(self.gameObject_, true)
	end
end

function ActivityMainToggleItem:RefreshTime()
	if self.textTime_ then
		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end
end

function ActivityMainToggleItem:UpdateActivity(arg_12_1)
	local var_12_0 = self:GetTempActivityID()

	if var_12_0 == arg_12_1 then
		local var_12_1 = ActivityData:GetActivityData(var_12_0)

		self.startTime_ = var_12_1.startTime
		self.stopTime_ = var_12_1.stopTime

		self:UpdateResidentTime()
		self:AddTimer()
	end
end

function ActivityMainToggleItem:GetTempActivityID()
	if ActivityShopCfg[self.activityID_] then
		return ShopListCfg[ActivityShopCfg[self.activityID_].shop_id].activity_id
	end

	return self.activityID_
end

function ActivityMainToggleItem:AddTimer()
	self:StopTimer()
	self:RefreshLock()
	self:RefreshTime()

	local var_14_0 = manager.time:GetServerTime() < self.startTime_

	if manager.time:GetServerTime() >= self.stopTime_ then
		manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_OVER, self.activityID_)

		return
	end

	self.timer_ = Timer.New(function()
		local var_15_0 = manager.time:GetServerTime()

		if var_14_0 and var_15_0 > self.startTime_ then
			self:RefreshLock()

			var_14_0 = false
		elseif var_15_0 >= self.stopTime_ then
			self:RefreshLock()
			self:StopTimer()
			manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_OVER, self.activityID_)

			return
		end

		self:RefreshTime()
	end, 1, -1)

	self.timer_:Start()
end

function ActivityMainToggleItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityMainToggleItem:RefreshUI()
	local var_17_0 = ActivityToggleCfg[self.toggleID_]

	if ActivityToggleCfg[self.toggleID_].sub_title_type == 0 then
		self.subTitleController_:SetSelectedState("false")
	else
		self.subTitleController_:SetSelectedState("true")

		if ActivityToggleCfg[self.toggleID_].sub_title_type == 1 then
			self.subTitleText_.text = GetTips("MAIN_PLOT_TEXT")
		elseif ActivityToggleCfg[self.toggleID_].sub_title_type == 2 then
			self.subTitleText_.text = GetTips("SUB_PLOT_TEXT")
		elseif ActivityToggleCfg[self.toggleID_].sub_title_type == 3 then
			self.subTitleText_.text = GetTips("WELFARE_TEXT")
		elseif ActivityToggleCfg[self.toggleID_].sub_title_type == 4 then
			self.subTitleText_.text = GetTips("SKIN_TEXT")
		end
	end

	self.nameText_.text = GetI18NText(var_17_0.name)
	self.iconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/ActivityiconUI/" .. var_17_0.icon)
end

function ActivityMainToggleItem:Show(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)
end

return ActivityMainToggleItem
