local var_0_0 = class("ChargePickShopView", import(".ChargeGiftShopView"))

var_0_0.ShowPickUp = true

function var_0_0.getUIName(arg_1_0)
	return "ChargePickShopUI"
end

function var_0_0.GetViewSkinWrap(arg_2_0)
	return ChargeScene.TYPE_PICK
end

return var_0_0
