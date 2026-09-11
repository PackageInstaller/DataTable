local SummerStorySeabedItem = class("SummerStorySeabedItem", ReduxView)

function SummerStorySeabedItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2
	self.activityID_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function SummerStorySeabedItem:OnEnter()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.unLockState_ = ActivityTools.IsUnlockActivity(self.activityID_)

	manager.redPoint:bindUIandKey(self.transform_, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)
	self:AddTimer()
end

function SummerStorySeabedItem:OnExit()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.transform_, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)
end

function SummerStorySeabedItem:Dispose()
	SummerStorySeabedItem.super.Dispose(self)
end

function SummerStorySeabedItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_6_0 = manager.time:GetServerTime()

		if var_6_0 > self.activityData_.stopTime then
			ShowTips("TIME_OVER")

			return
		end

		if var_6_0 < self.activityData_.startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.activityData_.startTime)))

			return
		end

		if ActivityData:GetActivityIsOpen(self.activityID_) == false then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(manager.time:GetServerTime() + 1)))

			return
		end

		if not self.unLockState_ then
			ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")

			return
		end

		ActivityStoryAction.UpdateRedPoint(self.activityID_, 0)
		self:Go("/summerStageSeabed", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = self.chapterID_
		})
	end)
end

function SummerStorySeabedItem:AddTimer()
	self:StopTimer()

	local var_7_0 = self.activityData_
	local var_7_1 = manager.time:GetServerTime()

	if var_7_1 > self.activityData_.stopTime then
		self.controller_:SetSelectedState("on")

		return
	end

	if var_7_1 < self.activityData_.startTime then
		self.controller_:SetSelectedState("off")

		self.timeText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.activityData_.startTime))
		self.timer_ = Timer.New(function()
			var_7_1 = manager.time:GetServerTime()

			if var_7_1 >= var_7_0.startTime then
				self.controller_:SetSelectedState("on")
				self:StopTimer()

				return
			end

			self.timeText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_7_0.startTime))
		end, 1, -1)

		self.timer_:Start()

		return
	end

	self.controller_:SetSelectedState("on")
end

function SummerStorySeabedItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SummerStorySeabedItem
