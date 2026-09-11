local ActivityEntraceItem = class("ActivityEntraceItem", ReduxView)

function ActivityEntraceItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ActivityEntraceItem:OnEnter()
	if JumpTools.GetLinkIsLocked(ActivityEntraceCfg[self.activityID_].jump_system) then
		SetActive(self.redPointGo_, false)
	else
		SetActive(self.redPointGo_, true)
	end

	manager.redPoint:bindUIandKey(self.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, self.activityID_))
	self:RefreshUI()
end

function ActivityEntraceItem:OnExit()
	manager.redPoint:unbindUIandKey(self.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, self.activityID_))
end

function ActivityEntraceItem:Dispose()
	ActivityEntraceItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityEntraceItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if ActivityTools.CheckActivityIsSuspended(self.activityID_) then
			return
		end

		local var_6_0 = "btn_homepage_activity" .. self.activityID_
		local var_6_1 = getData("SDK", "btn_homepage_activity" .. self.activityID_)

		if var_6_1 == nil or not TimeMgr:IsSameDay(var_6_1, (TimeMgr:GetServerTime())) then
			saveData("SDK", var_6_0, TimeMgr:GetServerTime())
			OperationRecorder.RecordButtonTouch("homepage_activity_" .. self.activityID_)
		end

		local var_6_2 = ActivityEntraceCfg[self.activityID_]

		ActivityVersionData:SetReprintField(ActivityEntraceCfg[self.activityID_].reprint_field)
		JumpTools.JumpToPage2(var_6_2.jump_system)
	end)
end

function ActivityEntraceItem:SetData(arg_7_1)
	if self.activityID_ then
		self:OnExit()
	end

	self.activityID_ = arg_7_1

	self:OnEnter()
end

function ActivityEntraceItem:RefreshUI()
	local var_8_0 = ActivityData:GetActivityData(self.activityID_).startTime

	self.image_.sprite = getSpriteViaConfig("ActivityBannerTextures", ActivityEntraceCfg[self.activityID_].icon_list[self:GetIndex()])
end

function ActivityEntraceItem:GetIndex()
	local var_9_0 = ActivityData:GetActivityData(self.activityID_).startTime
	local var_9_1 = manager.time:GetServerTime()

	for iter_9_0 = #ActivityEntraceCfg[self.activityID_].day_list, 1, -1 do
		if var_9_1 >= var_9_0 + ActivityEntraceCfg[self.activityID_].day_list[iter_9_0] * 24 * 3600 then
			return iter_9_0 + 1
		end
	end

	return 1
end

return ActivityEntraceItem
