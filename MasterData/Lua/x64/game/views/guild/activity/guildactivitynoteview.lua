local GuildActivityNoteView = class("GuildActivityNoteView", ReduxView)

function GuildActivityNoteView:UIName()
	return "UI/GuildActivityUI/GuildActivityNoteUI"
end

function GuildActivityNoteView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityNoteView:OnCtor()
	return
end

function GuildActivityNoteView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityNoteView:InitUI()
	self:BindCfgUI()
end

function GuildActivityNoteView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivityNoteView:AddEventListeners()
	return
end

function GuildActivityNoteView:OnTop()
	self:UpdateBar()
end

function GuildActivityNoteView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivityNoteView:UpdateBar()
	self:ShowDefaultBar()
end

function GuildActivityNoteView:OnEnter()
	self:AddEventListeners()
end

function GuildActivityNoteView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function GuildActivityNoteView:OnMainHomeViewTop()
	return
end

function GuildActivityNoteView:Dispose()
	GuildActivityNoteView.super.Dispose(self)
end

return GuildActivityNoteView
