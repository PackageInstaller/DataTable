local FishingNoteView = class("FishingNoteView", ReduxView)

function FishingNoteView:UIName()
	return "UI/Fishing/FishingNoteUI"
end

function FishingNoteView:UIParent()
	return manager.ui.uiPop.transform
end

function FishingNoteView:OnCtor()
	return
end

function FishingNoteView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingNoteView:InitUI()
	self:BindCfgUI()
end

function FishingNoteView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function FishingNoteView:AddEventListeners()
	return
end

function FishingNoteView:OnTop()
	self:UpdateBar()
end

function FishingNoteView:UpdateBar()
	return
end

function FishingNoteView:OnEnter()
	self:AddEventListeners()

	self.descLabel_.text = GetTips("ACTIVITY_SUMMER_FISH_DESCRIPE")
end

function FishingNoteView:OnExit()
	self:RemoveAllEventListener()
end

function FishingNoteView:OnMainHomeViewTop()
	return
end

function FishingNoteView:Dispose()
	FishingNoteView.super.Dispose(self)
end

return FishingNoteView
