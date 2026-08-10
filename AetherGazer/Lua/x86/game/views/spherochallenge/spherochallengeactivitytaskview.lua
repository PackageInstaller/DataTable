local var_0_0 = class("SPHeroChallengeActivityTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeActivityTaskPop"
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

	arg_4_0.taskList_ = {}
	arg_4_0.taskListModule = LimitTaskListModule.New(arg_4_0.comTaskList_)
	arg_4_0.awardController = arg_4_0.controller:GetController("award")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.allBtn, nil, function()
		TaskTools:GetAllCanReciveTaskByActivityID(arg_5_0.params_.activityID)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.taskListModule:OnEnter()

	local var_9_0 = arg_9_0.params_.activityID

	if var_9_0 then
		arg_9_0.taskListModule:RenderView(var_9_0)
	end
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:RefreshReciveBtn()
end

function var_0_0.RefreshReciveBtn(arg_11_0)
	if #TaskTools:GetCanGetActivityTaskList(arg_11_0.params_.activityID) > 0 then
		arg_11_0.awardController:SetSelectedState("show")
	else
		arg_11_0.awardController:SetSelectedState("close")
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.taskListModule:OnExit()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.taskListModule:Dispose()
	arg_13_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
