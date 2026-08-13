class = var_0_10000

local var_0_0 = "ALYAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = {}
	local var_1_2 = arg_1_0.AD

	var_1_1[1] = var_2.Find(var_1_2, "tabs/top_1")

	local var_1_3 = arg_1_0.AD

	var_1_1[2] = var_2.Find(var_1_3, "tabs/top_2")

	local var_1_4 = arg_1_0.AD

	var_1_1[3] = var_2.Find(var_1_4, "tabs/top_3")

	local var_1_5 = arg_1_0.AD

	var_1_1[4] = var_2.Find(var_1_5, "tabs/top_4")
	arg_1_0.table_Top = var_1_1

	local var_1_6 = arg_1_0.AD

	arg_1_0.btn = var_1.Find(var_1_6, "btn")

	local var_1_7 = arg_1_0.btn

	arg_1_0.furmiturebtn = var_1.Find(var_1_7, "furmiturebtn")

	local var_1_8 = arg_1_0.btn

	arg_1_0.commemoratebtn = var_1.Find(var_1_8, "commemoratebtn")

	local var_1_9 = arg_1_0.btn

	arg_1_0.equipmentbtn = var_1.Find(var_1_9, "equipmentbtn")

	local var_1_10 = arg_1_0.furmiturebtn
	local var_1_11 = var_1.Find(var_1_10, "left/Title")
	local var_1_12 = var_1.GetComponent

	typeof = var_3
	Image = var_4

	local var_1_13 = var_1_12(var_1_11, var_3(var_4))

	var_1.SetNativeSize(var_1_13)

	local var_1_14 = arg_1_0.commemoratebtn
	local var_1_15 = var_1.Find(var_1_14, "left/Title")
	local var_1_16 = var_1.GetComponent

	typeof = var_3
	Image = var_4

	local var_1_17 = var_1_16(var_1_15, var_3(var_4))

	var_1.SetNativeSize(var_1_17)

	local var_1_18 = arg_1_0.equipmentbtn
	local var_1_19 = var_1.Find(var_1_18, "left/Title")
	local var_1_20 = var_1.GetComponent

	typeof = var_3
	Image = var_4

	local var_1_21 = var_1_20(var_1_19, var_3(var_4))

	var_1.SetNativeSize(var_1_21)

	local var_1_22 = arg_1_0._tf

	arg_1_0.boxTF = var_1.Find(var_1_22, "Box")

	local var_1_23 = arg_1_0.boxTF

	arg_1_0.boxBG = var_1.Find(var_1_23, "BG")

	local var_1_24 = arg_1_0.boxTF

	arg_1_0.panel = var_1.Find(var_1_24, "Panel")

	local var_1_25 = arg_1_0.panel

	arg_1_0.infoTF = var_1.Find(var_1_25, "Info")

	local var_1_26 = arg_1_0.infoTF

	arg_1_0.boxCloseBtn = var_1.Find(var_1_26, "CloseBtn")

	local var_1_27 = arg_1_0.infoTF

	arg_1_0.Title = var_1.Find(var_1_27, "Title")
	setText = var_1

	local var_1_28 = arg_1_0.Title

	i18n = var_3

	var_1(var_1_28, var_3("brs_reward_tip_1"))

	local var_1_29 = arg_1_0.infoTF

	arg_1_0.boxIconTF = var_1.Find(var_1_29, "Icon/Mask/IconTpl")

	local var_1_30 = arg_1_0.infoTF

	arg_1_0.boxNameText = var_1.Find(var_1_30, "NameText")

	local var_1_31 = arg_1_0.infoTF

	arg_1_0.boxNumTF = var_1.Find(var_1_31, "Num")

	local var_1_32 = arg_1_0.boxNumTF

	arg_1_0.boxNumTip = var_1.Find(var_1_32, "Text")

	local var_1_33 = arg_1_0.boxNumTF

	arg_1_0.boxNumText = var_1.Find(var_1_33, "NumText")

	local var_1_34 = arg_1_0.infoTF

	arg_1_0.boxDescText = var_1.Find(var_1_34, "DescText")

	local var_1_35 = arg_1_0.infoTF

	arg_1_0.boxSrcText = var_1.Find(var_1_35, "SrcText")

	local var_1_36 = arg_1_0.panel

	arg_1_0.boxSrcContent = var_1.Find(var_1_36, "Content")

	local var_1_37 = arg_1_0.boxSrcContent

	arg_1_0.boxSrcTpl = var_1.Find(var_1_37, "SrcTpl")
	onButton = var_1

	local var_1_38 = arg_1_0
	local var_1_39 = arg_1_0.boxBG

	local function var_1_40()
		local var_2_0 = arg_1_0

		var_0.showBoxPanel(var_2_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_38, var_1_39, var_1_40, var_1_10005)

	onButton = var_1

	local var_1_41 = arg_1_0
	local var_1_42 = arg_1_0.boxCloseBtn

	local function var_1_43()
		local var_3_0 = arg_1_0

		var_0.showBoxPanel(var_3_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_41, var_1_42, var_1_43, var_1_10005)

	return
