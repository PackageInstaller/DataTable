class = var_0_10000

local var_0_0 = "IslandBaseMapDescPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandMapDescUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/title/name/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_6, "frame/go")
	UIItemList = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/scrollrect/list")
	local var_2_10 = arg_2_0._tf

	arg_2_0.uiProductionList = var_2_7(var_2_9, var_3.Find(var_2_10, "frame/scrollrect/list/tpl"))

	local var_2_11 = arg_2_0._tf

	arg_2_0.iconTr = var_1.Find(var_2_11, "frame/icon")

	local var_2_12 = arg_2_0._tf

	arg_2_0.fullMark = var_1.Find(var_2_12, "frame/icon/tag")
	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "frame/go/Text")

	i18n = var_2_13

	var_1(var_2_14, var_2_13("island_word_go"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		local var_4_1 = arg_3_0
		local var_4_2 = var_0.emit

		IslandBaseMapPage = var_2_10002

		var_4_2(var_4_1, var_2_10002.HIDE_DESC)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnShow(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.island_map[arg_5_1]

	arg_5_0.nameTxt.text = var_5_0.name

	local var_5_1 = arg_5_0.descTxt

	var_5_1.text = var_5_0.desc
	LoadImageSpriteAtlasAsync = var_5_1

	var_5_1("island/IslandMapIcon/" .. arg_5_1, "", arg_5_0.iconTr)

	onButton = var_5_1

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.goBtn

	local function var_5_4()
		local var_6_0 = arg_5_0

		var_0.GoMap(var_6_0, arg_5_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_5_1(var_5_2, var_5_3, var_5_4, var_1_10007)

	setActive = var_5_1

	var_5_1(arg_5_0.fullMark, false)

	return
end

function var_0_1.GoMap(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.island_map[arg_7_1]
	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.emitCoreController

	ISLAND_EVT = var_1_10005

	var_7_2(var_7_1, var_1_10005.SWITCH_MAP)

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.emit

	IslandBaseMediator = var_5

	var_7_4(var_7_3, var_5.SWITCH_MAP, arg_7_1, var_7_0.born_object)

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.emit

	IslandBaseMapPage = var_5

	var_7_6(var_7_5, var_5.CLOSE)

	return
end

return var_0_1
