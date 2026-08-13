class = var_0_10000

local var_0_0 = "StrategyPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BasePanel"))

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.icon = var_1.Find(var_1_0, "window/panel/item/icon_bg/icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.count = var_1.Find(var_1_1, "window/panel/item/icon_bg/count")

	local var_1_2 = arg_1_0._tf

	arg_1_0.name = var_1.Find(var_1_2, "window/panel/item/name")

	local var_1_3 = arg_1_0._tf

	arg_1_0.desc = var_1.Find(var_1_3, "window/panel/item/desc")

	local var_1_4 = arg_1_0._tf

	arg_1_0.btnCancel = var_1.Find(var_1_4, "window/panel/actions/cancel_button")

	local var_1_5 = arg_1_0._tf

	arg_1_0.btnUse = var_1.Find(var_1_5, "window/panel/actions/use_button")

	local var_1_6 = arg_1_0._tf

	arg_1_0.btnBack = var_1.Find(var_1_6, "top/btnBack")

	local var_1_7 = arg_1_0._tf

	arg_1_0.tips = var_1.Find(var_1_7, "window/panel/tips")
	findTF = var_1
	arg_1_0.txSwitch = var_1(arg_1_0.btnUse, "switch")
	findTF = var_1
	arg_1_0.txUse = var_1(arg_1_0.btnUse, "use")
	arg_1_0.onConfirm = nil
	arg_1_0.onCancel = nil

	return
end

function var_0_1.set(arg_2_0, arg_2_1)
	arg_2_0.strategy = arg_2_1
	pg = var_1_10002

	local var_2_0 = var_1_10002.strategy_data_template[arg_2_1.id]

	GetImageSpriteFromAtlasAsync = var_3

	var_3("strategyicon/" .. var_2_0.icon, "", arg_2_0.icon)

	if var_2_0.type == 1 then
		setText = var_3

		var_3(arg_2_0.count, "")

		setActive = var_3

		var_3(arg_2_0.tips, true)

		setActive = var_3

		var_3(arg_2_0.txSwitch, true)

		setActive = var_3

		var_3(arg_2_0.txUse, false)
	else
		setText = var_3

		var_3(arg_2_0.count, arg_2_1.count)

		setActive = var_3

		var_3(arg_2_0.tips, false)

		setActive = var_3

		var_3(arg_2_0.txSwitch, false)

		setActive = var_3

		var_3(arg_2_0.txUse, true)
	end

	setText = var_3

	var_3(arg_2_0.name, var_2_0.name)

	setText = var_3

	var_3(arg_2_0.desc, var_2_0.desc)

	onButton = var_3

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.btnBack

	local function var_2_3()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10008

	var_3(var_2_1, var_2_2, var_2_3, var_1_10008)

	onButton = var_3

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.btnCancel

	local function var_2_6()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10008

	var_3(var_2_4, var_2_5, var_2_6, var_1_10008)

	onButton = var_3

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.btnUse

	local function var_2_9()
		if arg_2_0.onConfirm then
			arg_2_0.onConfirm()
		end

		return
	end

	SFX_CONFIRM = var_1_10008

	var_3(var_2_7, var_2_8, var_2_9, var_1_10008)

	return
end

return var_0_1
