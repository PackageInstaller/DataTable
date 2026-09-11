local RegressionTaskItem = class("RegressionTaskItem", ReduxView)

function RegressionTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow_ = true

	self:InitUI()
	self:AddListeners()
end

function RegressionTaskItem:SetData(arg_2_1, arg_2_2)
	self.taskID_ = arg_2_1
	self.maxRewardNum_ = arg_2_2
	self.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshUI()
	self:RefreshProgress()

	self.isShow_ = true
end

function RegressionTaskItem:OnExit()
	self.isShow_ = false

	SetActive(self.gameObject_, false)
end

function RegressionTaskItem:Dispose()
	self:RemoveListeners()
	self.rewardItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil

	RegressionTaskItem.super.Dispose(self)
end

function RegressionTaskItem:InitUI()
	self:BindCfgUI()

	self.itemData = clone(ItemTemplateData)
	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
end

function RegressionTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function RegressionTaskItem:RemoveListeners()
	self.receiveBtn_.onClick:RemoveAllListeners()
end

function RegressionTaskItem:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	self:RefreshReward()
end

function RegressionTaskItem:RefreshReward()
	local var_10_0 = AssignmentCfg[self.taskID_].reward or {}
	local var_10_1 = self.itemData

	var_10_1.id = var_10_0[1][1]
	var_10_1.number = var_10_0[1][2]

	function var_10_1.clickFun(arg_11_0)
		ShowPopItem(POP_ITEM, {
			var_10_1.id,
			var_10_1.number
		})
	end

	self.rewardItem = CommonItemView.New(self.rewardGo_)

	self.rewardItem:Show(true)
	self.rewardItem:SetData(var_10_1)
end

function RegressionTaskItem:RefreshProgress()
	local var_12_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_12_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.value = var_12_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_12_0, AssignmentCfg[self.taskID_].need)

	local var_12_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.controller_:SetSelectedState("2")
	elseif var_12_1 then
		self.controller_:SetSelectedState("1")
	else
		self.controller_:SetSelectedState("0")
	end
end

function RegressionTaskItem:SetSibling(arg_13_1)
	if AssignmentCfg[self.taskID_].condition == GameSetting.task_top_type.value[1] and AssignmentCfg[self.taskID_].additional_parameter[1] == TaskConst.TASK_TYPE.DAILY then
		self.transform_:SetSiblingIndex(0)
	else
		self.transform_:SetSiblingIndex(arg_13_1)
	end
end

return RegressionTaskItem
