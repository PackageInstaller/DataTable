class = var_0_10000

local var_0_0 = var_0_10000("ShipExpItemUsageCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	local var_1_0 = arg_1_1:Find("name")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_1(var_1_0, var_4(var_1_10005))
	arg_1_0.itemTF = arg_1_1:Find("item")

	local var_1_2 = arg_1_1:Find("value/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.valueTxt = var_1_3(var_1_2, var_4(var_1_10005))
	arg_1_0.value = 0
	pressPersistTrigger = var_2

	local var_1_4 = arg_1_1:Find("m10")
	local var_1_5 = 0.5

	local function var_1_6()
		arg_1_0.value = arg_1_0.value - 10

		local var_2_0 = arg_1_0

		var_0.UpdateValue(var_2_0, true)

		return
	end

	local var_1_7
	local var_1_8 = true
	local var_1_9 = true
	local var_1_10 = 0.15

	SFX_PANEL = var_1_10010

	var_2(var_1_4, var_1_5, var_1_6, var_1_7, var_1_8, var_1_9, var_1_10, var_1_10010)

	pressPersistTrigger = var_2

	local var_1_11 = arg_1_1:Find("a10")
	local var_1_12 = 0.5

	local function var_1_13()
		arg_1_0.value = arg_1_0.value + 10

		local var_3_0 = arg_1_0

		var_0.UpdateValue(var_3_0)

		return
	end

	local var_1_14
	local var_1_15 = true
	local var_1_16 = true
	local var_1_17 = 0.15

	SFX_PANEL = var_1_10010

	var_2(var_1_11, var_1_12, var_1_13, var_1_14, var_1_15, var_1_16, var_1_17, var_1_10010)

	pressPersistTrigger = var_2

	local var_1_18 = arg_1_1:Find("a1")
	local var_1_19 = 0.5

	local function var_1_20()
		arg_1_0.value = arg_1_0.value + 1

		local var_4_0 = arg_1_0

		var_0.UpdateValue(var_4_0)

		return
	end

	local var_1_21
	local var_1_22 = true
	local var_1_23 = true
	local var_1_24 = 0.15

	SFX_PANEL = var_1_10010

	var_2(var_1_18, var_1_19, var_1_20, var_1_21, var_1_22, var_1_23, var_1_24, var_1_10010)

	pressPersistTrigger = var_2

	local var_1_25 = arg_1_1:Find("m1")
	local var_1_26 = 0.5

	local function var_1_27()
		arg_1_0.value = arg_1_0.value - 1

		local var_5_0 = arg_1_0

		var_0.UpdateValue(var_5_0, true)

		return
	end

	local var_1_28
	local var_1_29 = true
	local var_1_30 = true
	local var_1_31 = 0.15

	SFX_PANEL = var_1_10010

	var_2(var_1_25, var_1_26, var_1_27, var_1_28, var_1_29, var_1_30, var_1_31, var_1_10010)

	return
end

function var_0_0.SetCallBack(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1

	return
end

function var_0_0.GetItem(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	BagProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)
	local var_7_1

	if not var_2.getItemById(var_7_0, arg_7_1) then
		Drop = var_7_1
		var_7_1 = var_7_1.New

		local var_7_2 = {
			count = 0
		}

		DROP_TYPE_ITEM = var_4
		var_7_2.type = var_4
		var_7_2.id = arg_7_1
		var_7_1 = var_7_1(var_7_2)
	end

	return var_7_1
end

function var_0_0.Update(arg_8_0, arg_8_1)
	arg_8_0.value = 0

	local var_8_0 = arg_8_0

	arg_8_0.item = arg_8_0.GetItem(var_8_0, arg_8_1)
	updateDrop = var_8_0

	local var_8_1 = arg_8_0.itemTF
	local var_8_2 = {}

	DROP_TYPE_ITEM = var_1_10006
	var_8_2.type = var_1_10006
	var_8_2.id = arg_8_1
	var_8_2.count = var_2.count

	var_8_0(var_8_1, var_8_2)

	if var_2.count == 0 then
		setText = var_3

		local var_8_3 = arg_8_0.itemTF

		var_3(var_8_1.Find(var_8_3, "icon_bg/count"), 0)
	end

	local var_8_4 = arg_8_0.nameTxt

	string = var_8_1

	local var_8_5 = var_8_1.format
	local var_8_6 = "<color=#%s>%s</color>"

	ItemRarity = var_6
	var_8_4.text = var_8_5(var_8_6, var_6.Rarity2HexColor(var_2:getConfig("rarity")), var_2:getConfig("name"))

	arg_8_0:UpdateValue()

	return
end

function var_0_0.UpdateValue(arg_9_0, arg_9_1)
	math = var_1_10002
	arg_9_0.value = var_1_10002.min(arg_9_0.value, arg_9_0.item.count)
	math = var_2
	arg_9_0.value = var_2.max(arg_9_0.value, 0)
	arg_9_0.valueTxt.text = arg_9_0.value

	if arg_9_0.callback then
		arg_9_0.callback(arg_9_0, arg_9_0.item.id, arg_9_0.value, arg_9_1)
	end

	return
end

function var_0_0.ForceUpdateValue(arg_10_0, arg_10_1)
	arg_10_0.value = arg_10_1
	arg_10_0.valueTxt.text = arg_10_0.value

	return
end

function var_0_0.Dispose(arg_11_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_11_0)

	return
end

return var_0_0
