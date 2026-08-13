class = var_0_10000

local var_0_0 = "LevelRepairView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LevelRepairView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitUI()

	setActive = var_1

	var_1(arg_2_0._tf, true)

	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	return
end

function var_0_1.OnDestroy(arg_3_0)
	arg_3_0.onConfirm = nil
	arg_3_0.onCancel = nil
	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_3_0, arg_3_0._tf, arg_3_0._parentTf)

	return
end

function var_0_1.setCBFunc(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.onConfirm = arg_4_1
	arg_4_0.onCancel = arg_4_2

	return
end

function var_0_1.InitUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.desc = var_1.Find(var_5_0, "window/desc")

	local var_5_1 = arg_5_0._tf

	arg_5_0.descFree = var_1.Find(var_5_1, "window/text_free")

	local var_5_2 = arg_5_0._tf

	arg_5_0.descCharge = var_1.Find(var_5_2, "window/text_charge")

	local var_5_3 = arg_5_0._tf

	arg_5_0.free = var_1.Find(var_5_3, "window/text_free/time")

	local var_5_4 = arg_5_0._tf

	arg_5_0.charge = var_1.Find(var_5_4, "window/text_charge/time")

	local var_5_5 = arg_5_0._tf

	arg_5_0.diamond = var_1.Find(var_5_5, "window/diamond")
	findTF = var_1
	arg_5_0.cost = var_1(arg_5_0.diamond, "cost")

	local var_5_6 = arg_5_0._tf

	arg_5_0.cancel = var_1.Find(var_5_6, "window/actions/cancel_button")

	local var_5_7 = arg_5_0._tf

	arg_5_0.confirm = var_1.Find(var_5_7, "window/actions/use_button")

	local var_5_8 = arg_5_0._tf

	arg_5_0.back = var_1.Find(var_5_8, "top/btnBack")

	return
end

function var_0_1.set(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.repairTimes = arg_6_1
	arg_6_0.freeTimes = arg_6_2
	arg_6_0.chargeTimes = arg_6_3
	arg_6_0.chargeDiamond = arg_6_4

	local var_6_0 = arg_6_0.freeTimes

	math = var_1_10006

	local var_6_1 = var_6_0 - var_1_10006.min(arg_6_0.repairTimes, arg_6_0.freeTimes)
	local var_6_2 = arg_6_0.chargeTimes - (arg_6_0.repairTimes - (arg_6_0.freeTimes - var_6_1))

	setText = var_7

	var_7(arg_6_0.free, var_6_1 .. "/" .. arg_6_0.freeTimes)

	setText = var_7

	var_7(arg_6_0.charge, var_6_2 .. "/" .. arg_6_0.chargeTimes)

	setText = var_7

	var_7(arg_6_0.cost, arg_6_0.chargeDiamond)

	setActive = var_7

	var_7(arg_6_0.descFree, var_6_1 > 0)

	setActive = var_7

	var_7(arg_6_0.descCharge, var_6_1 <= 0)

	setText = var_7

	local var_6_3 = arg_6_0.desc

	i18n = var_9

	var_7(var_6_3, var_9("battle_repair_special_tip"))

	setText = var_7

	local var_6_4 = arg_6_0.descFree

	i18n = var_9

	var_7(var_6_4, var_9("battle_repair_normal_name"))

	setText = var_7

	local var_6_5 = arg_6_0.descCharge

	i18n = var_9

	var_7(var_6_5, var_9("battle_repair_special_name"))

	local var_6_6 = arg_6_0.repairTimes < arg_6_0.freeTimes + arg_6_0.chargeTimes

	setActive = var_8

	var_8(arg_6_0.diamond, var_6_6 and arg_6_0.repairTimes >= arg_6_0.freeTimes)

	setButtonEnabled = var_8

	var_8(arg_6_0.confirm, var_6_6)

	setGray = var_8

	var_8(arg_6_0.confirm, not var_6_6, true)

	onButton = var_8

	local var_6_7 = arg_6_0
	local var_6_8 = arg_6_0.back

	local function var_6_9()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10012

	var_8(var_6_7, var_6_8, var_6_9, var_1_10012)

	onButton = var_8

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.cancel

	local function var_6_12()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10012

	var_8(var_6_10, var_6_11, var_6_12, var_1_10012)

	onButton = var_8

	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.confirm

	local function var_6_15()
		if arg_6_0.onConfirm then
			arg_6_0.onConfirm()
		end

		return
	end

	SFX_CONFIRM = var_1_10012

	var_8(var_6_13, var_6_14, var_6_15, var_1_10012)

	return
end

return var_0_1
