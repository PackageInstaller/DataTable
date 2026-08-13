class = var_0_10000

local var_0_0 = "CoreAwardTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = {}

DROP_TYPE_EQUIP = var_0_0
var_0_2[var_0_0] = "equip"
DROP_TYPE_FURNITURE = var_0_0
var_0_2[var_0_0] = "furniture"
DROP_TYPE_EQUIPMENT_SKIN = var_0_0
var_0_2[var_0_0] = "equip_skin"
DROP_TYPE_SPWEAPON = var_0_0
var_0_2[var_0_0] = "special_weapon"
var_0_1.DropType2Name = var_0_2

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btnList = var_1.Find(var_1_1, "btn_list")

	local var_1_2 = arg_1_0.bg

	arg_1_0.itemPanel = var_1.Find(var_1_2, "item_panel")

	local var_1_3 = arg_1_0.itemPanel

	arg_1_0.togglesTF = var_1.Find(var_1_3, "toggles")

	local var_1_4 = arg_1_0.itemPanel

	arg_1_0.content = var_1.Find(var_1_4, "item_list/content")
	UIItemList = var_1

	local var_1_5 = var_1.New
	local var_1_6 = arg_1_0.content
	local var_1_7 = arg_1_0.content

	arg_1_0.itemList = var_1_5(var_1_6, var_4.Find(var_1_7, "tpl"))
	setText = var_1

	local var_1_8 = arg_1_0.content
	local var_1_9 = var_3.Find(var_1_8, "tpl/owner/title")

	i18n = var_4

	var_1(var_1_9, var_4("collect_page_got"))

	local var_1_10 = arg_1_0._tf

	arg_1_0.boxTF = var_1.Find(var_1_10, "Box")

	local var_1_11 = arg_1_0.boxTF

	arg_1_0.boxBG = var_1.Find(var_1_11, "BG")

	local var_1_12 = arg_1_0.boxTF

	arg_1_0.panel = var_1.Find(var_1_12, "Panel")

	local var_1_13 = arg_1_0.panel

	arg_1_0.infoTF = var_1.Find(var_1_13, "Info")

	local var_1_14 = arg_1_0.infoTF

	arg_1_0.boxCloseBtn = var_1.Find(var_1_14, "CloseBtn")

	local var_1_15 = arg_1_0.infoTF

	arg_1_0.Title = var_1.Find(var_1_15, "Title")

	local var_1_16 = arg_1_0.infoTF

	arg_1_0.boxIconTF = var_1.Find(var_1_16, "Icon/Mask/IconTpl")

	local var_1_17 = arg_1_0.infoTF

	arg_1_0.boxNameText = var_1.Find(var_1_17, "NameText")

	local var_1_18 = arg_1_0.infoTF

	arg_1_0.boxNumTF = var_1.Find(var_1_18, "Num")

	local var_1_19 = arg_1_0.boxNumTF

	arg_1_0.boxNumTip = var_1.Find(var_1_19, "Text")

	local var_1_20 = arg_1_0.boxNumTF

	arg_1_0.boxNumText = var_1.Find(var_1_20, "NumText")

	local var_1_21 = arg_1_0.infoTF

	arg_1_0.boxDescText = var_1.Find(var_1_21, "DescText")

	local var_1_22 = arg_1_0.infoTF

	arg_1_0.boxSrcText = var_1.Find(var_1_22, "SrcText")

	local var_1_23 = arg_1_0.panel

	arg_1_0.boxSrcContent = var_1.Find(var_1_23, "Content")

	local var_1_24 = arg_1_0.boxSrcContent

	arg_1_0.boxSrcTpl = var_1.Find(var_1_24, "SrcTpl")
	onButton = var_1

	local var_1_25 = arg_1_0
	local var_1_26 = arg_1_0.boxBG

	local function var_1_27()
		local var_2_0 = arg_1_0

		var_0.showBoxPanel(var_2_0, false)

		return
	end

	SFX_PANEL = var_6

	var_1(var_1_25, var_1_26, var_1_27, var_6)

	onButton = var_1

	local var_1_28 = arg_1_0
	local var_1_29 = arg_1_0.boxCloseBtn

	local function var_1_30()
		local var_3_0 = arg_1_0

		var_0.showBoxPanel(var_3_0, false)

		return
	end

	SFX_PANEL = var_6

	var_1(var_1_28, var_1_29, var_1_30, var_6)

	return
