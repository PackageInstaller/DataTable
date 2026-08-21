local var_0_0 = class("IslandBaseMapDescPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandMapDescUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.nameTxt = arg_2_0._tf:Find("frame/title/name/Text"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/Text"):GetComponent(typeof(Text))
	arg_2_0.goBtn = arg_2_0._tf:Find("frame/go")
	arg_2_0.uiProductionList = UIItemList.New(arg_2_0._tf:Find("frame/scrollrect/list"), arg_2_0._tf:Find("frame/scrollrect/list/tpl"))
	arg_2_0.iconTr = arg_2_0._tf:Find("frame/icon")
	arg_2_0.fullMark = arg_2_0._tf:Find("frame/icon/tag")

	setText(arg_2_0._tf:Find("frame/go/Text"), i18n("island_word_go"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()
		arg_3_0:emit(IslandBaseMapPage.HIDE_DESC)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_5_0, arg_5_1)
	arg_5_0.nameTxt.text = pg.island_map[arg_5_1].name
	arg_5_0.descTxt.text = pg.island_map[arg_5_1].desc

	LoadImageSpriteAtlasAsync("island/IslandMapIcon/" .. arg_5_1, "", arg_5_0.iconTr)
	onButton(arg_5_0, arg_5_0.goBtn, function()
		arg_5_0:GoMap(arg_5_1)

		return
	end, SFX_PANEL)
	setActive(arg_5_0.fullMark, false)

	return
end

function var_0_0.GoMap(arg_7_0, arg_7_1)
	arg_7_0:emitCoreController(ISLAND_EVT.SWITCH_MAP)
	arg_7_0:emit(IslandBaseMediator.SWITCH_MAP, arg_7_1, pg.island_map[arg_7_1].born_object)
	arg_7_0:emit(IslandBaseMapPage.CLOSE)

	return
end

return var_0_0
