local GuildActivitySPWarFieldMapTitleItemView = class("GuildActivitySPWarFieldMapTitleItemView", ReduxView)

function GuildActivitySPWarFieldMapTitleItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPWarFieldMapTitleItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPWarFieldMapTitleItemView:InitUI()
	self:BindCfgUI()
end

function GuildActivitySPWarFieldMapTitleItemView:AddUIListener()
	return
end

function GuildActivitySPWarFieldMapTitleItemView:AddEventListeners()
	return
end

function GuildActivitySPWarFieldMapTitleItemView:SetData(arg_6_1)
	self.data_ = arg_6_1

	self:UpdateView()
end

function GuildActivitySPWarFieldMapTitleItemView:UpdateView()
	return
end

function GuildActivitySPWarFieldMapTitleItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivitySPWarFieldMapTitleItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPWarFieldMapTitleItemView:OnMainHomeViewTop()
	return
end

function GuildActivitySPWarFieldMapTitleItemView:Dispose()
	self.data_ = nil

	GuildActivitySPWarFieldMapTitleItemView.super.Dispose(self)
end

return GuildActivitySPWarFieldMapTitleItemView
