local var_0_0 = class("ShipExpItemUsageCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.nameTxt = arg_1_1:Find("name"):GetComponent(typeof(Text))
	arg_1_0.itemTF = arg_1_1:Find("item")
	arg_1_0.valueTxt = arg_1_1:Find("value/Text"):GetComponent(typeof(Text))
	arg_1_0.value = 0

	pressPersistTrigger(arg_1_1:Find("m10"), 0.5, function()
		arg_1_0.value = arg_1_0.value - 10

		arg_1_0:UpdateValue(true)

		return
	end, nil, true, true, 0.15, SFX_PANEL)
	pressPersistTrigger(arg_1_1:Find("a10"), 0.5, function()
		arg_1_0.value = arg_1_0.value + 10

		arg_1_0:UpdateValue()

		return
	end, nil, true, true, 0.15, SFX_PANEL)
	pressPersistTrigger(arg_1_1:Find("a1"), 0.5, function()
		arg_1_0.value = arg_1_0.value + 1

		arg_1_0:UpdateValue()

		return
	end, nil, true, true, 0.15, SFX_PANEL)
	pressPersistTrigger(arg_1_1:Find("m1"), 0.5, function()
		arg_1_0.value = arg_1_0.value - 1

		arg_1_0:UpdateValue(true)

		return
	end, nil, true, true, 0.15, SFX_PANEL)

	return
end

function var_0_0.SetCallBack(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1

	return
end

function var_0_0.GetItem(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(BagProxy):getItemById(arg_7_1)

	var_7_0 = var_7_0 or Drop.New({
		count = 0,
		type = DROP_TYPE_ITEM,
		id = arg_7_1
	})

	return var_7_0
end

function var_0_0.Update(arg_8_0, arg_8_1)
	arg_8_0.value = 0

	local var_8_0 = arg_8_0:GetItem(arg_8_1)

	arg_8_0.item = var_8_0

	updateDrop(arg_8_0.itemTF, {
		type = DROP_TYPE_ITEM,
		id = arg_8_1,
		count = var_8_0.count
	})

	if var_8_0.count == 0 then
		setText(arg_8_0.itemTF:Find("icon_bg/count"), 0)
	end

	arg_8_0.nameTxt.text = string.format("<color=#%s>%s</color>", ItemRarity.Rarity2HexColor(var_8_0:getConfig("rarity")), var_8_0:getConfig("name"))

	arg_8_0:UpdateValue()

	return
end

function var_0_0.UpdateValue(arg_9_0, arg_9_1)
	arg_9_0.value = math.min(arg_9_0.value, arg_9_0.item.count)
	arg_9_0.value = math.max(arg_9_0.value, 0)
	arg_9_0.valueTxt.text = arg_9_0.value

	if arg_9_0.callback then
		arg_9_0:callback(arg_9_0.item.id, arg_9_0.value, arg_9_1)
	end

	return
end

function var_0_0.ForceUpdateValue(arg_10_0, arg_10_1)
	arg_10_0.value = arg_10_1
	arg_10_0.valueTxt.text = arg_10_0.value

	return
end

function var_0_0.Dispose(arg_11_0)
	pg.DelegateInfo.Dispose(arg_11_0)

	return
end

return var_0_0
