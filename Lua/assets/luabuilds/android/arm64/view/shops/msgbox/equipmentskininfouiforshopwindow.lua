local var_0_0 = class("EquipmentSkinInfoUIForShopWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "EquipmentSkinInfoUIForShop"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.displayPanel = arg_2_0._tf:Find("display")
	arg_2_0.displayActions = arg_2_0.displayPanel:Find("actions")
	arg_2_0.displayNameTxt = arg_2_0.displayPanel:Find("info/display_panel/name_container/name"):GetComponent(typeof(Text))
	arg_2_0.displayDescTxt = arg_2_0.displayPanel:Find("info/display_panel/desc"):GetComponent(typeof(Text))
	arg_2_0.playBtn = arg_2_0.displayPanel:Find("info/play_btn")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("display/actions/confirm")

	setText(arg_2_0._tf:Find("display/top/bg/infomation/title"), i18n("words_information"))
	setText(arg_2_0._tf:Find("display/actions/cancel/upgrade"), i18n("msgbox_text_cancel"))
	setText(arg_2_0._tf:Find("display/actions/confirm/change"), i18n("shop_word_exchange"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SOUND_BACK)
	onButton(arg_3_0, arg_3_0._tf:Find("display/top/btnBack"), function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("display/actions/cancel"), function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	arg_7_0:UpdateSkinView(arg_7_1)

	arg_7_0.showing = true

	return
end

function var_0_0.Open(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:getConfig("commodity_id") or arg_8_1:getConfig("effect_args")[1]

	onButton(arg_8_0, arg_8_0.confirmBtn, function()
		if arg_8_2 then
			arg_8_2(arg_8_1, 1, pg.equip_skin_template[var_8_0].name)
		end

		arg_8_0:Hide()

		return
	end, SFX_CANCEL)
	arg_8_0:Show(var_8_0)

	return
end

function var_0_0.UpdateSkinView(arg_10_0, arg_10_1)
	assert(pg.equip_skin_template[arg_10_1], "miss config equip_skin_template >> " .. arg_10_1)

	arg_10_0.displayNameTxt.text = pg.equip_skin_template[arg_10_1].name
	arg_10_0.displayDescTxt.text = pg.equip_skin_template[arg_10_1].desc

	setScrollText(arg_10_0.displayPanel:Find("info/display_panel/equip_type/mask/Text"), table.concat(_.map(pg.equip_skin_template[arg_10_1].equip_type, function(arg_11_0)
		return EquipType.Type2Name2(arg_11_0)
	end), ","))
	onButton(arg_10_0, arg_10_0.playBtn, function()
		arg_10_0:emit(NewShopMainMediator.ON_ESKIN_PREVIEW, arg_10_1)

		return
	end, SFX_PANEL)
	updateDrop(arg_10_0.displayPanel:Find("info/equip"), {
		type = DROP_TYPE_EQUIPMENT_SKIN,
		id = arg_10_1
	})

	return
end

function var_0_0.Hide(arg_13_0)
	if arg_13_0.showing then
		var_0_0.super.Hide(arg_13_0)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf, arg_13_0._parentTf)

		arg_13_0.showing = false
	end

	return
end

function var_0_0.OnDestroy(arg_14_0)
	arg_14_0:Hide()

	return
end

return var_0_0
