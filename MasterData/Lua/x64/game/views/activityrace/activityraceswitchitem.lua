local ActivityRaceSwitchItem = class("ActivityRaceSwitchItem", ReduxView)

function ActivityRaceSwitchItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.scoreController_ = ControllerUtil.GetController(self.transform_, "score")

	SetActive(self.gameObject_, true)
end

function ActivityRaceSwitchItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceData:SetSelectActivityID(self.activityID_)
		self:Go("/activityRaceSwitch", {
			activityID = self.activityID_,
			mainActivityID = self.mainActivityID_
		})
	end)
end

function ActivityRaceSwitchItem:SetData(arg_4_1, arg_4_2)
	self.redPointStr_ = string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, arg_4_1, arg_4_2)

	manager.redPoint:bindUIandKey(self.transform_, self.redPointStr_)

	self.activityID_ = arg_4_2
	self.mainActivityID_ = arg_4_1
	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
end

function ActivityRaceSwitchItem:RefreshUI()
	self.isLock_ = manager.time:GetServerTime() < self.startTime_

	self.lockController_:SetSelectedState(tostring(self.isLock_))

	self.mapNameText_.text = GetI18NText(ActivityRaceCfg[self.activityID_].map_name)

	self:RefreshScore()
	self:RefreshCompleted()
end

function ActivityRaceSwitchItem:RefreshScore()
	local var_6_0 = ActivityRaceData:GetStateList()

	if var_6_0[self.activityID_] then
		self.score_ = var_6_0[self.activityID_].score
	else
		self.scoreController_:SetSelectedState("false")
	end

	if self.score_ and self.score_ ~= 0 then
		self.scoreController_:SetSelectedState("true")

		self.scoreText_.text = self.score_
	end
end

function ActivityRaceSwitchItem:RefreshCompleted()
	return
end

function ActivityRaceSwitchItem:RefreshLock()
	if self.isLock_ == false then
		return
	end

	self.isLock_ = manager.time:GetServerTime() < self.startTime_

	if self.isLock_ == true then
		self.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
	else
		self.lockController_:SetSelectedState("false")
	end
end

function ActivityRaceSwitchItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, self.redPointStr_)
end

function ActivityRaceSwitchItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil

	ActivityRaceSwitchItem.super.Dispose(self)
end

return ActivityRaceSwitchItem
