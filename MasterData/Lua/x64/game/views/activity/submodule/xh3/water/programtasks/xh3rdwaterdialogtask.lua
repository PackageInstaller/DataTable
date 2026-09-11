local XH3rdWaterDialogTask = class("XH3rdWaterDialogTask")

function XH3rdWaterDialogTask:Init(arg_1_1)
	self.activityId_ = arg_1_1
	self.unSelectDialogGroupIndex_ = 0
	self.talkGroupIdList_ = {}

	if ActivityWaterData:GetCurrentSchedule(self.activityId_) then
		self.talkGroupIdList_ = ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(self.activityId_).schedule_id].groups
	end
end

function XH3rdWaterDialogTask:StartDialogTimer()
	self:StopDialogTimer()

	self.selectDialogIndex_ = 0
	self.unselectDialogIndex_ = 0
	self.dialogTimer_ = Timer.New(function()
		self:ShowDialog()
	end, 3, -1)

	self.dialogTimer_:Start()
	self:ShowDialog()
end

function XH3rdWaterDialogTask:StopDialogTimer()
	if self.dialogTimer_ then
		self.dialogTimer_:Stop()

		self.dialogTimer_ = nil
	end
end

function XH3rdWaterDialogTask:StartScheduleTimer()
	self:StopScheduleTimer()

	self.scheduleTimer_ = Timer.New(function()
		if ActivityWaterData:GetCurrentAssistantRole(self.activityId_) == 0 then
			self.unSelectDialogGroupIndex_ = self.unSelectDialogGroupIndex_ % #ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(self.activityId_).schedule_id].groups + 1

			self:StartDialogTimer()
		end

		self:StopScheduleTimer()
	end, 30, 1)

	self.scheduleTimer_:Start()
end

function XH3rdWaterDialogTask:StopScheduleTimer()
	if self.scheduleTimer_ then
		self.scheduleTimer_:Stop()

		self.scheduleTimer_ = nil
	end
end

function XH3rdWaterDialogTask:SetOnDialogHandler(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self.onSinglePlayerDialog_ = arg_8_1
	self.onMultiPlayerDialog_ = arg_8_3
	self.onSinglePlayerStop_ = arg_8_2
	self.onMultiPlayerStop_ = arg_8_4
end

function XH3rdWaterDialogTask:ShowDialog()
	if ActivityWaterData:GetCurrentAssistantRole(self.activityId_) == 0 then
		self:NextUnSelectTalk()
	end
end

function XH3rdWaterDialogTask:NextSelectTalk()
	if not self.selectDialogGroup_ or ActivityWaterData:GetCurrentAssistantRole(self.activityId_) ~= self.currentCompetitionId_ then
		self.currentCompetitionId_ = ActivityWaterData:GetCurrentAssistantRole(self.activityId_)
		self.selectDialogGroup_ = ActivityWaterCompetitionCfg[self.currentCompetitionId_].dialog_group
		self.currentSelectDialogIdList_ = ActivityWaterDialogCfg.get_id_list_by_dialog_group[self.selectDialogGroup_]
	end

	if self.selectTimer_ then
		self.selectTimer_:Stop()
	end

	self.selectDialogIndex_ = self.selectDialogIndex_ or 0
	self.selectDialogIndex_ = self.selectDialogIndex_ % #self.currentSelectDialogIdList_ + 1

	if self.onSinglePlayerDialog_ ~= nil then
		self.onSinglePlayerDialog_(ActivityWaterData:GetCurrentAssistantRole(self.activityId_), self.currentSelectDialogIdList_[self.selectDialogIndex_])
	end

	self.selectTimer_ = TimeTools.StartAfterSeconds(3, function()
		if self.onSinglePlayerStop_ ~= nil then
			self.onSinglePlayerStop_()
		end

		self.selectTimer_ = nil
	end, {})
end

function XH3rdWaterDialogTask:NextUnSelectTalk()
	if not self.unselectDialogGroup_ then
		self.unselectDialogGroup_ = ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(self.activityId_).schedule_id].groups[self.unSelectDialogGroupIndex_]
		self.currentUnselectDialogIdList_ = ActivityWaterDialogCfg.get_id_list_by_dialog_group[self.unselectDialogGroup_]
	end

	self.unselectDialogIndex_ = self.unselectDialogIndex_ or 0

	if self.unselectDialogIndex_ >= #self.currentUnselectDialogIdList_ then
		if self.onMultiPlayerStop_ ~= nil then
			self.onMultiPlayerStop_()
		end

		self.unselectDialogIndex_ = 0

		self:StopDialogTimer()
		self:StartScheduleTimer()

		return
	end

	self.unselectDialogIndex_ = self.unselectDialogIndex_ + 1

	if self.onMultiPlayerDialog_ ~= nil then
		self.onMultiPlayerDialog_(self.currentUnselectDialogIdList_[self.unselectDialogIndex_])
	end
end

function XH3rdWaterDialogTask:OnEnter()
	if ActivityWaterData:GetCurrentAssistantRole(self.activityId_) == 0 then
		self:StartScheduleTimer()
	end
end

function XH3rdWaterDialogTask:OnExit()
	if ActivityWaterData:GetCurrentAssistantRole(self.activityId_) ~= 0 then
		if self.onSinglePlayerStop_ ~= nil then
			self.onSinglePlayerStop_()
		end
	elseif self.onMultiPlayerStop_ ~= nil then
		self.onMultiPlayerStop_()
	end

	self:StopDialogTimer()
	self:StopScheduleTimer()
end

function XH3rdWaterDialogTask:Disturb()
	if ActivityWaterData:GetCurrentAssistantRole(self.activityId_) ~= 0 then
		if self.onSinglePlayerStop_ ~= nil then
			self.onSinglePlayerStop_()
		end
	elseif self.onMultiPlayerStop_ ~= nil then
		self.onMultiPlayerStop_()
	end

	self:StopDialogTimer()
	self:StartScheduleTimer()
end

function XH3rdWaterDialogTask:Dispose()
	self:StopDialogTimer()
	self:StopScheduleTimer()
end

return XH3rdWaterDialogTask
