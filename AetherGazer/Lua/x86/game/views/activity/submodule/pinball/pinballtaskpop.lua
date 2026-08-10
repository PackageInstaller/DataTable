local var_0_0 = class("PinballTaskPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballRewardPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.backBtn_, nil, JumpTools.Back)

	arg_3_0.taskListModule = CommonActivityTaskListModule.New(arg_3_0.taskPanelTrans_.gameObject)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0.taskListModule:Dispose()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.taskListModule:OnEnter()
	arg_5_0.taskListModule:RenderView(arg_5_0.params_.activityId)
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.taskListModule:OnExit()
end

function var_0_0.OnExitInput(arg_7_0)
	JumpTools.Back()

	return true
end

return var_0_0
