local ShopBuiding = class("ShopBuiding", import(".NavalAcademyUpgradableBuilding"))

function ShopBuiding:GetGameObjectName()
	return "shop"
end

function ShopBuiding:GetTitle()
	return i18n("school_title_xiaomaibu")
end

function ShopBuiding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_GOLDRESFIELD)

	return
end

function ShopBuiding:GetResField()
	return self.parent.goldResField
end

return ShopBuiding
