local RiddleMainView = class("RiddleMainView", ReduxView)

function RiddleMainView:UIName()
	return "UI/EmptyDream/Riddle/RiddleMainUI"
end

function RiddleMainView:UIParent()
	return manager.ui.uiMain.transform
end

function RiddleMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
	self.riddleUpdateHandler_ = handler(self, self.RefreshRiddle)
end

function RiddleMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SPRING_FESTIVAL_RIDDLE_DESCRIPE")

	local var_4_0 = self:GetActivityID()

	for iter_4_0, iter_4_1 in ipairs(ActivitySpringFestivalRiddleCfg.get_id_list_by_activity_id[var_4_0]) do
		if self.itemList_[iter_4_0] == nil then
			self.itemList_[iter_4_0] = SpringFestivalRiddleMainItem.New(self[string.format("riddleGo%s_", iter_4_0)], var_4_0, iter_4_1)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self.itemList_) do
		iter_4_3:OnEnter()
	end

	self:AddTimer()
	self:AddRefreshTimer()
	SpringFestivalRiddleAction.HideRedPoint(var_4_0)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_UPDATE, self.riddleUpdateHandler_)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, self.riddleUpdateHandler_)
end

function RiddleMainView:OnExit()
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_UPDATE, self.riddleUpdateHandler_)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, self.riddleUpdateHandler_)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(self.itemList_) do
		iter_5_1:OnExit()
	end

	self:StopTimer()
	self:StopRefreshTimer()

	self.lightState_ = nil
end

function RiddleMainView:Dispose()
	RiddleMainView.super.Dispose(self)

	self.riddleUpdateHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.itemList_ = {}
end

function RiddleMainView:AddListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalRiddleReward", {
			activityID = self:GetActivityID()
		})
	end)
end

function RiddleMainView:GetActivityID()
	return ActivityConst.SPRING_FESTIVAL_RIDDLE
end

function RiddleMainView:RefreshItemList(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.itemList_) do
		iter_10_1:RefreshState(arg_10_1)
	end
end

function RiddleMainView:RefreshRiddle()
	self:AddRefreshTimer()
end

function RiddleMainView:CheckLightRiddle()
	local var_12_0 = self:GetActivityID()
	local var_12_1 = manager.time:GetServerTime()

	if ActivityData:GetActivityData(var_12_0).stopTime <= var_12_1 then
		self.lightState_ = false

		self:RefreshItemList(self.lightState_)
		self:StopRefreshTimer()

		return
	end

	local var_12_2 = SpringFestivalRiddleData:GetLastAnswerTime(var_12_0)
	local var_12_4 = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)
	local var_12_6 = SpringFestivalRiddleData:CanAnswer(var_12_0) and (((var_12_4 < var_12_2 + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60 or nil) and var_12_4) <= var_12_1 or var_12_4 - var_12_2 > 86400) or false

	if self.lightState_ ~= var_12_6 then
		self.lightState_ = var_12_6

		self:RefreshItemList(self.lightState_)
	end
end

function RiddleMainView:AddRefreshTimer()
	self:StopRefreshTimer()
	self:CheckLightRiddle()

	self.refreshTimer_ = Timer.New(function()
		self:CheckLightRiddle()
	end, 1, -1)

	self.refreshTimer_:Start()
end

function RiddleMainView:StopRefreshTimer()
	if self.refreshTimer_ then
		self.refreshTimer_:Stop()

		self.refreshTimer_ = nil
	end
end

function RiddleMainView:AddTimer()
	self.stopTime_ = ActivityData:GetActivityData((self:GetActivityID())).stopTime

	self:StopTimer()

	if manager.time:GetServerTime() >= self.stopTime_ then
		self.timeText_.text = GetTips("TIME_OVER")

		return
	end

	self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")

			return
		end

		self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function RiddleMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return RiddleMainView
