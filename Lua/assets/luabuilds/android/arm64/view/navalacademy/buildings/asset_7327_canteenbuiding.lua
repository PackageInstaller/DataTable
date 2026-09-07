local CanteenBuiding = class("CanteenBuiding", import(".NavalAcademyUpgradableBuilding"))

function CanteenBuiding:GetGameObjectName()
	return "canteen"
end

function CanteenBuiding:GetTitle()
	return i18n("school_title_shitang")
end

function CanteenBuiding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_OILRESFIELD)

	return
end

function CanteenBuiding:GetResField()
	return self.parent.oilResField
end

return CanteenBuiding
