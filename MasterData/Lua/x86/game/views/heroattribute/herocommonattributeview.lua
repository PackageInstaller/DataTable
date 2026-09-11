local HeroCommonAttributeView = class("HeroCommonAttributeView", HeroAttributeView)

function HeroCommonAttributeView:OnEnter()
	self.attribute_ = self.params_.attribute

	for iter_1_0, iter_1_1 in pairs(self.attributeItemList_) do
		iter_1_1:SetData(self.attribute_[iter_1_0])
	end

	self.scrollView_.verticalNormalizedPosition = 1
end

return HeroCommonAttributeView
