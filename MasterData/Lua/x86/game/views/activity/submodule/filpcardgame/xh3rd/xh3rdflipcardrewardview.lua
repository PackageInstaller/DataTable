local XH3rdFlipCardRewardView = class("XH3rdFlipCardRewardView", ReduxView)

function XH3rdFlipCardRewardView:UIName()
	return XH3rdFlipCardTool.GetRewardUI()
end

function XH3rdFlipCardRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function XH3rdFlipCardRewardView:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.backBtn_, nil, JumpTools.Back)

	self.taskListModule = CommonActivityTaskListModule.New(self.taskPanelTrans_.gameObject)
end

function XH3rdFlipCardRewardView:Dispose()
	XH3rdFlipCardRewardView.super.Dispose(self)
	self.taskListModule:Dispose()
end

function XH3rdFlipCardRewardView:OnEnter()
	self.taskListModule:OnEnter()
	self.taskListModule:RenderView(self.params_.activityID)
end

function XH3rdFlipCardRewardView:OnExit()
	self.taskListModule:OnExit()
end

return XH3rdFlipCardRewardView
