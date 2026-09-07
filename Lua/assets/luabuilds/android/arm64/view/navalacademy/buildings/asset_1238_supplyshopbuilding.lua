local SupplyShopBuilding = class("SupplyShopBuilding", import(".NavalAcademyBuilding"))

function SupplyShopBuilding:GetGameObjectName()
	return "supplyShop"
end

function SupplyShopBuilding:GetTitle()
	return i18n("school_title_shangdian")
end

function SupplyShopBuilding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_SUPPLYSHOP)

	return
end

function SupplyShopBuilding:IsTip()
	local var_4_0 = getProxy(ShopsProxy):getShopStreet()

	return var_4_0 and var_4_0:isUpdateGoods()
end

return SupplyShopBuilding
