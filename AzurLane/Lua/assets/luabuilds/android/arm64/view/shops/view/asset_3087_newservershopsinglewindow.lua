class = var_0_10000

local var_0_0 = "NewServerShopSingleWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..msgbox.ShopSingleWindow"))

function var_0_1.InitWindow(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		id = arg_1_1:getConfig("goods")[1],
		type = arg_1_1:getConfig("type"),
		count = arg_1_1:getConfig("num")
	}

	onButton = var_4

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.confirmBtn

	local function var_1_3()
		if arg_1_2 then
			local var_2_0 = arg_1_2
			local var_2_1 = arg_1_1
			local var_2_2 = 1
			local var_2_3 = var_1_0

			var_2_0(var_2_1, var_2_2, var_4.getConfig(var_2_3, "name"))
		end

		local var_2_4 = arg_1_0

		var_0.Close(var_2_4)

		return
	end

	SFX_CANCEL = var_1_10009

	var_4(var_1_1, var_1_2, var_1_3, var_1_10009)

	updateDrop = var_4

	local var_1_4 = arg_1_0.itemTF

	var_4(var_6.Find(var_1_4, "left/IconTpl"), var_1_0)

	UpdateOwnDisplay = var_4

	var_4(arg_1_0.itemOwnTF, var_1_0)

	RegisterDetailButton = var_4

	var_4(arg_1_0, arg_1_0.itemDetailTF, var_1_0)

	local var_1_5 = var_1_0.type

	DROP_TYPE_SHIP = var_1_10005

	local var_1_6 = var_1_5 == var_1_10005
	local var_1_7 = arg_1_0.itemTF
	local var_1_8 = var_5.Find(var_1_7, "ship_group")

	SetActive = var_6

	var_6(var_1_8, var_1_6)

	if var_1_6 then
		tobool = var_6
		getProxy = var_8
		CollectionProxy = var_1_10010

		local var_1_9 = var_8(var_1_10010)
		local var_1_10 = var_8.getShipGroup

		pg = var_1_10011

		local var_1_11 = var_6(var_1_10(var_1_9, var_1_10011.ship_data_template[var_1_0.id].group_type))

		SetActive = var_1_7

		var_1_7(var_1_8:Find("unlocked"), var_1_11)

		SetActive = var_1_7

		var_1_7(var_1_8:Find("locked"), not var_1_11)
	end

	local var_1_12 = arg_1_0.descTF
	local var_1_13

	if not var_1_0.desc then
		var_1_13 = var_1_0:getConfig("desc")
	end

	var_1_12.text = var_1_13
	arg_1_0.nameTF.text = var_1_0:getConfig("name")

	return
end

return var_0_1
