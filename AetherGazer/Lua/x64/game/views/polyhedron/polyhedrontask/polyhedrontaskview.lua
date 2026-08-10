local var_0_0 = class("PolyhedronTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronTaskPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.taskListModule_ = CommonTaskListModule.New(arg_4_0.comTaskList_)
	arg_4_0.awardController_ = arg_4_0.controller_:GetController("award")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.allBtn_, nil, function()
		TaskTools:GetAllCanReciveTask(arg_5_0.taskIDList_)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.taskListModule_:OnEnter()

	arg_9_0.activityID_ = PolyhedronData:GetActivityID()
	arg_9_0.taskIDList_ = TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.POLYHEDRON_RESIDENT_TASK)

	arg_9_0:RegistEventListener(ACTIVITY_UPDATE, function(arg_10_0)
		local var_10_0 = ActivityTools.GetActivityType(arg_10_0)

		if ActivityTemplateConst.POLYHEDRON_ACTIVITY == var_10_0 then
			arg_9_0.activityID_ = arg_10_0

			arg_9_0:RefreshTaskList()
		end
	end)
	arg_9_0:RefreshTaskList()
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:RefreshReciveBtn()
end

function var_0_0.RefreshReciveBtn(arg_12_0)
	if #TaskTools:GetFinishTaskIDList(arg_12_0.taskIDList_) > 0 then
		arg_12_0.awardController_:SetSelectedState("show")
	else
		arg_12_0.awardController_:SetSelectedState("close")
	end
end

function var_0_0.RefreshTaskList(arg_13_0)
	arg_13_0.taskListModule_:RenderTypeTaskList(TaskConst.TASK_TYPE.POLYHEDRON_RESIDENT_TASK)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.taskListModule_:OnExit()
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.taskListModule_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
