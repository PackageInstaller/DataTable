local var_0_0 = class("FeastResWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "FeastResWindow"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.icon = arg_2_0._tf:Find("frame/item/icon"):GetComponent(typeof(Image))
	arg_2_0.name = arg_2_0._tf:Find("frame/name/Text"):GetComponent(typeof(Text))
	arg_2_0.desc = arg_2_0._tf:Find("frame/Text"):GetComponent(typeof(Text))
	arg_2_0.outPut = arg_2_0._tf:Find("frame/output/Text"):GetComponent(typeof(Text))
	arg_2_0.goBtn = arg_2_0._tf:Find("frame/go")

	setText(arg_2_0.goBtn:Find("Text"), i18n("feast_res_window_go_label"))
	setText(arg_2_0._tf:Find("frame/title"), i18n("feast_res_window_title"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	var_0_0.super.Show(arg_5_0)

	arg_5_0.id = arg_5_1

	arg_5_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.icon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[arg_6_0.id].icon)

	arg_6_0.icon:SetNativeSize()

	arg_6_0.name.text = pg.activity_workbench_item[arg_6_0.id].name
	arg_6_0.desc.text = pg.activity_workbench_item[arg_6_0.id].display
	arg_6_0.outPut.text = pg.activity_workbench_item[arg_6_0.id].get_access[1]

	onButton(arg_6_0, arg_6_0.goBtn, function()
		pg.m02:sendNotification(GAME.WORKBENCH_ITEM_GO, arg_6_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
