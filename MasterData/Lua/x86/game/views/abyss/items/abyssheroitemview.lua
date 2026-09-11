local AbyssHeroItemView = class("AbyssHeroItemView", ReduxView)

function AbyssHeroItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssHeroItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssHeroItemView:InitUI()
	self:BindCfgUI()
end

function AbyssHeroItemView:AddUIListener()
	return
end

function AbyssHeroItemView:AddEventListeners()
	return
end

function AbyssHeroItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.heroId_ = arg_6_2

	self:UpdateView()
end

function AbyssHeroItemView:UpdateView()
	self.roleImage_.sprite = ItemTools.getItemSprite(HeroTools.HeroUsingSkinInfo(self.heroId_).id)
end

function AbyssHeroItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssHeroItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssHeroItemView:OnMainHomeViewTop()
	return
end

function AbyssHeroItemView:Dispose()
	self.data_ = nil

	AbyssHeroItemView.super.Dispose(self)
end

return AbyssHeroItemView
