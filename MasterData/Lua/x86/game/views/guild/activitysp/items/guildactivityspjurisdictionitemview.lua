local GuildActivitySPJurisdictionItemView = class("GuildActivitySPJurisdictionItemView", ReduxView)

function GuildActivitySPJurisdictionItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPJurisdictionItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPJurisdictionItemView:InitUI()
	self:BindCfgUI()
end

function GuildActivitySPJurisdictionItemView:AddUIListener()
	return
end

function GuildActivitySPJurisdictionItemView:AddEventListeners()
	return
end

function GuildActivitySPJurisdictionItemView:SetData(arg_6_1)
	self.data_ = arg_6_1

	self:UpdateView()
end

function GuildActivitySPJurisdictionItemView:UpdateView()
	return
end

function GuildActivitySPJurisdictionItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivitySPJurisdictionItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPJurisdictionItemView:OnMainHomeViewTop()
	return
end

function GuildActivitySPJurisdictionItemView:Dispose()
	self.data_ = nil

	GuildActivitySPJurisdictionItemView.super.Dispose(self)
end

return GuildActivitySPJurisdictionItemView
