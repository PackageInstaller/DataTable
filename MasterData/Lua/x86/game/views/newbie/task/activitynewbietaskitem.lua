local ActivityNewbieTaskItem = class("ActivityNewbieTaskItem", ReduxView)
local var_0_1 = {
	"complete",
	"incomplete",
	"lock",
	"finish"
}

function ActivityNewbieTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.rewardItems_ = {}
end

function ActivityNewbieTaskItem:Dispose()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)

	for iter_2_0, iter_2_1 in pairs(self.rewardItems_) do
		iter_2_1:Dispose()
	end

	self.rewardItems_ = nil

	ActivityNewbieTaskItem.super.Dispose(self)
end

function ActivityNewbieTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)

	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
end

function ActivityNewbieTaskItem:onSubmitTaskResponse()
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
end

function ActivityNewbieTaskItem:SetData(arg_7_1)
	if self.taskID_ ~= arg_7_1 then
		self:RefreshReward(arg_7_1)
	end

	self.taskID_ = arg_7_1

	self:RefreshTitle()
	self:RefreshProgress()
	self:RefreshState()
end

function ActivityNewbieTaskItem:RefreshTitle()
	self.titleText_.text = AssignmentCfg[self.taskID_].desc
end

function ActivityNewbieTaskItem:RefreshProgress()
	local var_9_0 = TaskData2:GetTask(self.taskID_).progress or 0

	if AssignmentCfg[self.taskID_].need < var_9_0 then
		var_9_0 = AssignmentCfg[self.taskID_].need
	end

	if AssignmentCfg[self.taskID_].phase < TaskData2:GetAssignmentPhase() then
		var_9_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressText_.text = string.format("%s/%s", var_9_0, AssignmentCfg[self.taskID_].need)
end

function ActivityNewbieTaskItem:RefreshReward(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(AssignmentCfg[arg_10_1].reward) do
		local var_10_0 = clone(ItemTemplateData)

		var_10_0.id = iter_10_1[1]
		var_10_0.number = iter_10_1[2]

		function var_10_0:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
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

function ActivityNewbieTaskItem:RefreshState()
	self.stateCon_:SetSelectedState((self:GetItemState()))
end

function ActivityNewbieTaskItem:GetItemState()
	local var_13_0 = TaskData2:GetAssignmentPhase()
	local var_13_1 = TaskData2:GetTask(self.taskID_)

	if var_13_0 < AssignmentCfg[self.taskID_].phase then
		return var_0_1[3]
	elseif var_13_0 > AssignmentCfg[self.taskID_].phase or var_13_1.complete_flag >= 1 then
		return var_0_1[4]
	end

	if (var_13_1.progress or 0) < AssignmentCfg[self.taskID_].need then
		return var_0_1[2]
	else
		return var_0_1[1]
	end
end

return ActivityNewbieTaskItem
