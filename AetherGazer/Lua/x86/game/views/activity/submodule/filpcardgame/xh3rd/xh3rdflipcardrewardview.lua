local var_0_0 = class("XH3rdFlipCardRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return XH3rdFlipCardTool.GetRewardUI()
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
	arg_5_0.taskListModule:RenderView(arg_5_0.params_.activityID)
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.taskListModule:OnExit()
end

return var_0_0