end

function var_0_1.BuildDatas(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.activity_limit_item_guide.get_id_list_by_activity[arg_4_0.activity.id]

	assert = var_2

	var_2(var_4_0, "activity_limit_item_guide not exist activity id: " .. arg_4_0.activity.id)

	arg_4_0.dataList = {}
	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(var_4_0) do
		local var_4_1 = {
			id = iter_4_1
		}

		var_4_1.config = arg_4_0.guideConfig[var_4_1.id]

		local var_4_2 = arg_4_0.activity

		var_4_1.count = var_8.getKVPList(var_4_2, 1, var_4_1.id)

		if var_4_1.config.count_storage == 1 then
			Drop = var_8

			local var_4_3 = var_8.New({
				type = var_4_1.config.type,
				id = var_4_1.config.drop_id
			})

			var_4_1.count = var_8.getOwnedCount(var_4_3)
		end

		table = var_8

		var_8.insert(arg_4_0.dataList, var_4_1)
	end

	return
end

function var_0_1.OnDataSetting(arg_5_0)
	pg = var_1_10001
	arg_5_0.guideConfig = var_1_10001.activity_limit_item_guide

	arg_5_0:BuildDatas()

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	arg_6_0:InitData()

	local var_6_0 = arg_6_0.activity
	local var_6_1 = var_1.getConfig(var_6_0, "config_client")

	onButton = var_6_0

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.furmiturebtn

	local function var_6_4()
		local var_7_0 = arg_6_0

		var_0.DoSkip(var_7_0, var_6_1.furniture_theme_link[1], var_6_1.furniture_theme_link[2])

		return
	end

	SFX_PANEL = var_1_10006

	var_6_0(var_6_2, var_6_3, var_6_4, var_1_10006)

	onButton = var_6_0

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.commemoratebtn

	local function var_6_7()
		local var_8_0 = arg_6_0

		var_0.DoSkip(var_8_0, var_6_1.medal_link[1], var_6_1.medal_link[2])

		return
	end

	SFX_PANEL = var_1_10006

	var_6_0(var_6_5, var_6_6, var_6_7, var_1_10006)

	onButton = var_6_0

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.equipmentbtn

	local function var_6_10()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10003
		var_9_2.type = var_2_10003
		Msgbox4LinkCollectGuide = var_2_10003
		var_9_2.show_type = var_2_10003.SHOW_TYPE_NORMAL
		var_9_2.drop_type = var_6_1.equipskin_box_link.drop_type
		var_9_2.drop_id = var_6_1.equipskin_box_link.drop_id
		count = var_3
		var_9_2.count = var_3
		var_9_2.skipable_list = var_6_1.equipskin_box_link.list

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_6_0(var_6_8, var_6_9, var_6_10, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	triggerToggle = var_1_10001

	local var_10_0 = arg_10_0.table_Top
	local var_10_1

	if not arg_10_0.pageIndex then
		var_10_1 = 1
	end

	var_1_10001(var_10_0[var_10_1], true)

	return
end

function var_0_1.ResetTop(arg_11_0)
	for iter_11_0 = 1, #arg_11_0.table_Top do
		setText = var_1_10005

		local var_11_0 = arg_11_0.AD
		local var_11_1 = var_6.Find(var_11_0, "tabs/top_" .. iter_11_0 .. "/Label")

		i18n = var_11_0

		var_1_10005(var_11_1, var_11_0("yumia_award_" .. iter_11_0))

		setTextColor = var_1_10005

		local var_11_2 = arg_11_0.AD
		local var_11_3 = var_6.Find(var_11_2, "tabs/top_" .. iter_11_0 .. "/Label")

		Color = var_11_2

		var_1_10005(var_11_3, var_11_2.NewHex("cfcfcf"))
	end

	return
end

function var_0_1.InitData(arg_12_0)
	ipairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.table_Top) do
		onToggle = var_1_10006

		local var_12_0 = arg_12_0
		local var_12_1 = iter_12_1

		local function var_12_2(arg_13_0)
			if arg_13_0 then
				local var_13_0 = arg_12_0

				var_13_0.pageIndex = iter_12_0
				onDelayTick = var_13_0

				var_13_0(function()
					local var_14_0 = arg_12_0

					var_0.DataList(var_14_0, iter_12_0)

					return
				end, 0.08)

				local var_13_1 = arg_12_0

				var_1.ResetTop(var_13_1)

				setTextColor = var_1

				local var_13_2 = arg_12_0.AD
				local var_13_3 = var_2.Find(var_13_2, "tabs/top_" .. iter_12_0 .. "/Label")

				Color = var_13_2

				var_1(var_13_3, var_13_2.NewHex("0a2e31"))
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_12_0, var_12_1, var_12_2, var_1_10010)
	end

	return
