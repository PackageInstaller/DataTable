local var_0_0 = class("Dorm3dIKController")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.triggerName = arg_1_1.triggerName
	arg_1_0.controllerName = arg_1_1.controllerName
	arg_1_0.subTargets = arg_1_1.subTargets
	arg_1_0.actionType = arg_1_1.actionType
	arg_1_0.controlRect = arg_1_1.controlRect
	arg_1_0.actionRect = arg_1_1.actionRect
	arg_1_0.backTime = arg_1_1.backTime
	arg_1_0.actionRevertTime = arg_1_1.actionRevertTime
	arg_1_0.timelineActionEvent = arg_1_1.timelineActionEvent
	arg_1_0.ignoreDrag = arg_1_1.ignoreDrag

	return
end

function var_0_0.GetTriggerName(arg_2_0)
	return arg_2_0.triggerName
end

function var_0_0.GetControllerPath(arg_3_0)
	return arg_3_0.controllerName
end

function var_0_0.GetSubTargets(arg_4_0)
	return arg_4_0.subTargets
end

function var_0_0.GetActionType(arg_5_0)
	return arg_5_0.actionType
end

function var_0_0.GetControlRect(arg_6_0)
	return arg_6_0.controlRect
end

function var_0_0.GetActionRect(arg_7_0)
	return arg_7_0.actionRect
end

function var_0_0.GetBackTime(arg_8_0)
	return arg_8_0.backTime
end

function var_0_0.GetActionRevertTime(arg_9_0)
	return arg_9_0.actionRevertTime
end

function var_0_0.GetTimelineActionEvent(arg_10_0)
	return arg_10_0.timelineActionEvent
end

function var_0_0.IsIgnoreDrag(arg_11_0)
	return arg_11_0.ignoreDrag
end

return var_0_0
