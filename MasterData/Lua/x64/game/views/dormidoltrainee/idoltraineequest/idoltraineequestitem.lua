local IdolTraineeQuestItem = class("IdolTraineeQuestItem", ReduxView)

function IdolTraineeQuestItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolTraineeQuestItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.rewardItems_ = {}
	self.stateController_ = self.mainControllerEx_:GetController("state")
	self.typeController_ = self.mainControllerEx_:GetController("type")
end

function IdolTraineeQuestItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.taskID_ then
			local var_4_1 = getData("dorm_weekly_task", "tip_deadline")

			if (var_4_1 and tonumber(var_4_1) > manager.time:GetServerTime() or nil) and false and ((GameSetting.house_task_points or nil) and GameSetting.house_task_points.value[2]) <= TaskTools.GetTargetTaskReward({
				self.taskID_
			}, 61) + IdolTraineeData:GetQuestWeeklyData() then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("DORM_TASK_WEEKLY_LIMIT_TIP"),
					toggleText = GetTips("WEEKLY_MUTE_TIP"),
					OkCallback = function()
						TaskAction:SubmitTask(self.taskID_)
					end,
					ToggleCallback = function(arg_6_0)
						if arg_6_0 then
							saveData("dorm_weekly_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
						end
					end
				})
			else
				TaskAction:SubmitTask(self.taskID_)
			end
		end
	end)
end

function IdolTraineeQuestItem:SetData(arg_7_1)
	self.taskID_ = arg_7_1

	local var_7_0 = AssignmentCfg[arg_7_1]

	self.typeController_:SetSelectedState(AssignmentCfg[arg_7_1].type == TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY and "day" or "week")

	local var_7_1 = TaskData2:GetTaskProgress(arg_7_1)

	if var_7_1 > var_7_0.need then
		var_7_1 = var_7_0.need
	end

	self.desc_.text = var_7_0.desc
	self.slider_.value = var_7_1 / var_7_0.need
	self.progress_.text = string.format("%s/%s", var_7_1, var_7_0.need)

	if TaskData2:GetTaskComplete(arg_7_1) then
		self.stateController_:SetSelectedState("received")
	elseif var_7_1 >= var_7_0.need then
		self.stateController_:SetSelectedState("complete")
	else
		self.stateController_:SetSelectedState("unfinish")
	end

	for iter_7_0, iter_7_1 in ipairs(var_7_0.reward or {}) do
		local var_7_2 = formatReward(iter_7_1)
		local var_7_3 = clone(ItemTemplateData)

		if self.rewardItems_[iter_7_0] == nil then
			self.rewardItems_[iter_7_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_7_0)])
			self.rewardItems_[iter_7_0].ResetTransform = function()
				return
			end
		end

		var_7_3.id = var_7_2.id
		var_7_3.number = var_7_2.num
		var_7_3.timeValid = iter_7_1.timeValid or 0
		var_7_3.completedFlag = self.taskComplete_
		var_7_3.clickFun = handler(self, self.OnClickCommonItem)

		self.rewardItems_[iter_7_0]:SetData(var_7_3)
	end

	for iter_7_2 = #var_7_0.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_7_2]:SetData(nil)
	end
end

function IdolTraineeQuestItem:OnClickCommonItem(arg_9_1)
	ShowPopItem(POP_ITEM, {
		arg_9_1.id,
		arg_9_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function IdolTraineeQuestItem:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.rewardItems_) do
		iter_10_1:Dispose()
	end

	self.rewardItems_ = {}

	IdolTraineeQuestItem.super.Dispose(self)
end

return IdolTraineeQuestItem