end

function var_0_1.OnDataSetting(arg_4_0)
	pg = var_1_10001
	arg_4_0.guideConfig = var_1_10001.activity_limit_item_guide

	arg_4_0:BuildDatas()

	return
end

function var_0_1.BuildDatas(arg_5_0)
	pg = var_1_10001

	local var_5_0

	if not var_1_10001.activity_limit_item_guide.get_id_list_by_activity[arg_5_0.activity.id] then
		var_5_0 = {}
	end

	arg_5_0.dataList = {}
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(var_5_0) do
		local var_5_1 = {
			id = iter_5_1
		}

		var_5_1.config = arg_5_0.guideConfig[var_5_1.id]

		local var_5_2 = arg_5_0.activity

		var_5_1.count = var_8.getKVPList(var_5_2, 1, var_5_1.id)

		if var_5_1.config.count_storage == 1 then
			Drop = var_8

			local var_5_3 = var_8.New({
				type = var_5_1.config.type,
				id = var_5_1.config.drop_id
			})

			var_5_1.count = var_8.getOwnedCount(var_5_3)
		end

		table = var_8

		var_8.insert(arg_5_0.dataList, var_5_1)
	end

	return
end

function var_0_1.GetTogglesDropTypes(arg_6_0)
	local var_6_0 = {}

	DROP_TYPE_EQUIP = var_1_10002
	var_6_0[1] = var_1_10002
	DROP_TYPE_FURNITURE = var_1_10002
	var_6_0[2] = var_1_10002
	DROP_TYPE_EQUIPMENT_SKIN = var_1_10002
	var_6_0[3] = var_1_10002
	DROP_TYPE_SPWEAPON = var_1_10002
	var_6_0[4] = var_1_10002

	return var_6_0
end

function var_0_1.OnFirstFlush(arg_7_0)
	local var_7_0 = arg_7_0.itemList

	var_1.make(var_7_0, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_7_0

			var_3.OnUpdateItem(var_8_0, arg_8_1, arg_8_2)
		end

		return
	end)
	arg_7_0:AddTogglesListener()
	arg_7_0:AddSpecialBtnListener()

	local var_7_1

	if not arg_7_0.curPage then
		var_7_1 = arg_7_0:GetTogglesDropTypes()[1]
	end

	arg_7_0.curPage = var_7_1
	triggerToggle = var_7_1

	var_7_1(arg_7_0.toggles[arg_7_0.curPage], true)

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	arg_9_0:BuildDatas()
	arg_9_0:UpdatePage(arg_9_0.curPage)

	return
end

