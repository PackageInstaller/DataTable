local OsirisPlayGameLimitRewardView = class("OsirisPlayGameLimitRewardView", (import("game.views.task.limitTime.LimitTimeTaskBaseView")))

function OsirisPlayGameLimitRewardView:OnEnter()
	self.super.OnEnter(self)

	for iter_1_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:bindUIandKey(self.tabList_[iter_1_0].transform_, RedPointConst.OSIRIS_PLAY_GAME_TASK_TAG .. self.subActivityIDList_[iter_1_0])
	end
end

function OsirisPlayGameLimitRewardView:OnExit()
	self.super.OnExit(self)

	for iter_2_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_2_0].transform_, RedPointConst.OSIRIS_PLAY_GAME_TASK_TAG .. self.subActivityIDList_[iter_2_0])
	end
end

function OsirisPlayGameLimitRewardView:CheckPointReward()
	local var_3_0, var_3_1 = GetCurTaskScheduleInfo(self.mainActivityID_)
	local var_3_2 = {}

	for iter_3_0 = 1, #AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] do
		local var_3_3 = self.pointItemList_[iter_3_0]:GetTaskID()

		if TaskData2:GetTaskProgress(var_3_3) >= AssignmentCfg[var_3_3].need and not TaskData2:GetTaskComplete(var_3_3) then
			table.insert(var_3_2, var_3_3)
		end
	end

	if #var_3_2 > 0 then
		TaskAction:SubmitTaskList(var_3_2)
		OsirisPlayGameData:UpdateOsirisTaskRedPoint()
	end
end

function OsirisPlayGameLimitRewardView:InitData()
	self.mainActivityID_ = self.params_.activityID

	local var_4_0 = ActivityData:GetActivityData(self.mainActivityID_)

	if ActivityData:GetActivityIsOpen(self.mainActivityID_) then
		self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_4_0.stopTime)
	elseif manager.time:GetServerTime() < var_4_0.startTime then
		self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_4_0.startTime))
	elseif manager.time:GetServerTime() > var_4_0.stopTime then
		self.timeLable_.text = GetTips("TIME_OVER")
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(self.mainActivityID_) then
				self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_4_0.stopTime)
			else
				if manager.time:GetServerTime() < var_4_0.startTime then
					self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_4_0.startTime))
				elseif manager.time:GetServerTime() > var_4_0.stopTime then
					self.timeLable_.text = GetTips("TIME_OVER")
				end

				gameContext:Go("/home")
			end
		end, 1, -1)
	end

	self.timer_:Start()
end

function GetCurTaskScheduleInfo(arg_6_0)
	if AssignmentCfg.get_id_list_by_activity_id[arg_6_0] then
		return TaskData2:GetTaskProgress(AssignmentCfg.get_id_list_by_activity_id[arg_6_0][#AssignmentCfg.get_id_list_by_activity_id[arg_6_0]]), AssignmentCfg[AssignmentCfg.get_id_list_by_activity_id[arg_6_0][#AssignmentCfg.get_id_list_by_activity_id[arg_6_0]]].need
	end
end

return OsirisPlayGameLimitRewardView