end

function var_0_1.DataList(arg_15_0, arg_15_1)
	arg_15_0.showDataList = {}
	ipairs = var_2

	for iter_15_0, iter_15_1 in var_2(arg_15_0.dataList) do
		if arg_15_0.guideConfig[iter_15_1.id].type == 3 and arg_15_1 == 1 then
			table = var_7

			var_7.insert(arg_15_0.showDataList, iter_15_1)
		elseif arg_15_0.guideConfig[iter_15_1.id].type == 5 and arg_15_1 == 2 then
			table = var_7

			var_7.insert(arg_15_0.showDataList, iter_15_1)
		elseif arg_15_0.guideConfig[iter_15_1.id].type == 9 and arg_15_1 == 3 then
			table = var_7

			var_7.insert(arg_15_0.showDataList, iter_15_1)
		elseif arg_15_0.guideConfig[iter_15_1.id].type == 21 and arg_15_1 == 4 then
			table = var_7

			var_7.insert(arg_15_0.showDataList, iter_15_1)
		end
	end

	table = var_2

	local var_15_0 = var_2.sort
	local var_15_1 = arg_15_0.showDataList

	CompareFuncs = var_4

	var_15_0(var_15_1, var_4({
		function(arg_16_0)
			return arg_16_0.count < arg_16_0.config.count and 0 or 1
		end,
		function(arg_17_0)
			return arg_17_0.config.order
		end,
		function(arg_18_0)
			return arg_18_0.id
		end
	}))
	arg_15_0:ShowCharaPage()

	return
end

