class = var_0_10000

local var_0_0 = "RepairPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BasePanel"))

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.desc = var_1.Find(var_1_0, "window/desc")

	local var_1_1 = arg_1_0._tf

	arg_1_0.descFree = var_1.Find(var_1_1, "window/text_free")

	local var_1_2 = arg_1_0._tf

	arg_1_0.descCharge = var_1.Find(var_1_2, "window/text_charge")

	local var_1_3 = arg_1_0._tf

	arg_1_0.free = var_1.Find(var_1_3, "window/text_free/time")

	local var_1_4 = arg_1_0._tf

	arg_1_0.charge = var_1.Find(var_1_4, "window/text_charge/time")

	local var_1_5 = arg_1_0._tf

	arg_1_0.diamond = var_1.Find(var_1_5, "window/diamond")
	findTF = var_1
	arg_1_0.cost = var_1(arg_1_0.diamond, "cost")

	local var_1_6 = arg_1_0._tf

	arg_1_0.cancel = var_1.Find(var_1_6, "window/actions/cancel_button")

	local var_1_7 = arg_1_0._tf

	arg_1_0.confirm = var_1.Find(var_1_7, "window/actions/use_button")

	local var_1_8 = arg_1_0._tf

	arg_1_0.back = var_1.Find(var_1_8, "top/btnBack")
	arg_1_0.onConfirm = nil
	arg_1_0.onCancel = nil

	return
end

function var_0_1.set(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.repairTimes = arg_2_1
	arg_2_0.freeTimes = arg_2_2
	arg_2_0.chargeTimes = arg_2_3
	arg_2_0.chargeDiamond = arg_2_4

	local var_2_0 = arg_2_0.freeTimes

	math = var_1_10006

	local var_2_1 = var_2_0 - var_1_10006.min(arg_2_0.repairTimes, arg_2_0.freeTimes)
	local var_2_2 = arg_2_0.chargeTimes - (arg_2_0.repairTimes - (arg_2_0.freeTimes - var_2_1))

	setText = var_7

	var_7(arg_2_0.free, var_2_1 .. "/" .. arg_2_0.freeTimes)

	setText = var_7

	var_7(arg_2_0.charge, var_2_2 .. "/" .. arg_2_0.chargeTimes)

	setText = var_7

	var_7(arg_2_0.cost, arg_2_0.chargeDiamond)

	setActive = var_7

	var_7(arg_2_0.descFree, var_2_1 > 0)

	setActive = var_7

	var_7(arg_2_0.descCharge, var_2_1 <= 0)

	setText = var_7

	local var_2_3 = arg_2_0.desc

	i18n = var_9

	var_7(var_2_3, var_9("battle_repair_special_tip"))

	setText = var_7

	local var_2_4 = arg_2_0.descFree

	i18n = var_9

	var_7(var_2_4, var_9("battle_repair_normal_name"))

	setText = var_7

	local var_2_5 = arg_2_0.descCharge

	i18n = var_9

	var_7(var_2_5, var_9("battle_repair_special_name"))

	local var_2_6 = arg_2_0.repairTimes < arg_2_0.freeTimes + arg_2_0.chargeTimes

	setActive = var_8

	var_8(arg_2_0.diamond, var_2_6 and arg_2_0.repairTimes >= arg_2_0.freeTimes)

	setButtonEnabled = var_8

	var_8(arg_2_0.confirm, var_2_6)

	setGray = var_8

	var_8(arg_2_0.confirm, not var_2_6, true)

	onButton = var_8

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.back

	local function var_2_9()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10012

	var_8(var_2_7, var_2_8, var_2_9, var_1_10012)

	onButton = var_8

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.cancel

	local function var_2_12()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10012

	var_8(var_2_10, var_2_11, var_2_12, var_1_10012)

	onButton = var_8

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.confirm

	local function var_2_15()
		if arg_2_0.onConfirm then
			arg_2_0.onConfirm()
		end

		return
	end

	SFX_CONFIRM = var_1_10012

	var_8(var_2_13, var_2_14, var_2_15, var_1_10012)

	return
end

return var_0_1
