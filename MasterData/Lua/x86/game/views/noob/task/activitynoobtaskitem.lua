local ActivityNoobTaskItem = class("ActivityNoobTaskItem", ReduxView)
local var_0_1 = {
	"lock",
	"receive",
	"go",
	"complete"
}

function ActivityNoobTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.rewardItems_ = {}
end

function ActivityNoobTaskItem:Dispose()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)

	for iter_2_0, iter_2_1 in pairs(self.rewardItems_) do
		iter_2_1:Dispose()
	end

	self.rewardItems_ = nil

	ActivityNoobTaskItem.super.Dispose(self)
end

function ActivityNoobTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)

	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
end

function ActivityNoobTaskItem:onSubmitTaskResponse()
	ActivityNoobAction.RefreshAccumulateRedPoint()
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
	SendMessageManagerToSDK("task_finish", {
		taskId = self.taskID_
	})
end

function ActivityNoobTaskItem:SetData(arg_7_1)
	self.taskID_ = arg_7_1

	self:RefreshTitle()
	self:RefreshProgress()
	self:RefreshState()
	self:RefreshReward(arg_7_1)
end

function ActivityNoobTaskItem:RefreshTitle()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)
end

function ActivityNoobTaskItem:RefreshProgress()
	local var_9_0 = TaskData2:GetTask(self.taskID_).progress or 0

	if AssignmentCfg[self.taskID_].need < var_9_0 then
		var_9_0 = AssignmentCfg[self.taskID_].need
	end

	self.needText_.text = string.format("/%s", AssignmentCfg[self.taskID_].need)
	self.progressText_.text = var_9_0
	self.progressSlider_.value = var_9_0 / AssignmentCfg[self.taskID_].need
end

function ActivityNoobTaskItem:RefreshReward(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(AssignmentCfg[arg_10_1].reward) do
		local var_10_0 = clone(ItemTemplateData)

		var_10_0.id = iter_10_1[1]
		var_10_0.number = iter_10_1[2]

		function var_10_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		if self.rewardItems_[iter_10_0] == nil then
			local var_10_1 = Object.Instantiate(self.itemGo_, self.rewardParent_)

			SetActive(var_10_1, true)

			self.rewardItems_[iter_10_0] = CommonItemView.New(var_10_1)
		end

		self.rewardItems_[iter_10_0]:SetData(var_10_0)
	end

	for iter_10_2 = #AssignmentCfg[arg_10_1].reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_2]:Show(false)
	end
end

function ActivityNoobTaskItem:RefreshState()
	self.stateCon_:SetSelectedState((self:GetItemState()))
end

function ActivityNoobTaskItem:GetItemState()
	local var_13_0 = TaskData2:GetTask(self.taskID_)

	self.curState_ = ActivityNoobData:GetUnlockPhase() < AssignmentCfg[self.taskID_].phase and var_0_1[1] or var_13_0.complete_flag >= 1 and var_0_1[4] or (var_13_0.progress or 0) < AssignmentCfg[self.taskID_].need and var_0_1[3] or var_0_1[2]

	return self.curState_
end

return ActivityNoobTaskItem
