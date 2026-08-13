class = var_0_10000

local var_0_0 = var_0_10000("IslandMiniShipCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform

	local var_1_0 = arg_1_0.tf

	arg_1_0.addBtn = var_2.Find(var_1_0, "add")

	local var_1_1 = arg_1_0.tf

	arg_1_0.iconTr = var_2.Find(var_1_1, "icon")

	local var_1_2 = arg_1_0.tf

	arg_1_0.selected = var_2.Find(var_1_2, "sel")

	local var_1_3 = arg_1_0.tf
	local var_1_4 = var_2.Find(var_1_3, "sel_1")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.selImg = var_1_5(var_1_4, var_5(var_1_10007))

	local var_1_6 = arg_1_0.tf

	arg_1_0.redDot = var_2.Find(var_1_6, "red_dot")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
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

	var_1_10004("island/IslandShipIcon/" .. var_2_3, "", arg_2_0.iconTr)
	arg_2_0:UpdateSelected(arg_2_2)
	arg_2_0:FlushRedDot()

	return
end

function var_0_0.FlushRedDot(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.redDot, false)

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 == arg_4_0.configId

	setActive = var_1_10003

	var_1_10003(arg_4_0.selected, var_4_0)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
