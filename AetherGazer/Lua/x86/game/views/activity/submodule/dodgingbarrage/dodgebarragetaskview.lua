local var_0_0 = class("DodgeBarrageTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_7/ShashwatUI_3_7_BarrageUI/ShashwatUI_3_7_RewardPopUI"
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

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiListGo_, DodgeBarrageTaskItem)
	arg_4_0.btnController_ = arg_4_0.btnCon_:GetController("state")
	arg_4_0.onSubmitTaskHandle_ = handler(arg_4_0, arg_4_0.OnTaskRefresh)
	arg_4_0.onSubmitTaskListHandle_ = handler(arg_4_0, arg_4_0.OnTaskRefresh)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.taskList_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnReceiveAll_, nil, function()
		TaskAction:SubmitTaskList(arg_6_0.allRewards_)
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_10_0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_10_0.onSubmitTaskHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_10_0.onSubmitTaskListHandle_)

	arg_10_0.activityId_ = DodgeBarrageData:GetActivityId()

	arg_10_0:UpdateList()
end

function var_0_0.UpdateList(arg_11_0)
	arg_11_0.taskList_ = DodgeBarrageData:GetTaskList()

	arg_11_0.uiList_:StartScroll(#arg_11_0.taskList_)

	arg_11_0.allRewards_ = DodgeBarrageData:GetRewardTaskList()

	arg_11_0.btnController_:SetSelectedState(#arg_11_0.allRewards_ <= 0 and "hide" or "show")
end

function var_0_0.OnTaskRefresh(arg_12_0)
	DodgeBarrageData:CheckRewardTaskList()
	arg_12_0:UpdateList()
end

function var_0_0.OnExit(arg_13_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_13_0.onSubmitTaskHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_13_0.onSubmitTaskListHandle_)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
