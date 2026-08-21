local var_0_0 = class("ResidentMusicRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicRewardUI"
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

	arg_4_0.taskListModule = LimitTaskListModule.New(arg_4_0.m_list, MusicTaskItem)
	arg_4_0.oneClickController = arg_4_0.controller_:GetController("OneClick")

	arg_4_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		arg_4_0:RefreshReciveBtn()
		arg_4_0.taskListModule:RenderView(arg_4_0.activityID)
	end)
	arg_4_0:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		arg_4_0:RefreshReciveBtn()
		arg_4_0.taskListModule:RenderView(arg_4_0.activityID)
	end)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.m_mask, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.onegetBtn_, nil, function()
		TaskTools:GetAllCanReciveTaskByActivityID(arg_7_0.activityID)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.taskListModule:OnEnter()

	arg_10_0.activityID = arg_10_0.params_.activity_id

	if arg_10_0.activityID then
		arg_10_0.taskListModule:RenderView(arg_10_0.activityID)
	end

	arg_10_0:RefreshReciveBtn()
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.RefreshReciveBtn(arg_12_0)
	if #TaskTools:GetCanGetActivityTaskList(arg_12_0.activityID) > 0 then
		arg_12_0.oneClickController:SetSelectedState("state1")
	else
		arg_12_0.oneClickController:SetSelectedState("state0")
	end
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0.taskListModule:OnExit()
	manager.windowBar:HideBar()
end

function var_0_0.OnExitInput(arg_14_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.taskListModule:Dispose()
	arg_15_0:RemoveAllListeners()
	arg_15_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
