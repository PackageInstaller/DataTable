local var_0_0 = class("DromIlluTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IllustrateRewardPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.taskType_ = TaskConst.TASK_TYPE.DORM_ILLU

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.taskType_ = TaskConst.TASK_TYPE.DORM_ILLU
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.comTaskList_, DromIlluTaskItem)
	arg_4_0.receiveBtnController_ = arg_4_0.mainControllerEx_:GetController("oneClick")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:InitData()
	arg_5_0:OnTaskListChange(true)
	SetActive(arg_5_0.gameObject_, true)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		local var_7_0 = TaskTools:GetFinishTaskIds(arg_6_0.taskType_)
		local var_7_1 = {}

		for iter_7_0 = 1, #var_7_0 do
			if AssignmentCfg[var_7_0[iter_7_0]].condition == arg_6_0.targetCondition then
				table.insert(var_7_1, var_7_0[iter_7_0])
			end
		end

		TaskAction:SubmitTaskList(var_7_1, arg_6_0.taskType_, function()
			DormRedPointTools:UpdateDormIlluRedPoint(arg_6_0.targetCondition)
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgmaskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.InitData(arg_10_0)
	arg_10_0.index_ = arg_10_0.params_.index
	arg_10_0.targetCondition = 0

	if arg_10_0.index_ == 1 then
		arg_10_0.targetCondition = DormIlluConst.TaskCondition.hero
	elseif arg_10_0.index_ == 2 then
		arg_10_0.targetCondition = DormIlluConst.TaskCondition.dance
	else
		arg_10_0.targetCondition = DormIlluConst.TaskCondition.fur
	end

	arg_10_0.taskList_ = {}

	local var_10_0 = TaskData2:GetTypedTaskSortListCommonFilter(arg_10_0.taskType_)

	for iter_10_0 = 1, #var_10_0 do
		if AssignmentCfg[var_10_0[iter_10_0].id].condition == arg_10_0.targetCondition then
			table.insert(arg_10_0.taskList_, var_10_0[iter_10_0])
		end
	end

	arg_10_0.finishList_ = {}

	local var_10_1 = TaskTools:GetFinishTaskIds(arg_10_0.taskType_)

	for iter_10_1 = 1, #var_10_1 do
		if AssignmentCfg[var_10_1[iter_10_1]].condition == arg_10_0.targetCondition then
			table.insert(arg_10_0.finishList_, var_10_1[iter_10_1])
		end
	end

	arg_10_0:RefreshRecivedAll()
end

function var_0_0.RefreshScroll(arg_11_0, arg_11_1)
	arg_11_0:UpdateData()

	if arg_11_1 then
		arg_11_0.scrollHelper_:StartScrollWithoutAnimator(#arg_11_0.taskList_)
	else
		arg_11_0.scrollHelper_:StartScroll(#arg_11_0.taskList_)
	end
end

function var_0_0.indexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskList_[arg_12_1].id

	arg_12_2:ReEnter(var_12_0)
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.UpdateData(arg_15_0)
	arg_15_0.taskList_ = {}

	local var_15_0 = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.DORM_ILLU)

	for iter_15_0 = 1, #var_15_0 do
		if AssignmentCfg[var_15_0[iter_15_0].id].condition == arg_15_0.targetCondition then
			table.insert(arg_15_0.taskList_, var_15_0[iter_15_0])
		end
	end

	arg_15_0.finishList_ = {}

	local var_15_1 = TaskTools:GetFinishTaskIds(arg_15_0.taskType_)

	for iter_15_1 = 1, #var_15_1 do
		if AssignmentCfg[var_15_1[iter_15_1]].condition == arg_15_0.targetCondition then
			table.insert(arg_15_0.finishList_, var_15_1[iter_15_1])
		end
	end
end

function var_0_0.OnTaskListChange(arg_16_0, arg_16_1)
	arg_16_0.finishList_ = {}

	local var_16_0 = TaskTools:GetFinishTaskIds(arg_16_0.taskType_)

	for iter_16_0 = 1, #var_16_0 do
		if AssignmentCfg[var_16_0[iter_16_0]].condition == arg_16_0.targetCondition then
			table.insert(arg_16_0.finishList_, var_16_0[iter_16_0])
		end
	end

	arg_16_0:RefreshRecivedAll()

	if not arg_16_1 then
		arg_16_0:RefreshScroll(true)
	else
		arg_16_0:RefreshScroll(false)
	end
end

function var_0_0.RefreshRecivedAll(arg_17_0)
	if #arg_17_0.finishList_ > 0 then
		arg_17_0:RefreshOnceState(true)
	else
		arg_17_0:RefreshOnceState(false)
	end
end

function var_0_0.RefreshOnceState(arg_18_0, arg_18_1)
	arg_18_0.receiveBtnController_:SetSelectedState(arg_18_1 and "on" or "off")
end

return var_0_0
