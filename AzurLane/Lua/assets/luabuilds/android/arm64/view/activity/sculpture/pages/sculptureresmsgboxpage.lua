local var_0_0 = class("SculptureResMsgBoxPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SculptureResMsgBoxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.icon = arg_2_0._tf:Find("frame/icon/Image"):GetComponent(typeof(Image))
	arg_2_0.name = arg_2_0._tf:Find("frame/name"):GetComponent(typeof(Text))
	arg_2_0.desc = arg_2_0._tf:Find("frame/scrollrect/desc"):GetComponent(typeof(Text))
	arg_2_0.outPut = arg_2_0._tf:Find("frame/output/Text"):GetComponent(typeof(Text))
	arg_2_0.goBtn = arg_2_0._tf:Find("frame/output/btn")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	var_0_0.super.Show(arg_6_0)

	arg_6_0.id = arg_6_1

	arg_6_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.icon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[arg_7_0.id].icon)

	arg_7_0.icon:SetNativeSize()

	arg_7_0.name.text = pg.activity_workbench_item[arg_7_0.id].name
	arg_7_0.desc.text = pg.activity_workbench_item[arg_7_0.id].display
	arg_7_0.outPut.text = pg.activity_workbench_item[arg_7_0.id].get_access[1]

	onButton(arg_7_0, arg_7_0.goBtn, function()
		pg.m02:sendNotification(GAME.WORKBENCH_ITEM_GO, arg_7_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_9_0)
	return
end

return var_0_0
