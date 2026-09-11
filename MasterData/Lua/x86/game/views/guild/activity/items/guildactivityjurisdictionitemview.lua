local GuildActivityJurisdictionItemView = class("GuildActivityJurisdictionItemView", ReduxView)

function GuildActivityJurisdictionItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivityJurisdictionItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityJurisdictionItemView:InitUI()
	self:BindCfgUI()
end

function GuildActivityJurisdictionItemView:AddUIListener()
	return
end

function GuildActivityJurisdictionItemView:AddEventListeners()
	return
end

function GuildActivityJurisdictionItemView:SetData(arg_6_1)
	self.data_ = arg_6_1

	self:UpdateView()
end

function GuildActivityJurisdictionItemView:UpdateView()
	return
end

function GuildActivityJurisdictionItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivityJurisdictionItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivityJurisdictionItemView:OnMainHomeViewTop()
	return
end

function GuildActivityJurisdictionItemView:Dispose()
	self.data_ = nil

	GuildActivityJurisdictionItemView.super.Dispose(self)
end

return GuildActivityJurisdictionItemView
