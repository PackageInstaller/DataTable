local HeroAttributeView = class("HeroAttributeView", ReduxView)
local var_0_1 = {
	BASE = {
		1,
		2,
		3,
		81,
		82
	},
	ELEMENT = {
		151,
		153,
		155,
		154,
		158,
		152,
		157,
		156
	},
	TARGET = {
		201,
		202,
		203,
		221,
		222,
		421
	},
	SKILL = {
		301,
		302,
		303,
		315
	}
}

function HeroAttributeView:UIName()
	return "Widget/System/Hero_arrt/HeroArrtPopUI"
end

function HeroAttributeView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroAttributeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.attributeItemList_ = {}

	for iter_3_0, iter_3_1 in pairs(var_0_1.BASE) do
		self.attributeItemList_[iter_3_1] = HeroAttributeItemView.New(self.goAttributeItem_, self.goBaseAttribute_, iter_3_0, iter_3_1)
	end

	for iter_3_2, iter_3_3 in pairs(var_0_1.ELEMENT) do
		self.attributeItemList_[iter_3_3] = HeroAttributeItemView.New(self.goAttributeItem_, self.goElementAttribute_, iter_3_2, iter_3_3)
	end

	for iter_3_4, iter_3_5 in pairs(var_0_1.TARGET) do
		self.attributeItemList_[iter_3_5] = HeroAttributeItemView.New(self.goAttributeItem_, self.goTargetAttribute_, iter_3_4, iter_3_5)
	end

	for iter_3_6, iter_3_7 in pairs(var_0_1.SKILL) do
		self.attributeItemList_[iter_3_7] = HeroAttributeItemView.New(self.goAttributeItem_, self.goSkillAttribute_, iter_3_6, iter_3_7)
	end
end

function HeroAttributeView:OnEnter()
	self.heroID_ = self.params_.heroID
	self.heroViewProxy_ = self.params_.proxy
	self.attribute_ = self.heroViewProxy_:GetHeroAllAttribute(self.heroID_)

	for iter_4_0, iter_4_1 in pairs(self.attributeItemList_) do
		iter_4_1:SetData(self.attribute_[iter_4_0] or 0)
	end

	self.scrollView_.verticalNormalizedPosition = 1
end

function HeroAttributeView:OnExit()
	return
end

function HeroAttributeView:Dispose()
	HeroAttributeView.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.attributeItemList_) do
		iter_6_1:Dispose()
	end

	self.attributeItemList_ = nil
end

function HeroAttributeView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
end

return HeroAttributeView
