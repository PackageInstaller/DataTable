local GuildBossBuffItem = class("GuildBossBuffItem", ReduxView)

function GuildBossBuffItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossBuffItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossBuffItem:InitUI()
	self:BindCfgUI()
end

function GuildBossBuffItem:AddUIListener()
	return
end

function GuildBossBuffItem:AddEventListeners()
	return
end

function GuildBossBuffItem:OnTop()
	self:UpdateBar()
end

function GuildBossBuffItem:UpdateBar()
	return
end

function GuildBossBuffItem:OnEnter()
	self:AddEventListeners()
end

function GuildBossBuffItem:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossBuffItem:OnMainHomeViewTop()
	return
end

function GuildBossBuffItem:Dispose()
	GuildBossBuffItem.super.Dispose(self)
end

return GuildBossBuffItem
