local var_0_0 = class("RegressionTaskView", ReduxView)

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

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnThree/RT3rd_TaskUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.receiveAllController_ = arg_3_0.controller_:GetController("receiveAll")
	arg_3_0.viewTypeController_ = arg_3_0.controller_:GetController("viewType")
	arg_3_0.taskList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexTaskItem), arg_3_0.scrollView_, RegressionTaskItem)
	arg_3_0.viewClassList = {}

	for iter_3_0 = 0, arg_3_0.contentnodeTrs_.childCount - 1 do
		local var_3_0 = arg_3_0.contentnodeTrs_:GetChild(iter_3_0)
		local var_3_1 = var_0_2[iter_3_0 + 1]

		arg_3_0.viewClassList[iter_3_0] = var_3_1.New(var_3_0.gameObject)
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(arg_4_0.taskType_), arg_4_0.taskType_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.taskType_ = arg_6_1

	if not saveData("Regression", "First" .. arg_6_0.taskType_ .. RegressionDataNew:GetRegressionEndTime()) then
		saveData("Regression", "First" .. arg_6_0.taskType_ .. RegressionDataNew:GetRegressionEndTime(), true)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_FIRST, arg_6_0.taskType_), 0)
	end

	arg_6_0:RefreshTaskUI()
	arg_6_0:RefreshViewContentUI()
end

function var_0_0.RefreshViewContentUI(arg_7_0)
	local var_7_0 = table.indexof(var_0_1, arg_7_0.taskType_)

	if var_7_0 > 0 then
		arg_7_0.viewTypeController_:SetSelectedIndex(var_7_0 - 1)
		arg_7_0.viewClassList[var_7_0 - 1]:RefreshUI()
	end
end

function var_0_0.RefreshTime(arg_8_0, arg_8_1)
	local var_8_0 = table.indexof(var_0_1, arg_8_0.taskType_)

	if var_8_0 > 0 then
		arg_8_0.viewClassList[var_8_0 - 1]:RefreshTime(arg_8_1)
	end
end

function var_0_0.OnTaskListChange(arg_9_0)
	arg_9_0:RefreshTaskUI()
	arg_9_0:RefreshViewContentUI()
end

function var_0_0.RefreshTaskUI(arg_10_0)
	local var_10_0 = arg_10_0.taskType_

	arg_10_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(var_10_0)

	table.sort(arg_10_0._taskIDList, function(arg_11_0, arg_11_1)
		return arg_11_0.id < arg_11_1.id
	end)

	arg_10_0._finishList = TaskTools:GetFinishTaskIds(var_10_0)
	arg_10_0.maxRewardNum_ = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._taskIDList) do
		local var_10_1 = iter_10_1.id

		if not AssignmentCfg[var_10_1] then
			print(var_10_1)
		else
			local var_10_2 = #AssignmentCfg[var_10_1].reward

			arg_10_0.maxRewardNum_ = var_10_2 > arg_10_0.maxRewardNum_ and var_10_2 or arg_10_0.maxRewardNum_
		end
	end

	arg_10_0.taskList_:StartScroll(#arg_10_0._taskIDList)
	arg_10_0.receiveAllController_:SetSelectedState(#arg_10_0._finishList > 0 and "show" or "hide")
end

function var_0_0.IndexTaskItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._taskIDList[arg_12_1].id

	arg_12_2:SetData(var_12_0, arg_12_0.maxRewardNum_)
end

function var_0_0.GetSelectParams(arg_13_0)
	local var_13_0 = table.indexof(var_0_1, arg_13_0.taskType_)

	if arg_13_0.viewClassList[var_13_0 - 1] and arg_13_0.viewClassList[var_13_0 - 1].GetSelectParams then
		return arg_13_0.viewClassList[var_13_0 - 1]:GetSelectParams()
	end

	return nil, nil
end

function var_0_0.SetActive(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.taskList_ then
		arg_15_0.taskList_:Dispose()

		arg_15_0.taskList_ = nil
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.viewClassList) do
		if iter_15_1 then
			iter_15_1:Dispose()

			iter_15_1 = nil
		end
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
