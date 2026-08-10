local var_0_0 = class("StrategyMatrixRwardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MatrixlUI/StrategyMatriReward01UI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.taskUpdateHandler_ = handler(arg_3_0, arg_3_0.RefreshScroll)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiList_, StrategyMatrixRwardItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.taskType_ = TaskConst.TASK_TYPE.STRATEGY_MATRIX
	arg_8_0.activity_id = arg_8_0.params_.task_activity_id
	arg_8_0._taskIDList = TaskData2:GetActivityTaskSortList(arg_8_0.activity_id)

	arg_8_0.list:StartScroll(#arg_8_0._taskIDList)
	arg_8_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_8_0.taskUpdateHandler_)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.RefreshScroll(arg_10_0)
	arg_10_0._taskIDList = TaskData2:GetActivityTaskSortList(arg_10_0.activity_id)

	local var_10_0 = arg_10_0.list:GetScrolledPosition()

	arg_10_0.list:StartScrollWithoutAnimator(#arg_10_0._taskIDList, var_10_0)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._taskIDList[arg_11_1]

	arg_11_2:SetData(var_11_0)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.list:Dispose()

	arg_12_0.taskUpdateHandler_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.OnTaskListChange(arg_13_0)
	arg_13_0:RefreshScroll()
end

return var_0_0
