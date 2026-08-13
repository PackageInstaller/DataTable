class = var_0_10000

local var_0_0 = "EquipmentDesignObtainWayPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = {}

i18n = var_0_10005
var_0_5[var_0_2] = var_0_10005("equipment_design_chapter")
i18n = var_5
var_0_5[var_0_3] = var_5("equipment_design_tech")
i18n = var_5
var_0_5[var_0_4] = var_5("equipment_design_shop")

function var_0_1.getUIName(arg_1_0)
	return "EquipmentDesignObtainWayUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.animationPlayer = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf

	arg_2_0.dropTF = var_1.Find(var_2_2, "main_page/item/left/IconTpl")

	local var_2_3 = arg_2_0._tf

	arg_2_0.nameTxt = var_1.Find(var_2_3, "main_page/item/name_container/name/Text")

	local var_2_4 = arg_2_0._tf

	arg_2_0.descTxt = var_1.Find(var_2_4, "main_page/item/Text")

	local var_2_5 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_5, "main_page/top/btnBack")
	UIItemList = var_1

	local var_2_6 = var_1.New
	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "main_page/obtainWay/list/content")
	local var_2_9 = arg_2_0._tf

	arg_2_0.uiWayList = var_2_6(var_2_8, var_3.Find(var_2_9, "main_page/obtainWay/list/content/tpl"))
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "sub_page/list/content")
	local var_2_13 = arg_2_0._tf

	arg_2_0.uiChapterWayList = var_2_10(var_2_12, var_3.Find(var_2_13, "sub_page/list/content/tpl"))
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "main_page/obtainWay/list/content/tpl/expand/Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("equipment_design_btn_expand"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "main_page/obtainWay/list/content/tpl/fold/Text")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("equipment_design_btn_fold"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "main_page/obtainWay/list/content/tpl/skip/Text")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("equipment_design_btn_skip"))

	setText = var_1

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_2.Find(var_2_20, "sub_page/list/content/tpl/skip_btn/Text")

	i18n = var_2_20

	var_1(var_2_21, var_2_20("equipment_design_btn_skip"))

	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_2.Find(var_2_22, "main_page/obtainWay/title")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("equipment_design_sub_title"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "main_page/top/bg/infomation/title")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("words_information"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "bg")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.closeBtn

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_5, var_3_6, var_5)

	arg_3_0.isOpenSubPage = false

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.designId = arg_6_1

	local var_6_0 = arg_6_0:GetObtainWayData(arg_6_1)

	arg_6_0:UpdateObtainWay(var_6_0)
	arg_6_0:UpdateEquipmentDesignInfo(arg_6_1)
	arg_6_0:ResetSubPage()
	arg_6_0:BlurPanel(arg_6_0._tf)

	return
end

function var_0_1.UpdateEquipmentDesignInfo(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.compose_data_template[arg_7_1]

	Item = var_1_10003

	local var_7_1 = var_1_10003.New({
		count = 0,
		id = var_7_0.material_id
	})

	setText = var_4

	local var_7_2 = arg_7_0.nameTxt

	HXSet = var_1_10006

	local var_7_3 = var_1_10006.hxLan

	shortenString = var_1_10007

	var_4(var_7_2, var_7_3(var_1_10007(var_7_1:getConfig("name"), 12)))

	setText = var_4

	local var_7_4 = arg_7_0.descTxt

	HXSet = var_6

	var_4(var_7_4, var_6.hxLan(var_7_1:getConfig("display")))

	updateItem = var_4

	var_4(arg_7_0.dropTF, var_7_1)

	setActive = var_4

	local var_7_5 = arg_7_0.dropTF

	var_4(var_5.Find(var_7_5, "icon_bg/count"), false)

	return
end

function var_0_1.ResetSubPage(arg_8_0)
	local var_8_0 = arg_8_0.animationPlayer

	var_1.Stop(var_8_0)

	local var_8_1 = arg_8_0.animationPlayer

	var_1.Play(var_8_1, "reset_sub_page")

	arg_8_0.isOpenSubPage = false

	return
end

function var_0_1.Hide(arg_9_0)
	var_0_1.super.Hide(arg_9_0)
	arg_9_0:ResetSubPage()
	arg_9_0:UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)

	return
