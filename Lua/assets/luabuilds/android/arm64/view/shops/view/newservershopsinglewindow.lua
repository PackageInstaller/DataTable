local var_0_0 = class("NewServerShopSingleWindow", import("..msgbox.ShopSingleWindow"))

function var_0_0.InitWindow(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		id = arg_1_1:getConfig("goods")[1],
		type = arg_1_1:getConfig("type"),
		count = arg_1_1:getConfig("num")
	}

	onButton(arg_1_0, arg_1_0.confirmBtn, function()
		if arg_1_2 then
			arg_1_2(arg_1_1, 1, var_1_0:getConfig("name"))
		end

		arg_1_0:Close()

		return
	end, SFX_CANCEL)
	updateDrop(arg_1_0.itemTF:Find("left/IconTpl"), var_1_0)
	UpdateOwnDisplay(arg_1_0.itemOwnTF, var_1_0)
	RegisterDetailButton(arg_1_0, arg_1_0.itemDetailTF, var_1_0)

	local var_1_1 = var_1_0.type == DROP_TYPE_SHIP
	local var_1_2 = arg_1_0.itemTF:Find("ship_group")

	SetActive(var_1_2, var_1_0.type == DROP_TYPE_SHIP)

	if var_1_1 then
		local var_1_3 = tobool(getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[var_1_0.id].group_type))

		SetActive(var_1_2:Find("unlocked"), var_1_3)
		SetActive(var_1_2:Find("locked"), not var_1_3)
	end

	local var_1_4 = arg_1_0.descTF

	var_1_4.text = var_1_0.desc or var_1_0:getConfig("desc")
	arg_1_0.nameTF.text = var_1_0:getConfig("name")

	return
end

return var_0_0
