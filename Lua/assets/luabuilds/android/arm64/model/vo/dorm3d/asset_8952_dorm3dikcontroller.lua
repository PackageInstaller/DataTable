local Dorm3dIKController = class("Dorm3dIKController")

function Dorm3dIKController:Ctor(arg_1_1)
	self.triggerName = arg_1_1.triggerName
	self.controllerName = arg_1_1.controllerName
	self.subTargets = arg_1_1.subTargets
	self.actionType = arg_1_1.actionType
	self.controlRect = arg_1_1.controlRect
	self.actionRect = arg_1_1.actionRect
	self.backTime = arg_1_1.backTime
	self.actionRevertTime = arg_1_1.actionRevertTime
	self.timelineActionEvent = arg_1_1.timelineActionEvent
	self.ignoreDrag = arg_1_1.ignoreDrag

	return
end

function Dorm3dIKController:GetTriggerName()
	return self.triggerName
end

function Dorm3dIKController:GetControllerPath()
	return self.controllerName
end

function Dorm3dIKController:GetSubTargets()
	return self.subTargets
end

function Dorm3dIKController:GetActionType()
	return self.actionType
end

function Dorm3dIKController:GetControlRect()
	return self.controlRect
end

function Dorm3dIKController:GetActionRect()
	return self.actionRect
end

function Dorm3dIKController:GetBackTime()
	return self.backTime
end

function Dorm3dIKController:GetActionRevertTime()
	return self.actionRevertTime
end

function Dorm3dIKController:GetTimelineActionEvent()
	return self.timelineActionEvent
end

function Dorm3dIKController:IsIgnoreDrag()
	return self.ignoreDrag
end

return Dorm3dIKController