function var_0_1.AddTogglesListener(arg_10_0)
	arg_10_0.toggles = {}

	local var_10_0 = arg_10_0:GetTogglesDropTypes()

	assert = var_1_10002

	var_1_10002(#var_10_0 == arg_10_0.togglesTF.childCount, "dropType数量与togglesTF子节点数不匹配")

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(var_10_0) do
		local var_10_1 = arg_10_0.togglesTF
		local var_10_2 = var_7.Find(var_10_1, var_0_1.DropType2Name[iter_10_1])

		onToggle = var_1_10008

		local var_10_3 = arg_10_0
		local var_10_4 = var_10_2

		local function var_10_5(arg_11_0)
			if arg_11_0 then
				local var_11_0 = arg_10_0

				var_1.UpdatePage(var_11_0, iter_10_1)
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_1_10008(var_10_3, var_10_4, var_10_5, var_1_10013)

		var_1_10008 = arg_10_0.toggles
		var_1_10008[iter_10_1] = var_10_2
	end

	return
end

function var_0_1.AddSpecialBtnListener(arg_12_0)
	local var_12_0 = arg_12_0.activity
	local var_12_1 = var_1.getConfig(var_12_0, "config_client")
	local var_12_2 = arg_12_0.btnList

	arg_12_0.furnitureThemeBtn = var_2.Find(var_12_2, "furniture_theme")

	if arg_12_0.furnitureThemeBtn and var_12_1.furniture_theme_link then
		onButton = var_2

		local var_12_3 = arg_12_0
		local var_12_4 = arg_12_0.furnitureThemeBtn

		local function var_12_5()
			local var_13_0 = var_12_1.furniture_theme_link[1]
			local var_13_1 = var_0[2]
			local var_13_2 = var_0[3]
			local var_13_3 = arg_12_0

			var_4.DoSkip(var_13_3, var_13_0, var_13_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_12_3, var_12_4, var_12_5, var_1_10007)
	end

	local var_12_6 = arg_12_0.btnList

	arg_12_0.medalBtn = var_2.Find(var_12_6, "medal")

	if arg_12_0.medalBtn and var_12_1.medal_link then
		onButton = var_2

		local var_12_7 = arg_12_0
		local var_12_8 = arg_12_0.medalBtn

		local function var_12_9()
			local var_14_0 = var_12_1.medal_link[1]
			local var_14_1 = var_0[2]
			local var_14_2 = var_0[3]
			local var_14_3 = arg_12_0

			var_4.DoSkip(var_14_3, var_14_0, var_14_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_12_7, var_12_8, var_12_9, var_1_10007)
	end

	local var_12_10 = arg_12_0.btnList

	arg_12_0.equipSkinBoxBtn = var_2.Find(var_12_10, "equip_skin_box")

	if arg_12_0.equipSkinBoxBtn and var_12_1.equipskin_box_link then
		Drop = var_2

		local var_12_11 = var_2.New({
			type = var_12_1.equipskin_box_link.drop_type,
			id = var_12_1.equipskin_box_link.drop_id
		})
		local var_12_12 = var_2.getOwnedCount(var_12_11)

		onButton = var_12_0

		local var_12_13 = arg_12_0
		local var_12_14 = arg_12_0.equipSkinBoxBtn

		local function var_12_15()
			pg = var_2_10000

			local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_15_1 = var_0.ShowMsgBox
			local var_15_2 = {}

			MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10004
			var_15_2.type = var_2_10004
			Msgbox4LinkCollectGuide = var_2_10004
			var_15_2.show_type = var_2_10004.SHOW_TYPE_NORMAL
			var_15_2.drop_type = var_12_1.equipskin_box_link.drop_type
			var_15_2.drop_id = var_12_1.equipskin_box_link.drop_id
			var_15_2.count = var_12_12
			var_15_2.skipable_list = var_12_1.equipskin_box_link.list

			var_15_1(var_15_0, var_15_2)

			return
		end

		SFX_PANEL = var_1_10008

		var_12_0(var_12_13, var_12_14, var_12_15, var_1_10008)
	end

	return
end

function var_0_1.OnUpdateItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.showDataList[arg_16_1 + 1]
	local var_16_1 = arg_16_2:Find("icon_mask/icon")
	local var_16_2 = {
		type = var_16_0.config.type,
		id = var_16_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_16_1, var_16_2)

	onButton = var_6

	local var_16_3 = arg_16_0
	local var_16_4 = var_16_1

	local function var_16_5()
		local var_17_0 = arg_16_0

		var_0.OnClickItem(var_17_0, var_16_0)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_16_3, var_16_4, var_16_5, var_1_10011)

	changeToScrollText = var_6

	local var_16_6 = arg_16_2:Find("name_mask/name")

	Drop = var_16_4

	local var_16_7 = var_16_4.New({
		type = var_16_0.config.type,
		id = var_16_0.config.drop_id
	})

	var_6(var_16_6, var_9.getName(var_16_7))
	arg_16_0:RefreshCountText(var_16_0, arg_16_2)

	GetOrAddComponent = var_6

	local var_16_8 = arg_16_2:Find("owner")

	typeof = var_9
	CanvasGroup = var_11
	var_6(var_16_8, var_9(var_11)).alpha = var_16_0.count == var_16_0.config.count and 0.5 or 1
	setActive = var_7

	var_7(arg_16_2:Find("got"), var_16_0.count == var_16_0.config.count)

	setActive = var_7

	var_7(arg_16_2:Find("new"), var_16_0.config.is_new == "1")

	return
