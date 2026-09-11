local GuildActivityWarFieldMapTitleItemView = class("GuildActivityWarFieldMapTitleItemView", ReduxView)

function GuildActivityWarFieldMapTitleItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivityWarFieldMapTitleItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityWarFieldMapTitleItemView:InitUI()
	self:BindCfgUI()
end

function GuildActivityWarFieldMapTitleItemView:AddUIListener()
	return
end

function GuildActivityWarFieldMapTitleItemView:AddEventListeners()
	return
end

function GuildActivityWarFieldMapTitleItemView:SetData(arg_6_1)
	self.data_ = arg_6_1

	self:UpdateView()
end

function GuildActivityWarFieldMapTitleItemView:UpdateView()
	return
end

function GuildActivityWarFieldMapTitleItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivityWarFieldMapTitleItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivityWarFieldMapTitleItemView:OnMainHomeViewTop()
	return
end

function GuildActivityWarFieldMapTitleItemView:Dispose()
	self.data_ = nil

	GuildActivityWarFieldMapTitleItemView.super.Dispose(self)
end

return GuildActivityWarFieldMapTitleItemView