end

function var_0_1.GetObtainWayData(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	EquipmentProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)
	local var_10_1 = var_2.GetObtainWay4EquipmentDesign(var_10_0, arg_10_1)[1]
	local var_10_2 = var_2[2]
	local var_10_3 = var_2[3]
	local var_10_4 = {}

	if var_10_2 then
		table = var_1_10007

		var_1_10007.insert(var_10_4, var_0_3)
	end

	if var_10_3 then
		table = var_1_10007

		var_1_10007.insert(var_10_4, var_0_4)
	end

	if #var_10_1 > 0 then
		table = var_7

		var_7.insert(var_10_4, 1, var_0_2)
	end

	return var_10_4
end

function var_0_1.UpdateObtainWay(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.uiWayList

	var_2.make(var_11_0, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_11_1[arg_12_1 + 1]
			local var_12_1 = arg_11_0

			var_4.UpdateWayTpl(var_12_1, arg_12_2, var_12_0)
		end

		return
	end)

	local var_11_1 = arg_11_0.uiWayList

	var_2.align(var_11_1, #arg_11_1)

	return
end

function var_0_1.UpdateWayTpl(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:Find("expand")
	local var_13_1 = arg_13_1:Find("fold")
	local var_13_2 = arg_13_1:Find("skip")
	local var_13_3 = arg_13_1:Find("title")

	local function var_13_4()
		setActive = var_2_10000

		var_2_10000(var_13_0, arg_13_2 == var_0_2 and not arg_13_0.isOpenSubPage)

		setActive = var_2_10000

		var_2_10000(var_13_1, arg_13_2 == var_0_2 and arg_13_0.isOpenSubPage)

		setActive = var_2_10000

		var_2_10000(var_13_2, arg_13_2 == var_0_3 or arg_13_2 == var_0_4)

		return
	end

	onButton = var_8

	local var_13_5 = arg_13_0
	local var_13_6 = var_13_0

	local function var_13_7()
		local var_15_0 = arg_13_0.animationPlayer

		var_0.Stop(var_15_0)

		local var_15_1 = arg_13_0.animationPlayer

		var_0.Play(var_15_1, "open_sub_page")

		local var_15_2 = arg_13_0

		var_0.UpdateChapterWays(var_15_2)

		arg_13_0.isOpenSubPage = true

		var_13_4()

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_13_5, var_13_6, var_13_7, var_1_10012)

	onButton = var_8

	local var_13_8 = arg_13_0
	local var_13_9 = var_13_1

	local function var_13_10()
		local var_16_0 = arg_13_0.animationPlayer

		var_0.Stop(var_16_0)

		local var_16_1 = arg_13_0.animationPlayer

		var_0.Play(var_16_1, "close_sub_page")

		arg_13_0.isOpenSubPage = false

		var_13_4()

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_13_8, var_13_9, var_13_10, var_1_10012)
	var_13_4()

	onButton = var_8

	local var_13_11 = arg_13_0
	local var_13_12 = var_13_2

	local function var_13_13()
		if arg_13_2 == var_0_3 then
			local var_17_0 = arg_13_0

			var_0.GoTechScene(var_17_0)
		elseif arg_13_2 == var_0_4 then
			local var_17_1 = arg_13_0

			var_0.GoShopScene(var_17_1)
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_13_11, var_13_12, var_13_13, var_1_10012)

	setText = var_8

	var_8(var_13_3, var_0_5[arg_13_2])

	return
end