function var_0_1.ShowCharaPage(arg_19_0)
	local var_19_0 = arg_19_0.AD

	arg_19_0.award = var_1.Find(var_19_0, "tpl")

	local var_19_1 = arg_19_0.AD

	arg_19_0.count = var_1.Find(var_19_1, "item_list/content")
	UIItemList = var_1
	arg_19_0.tabsList = var_1.New(arg_19_0.count, arg_19_0.award)

	local var_19_2 = arg_19_0.tabsList

	var_1.make(var_19_2, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = arg_19_0

			var_3.OnUpdateItem(var_20_0, arg_20_1, arg_20_2)
		end

		return
	end)

	local var_19_3 = arg_19_0.tabsList

	var_1.align(var_19_3, #arg_19_0.showDataList)

	return
end

function var_0_1.OnUpdateItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.showDataList[arg_21_1 + 1]
	local var_21_1 = arg_21_2:Find("icon_mask/icon")
	local var_21_2 = {
		type = var_21_0.config.type,
		id = var_21_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_21_1, var_21_2)

	onButton = var_6

	local var_21_3 = arg_21_0
	local var_21_4 = var_21_1

	local function var_21_5()
		local var_22_0 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10001
		var_22_0.type = var_2_10001
		Msgbox4LinkCollectGuide = var_2_10001
		var_22_0.show_type = var_2_10001.SHOW_TYPE_LIMIT
		var_22_0.drop_type = var_21_0.config.type
		var_22_0.drop_id = var_21_0.config.drop_id
		var_22_0.count = var_21_0.count
		var_22_0.count_limit = var_21_0.config.count
		var_22_0.skipable_list = var_21_0.config.link_params

		local var_22_1 = arg_21_0

		var_1.updateBoxPanel(var_22_1, var_22_0)

		local var_22_2 = arg_21_0

		var_1.showBoxPanel(var_22_2, true)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_21_3, var_21_4, var_21_5, var_1_10010)

	changeToScrollText = var_6

	local var_21_6 = arg_21_2
	local var_21_7 = arg_21_2.Find(var_21_6, "name_mask/name")

	Drop = var_21_6

	local var_21_8 = var_21_6.New({
		type = var_21_0.config.type,
		id = var_21_0.config.drop_id
	})

	var_6(var_21_7, var_8.getName(var_21_8))

	setText = var_6

	local var_21_9 = arg_21_2
	local var_21_10 = arg_21_2.Find(var_21_9, "owner/title")

	i18n = var_21_9

	var_6(var_21_10, var_21_9("collect_page_got"))

	setText = var_6

	var_6(arg_21_2:Find("owner/Text"), var_21_0.count)

	setText = var_6

	var_6(arg_21_2:Find("owner/number"), "/" .. var_21_0.config.count)

	GetOrAddComponent = var_6

	local var_21_11 = arg_21_2
	local var_21_12 = arg_21_2.Find(var_21_11, "owner")

	typeof = var_21_11
	CanvasGroup = var_9
	var_6(var_21_12, var_21_11(var_9)).alpha = var_21_0.count == var_21_0.config.count and 0.5 or 1
	setActive = var_7

	var_7(arg_21_2:Find("got"), var_21_0.count == var_21_0.config.count)

	return
end

