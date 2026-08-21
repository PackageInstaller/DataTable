local var_0_0 = class("WinterFestival2025ShrineShipWordView", import(".Shrine2022ShipWordView"))

function var_0_0.getUIName(arg_1_0)
	return "WinterFestival2025ShrineShipWordUI"
end

function var_0_0.setUIData(arg_2_0)
	arg_2_0.shipWordSpriteList = {}
	arg_2_0.shipWordSpriteList[arg_2_0.curSelectShip] = getImageSprite(arg_2_0._tf:Find("Res"):Find("ShipWord" .. arg_2_0.curSelectShip))

	return
end

return var_0_0
