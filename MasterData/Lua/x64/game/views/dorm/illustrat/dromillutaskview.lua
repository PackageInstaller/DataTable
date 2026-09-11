local DromIlluTaskView = class("DromIlluTaskView", ReduxView)

function DromIlluTaskView:UIName()
	return "Widget/BackHouseUI/IdolDance/IllustrateRewardPopup"
end

function DromIlluTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function DromIlluTaskView:Init()
	self.taskType_ = TaskConst.TASK_TYPE.DORM_ILLU

	self:InitUI()
	self:AddUIListener()
end

function DromIlluTaskView:InitUI()
	self:BindCfgUI()

	self.taskType_ = TaskConst.TASK_TYPE.DORM_ILLU
	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.comTaskList_, DromIlluTaskItem)
	self.receiveBtnController_ = self.mainControllerEx_:GetController("oneClick")
end

function DromIlluTaskView:OnEnter()
	self:InitData()
	self:OnTaskListChange(true)
	SetActive(self.gameObject_, true)
end

function DromIlluTaskView:AddUIListener()
	self:AddBtnListener(self.allBtn_, nil, function()
		local var_7_0 = TaskTools:GetFinishTaskIds(self.taskType_)
		local var_7_1 = {}

		for iter_7_0 = 1, #var_7_0 do
			if AssignmentCfg[var_7_0[iter_7_0]].condition == self.targetCondition then
				table.insert(var_7_1, var_7_0[iter_7_0])
			end
		end

		TaskAction:SubmitTaskList(var_7_1, self.taskType_, function()
			DormRedPointTools:UpdateDormIlluRedPoint(self.targetCondition)
		end)
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function DromIlluTaskView:InitData()
	self.index_ = self.params_.index
	self.targetCondition = 0
	self.targetCondition = self.index_ == 1 and DormIlluConst.TaskCondition.hero or self.index_ == 2 and DormIlluConst.TaskCondition.dance or DormIlluConst.TaskCondition.fur
	self.taskList_ = {}

	local var_10_0 = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)

	for iter_10_0 = 1, #var_10_0 do
		if AssignmentCfg[var_10_0[iter_10_0].id].condition == self.targetCondition then
			table.insert(self.taskList_, var_10_0[iter_10_0])
		end
	end

	self.finishList_ = {}

	local var_10_1 = TaskTools:GetFinishTaskIds(self.taskType_)

	for iter_10_1 = 1, #var_10_1 do
		if AssignmentCfg[var_10_1[iter_10_1]].condition == self.targetCondition then
			table.insert(self.finishList_, var_10_1[iter_10_1])
		end
	end

	self:RefreshRecivedAll()
end

function DromIlluTaskView:RefreshScroll(arg_11_1)
	self:UpdateData()

	if arg_11_1 then
		self.scrollHelper_:StartScrollWithoutAnimator(#self.taskList_)
	else
		self.scrollHelper_:StartScroll(#self.taskList_)
	end
end

function DromIlluTaskView:indexItem(arg_12_1, arg_12_2)
	arg_12_2:ReEnter(self.taskList_[arg_12_1].id)
end

function DromIlluTaskView:OnExit()
	return
end

function DromIlluTaskView:Dispose()
	self.scrollHelper_:Dispose()
	DromIlluTaskView.super.Dispose(self)
end

function DromIlluTaskView:UpdateData()
	self.taskList_ = {}

	local var_15_0 = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.DORM_ILLU)

	for iter_15_0 = 1, #var_15_0 do
		if AssignmentCfg[var_15_0[iter_15_0].id].condition == self.targetCondition then
			table.insert(self.taskList_, var_15_0[iter_15_0])
		end
	end

	self.finishList_ = {}

	local var_15_1 = TaskTools:GetFinishTaskIds(self.taskType_)

	for iter_15_1 = 1, #var_15_1 do
		if AssignmentCfg[var_15_1[iter_15_1]].condition == self.targetCondition then
			table.insert(self.finishList_, var_15_1[iter_15_1])
		end
	end
end

function DromIlluTaskView:OnTaskListChange(arg_16_1)
	self.finishList_ = {}

	local var_16_0 = TaskTools:GetFinishTaskIds(self.taskType_)

	for iter_16_0 = 1, #var_16_0 do
		if AssignmentCfg[var_16_0[iter_16_0]].condition == self.targetCondition then
			table.insert(self.finishList_, var_16_0[iter_16_0])
		end
	end

	self:RefreshRecivedAll()

	if not arg_16_1 then
		self:RefreshScroll(true)
	else
		self:RefreshScroll(false)
	end
end

function DromIlluTaskView:RefreshRecivedAll()
	if #self.finishList_ > 0 then
		self:RefreshOnceState(true)
	else
		self:RefreshOnceState(false)
	end
end

function DromIlluTaskView:RefreshOnceState(arg_18_1)
	self.receiveBtnController_:SetSelectedState(arg_18_1 and "on" or "off")
end

return DromIlluTaskView