function var_0_1.updateBoxPanel(arg_23_0, arg_23_1)
	Drop = var_1_10002

	local var_23_0 = var_1_10002.New({
		type = arg_23_1.drop_type,
		id = arg_23_1.drop_id
	})

	updateDrop = var_3

	var_3(arg_23_0.boxIconTF, var_23_0)

	local var_23_1 = var_23_0.cfg

	changeToScrollText = var_4

	var_4(arg_23_0.boxNameText, var_23_1.name)

	setText = var_4

	local var_23_2 = arg_23_0.boxDescText

	SwitchSpecialChar = var_6

	var_4(var_23_2, var_6(var_23_0.desc))

	setText = var_4

	local var_23_3 = arg_23_0.boxNumTip

	i18n = var_6

	var_4(var_23_3, var_6("word_got") .. "：")

	local var_23_4 = arg_23_1.show_type

	Msgbox4LinkCollectGuide = var_23_3

	if var_23_4 == var_23_3.SHOW_TYPE_NORMAL then
		setText = var_23_4

		var_23_4(arg_23_0.boxNumText, "<color=#FCFCE8>" .. arg_23_1.count .. "</color>")
	else
		var_23_4 = arg_23_1.show_type
		Msgbox4LinkCollectGuide = var_5

		if var_23_4 == var_5.SHOW_TYPE_LIMIT then
			setText = var_23_4

			local var_23_5 = arg_23_0.boxNumText
			local var_23_6 = "<color=#FCFCE8>"
			local var_23_7 = arg_23_1.count
			local var_23_8 = "</color>/"
			local var_23_9

			if not arg_23_1.count_limit then
				var_23_9 = 0
			end

			var_23_4(var_23_5, var_23_6 .. var_23_7 .. var_23_8 .. var_23_9)
		end
	end

	UIItemList = var_23_4

	var_23_4.StaticAlign(arg_23_0.boxSrcContent, arg_23_0.boxSrcTpl, #arg_23_1.skipable_list, function(arg_24_0, arg_24_1, arg_24_2)
		UIItemList = var_2_10003

		if arg_24_0 == var_2_10003.EventUpdate then
			local var_24_0 = arg_23_1.skipable_list[arg_24_1 + 1][1]
			local var_24_1 = var_3[2]
			local var_24_2 = var_3[3]

			changeToScrollText = var_2_10007

			var_2_10007(arg_24_2:Find("SrcText"), var_24_2)

			local var_24_3 = arg_24_2
			local var_24_4 = arg_24_2.Find(var_24_3, "GoBtn")

			setText = var_24_3

			local var_24_5 = var_24_4
			local var_24_6 = var_24_4.Find(var_24_5, "go")

			i18n = var_24_5

			var_24_3(var_24_6, var_24_5("brs_reward_tip_2"))

			onButton = var_24_3

			local var_24_7 = arg_23_0
			local var_24_8 = var_24_4

			local function var_24_9()
				local var_25_0 = arg_23_0

				var_0.DoSkip(var_25_0, var_24_0, var_24_1)

				local var_25_1 = arg_23_0

				var_0.showBoxPanel(var_25_1, false)

				return
			end

			SFX_PANEL = var_2_10012

			var_24_3(var_24_7, var_24_8, var_24_9, var_2_10012)
		end

		return
	end)

	return
end

function var_0_1.DoSkip(arg_26_0, arg_26_1, arg_26_2)
	Msgbox4LinkCollectGuide = var_1_10003

	local var_26_1

	if arg_26_1 == var_1_10003.SKIP_TYPE_SCENE then
		pg = var_26_1

		local var_26_0 = var_26_1.m02

		var_26_1 = var_26_1.sendNotification
		GAME = var_1_10005
		var_1_10005 = var_1_10005.GO_SCENE
		var_1_10006 = arg_26_2[1]

		local var_26_2

		if not arg_26_2[2] then
			var_26_2 = {}
		end

		var_26_1(var_26_0, var_1_10005, var_1_10006, var_26_2)
	else
		Msgbox4LinkCollectGuide = var_26_1

		if arg_26_1 == var_26_1.SKIP_TYPE_ACTIVITY then
			pg = var_3

			local var_26_3 = var_3.m02
			local var_26_4 = var_3.sendNotification

			GAME = var_1_10005

			local var_26_5 = var_1_10005.GO_SCENE

			SCENE = var_1_10006

			var_26_4(var_26_3, var_26_5, var_1_10006.ACTIVITY, {
				id = arg_26_2
			})
		end
	end

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

		var_2.UnOverlayPanel(var_27_1, arg_27_0.boxTF, arg_27_0._tf)
	end

	return
end

function var_0_1.OnDestroy(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_28_0, arg_28_0.boxTF, arg_28_0._tf)
	var_0_1.super.OnDestroy(arg_28_0)

	return
end

return var_0_1
