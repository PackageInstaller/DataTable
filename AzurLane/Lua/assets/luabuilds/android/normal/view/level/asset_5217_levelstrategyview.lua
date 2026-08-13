class = var_0_10000

local var_0_0 = "LevelStrategyView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LevelStrategyView"
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

	arg_5_0.icon = var_1.Find(var_5_0, "window/panel/item/icon_bg/icon")

	local var_5_1 = arg_5_0._tf

	arg_5_0.count = var_1.Find(var_5_1, "window/panel/item/icon_bg/count")

	local var_5_2 = arg_5_0._tf

	arg_5_0.name = var_1.Find(var_5_2, "window/panel/item/name")

	local var_5_3 = arg_5_0._tf

	arg_5_0.desc = var_1.Find(var_5_3, "window/panel/item/desc")

	local var_5_4 = arg_5_0._tf

	arg_5_0.btnCancel = var_1.Find(var_5_4, "window/panel/actions/cancel_button")

	local var_5_5 = arg_5_0._tf

	arg_5_0.btnUse = var_1.Find(var_5_5, "window/panel/actions/use_button")

	local var_5_6 = arg_5_0._tf

	arg_5_0.btnBack = var_1.Find(var_5_6, "top/btnBack")

	local var_5_7 = arg_5_0._tf

	arg_5_0.tips = var_1.Find(var_5_7, "window/panel/tips")
	findTF = var_1
	arg_5_0.txSwitch = var_1(arg_5_0.btnUse, "switch")
	findTF = var_1
	arg_5_0.txUse = var_1(arg_5_0.btnUse, "use")

	return
end

function var_0_1.set(arg_6_0, arg_6_1)
	arg_6_0.strategy = arg_6_1
	pg = var_1_10002

	local var_6_0 = var_1_10002.strategy_data_template[arg_6_1.id]

	GetImageSpriteFromAtlasAsync = var_3

	var_3("strategyicon/" .. var_6_0.icon, "", arg_6_0.icon)

	if var_6_0.type == 1 then
		setText = var_3

		var_3(arg_6_0.count, "")

		setActive = var_3

		var_3(arg_6_0.tips, true)

		setActive = var_3

		var_3(arg_6_0.txSwitch, true)

		setActive = var_3

		var_3(arg_6_0.txUse, false)
	else
		setText = var_3

		var_3(arg_6_0.count, arg_6_1.count)

		setActive = var_3

		var_3(arg_6_0.tips, false)

		setActive = var_3

		var_3(arg_6_0.txSwitch, false)

		setActive = var_3

		var_3(arg_6_0.txUse, true)
	end

	setText = var_3

	var_3(arg_6_0.name, var_6_0.name)

	setText = var_3

	var_3(arg_6_0.desc, var_6_0.desc)

	onButton = var_3

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.btnBack

	local function var_6_3()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_6_1, var_6_2, var_6_3, var_1_10007)

	onButton = var_3

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.btnCancel

	local function var_6_6()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_6_4, var_6_5, var_6_6, var_1_10007)

	onButton = var_3

	local var_6_7 = arg_6_0
	local var_6_8 = arg_6_0.btnUse

	local function var_6_9()
		if arg_6_0.onConfirm then
			arg_6_0.onConfirm()
		end

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_6_7, var_6_8, var_6_9, var_1_10007)

	return
end

return var_0_1