end

function var_0_1.RefreshCountText(arg_18_0, arg_18_1, arg_18_2)
	setText = var_1_10003

	var_1_10003(arg_18_2:Find("owner/number"), arg_18_1.count .. "/" .. arg_18_1.config.count)

	return
end

function var_0_1.OnClickItem(arg_19_0, arg_19_1)
	local var_19_0 = {}

	MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_1_10003
	var_19_0.type = var_1_10003
	Msgbox4LinkCollectGuide = var_1_10003
	var_19_0.show_type = var_1_10003.SHOW_TYPE_LIMIT
	var_19_0.drop_type = arg_19_1.config.type
	var_19_0.drop_id = arg_19_1.config.drop_id
	var_19_0.count = arg_19_1.count
	var_19_0.count_limit = arg_19_1.config.count
	var_19_0.skipable_list = arg_19_1.config.link_params

	arg_19_0:updateBoxPanel(var_19_0)
	arg_19_0:showBoxPanel(true)

	return
end

function var_0_1.UpdatePage(arg_20_0, arg_20_1)
	arg_20_0.curPage = arg_20_1
	arg_20_0.showDataList = {}
	ipairs = var_2

	for iter_20_0, iter_20_1 in var_2(arg_20_0.dataList) do
		if arg_20_0.guideConfig[iter_20_1.id].type == arg_20_1 then
			table = var_7

			var_7.insert(arg_20_0.showDataList, iter_20_1)
		end
	end

	table = var_2

	local var_20_0 = var_2.sort
	local var_20_1 = arg_20_0.showDataList

	CompareFuncs = iter_20_0

	var_20_0(var_20_1, iter_20_0({
		function(arg_21_0)
			return arg_21_0.count < arg_21_0.config.count and 0 or 1
		end,
		function(arg_22_0)
			return arg_22_0.config.order
		end,
		function(arg_23_0)
			return arg_23_0.id
		end
	}))

	local var_20_2 = arg_20_0.itemList

	var_2.align(var_20_2, #arg_20_0.showDataList)

	return
end

function var_0_1.updateBoxPanel(arg_24_0, arg_24_1)
	Drop = var_1_10002

	local var_24_0 = var_1_10002.New({
		type = arg_24_1.drop_type,
		id = arg_24_1.drop_id
	})

	updateDrop = var_1_10003

	var_1_10003(arg_24_0.boxIconTF, var_24_0)

	local var_24_1 = var_24_0.cfg

	changeToScrollText = var_4

	var_4(arg_24_0.boxNameText, var_24_1.name)

	setText = var_4

	local var_24_2 = arg_24_0.boxDescText

	SwitchSpecialChar = var_7

	var_4(var_24_2, var_7(var_24_0.desc))

	setText = var_4

	local var_24_3 = arg_24_0.boxNumTip

	i18n = var_7

	var_4(var_24_3, var_7("collect_page_got"))

	local var_24_4 = arg_24_1.show_type

	Msgbox4LinkCollectGuide = var_5

	if var_24_4 == var_5.SHOW_TYPE_NORMAL then
		setText = var_24_4

		var_24_4(arg_24_0.boxNumText, arg_24_1.count)
	else
		var_24_4 = arg_24_1.show_type
		Msgbox4LinkCollectGuide = var_5

		if var_24_4 == var_5.SHOW_TYPE_LIMIT then
			setText = var_24_4

			local var_24_5 = arg_24_0.boxNumText

			string = var_7

			local var_24_6 = var_7.format
			local var_24_7 = "%s<color=#735d54>/%s</color>"
			local var_24_8 = arg_24_1.count
			local var_24_9

			if not arg_24_1.count_limit then
				var_24_9 = 0
			end

			var_24_4(var_24_5, var_24_6(var_24_7, var_24_8, var_24_9))
		end
	end

	UIItemList = var_24_4

	var_24_4.StaticAlign(arg_24_0.boxSrcContent, arg_24_0.boxSrcTpl, #arg_24_1.skipable_list, function(arg_25_0, arg_25_1, arg_25_2)
		UIItemList = var_2_10003

		if arg_25_0 == var_2_10003.EventUpdate then
			local var_25_0 = arg_24_1.skipable_list[arg_25_1 + 1][1]
			local var_25_1 = var_3[2]
			local var_25_2 = var_3[3]

			changeToScrollText = var_2_10007

			local var_25_3 = arg_25_2

			var_2_10007(arg_25_2.Find(var_25_3, "SrcText"), var_25_2)

			local var_25_4 = arg_25_2:Find("GoBtn")

			setText = var_2_10008

			local var_25_5 = var_25_4:Find("go")

			i18n = var_25_3

			var_2_10008(var_25_5, var_25_3("brs_reward_tip_2"))

			onButton = var_2_10008

			local var_25_6 = arg_24_0
			local var_25_7 = var_25_4

			local function var_25_8()
				local var_26_0 = arg_24_0

				var_0.DoSkip(var_26_0, var_25_0, var_25_1)

				local var_26_1 = arg_24_0

				var_0.showBoxPanel(var_26_1, false)

				return
			end

			SFX_PANEL = var_13

			var_2_10008(var_25_6, var_25_7, var_25_8, var_13)
		end

		return
	end)

	return
end

function var_0_1.showBoxPanel(arg_27_0, arg_27_1)
	setActive = var_1_10002

	var_1_10002(arg_27_0.boxTF, arg_27_1)

	if arg_27_1 == true then
		pg = var_1_10002

		local var_27_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_27_0, arg_27_0.boxTF)
	else
		pg = var_1_10002

		local var_27_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_27_1, arg_27_0.boxTF)
	end

	return
end

function var_0_1.DoSkip(arg_28_0, arg_28_1, arg_28_2)
	Msgbox4LinkCollectGuide = var_1_10003

	local var_28_1

	if arg_28_1 == var_1_10003.SKIP_TYPE_SCENE then
		pg = var_28_1

		local var_28_0 = var_28_1.m02

		var_28_1 = var_28_1.sendNotification
		GAME = var_1_10006
		var_1_10006 = var_1_10006.GO_SCENE
		var_1_10007 = arg_28_2[1]

		local var_28_2

		if not arg_28_2[2] then
			var_28_2 = {}
		end

		var_28_1(var_28_0, var_1_10006, var_1_10007, var_28_2)
	else
		Msgbox4LinkCollectGuide = var_28_1

		if arg_28_1 == var_28_1.SKIP_TYPE_SCENE then
			pg = var_3

			local var_28_3 = var_3.m02
			local var_28_4 = var_3.sendNotification

			GAME = var_1_10006

			local var_28_5 = var_1_10006.GO_SCENE

			SCENE = var_1_10007

			var_28_4(var_28_3, var_28_5, var_1_10007.ACTIVITY, {
				id = arg_28_2
			})
		end
	end

	return
end

return var_0_1
