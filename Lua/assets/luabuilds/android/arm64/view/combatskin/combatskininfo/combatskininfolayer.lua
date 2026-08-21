local var_0_0 = class("CombatSkinInfoLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CombatSkinInfoUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0.closeBtn = arg_2_0._tf:Find("display/top/btnBack")
	arg_2_0.confirm = arg_2_0._tf:Find("display/actions/confirm")
	arg_2_0.skinViewTF = arg_2_0._tf:Find("display")
	arg_2_0.toggleList = UIItemList.New(arg_2_0._tf:Find("display/info/display_panel/combat_skin/elementList"), arg_2_0._tf:Find("display/info/display_panel/combat_skin/elementList/main"))

	setText(arg_2_0.confirm:Find("upgrade"), i18n("text_consume"))
	setText(arg_2_0._tf:Find("display/top/bg/infomation/title"), i18n("words_information"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.confirm, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)
	arg_3_0:InitPanel()

	return
end

function var_0_0.InitPanel(arg_7_0)
	local var_7_0 = arg_7_0.contextData.skinID

	setText(arg_7_0.skinViewTF:Find("info/display_panel/name_container/name"), pg.item_data_battleui[arg_7_0.contextData.skinID].name)
	setText(arg_7_0.skinViewTF:Find("info/display_panel/desc/Text"), pg.item_data_battleui[arg_7_0.contextData.skinID].desc)

	local var_7_1 = pg.item_data_battleui[arg_7_0.contextData.skinID].rare_display

	arg_7_0.toggleList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("ui/combatskinrare", CombatSkinConst.TYPE_ICON_NAME[var_7_1[arg_8_1 + 1]], arg_8_2:Find("icon"), true)
			setScrollText(arg_8_2:Find("TextMask/Text"), i18n("battleui_display" .. var_7_1[arg_8_1 + 1]))
		end

		return
	end)
	arg_7_0.toggleList:align(#pg.item_data_battleui[arg_7_0.contextData.skinID].rare_display)
	onButton(arg_7_0, arg_7_0.skinViewTF:Find("info/play_btn"), function()
		arg_7_0.combatPreview = CombatPreviewLayer.New(pg.UIMgr.GetInstance().OverlayMain)

		arg_7_0.combatPreview:ExecuteAction("Show", var_7_0, function()
			arg_7_0.combatPreview:Destroy()

			arg_7_0.combatPreview = nil

			return
		end)

		return
	end, SPX_PANEL)
	updateDrop(arg_7_0.skinViewTF:Find("info/equip"), Drop.New({
		count = 1,
		type = DROP_TYPE_COMBAT_UI_STYLE,
		id = arg_7_0.contextData.skinID
	}))

	return
end

function var_0_0.willExit(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf)

	return
end

function var_0_0.onBackPressed(arg_12_0)
	if arg_12_0.combatPreview then
		arg_12_0.combatPreview:Destroy()

		arg_12_0.combatPreview = nil
	else
		var_0_0.super.onBackPressed(arg_12_0)
	end

	return
end

return var_0_0
