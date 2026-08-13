class = var_0_10000

local var_0_0 = "WinterFestival2025ShrineShipWordView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Shrine2022ShipWordView"))

function var_0_1.getUIName(arg_1_0)
	return "WinterFestival2025ShrineShipWordUI"
end

function var_0_1.setUIData(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Res")

	arg_2_0.shipWordSpriteList = {}
	getImageSprite = var_2

	local var_2_2 = var_2(var_2_1:Find("ShipWord" .. arg_2_0.curSelectShip))

	arg_2_0.shipWordSpriteList[arg_2_0.curSelectShip] = var_2_2

	return
end

return var_0_1
