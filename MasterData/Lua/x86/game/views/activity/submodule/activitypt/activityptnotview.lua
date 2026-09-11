local ActivityPtNotView = class("ActivityPtNotView", ReduxView)

function ActivityPtNotView:UIName()
	return "UI/Activity/Submodule/ActivityPt/ActivityPtNoteUI"
end

function ActivityPtNotView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityPtNotView:OnCtor()
	return
end

function ActivityPtNotView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityPtNotView:InitUI()
	self:BindCfgUI()
end

function ActivityPtNotView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ActivityPtNotView:AddEventListeners()
	return
end

function ActivityPtNotView:OnTop()
	self:UpdateBar()
end

function ActivityPtNotView:UpdateBar()
	return
end

function ActivityPtNotView:OnEnter()
	self:AddEventListeners()

	self.contentText_.text = GetTips("ACTIVITY_SUMMER_PT_REPEAT_DESCRIPE")
end

function ActivityPtNotView:OnExit()
	self:RemoveAllEventListener()
end

function ActivityPtNotView:OnMainHomeViewTop()
	return
end

function ActivityPtNotView:Dispose()
	ActivityPtNotView.super.Dispose(self)
end

return ActivityPtNotView
