local var_0_0 = class("LevelStrategyView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LevelStrategyView"
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
	arg_5_0.icon = arg_5_0._tf:Find("window/panel/item/icon_bg/icon")
	arg_5_0.count = arg_5_0._tf:Find("window/panel/item/icon_bg/count")
	arg_5_0.name = arg_5_0._tf:Find("window/panel/item/name")
	arg_5_0.desc = arg_5_0._tf:Find("window/panel/item/desc")
	arg_5_0.btnCancel = arg_5_0._tf:Find("window/panel/actions/cancel_button")
	arg_5_0.btnUse = arg_5_0._tf:Find("window/panel/actions/use_button")
	arg_5_0.btnBack = arg_5_0._tf:Find("top/btnBack")
	arg_5_0.tips = arg_5_0._tf:Find("window/panel/tips")
	arg_5_0.txSwitch = findTF(arg_5_0.btnUse, "switch")
	arg_5_0.txUse = findTF(arg_5_0.btnUse, "use")

	return
end

function var_0_0.set(arg_6_0, arg_6_1)
	arg_6_0.strategy = arg_6_1

	local var_6_0 = pg.strategy_data_template[arg_6_1.id]

	GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[arg_6_1.id].icon, "", arg_6_0.icon)

	if var_6_0.type == 1 then
		setText(arg_6_0.count, "")
		setActive(arg_6_0.tips, true)
		setActive(arg_6_0.txSwitch, true)
		setActive(arg_6_0.txUse, false)
	else
		setText(arg_6_0.count, arg_6_1.count)
		setActive(arg_6_0.tips, false)
		setActive(arg_6_0.txSwitch, false)
		setActive(arg_6_0.txUse, true)
	end

	setText(arg_6_0.name, var_6_0.name)
	setText(arg_6_0.desc, var_6_0.desc)
	onButton(arg_6_0, arg_6_0.btnBack, function()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.btnCancel, function()
		if arg_6_0.onCancel then
			arg_6_0.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.btnUse, function()
		if arg_6_0.onConfirm then
			arg_6_0.onConfirm()
		end

		return
	end, SFX_CONFIRM)

	return
end

return var_0_0
