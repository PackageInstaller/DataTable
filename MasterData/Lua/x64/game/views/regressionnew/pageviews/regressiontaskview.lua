local RegressionTaskView = class("RegressionTaskView", ReduxView)

RegressionCurrentActContent = import("game.views.regressionNew.pageViews.TaskContent.RegressionCurrentActContent")
RegressionCardTaskContent = import("game.views.regressionNew.pageViews.TaskContent.RegressionCardTaskContent")
RegressionDailyTaskContent = import("game.views.regressionNew.pageViews.TaskContent.RegressionDailyTaskContent")
RegressionTiliTaskContent = import("game.views.regressionNew.pageViews.TaskContent.RegressionTiliTaskContent")

local var_0_1 = {
	211,
	207,
	208,
	209
}
local var_0_2 = {
	RegressionCurrentActContent,
	RegressionCardTaskContent,
	RegressionDailyTaskContent,
	RegressionTiliTaskContent
}

function RegressionTaskView:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnThree/RT3rd_TaskUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionTaskView:InitUI()
	self:BindCfgUI()

	self.receiveAllController_ = self.controller_:GetController("receiveAll")
	self.viewTypeController_ = self.controller_:GetController("viewType")
	self.taskList_ = LuaList.New(handler(self, self.IndexTaskItem), self.scrollView_, RegressionTaskItem)
	self.viewClassList = {}

	for iter_3_0 = 0, self.contentnodeTrs_.childCount - 1 do
		self.viewClassList[iter_3_0] = var_0_2[iter_3_0 + 1].New(self.contentnodeTrs_:GetChild(iter_3_0).gameObject)
	end
end

function RegressionTaskView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(self.taskType_), self.taskType_)
	end)
end

function RegressionTaskView:SetData(arg_6_1)
	self.taskType_ = arg_6_1

	if not saveData("Regression", "First" .. self.taskType_ .. RegressionDataNew:GetRegressionEndTime()) then
		saveData("Regression", "First" .. self.taskType_ .. RegressionDataNew:GetRegressionEndTime(), true)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_FIRST, self.taskType_), 0)
	end

	self:RefreshTaskUI()
	self:RefreshViewContentUI()
end

function RegressionTaskView:RefreshViewContentUI()
	local var_7_0 = table.indexof(var_0_1, self.taskType_)

	if var_7_0 > 0 then
		self.viewTypeController_:SetSelectedIndex(var_7_0 - 1)
		self.viewClassList[var_7_0 - 1]:RefreshUI()
	end
end

function RegressionTaskView:RefreshTime(arg_8_1)
	local var_8_0 = table.indexof(var_0_1, self.taskType_)

	if var_8_0 > 0 then
		self.viewClassList[var_8_0 - 1]:RefreshTime(arg_8_1)
	end
end

function RegressionTaskView:OnTaskListChange()
	self:RefreshTaskUI()
	self:RefreshViewContentUI()
end

function RegressionTaskView:RefreshTaskUI()
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)

	table.sort(self._taskIDList, function(arg_11_0, arg_11_1)
		return arg_11_0.id < arg_11_1.id
	end)

	self._finishList = TaskTools:GetFinishTaskIds(self.taskType_)
	self.maxRewardNum_ = 0

	for iter_10_0, iter_10_1 in ipairs(self._taskIDList) do
		local var_10_0 = iter_10_1.id

		if not AssignmentCfg[iter_10_1.id] then
			print(var_10_0)
		else
			self.maxRewardNum_ = #AssignmentCfg[var_10_0].reward > self.maxRewardNum_ and #AssignmentCfg[var_10_0].reward or self.maxRewardNum_
		end
	end

	self.taskList_:StartScroll(#self._taskIDList)
	self.receiveAllController_:SetSelectedState(#self._finishList > 0 and "show" or "hide")
end

function RegressionTaskView:IndexTaskItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self._taskIDList[arg_12_1].id, self.maxRewardNum_)
end

function RegressionTaskView:GetSelectParams()
	local var_13_0 = table.indexof(var_0_1, self.taskType_)

	if self.viewClassList[var_13_0 - 1] and self.viewClassList[var_13_0 - 1].GetSelectParams then
		return self.viewClassList[var_13_0 - 1]:GetSelectParams()
	end

	return nil, nil
end

function RegressionTaskView:SetActive(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

function RegressionTaskView:Dispose()
	if self.taskList_ then
		self.taskList_:Dispose()

		self.taskList_ = nil
	end

	for iter_15_0, iter_15_1 in pairs(self.viewClassList) do
		if iter_15_1 then
			iter_15_1:Dispose()

			iter_15_1 = nil
		end
	end

	RegressionTaskView.super.Dispose(self)
end

return RegressionTaskView
