local PinballTaskPop = class("PinballTaskPop", ReduxView)

function PinballTaskPop:UIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballRewardPopUI"
end

function PinballTaskPop:UIParent()
	return manager.ui.uiPop.transform
end

function PinballTaskPop:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.backBtn_, nil, JumpTools.Back)

	self.taskListModule = CommonActivityTaskListModule.New(self.taskPanelTrans_.gameObject)
end

function PinballTaskPop:Dispose()
	PinballTaskPop.super.Dispose(self)
	self.taskListModule:Dispose()
end

function PinballTaskPop:OnEnter()
	self.taskListModule:OnEnter()
	self.taskListModule:RenderView(self.params_.activityId)
end

function PinballTaskPop:OnExit()
	self.taskListModule:OnExit()
end

function PinballTaskPop:OnExitInput()
	JumpTools.Back()

	return true
end

return PinballTaskPop
