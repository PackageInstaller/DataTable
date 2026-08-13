class = var_0_10000

local var_0_0 = "ChargePickShopView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ChargeGiftShopView"))

var_0_1.ShowPickUp = true

function var_0_1.getUIName(arg_1_0)
	return "ChargePickShopUI"
end

function var_0_1.GetViewSkinWrap(arg_2_0)
	ChargeScene = var_1_10001

	return var_1_10001.TYPE_PICK
end

return var_0_1
