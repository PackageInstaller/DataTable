local GuildBossNoteView = class("GuildBossNoteView", ReduxView)

function GuildBossNoteView:UIName()
	return "UI/ClubUI/ClubBossNoteUI"
end

function GuildBossNoteView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildBossNoteView:OnCtor()
	return
end

function GuildBossNoteView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossNoteView:InitUI()
	self:BindCfgUI()
end

function GuildBossNoteView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildBossNoteView:AddEventListeners()
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function GuildBossNoteView:OnTop()
	self:UpdateBar()
end

function GuildBossNoteView:UpdateBar()
	return
end

function GuildBossNoteView:OnEnter()
	self:AddEventListeners()

	self.contentText_.text = GetTips("CLUB_BOSS_DESCRIPE")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
end

function GuildBossNoteView:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossNoteView:OnMainHomeViewTop()
	return
end

function GuildBossNoteView:Dispose()
	GuildBossNoteView.super.Dispose(self)
end

return GuildBossNoteView
