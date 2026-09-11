local ActivityTaskBaseItem = class("ActivityTaskBaseItem", ReduxView)

function ActivityTaskBaseItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rewardItems_ = {}

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "conName")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "name")
end

function ActivityTaskBaseItem:Dispose()
	ActivityTaskBaseItem.super.Dispose(self)
	self:StopTimer()

	for iter_2_0, iter_2_1 in pairs(self.rewardItems_) do
		iter_2_1:Dispose()
	end

	self.rewardItem_ = nil
end

function ActivityTaskBaseItem:AddListeners()
	self:AddBtnListener(self.btnGo_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.btnReceive_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivityTaskBaseItem:SetData(arg_6_1)
	self.taskID_ = arg_6_1

	self:RefreshUI()
	self:RefreshReward(arg_6_1)
	self:RefreshState()
	self:AddTimer()
end

function ActivityTaskBaseItem:RefreshUI()
	self.textContent_.text = GetI18NText(AssignmentCfg[self.taskID_].name)
	self.textDesc_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_7_0 = TaskData2:GetTask(self.taskID_).progress or 0
	local var_7_1 = AssignmentCfg[self.taskID_].need

	if AssignmentCfg[self.taskID_].need < var_7_0 then
		var_7_0 = var_7_1
	end

	self.imageProgress_.fillAmount = var_7_0 / var_7_1
	self.textProgress_.text = string.format("%s/%s", var_7_0, var_7_1)

	if AssignmentCfg[self.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeController_:SetSelectedState("daily")
	else
		self.typeController_:SetSelectedState("challenge")
	end
end

function ActivityTaskBaseItem:RefreshReward(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(AssignmentCfg[arg_8_1].reward) do
		if self.rewardItems_[iter_8_0] == nil then
			self.rewardItems_[iter_8_0] = self:GetRewardItem(iter_8_1)
		else
			self.rewardItems_[iter_8_0]:SetData(iter_8_1)
		end
	end

	for iter_8_2 = #AssignmentCfg[arg_8_1].reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_2]:Show(false)
	end
end

function ActivityTaskBaseItem:GetRewardItem(arg_9_1)
	return RewardPoolItem.New(self.goItemParent_, arg_9_1)
end

function ActivityTaskBaseItem:RefreshState()
	self.stateController_:SetSelectedState((self:GetItemState()))
end

function ActivityTaskBaseItem:GetItemState()
	local var_11_0 = TaskData2:GetTask(self.taskID_)
	local var_11_1 = var_11_0.progress or 0

	if var_11_0.complete_flag >= 1 then
		return 2
	end

	if var_11_1 >= AssignmentCfg[self.taskID_].need then
		return 1
	else
		return 0
	end
end

function ActivityTaskBaseItem:AddTimer()
	if self.timer_ then
		self:StopTimer()
	end

	local var_12_1 = TaskData2:GetTask(self.taskID_)
	local var_12_2 = GameSetting.refresh_time1.value[1][1]
	local var_12_3 = var_12_1.expired_timestamp

	if var_12_1.expired_timestamp == nil or var_12_3 == 0 then
		var_12_3 = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)
	end

	if self.textTime_ then
		self.textTime_.text = manager.time:GetLostTimeStr(var_12_3)
	end

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_12_3 then
			var_12_3 = var_12_1 and var_12_1.expired_timestamp and var_12_1.expired_timestamp or manager.time:GetNextTime(var_12_2, 0, 0)
		end

		if self.textTime_ then
			self.textTime_.text = manager.time:GetLostTimeStr(var_12_3)
		end
	end, 1, -1)

	self.timer_:Start()
end

function ActivityTaskBaseItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityTaskBaseItem
