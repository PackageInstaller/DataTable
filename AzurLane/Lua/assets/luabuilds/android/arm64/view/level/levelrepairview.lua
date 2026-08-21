local var_0_0 = class("LevelRepairView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LevelRepairView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitUI()
	setActive(arg_2_0._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0.onConfirm = nil
	arg_3_0.onCancel = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_3_0._tf, arg_3_0._parentTf)

	return
end

function var_0_0.setCBFunc(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.onConfirm = arg_4_1
	arg_4_0.onCancel = arg_4_2

	return
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0.desc = arg_5_0._tf:Find("window/desc")
	arg_5_0.descFree = arg_5_0._tf:Find("window/text_free")
	arg_5_0.descCharge = arg_5_0._tf:Find("window/text_charge")
	arg_5_0.free = arg_5_0._tf:Find("window/text_free/time")
	arg_5_0.charge = arg_5_0._tf:Find("window/text_charge/time")
	arg_5_0.diamond = arg_5_0._tf:Find("window/diamond")
	arg_5_0.cost = findTF(arg_5_0.diamond, "cost")
	arg_5_0.cancel = arg_5_0._tf:Find("window/actions/cancel_button")
	arg_5_0.confirm = arg_5_0._tf:Find("window/actions/use_button")
	arg_5_0.back = arg_5_0._tf:Find("top/btnBack")

	return
end

function var_0_0.set(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.repairTimes = arg_6_1
	arg_6_0.freeTimes = arg_6_2
	arg_6_0.chargeTimes = arg_6_3
	arg_6_0.chargeDiamond = arg_6_4

	local var_6_0 = arg_6_0.freeTimes - math.min(arg_6_0.repairTimes, arg_6_0.freeTimes)

	setText(arg_6_0.free, var_6_0 .. "/" .. arg_6_0.freeTimes)
	setText(arg_6_0.charge, arg_6_0.chargeTimes - (arg_6_0.repairTimes - (arg_6_0.freeTimes - var_6_0)) .. "/" .. arg_6_0.chargeTimes)
	setText(arg_6_0.cost, arg_6_0.chargeDiamond)
	setActive(arg_6_0.descFree, var_6_0 > 0)
	setActive(arg_6_0.descCharge, var_6_0 <= 0)
	setText(arg_6_0.desc, i18n("battle_repair_special_tip"))
	setText(arg_6_0.descFree, i18n("battle_repair_normal_name"))
	setText(arg_6_0.descCharge, i18n("battle_repair_special_name"))

	local var_6_1 = arg_6_0.repairTimes < arg_6_0.freeTimes + arg_6_0.chargeTimes

	setActive(arg_6_0.diamond, arg_6_0.repairTimes < arg_6_0.freeTimes + arg_6_0.chargeTimes and arg_6_0.repairTimes >= arg_6_0.freeTimes)
	setButtonEnabled(arg_6_0.confirm, var_6_1)
	setGray(arg_6_0.confirm, not var_6_1, true)
	onButton(arg_6_0, arg_6_0.back, function()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.cancel, function()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.confirm, function()
		if arg_6_0.onConfirm then
			arg_6_0.onConfirm()
		end

		return
	end, SFX_CONFIRM)

	return
end

return var_0_0