function var_0_1.UpdateChapterWays(arg_18_0)
	getProxy = var_1_10001
	EquipmentProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)
	local var_18_1 = var_1.GetObtainWay4EquipmentDesign(var_18_0, arg_18_0.designId)[1]
	local var_18_2 = arg_18_0.uiChapterWayList

	var_3.make(var_18_2, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_1[arg_19_1 + 1]

			pg = var_4

			local var_19_1 = var_4.chapter_template[var_19_0]

			setScrollText = var_2_10005

			local var_19_2 = arg_19_2
			local var_19_3 = arg_19_2.Find(var_19_2, "mask/Text")

			i18n = var_19_2

			var_2_10005(var_19_3, var_19_2("equipment_design_chapter") .. ":" .. var_19_1.name)

			onButton = var_2_10005

			local var_19_4 = arg_18_0
			local var_19_5 = arg_19_2:Find("skip_btn")

			local function var_19_6()
				local var_20_0 = arg_18_0

				var_0.GoChapterScene(var_20_0, var_19_0)

				return
			end

			SFX_PANEL = var_9

			var_2_10005(var_19_4, var_19_5, var_19_6, var_9)
		end

		return
	end)

	local var_18_3 = arg_18_0.uiChapterWayList

	var_3.align(var_18_3, #var_18_1)

	return
end

function var_0_1.GoChapterScene(arg_21_0, arg_21_1)
	pg = var_1_10002

	if var_1_10002.chapter_template[arg_21_1].act_id ~= 0 and var_2.act_id ~= 100001 then
		getProxy = var_3
		ActivityProxy = var_1_10004
		var_1_10004 = var_3(var_1_10004)

		if not var_3.RawGetActivityById(var_1_10004, var_2.act_id) or var_3:isEnd() then
			pg = var_1_10004

			local var_21_0 = var_1_10004.TipsMgr.GetInstance()

			var_1_10004 = var_1_10004.ShowTips
			i18n = var_1_10006

			var_1_10004(var_21_0, var_1_10006("common_activity_notStartOrEnd"))

			return
		end

		chapterProxy = var_1_10004

		local var_21_1

		var_1_10004, var_21_1 = var_1_10004:getLastMapForActivity()
		pg = var_1_10006
		var_1_10007 = var_1_10006.m02

		local var_21_2 = var_6.sendNotification

		GAME = var_1_10008
		var_1_10008 = var_1_10008.GO_SCENE
		SCENE = var_1_10009

		var_21_2(var_1_10007, var_1_10008, var_1_10009.LEVEL, {
			chapterId = var_21_1,
			mapIdx = var_1_10004
		})

		return
	end

	getProxy = var_3
	ChapterProxy = var_1_10004

	local var_21_3 = var_3(var_1_10004)

	if not var_3.getChapterById(var_21_3, arg_21_1) or not var_4:isUnlock() then
		pg = var_21_3

		local var_21_4 = var_21_3.TipsMgr.GetInstance()

		var_21_3 = var_21_3.ShowTips
		i18n = var_1_10007

		var_21_3(var_21_4, var_1_10007("battle_levelScene_chapter_lock"))

		return
	end

	pg = var_21_3

	local var_21_5 = var_21_3.m02
	local var_21_6 = var_5.sendNotification

	GAME = var_1_10007

	local var_21_7 = var_1_10007.GO_SCENE

	SCENE = var_1_10008

	var_21_6(var_21_5, var_21_7, var_1_10008.LEVEL, {
		chapterId = arg_21_1,
		mapIdx = var_2.map
	})

	return
end

function var_0_1.GoTechScene(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.m02
	local var_22_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_22_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_22_1(var_22_0, var_22_2, var_1_10004.TECHNOLOGY)

	return
end

function var_0_1.GoShopScene(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.m02
	local var_23_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_23_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	local var_23_3 = var_1_10004.SHOP
	local var_23_4 = {}

	ShopConst = var_1_10006
	var_23_4.warp = var_1_10006.TYPE_FRAGMENT
	ShopConst = var_6
	var_23_4.type = var_6.SHOP_TYPE.SUPPLY

	var_23_1(var_23_0, var_23_2, var_23_3, var_23_4)

	return
end

function var_0_1.OnDestroy(arg_24_0)
	if arg_24_0:isShowing() then
		arg_24_0:Hide()
	end

	return
end

return var_0_1
