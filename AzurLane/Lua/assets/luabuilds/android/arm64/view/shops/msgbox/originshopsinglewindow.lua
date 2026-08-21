local var_0_0 = class("OriginShopSingleWindow", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ShopsUISinglebox"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.itemTF = arg_2_0._tf:Find("window/item")
	arg_2_0.nameTF = arg_2_0.itemTF:Find("display_panel/name_container/name/Text"):GetComponent(typeof(Text))
	arg_2_0.descTF = arg_2_0.itemTF:Find("display_panel/desc/Text"):GetComponent(typeof(Text))
	arg_2_0.itemOwnTF = arg_2_0.itemTF:Find("left/own")
	arg_2_0.itemDetailTF = arg_2_0.itemTF:Find("left/detail")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/actions/confirm_btn")

	setText(arg_2_0._tf:Find("window/actions/cancel_btn/pic"), i18n("shop_word_cancel"))
	setText(arg_2_0._tf:Find("window/actions/confirm_btn/pic"), i18n("shop_word_exchange"))
	setText(arg_2_0.itemTF:Find("ship_group/locked/Text"), i18n("tag_ship_locked"))
	setText(arg_2_0.itemTF:Find("ship_group/unlocked/Text"), i18n("tag_ship_unlocked"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("window/actions/cancel_btn"), function()
		arg_3_0:Close()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:Close()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("window/top/btnBack"), function()
		arg_3_0:Close()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.Open(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.opening = true

	arg_7_0:Show()
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	arg_7_0:InitWindow(arg_7_1, arg_7_2)

	return
end

function var_0_0.InitWindow(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = isa(arg_8_1, WorldNShopCommodity) and arg_8_1:GetDropInfo() or arg_8_1:getDropInfo()

	updateDrop(arg_8_0.itemTF:Find("left/IconTpl"), var_8_0)
	UpdateOwnDisplay(arg_8_0.itemOwnTF, var_8_0)
	RegisterDetailButton(arg_8_0, arg_8_0.itemDetailTF, var_8_0)
	onButton(arg_8_0, arg_8_0.confirmBtn, function()
		existCall(arg_8_2, arg_8_1, 1)
		arg_8_0:Close()

		return
	end, SFX_CANCEL)

	local var_8_1 = var_8_0.type == DROP_TYPE_SHIP
	local var_8_2 = arg_8_0.itemTF:Find("ship_group")

	SetActive(var_8_2, var_8_0.type == DROP_TYPE_SHIP)

	if var_8_1 then
		local var_8_3 = tobool(getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[var_8_0.id].group_type))

		SetActive(var_8_2:Find("unlocked"), var_8_3)
		SetActive(var_8_2:Find("locked"), not var_8_3)
	end

	local var_8_4 = arg_8_0.descTF

	var_8_4.text = var_8_0.desc or var_8_0:getConfig("desc")
	arg_8_0.nameTF.text = var_8_0:getConfig("name")

	return
end

function var_0_0.Close(arg_10_0)
	if arg_10_0.opening then
		arg_10_0.opening = false

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)
		arg_10_0:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	if arg_11_0.opening then
		arg_11_0:Close()
	end

	return
end

return var_0_0
