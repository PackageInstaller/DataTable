local GuildActivitySPNoteView = class("GuildActivitySPNoteView", ReduxView)

function GuildActivitySPNoteView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPNoteUI"
end

function GuildActivitySPNoteView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPNoteView:OnCtor()
	return
end

function GuildActivitySPNoteView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPNoteView:InitUI()
	self:BindCfgUI()
end

function GuildActivitySPNoteView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivitySPNoteView:AddEventListeners()
	return
end

function GuildActivitySPNoteView:OnTop()
	self:UpdateBar()
end

function GuildActivitySPNoteView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivitySPNoteView:UpdateBar()
	self:ShowDefaultBar()
end

function GuildActivitySPNoteView:OnEnter()
	self:AddEventListeners()
end

function GuildActivitySPNoteView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function GuildActivitySPNoteView:OnMainHomeViewTop()
	return
end

function GuildActivitySPNoteView:Dispose()
	GuildActivitySPNoteView.super.Dispose(self)
end

return GuildActivitySPNoteView
