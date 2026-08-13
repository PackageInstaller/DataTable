class = var_0_10000

local var_0_0 = "IslandShipCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandMiniShipCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform

	local var_1_0 = arg_1_0.tf

	arg_1_0.addBtn = var_2.Find(var_1_0, "add")

	local var_1_1 = arg_1_0.tf

	arg_1_0.iconTr = var_2.Find(var_1_1, "mask/icon")

	local var_1_2 = arg_1_0.tf

	arg_1_0.selected = var_2.Find(var_1_2, "sel")

	local var_1_3 = arg_1_0.tf
	local var_1_4 = var_2.Find(var_1_3, "Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.levelTxt = var_1_5(var_1_4, var_5(var_1_10007))

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.configId = arg_2_1
	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_2_0 = var_1_10003(var_1_10005)
	local var_2_1 = var_3.GetIsland(var_2_0)
	local var_2_2 = var_3.GetCharacterAgency(var_2_1)

	arg_2_0.ship = var_3.GetShipById(var_2_2, arg_2_1)
	setActive = var_3

	var_3(arg_2_0.addBtn, not arg_2_0.ship)

	IslandShip = var_3

	local var_2_3 = var_3.StaticGetPrefab(arg_2_1)

	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004("ShipYardIcon/" .. var_2_3, "", arg_2_0.iconTr)

	local var_2_4 = arg_2_0.levelTxt

	if arg_2_0.ship then
		local var_2_5 = "Lv."
		local var_2_6 = arg_2_0.ship
		local var_2_7

		if not (var_2_5 .. var_6.GetLevel(var_2_6)) then
			var_2_7 = ""
		end

		var_2_4.text = var_2_7

		arg_2_0:UpdateSelected(arg_2_2)

		return
	end
end

function var_0_1.Dispose(arg_3_0)
	return
end

return var_0_1
