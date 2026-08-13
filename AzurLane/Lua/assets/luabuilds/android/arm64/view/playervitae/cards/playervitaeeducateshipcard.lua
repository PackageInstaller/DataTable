class = var_0_10000

local var_0_0 = "PlayerVitaeEducateShipCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerVitaeEducateBaseCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.paintingTr = arg_1_1:Find("ship_icon/painting")

	local var_1_0 = arg_1_1:Find("detail/name_bg/name_mask/name")

	arg_1_0.nameTxt = var_3.GetComponent(var_1_0, "ScrollText")

	return
end

function var_0_1.Flush(arg_2_0)
	arg_2_0:Clear()

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		PlayerVitaeMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.ON_SEL_EDUCATE_CHAR)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	getProxy = var_1
	PlayerProxy = var_2_0

	local var_2_3 = var_1(var_2_0)
	local var_2_4 = var_1.getRawData(var_2_3)

	VirtualEducateCharShip = var_1_10002

	local var_2_5 = var_1_10002.New(var_2_4:GetEducateCharacter())

	setPaintingPrefabAsync = var_2_3

	var_2_3(arg_2_0.paintingTr, var_2_5:getPainting(), "biandui")

	local var_2_6 = arg_2_0.nameTxt

	var_3.SetText(var_2_6, var_2_5.name)

	arg_2_0.ship = var_2_5

	return
end

function var_0_1.Clear(arg_4_0)
	if arg_4_0.ship then
		retPaintingPrefab = var_1

		local var_4_0 = arg_4_0.paintingTr
		local var_4_1 = arg_4_0.ship

		var_1(var_4_0, var_4.getPainting(var_4_1))
	end

	removeOnButton = var_1

	var_1(arg_4_0._tf)

	return
end

return var_0_1
