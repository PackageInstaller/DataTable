local var_0_0 = class("RegressionNewPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("UI/ReturnUI/RegressionTaskUI")
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

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.scrollView_, TaskDailyItemView)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(arg_4_0.taskType_), arg_4_0.taskType_)
	end)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return
	end

	arg_7_0.taskType_ = arg_7_1
	arg_7_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(arg_7_0.taskType_)
	arg_7_0._finishList = TaskTools:GetFinishTaskIds(arg_7_0.taskType_)

	arg_7_0.scrollHelper_:StartScroll(#arg_7_0._taskIDList)
	arg_7_0:RefreshRecivedAll()
end

function var_0_0.Refresh(arg_8_0)
	arg_8_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(arg_8_0.taskType_)
	arg_8_0._finishList = TaskTools:GetFinishTaskIds(arg_8_0.taskType_)

	arg_8_0.scrollHelper_:Refresh()
	arg_8_0:RefreshRecivedAll()
end

function var_0_0.RefreshRecivedAll(arg_9_0)
	if #arg_9_0._finishList > 0 then
		SetActive(arg_9_0.goAllAccept_, true)
	else
		SetActive(arg_9_0.goAllAccept_, false)
	end
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._taskIDList[arg_10_1].id

	arg_10_2:ReEnter(var_10_0)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.RefreshScroll(arg_12_0)
	arg_12_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(arg_12_0.taskType_)

	local var_12_0 = arg_12_0.scrollHelper_:GetScrolledPosition()

	arg_12_0.scrollHelper_:StartScrollWithoutAnimator(#arg_12_0._taskIDList, var_12_0)
end

function var_0_0.OnTaskListChange(arg_13_0)
	arg_13_0:RefreshScroll()

	arg_13_0._finishList = TaskTools:GetFinishTaskIds(arg_13_0.taskType_)

	arg_13_0:RefreshRecivedAll()
end

return var_0_0
