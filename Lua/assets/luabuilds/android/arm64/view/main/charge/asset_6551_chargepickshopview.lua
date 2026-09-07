local ChargePickShopView = class("ChargePickShopView", import(".ChargeGiftShopView"))

ChargePickShopView.ShowPickUp = true

function ChargePickShopView:getUIName()
	return "ChargePickShopUI"
end

function ChargePickShopView:GetViewSkinWrap()
	return ChargeScene.TYPE_PICK
end

return ChargePickShopView
