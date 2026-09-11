local ActivityQuizEnterView_3_10 = class("ActivityQuizEnterView_3_10", ActivityQuizEnterView)

function ActivityQuizEnterView_3_10:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.controllers_:GetController("state")
end

function ActivityQuizEnterView_3_10:AddUIListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		if self:IsActivitying() then
			if self:IsOpenTime() then
				self:MuteEnterRedPoint()
				ActivityQuizAction.StartMarch()
			else
				ShowTips("ACTIVITY_QUIZ_NOT_OPEN_YET")
			end
		end
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityQuizTools.GetTaskActivityID(self.activityID_), "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
end

function ActivityQuizEnterView_3_10:RegisterEvents()
	return
end

function ActivityQuizEnterView_3_10:RefreshActivityData()
	self.titleText_.text = ActivityTools.GetActivityTitleName(self.activityID_)
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.openTbl_, self.closeTbl_ = GameSetting.activity_quiz_open_time.value[1], GameSetting.activity_quiz_open_time.value[2]
	self.dayOpen_.text = string.format("%02d:%02d-%02d:%02d", self.openTbl_[1], self.openTbl_[2], self.closeTbl_[1], self.closeTbl_[2])
end

function ActivityQuizEnterView_3_10:RefreshUI()
	self:RefreshActivityData()
	self:StartTimer()
	self:RefreshTimeText()
end

function ActivityQuizEnterView_3_10:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityQuizEnterView_3_10:StartTimer()
	self:StopTimer()

	if ActivityTools.GetActivityStatus(self.activityID_) ~= ActivityConst.ACTIVITY_STATE.OVER then
		self.timer_ = Timer.New(function()
			self:RefreshTimeText()
		end, 1, -1)

		self.timer_:Start()

		return true
	else
		return false
	end
end

function ActivityQuizEnterView_3_10:RefreshTask()
	return
end

function ActivityQuizEnterView_3_10:RefreshTimeText()
	local var_12_0, var_12_1 = ActivityTools.GetActivityStatusWithTips(self.activityID_)

	if var_12_0 ~= ActivityConst.ACTIVITY_STATE.OVER then
		self.stateCon_:SetSelectedState(var_12_0 == ActivityConst.ACTIVITY_STATE.ACTIVING and self:IsOpenTime() and "unlock" or "close")

		self.timeText_.text = var_12_1 or manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_)
	else
		self.stateCon_:SetSelectedState("close")

		self.timeText_.text = var_12_1

		self:StopTimer()
	end
end

function ActivityQuizEnterView_3_10:IsActivitying()
	return ActivityTools.GetActivityIsOpenWithTip(self.activityID_, false)
end

function ActivityQuizEnterView_3_10:OnEnter()
	self:RegisterEvents()

	self.activityID_ = self.params_.activityID

	self:RefreshUI()
	self:BindRedPoints()
end

function ActivityQuizEnterView_3_10:OnExit()
	self:UnbindRedPoints()
	self:RemoveAllEventListener()
	self:StopTimer()
end

function ActivityQuizEnterView_3_10:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(self.activityID_))
end

function ActivityQuizEnterView_3_10:Dispose()
	ReduxView.Dispose(self)
end

function ActivityQuizEnterView_3_10:BindRedPoints()
	local var_18_0 = ActivityQuizTools.GetTaskActivityID(self.activityID_)

	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. var_18_0)
	manager.redPoint:bindUIandKey(self.startBtn_.transform, RedPointConst.ACTIVITY_QUIZ_CHALLENGE_AVAILABLE .. "_" .. var_18_0)
end

function ActivityQuizEnterView_3_10:UnbindRedPoints()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform)
	manager.redPoint:unbindUIandKey(self.startBtn_.transform)
end

return ActivityQuizEnterView_3_10
