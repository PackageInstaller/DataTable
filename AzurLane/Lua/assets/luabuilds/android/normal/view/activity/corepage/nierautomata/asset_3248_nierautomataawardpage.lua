class = var_0_10000

local var_0_0 = "NieRAutomataAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

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
	arg_1_0.table_local = {
		"nier_award_char",
		"nier_award_furniture",
		"nier_award_equip_skin",
		"nier_award_sp_equip"
	}

	local var_1_6 = arg_1_0.AD

	arg_1_0.bg_1 = var_1.Find(var_1_6, "bg_1")

	local var_1_7 = arg_1_0.AD

	arg_1_0.bg_2 = var_1.Find(var_1_7, "bg_2")

	local var_1_8 = arg_1_0._tf

	arg_1_0.boxTF = var_1.Find(var_1_8, "Box")

	local var_1_9 = arg_1_0.boxTF

	arg_1_0.boxBG = var_1.Find(var_1_9, "BG")

	local var_1_10 = arg_1_0.boxTF

	arg_1_0.panel = var_1.Find(var_1_10, "Panel")

	local var_1_11 = arg_1_0.panel

	arg_1_0.infoTF = var_1.Find(var_1_11, "Info")

	local var_1_12 = arg_1_0.infoTF

	arg_1_0.boxCloseBtn = var_1.Find(var_1_12, "CloseBtn")

	local var_1_13 = arg_1_0.infoTF

	arg_1_0.Title = var_1.Find(var_1_13, "Title")
	setText = var_1

	local var_1_14 = arg_1_0.Title

	i18n = var_3

	var_1(var_1_14, var_3("brs_reward_tip_1"))

	local var_1_15 = arg_1_0.infoTF

	arg_1_0.boxIconTF = var_1.Find(var_1_15, "Icon/Mask/IconTpl")

	local var_1_16 = arg_1_0.infoTF

	arg_1_0.boxNameText = var_1.Find(var_1_16, "NameText")

	local var_1_17 = arg_1_0.infoTF

	arg_1_0.boxNumTF = var_1.Find(var_1_17, "Num")

	local var_1_18 = arg_1_0.boxNumTF

	arg_1_0.boxNumTip = var_1.Find(var_1_18, "Text")

	local var_1_19 = arg_1_0.boxNumTF

	arg_1_0.boxNumText = var_1.Find(var_1_19, "NumText")

	local var_1_20 = arg_1_0.infoTF

	arg_1_0.boxDescText = var_1.Find(var_1_20, "DescText")

	local var_1_21 = arg_1_0.infoTF

	arg_1_0.boxSrcText = var_1.Find(var_1_21, "SrcText")

	local var_1_22 = arg_1_0.panel

	arg_1_0.boxSrcContent = var_1.Find(var_1_22, "Content")

	local var_1_23 = arg_1_0.boxSrcContent

	arg_1_0.boxSrcTpl = var_1.Find(var_1_23, "SrcTpl")
	arg_1_0.boxOpen = false
	onButton = var_1

	local var_1_24 = arg_1_0
	local var_1_25 = arg_1_0.boxBG

	local function var_1_26()
		local var_2_0 = arg_1_0

		var_0.showBoxPanel(var_2_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_24, var_1_25, var_1_26, var_1_10005)

	onButton = var_1

	local var_1_27 = arg_1_0
	local var_1_28 = arg_1_0.boxCloseBtn

	local function var_1_29()
		local var_3_0 = arg_1_0

		var_0.showBoxPanel(var_3_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_27, var_1_28, var_1_29, var_1_10005)

	pg = var_1

	local var_1_30 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_1_30, arg_1_0.boxTF)

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

	local var_5_0 = var_1_10001.activity_limit_item_guide.get_id_list_by_activity[arg_5_0.activity.id]

	assert = var_2

	var_2(var_5_0, "activity_limit_item_guide not exist activity id: " .. arg_5_0.activity.id)

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

function var_0_1.OnFirstFlush(arg_6_0)
	arg_6_0:InitData()
	arg_6_0:Hx4Channel()

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	arg_7_0:UpdateView()

	return
end

function var_0_1.InitData(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.table_Top) do
		setText = var_1_10006

		local var_8_0 = iter_8_1
		local var_8_1 = iter_8_1.Find(var_8_0, "on/Text")

		i18n = var_8_0

		var_1_10006(var_8_1, var_8_0(arg_8_0.table_local[iter_8_0]))

		setText = var_1_10006

		local var_8_2 = iter_8_1
		local var_8_3 = iter_8_1.Find(var_8_2, "off/Text")

		i18n = var_8_2

		var_1_10006(var_8_3, var_8_2(arg_8_0.table_local[iter_8_0]))

		onToggle = var_1_10006

		local var_8_4 = arg_8_0
		local var_8_5 = iter_8_1

		local function var_8_6(arg_9_0)
			if arg_9_0 then
				var_2_10001 = arg_8_0
				var_2_10001.pageIndex = iter_8_0
				SetActive = var_2_10001

				var_2_10001(arg_8_0.bg_1, iter_8_0 == 1)

				SetActive = var_2_10001

				var_2_10001(arg_8_0.bg_2, iter_8_0 ~= 1)

				local var_9_0 = arg_8_0

				var_2_10001.DataList(var_9_0, iter_8_0)

				setActive = var_2_10001

				local var_9_1 = arg_8_0.table_Top[iter_8_0]

				var_2_10001(var_2.Find(var_9_1, "off"), false)
			else
				setActive = var_2_10001

				local var_9_2 = arg_8_0.table_Top[iter_8_0]

				var_2_10001(var_2.Find(var_9_2, "off"), true)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_8_4, var_8_5, var_8_6, var_1_10010)
	end

	return
end

function var_0_1.UpdateView(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.table_Top do
		setText = var_1_10005

		local var_10_0 = arg_10_0.table_Top[iter_10_0]

		var_1_10005(var_6.Find(var_10_0, "on/label"), arg_10_0:OnGetCount(iter_10_0) .. "/" .. arg_10_0:OnCount(iter_10_0))

		setText = var_1_10005

		local var_10_1 = arg_10_0.table_Top[iter_10_0]

		var_1_10005(var_6.Find(var_10_1, "off/label"), arg_10_0:OnGetCount(iter_10_0) .. "/" .. arg_10_0:OnCount(iter_10_0))
	end

	local var_10_2

	if not arg_10_0.pageIndex then
		var_10_2 = 1
	end

	triggerToggle = var_2

	var_2(arg_10_0.table_Top[var_10_2], true)

	return
end

function var_0_1.DataList(arg_11_0, arg_11_1)
	arg_11_0.showDataList = {}
	ipairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.dataList) do
		if arg_11_0.guideConfig[iter_11_1.id].type == 4 and arg_11_1 == 1 then
			table = var_7

			var_7.insert(arg_11_0.showDataList, iter_11_1)
		elseif arg_11_0.guideConfig[iter_11_1.id].type == 5 and arg_11_1 == 2 then
			table = var_7

			var_7.insert(arg_11_0.showDataList, iter_11_1)
		elseif arg_11_0.guideConfig[iter_11_1.id].type == 9 and arg_11_1 == 3 then
			table = var_7

			var_7.insert(arg_11_0.showDataList, iter_11_1)
		elseif arg_11_0.guideConfig[iter_11_1.id].type == 21 and arg_11_1 == 4 then
			table = var_7

			var_7.insert(arg_11_0.showDataList, iter_11_1)
		end
	end

	table = var_2

	local var_11_0 = var_2.sort
	local var_11_1 = arg_11_0.showDataList

	CompareFuncs = var_4

	var_11_0(var_11_1, var_4({
		function(arg_12_0)
			return arg_12_0.config.order
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))

	if arg_11_1 == 1 then
		arg_11_0:ShowSitePage()
	elseif arg_11_1 == 2 or arg_11_1 == 3 or arg_11_1 == 4 then
		arg_11_0:ShowCharaPage()
	end

	return
end

function var_0_1.OnCount(arg_14_0, arg_14_1)
	local var_14_0 = {}

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.dataList) do
		if arg_14_0.guideConfig[iter_14_1.id].type == 4 and arg_14_1 == 1 then
			table = var_8

			var_8.insert(var_14_0, iter_14_1)
		elseif arg_14_0.guideConfig[iter_14_1.id].type == 5 and arg_14_1 == 2 then
			table = var_8

			var_8.insert(var_14_0, iter_14_1)
		elseif arg_14_0.guideConfig[iter_14_1.id].type == 9 and arg_14_1 == 3 then
			table = var_8

			var_8.insert(var_14_0, iter_14_1)
		elseif arg_14_0.guideConfig[iter_14_1.id].type == 21 and arg_14_1 == 4 then
			table = var_8

			var_8.insert(var_14_0, iter_14_1)
		end
	end

	return #var_14_0
end

function var_0_1.OnGetCount(arg_15_0, arg_15_1)
	local var_15_0 = 0

	ipairs = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10003(arg_15_0.dataList) do
		if arg_15_0.guideConfig[iter_15_1.id].type == 4 and arg_15_1 == 1 then
			Drop = var_8

			local var_15_1 = var_8.New({
				type = iter_15_1.config.type,
				id = iter_15_1.config.drop_id
			}).id

			pg = var_10

			local var_15_2 = var_10.ship_data_template[var_15_1].group_type

			tobool = var_1_10011
			getProxy = var_1_10012
			CollectionProxy = var_1_10013
			var_1_10013 = var_1_10012(var_1_10013)

			if var_1_10011(var_1_10012.getShipGroup(var_1_10013, var_15_2)) then
				var_15_0 = var_15_0 + 1
			end
		elseif arg_15_0.guideConfig[iter_15_1.id].type == 5 and arg_15_1 == 2 then
			if iter_15_1.count == iter_15_1.config.count then
				var_15_0 = var_15_0 + 1
			end
		elseif arg_15_0.guideConfig[iter_15_1.id].type == 9 and arg_15_1 == 3 then
			if iter_15_1.count == iter_15_1.config.count then
				var_15_0 = var_15_0 + 1
			end
		elseif arg_15_0.guideConfig[iter_15_1.id].type == 21 and arg_15_1 == 4 and iter_15_1.count == iter_15_1.config.count then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function var_0_1.ShowSitePage(arg_16_0)
	local var_16_0 = arg_16_0.showDataList[1].config.drop_id
	local var_16_1 = arg_16_0.bg_1
	local var_16_2 = var_2.Find(var_16_1, "Role_left")
	local var_16_3 = var_2.Find(var_16_2, "lock_bg")
	local var_16_4 = var_2:Find("name")
	local var_16_5 = var_2:Find("get")
	local var_16_6 = var_5.Find(var_16_5, "Text")
	local var_16_7 = var_2:Find("notget")
	local var_16_8 = var_7.Find(var_16_7, "Text")

	setText = var_16_7

	local var_16_9 = var_16_6

	i18n = var_1_10011

	var_16_7(var_16_9, var_1_10011("word_got"))

	setText = var_16_7

	local var_16_10 = var_16_8

	i18n = var_11

	var_16_7(var_16_10, var_11("word_not_get"))

	Drop = var_16_7

	local var_16_11 = var_16_7.New({
		type = arg_16_0.showDataList[1].config.type,
		id = arg_16_0.showDataList[1].config.drop_id
	})
	local var_16_12 = var_9.getName(var_16_11)
	local var_16_13 = var_9.id

	pg = var_12

	local var_16_14 = var_12.ship_data_template[var_16_13].group_type

	tobool = var_1_10013
	getProxy = var_1_10014
	CollectionProxy = var_1_10015

	local var_16_15 = var_1_10014(var_1_10015)
	local var_16_16 = var_1_10013(var_14.getShipGroup(var_16_15, var_16_14))

	SetActive = var_14

	var_14(var_16_3, not var_16_16)

	SetActive = var_14

	var_14(var_5, var_16_16)

	SetActive = var_14

	var_14(var_7, not var_16_16)

	local var_16_17 = arg_16_0.bg_1
	local var_16_18 = var_14.Find(var_16_17, "Role_right")
	local var_16_19 = var_14.Find(var_16_18, "lock_bg")
	local var_16_20 = var_14:Find("name")
	local var_16_21 = var_14:Find("get")
	local var_16_22 = var_17.Find(var_16_21, "Text")
	local var_16_23 = var_14:Find("notget")
	local var_16_24 = var_19.Find(var_16_23, "Text")

	setText = var_16_23

	local var_16_25 = var_16_22

	i18n = var_1_10023

	var_16_23(var_16_25, var_1_10023("word_got"))

	setText = var_16_23

	local var_16_26 = var_16_24

	i18n = var_23

	var_16_23(var_16_26, var_23("word_not_get"))

	local var_16_27 = arg_16_0.showDataList[2].config.drop_id

	Drop = var_16_26

	local var_16_28 = var_16_26.New({
		type = arg_16_0.showDataList[2].config.type,
		id = arg_16_0.showDataList[2].config.drop_id
	})
	local var_16_29 = var_22.getName(var_16_28)
	local var_16_30 = var_22.id

	pg = var_1_10025

	local var_16_31 = var_1_10025.ship_data_template[var_16_30].group_type

	tobool = var_1_10026
	getProxy = var_1_10027
	CollectionProxy = var_1_10028

	local var_16_32 = var_1_10027(var_1_10028)
	local var_16_33 = var_1_10026(var_27.getShipGroup(var_16_32, var_16_31))

	SetActive = var_27

	var_27(var_19, not var_16_33)

	SetActive = var_27

	var_27(var_17, var_16_33)

	SetActive = var_27

	var_27(var_16_19, not var_16_33)

	return
end

function var_0_1.ShowCharaPage(arg_17_0)
	local var_17_0 = arg_17_0.bg_2

	arg_17_0.award = var_1.Find(var_17_0, "tpl")

	local var_17_1 = arg_17_0.bg_2

	arg_17_0.count = var_1.Find(var_17_1, "count")
	UIItemList = var_1
	arg_17_0.tabsList = var_1.New(arg_17_0.count, arg_17_0.award)

	local var_17_2 = arg_17_0.tabsList

	var_1.make(var_17_2, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = arg_17_0
			local var_18_1 = var_3.OnUpdateItem
			local var_18_2 = arg_18_1
			local var_18_3 = arg_18_2

			data = var_2_10007

			var_18_1(var_18_0, var_18_2, var_18_3, var_2_10007)
		end

		return
	end)

	local var_17_3 = arg_17_0.tabsList

	var_1.align(var_17_3, #arg_17_0.showDataList)

	return
end

function var_0_1.OnUpdateItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.showDataList[arg_19_1 + 1]
	local var_19_1 = arg_19_2:Find("icon_mask/icon")
	local var_19_2 = {
		type = var_19_0.config.type,
		id = var_19_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_19_1, var_19_2)

	onButton = var_6

	local var_19_3 = arg_19_0
	local var_19_4 = var_19_1

	local function var_19_5()
		local var_20_0 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10001
		var_20_0.type = var_2_10001
		Msgbox4LinkCollectGuide = var_2_10001
		var_20_0.show_type = var_2_10001.SHOW_TYPE_LIMIT
		var_20_0.drop_type = var_19_0.config.type
		var_20_0.drop_id = var_19_0.config.drop_id
		var_20_0.count = var_19_0.count
		var_20_0.count_limit = var_19_0.config.count
		var_20_0.skipable_list = var_19_0.config.link_params

		local var_20_1 = arg_19_0

		var_1.updateBoxPanel(var_20_1, var_20_0)

		local var_20_2 = arg_19_0

		var_1.showBoxPanel(var_20_2, true)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_19_3, var_19_4, var_19_5, var_1_10010)

	changeToScrollText = var_6

	local var_19_6 = arg_19_2
	local var_19_7 = arg_19_2.Find(var_19_6, "name_mask/name")

	Drop = var_19_6

	local var_19_8 = var_19_6.New({
		type = var_19_0.config.type,
		id = var_19_0.config.drop_id
	})

	var_6(var_19_7, var_8.getName(var_19_8))

	setText = var_6

	var_6(arg_19_2:Find("owner/number"), var_19_0.count .. "/" .. var_19_0.config.count)

	GetOrAddComponent = var_6

	local var_19_9 = arg_19_2
	local var_19_10 = arg_19_2.Find(var_19_9, "owner")

	typeof = var_19_9
	CanvasGroup = var_9
	var_6(var_19_10, var_19_9(var_9)).alpha = var_19_0.count == var_19_0.config.count and 0.5 or 1
	setActive = var_7

	var_7(arg_19_2:Find("got"), var_19_0.count == var_19_0.config.count)

	return
end

function var_0_1.updateBoxPanel(arg_21_0, arg_21_1)
	Drop = var_1_10002

	local var_21_0 = var_1_10002.New({
		type = arg_21_1.drop_type,
		id = arg_21_1.drop_id
	})

	updateDrop = var_3

	var_3(arg_21_0.boxIconTF, var_21_0)

	local var_21_1 = var_21_0.cfg

	changeToScrollText = var_4

	var_4(arg_21_0.boxNameText, var_21_1.name)

	setText = var_4

	local var_21_2 = arg_21_0.boxDescText

	SwitchSpecialChar = var_6

	var_4(var_21_2, var_6(var_21_0.desc))

	setText = var_4

	local var_21_3 = arg_21_0.boxNumTip

	i18n = var_6

	var_4(var_21_3, var_6("word_got"))

	local var_21_4 = arg_21_1.show_type

	Msgbox4LinkCollectGuide = var_21_3

	if var_21_4 == var_21_3.SHOW_TYPE_NORMAL then
		setText = var_21_4

		var_21_4(arg_21_0.boxNumText, arg_21_1.count)
	else
		var_21_4 = arg_21_1.show_type
		Msgbox4LinkCollectGuide = var_5

		if var_21_4 == var_5.SHOW_TYPE_LIMIT then
			setText = var_21_4

			local var_21_5 = arg_21_0.boxNumText
			local var_21_6 = arg_21_1.count
			local var_21_7 = "/"
			local var_21_8

			if not arg_21_1.count_limit then
				var_21_8 = 0
			end

			var_21_4(var_21_5, var_21_6 .. var_21_7 .. var_21_8)
		end
	end

	UIItemList = var_21_4

	var_21_4.StaticAlign(arg_21_0.boxSrcContent, arg_21_0.boxSrcTpl, #arg_21_1.skipable_list, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = arg_21_1.skipable_list[arg_22_1 + 1][1]
			local var_22_1 = var_3[2]
			local var_22_2 = var_3[3]

			changeToScrollText = var_2_10007

			var_2_10007(arg_22_2:Find("SrcText"), var_22_2)

			local var_22_3 = arg_22_2
			local var_22_4 = arg_22_2.Find(var_22_3, "GoBtn")

			setText = var_22_3

			local var_22_5 = var_22_4
			local var_22_6 = var_22_4.Find(var_22_5, "go")

			i18n = var_22_5

			var_22_3(var_22_6, var_22_5("brs_reward_tip_2"))

			onButton = var_22_3

			local var_22_7 = arg_21_0
			local var_22_8 = var_22_4

			local function var_22_9()
				local var_23_0 = var_22_0

				Msgbox4LinkCollectGuide = var_3_10001

				local var_23_1

				if var_23_0 == var_3_10001.SKIP_TYPE_SCENE then
					pg = var_23_0
					var_23_1 = var_23_0.m02

					local var_23_2 = var_0.sendNotification

					GAME = var_3_10002
					var_3_10002 = var_3_10002.GO_SCENE

					local var_23_3 = var_22_1[1]
					local var_23_4

					if not var_22_1[2] then
						var_23_4 = {}
					end

					var_23_2(var_23_1, var_3_10002, var_23_3, var_23_4)
				else
					local var_23_5 = var_22_0

					Msgbox4LinkCollectGuide = var_23_1

					if var_23_5 == var_23_1.SKIP_TYPE_ACTIVITY then
						local var_23_6 = arg_21_0
						local var_23_7 = var_0.emit

						ActivityMediator = var_3_10002

						var_23_7(var_23_6, var_3_10002.SELECT_ACTIVITY, var_22_1)
					end
				end

				local var_23_8 = arg_21_0

				var_0.showBoxPanel(var_23_8, false)

				return
			end

			SFX_PANEL = var_2_10012

			var_22_3(var_22_7, var_22_8, var_22_9, var_2_10012)
		end

		return
	end)

	return
end

function var_0_1.showBoxPanel(arg_24_0, arg_24_1)
	arg_24_0.boxOpen = arg_24_1
	setActive = var_1_10002

	var_1_10002(arg_24_0.boxTF, arg_24_1)

	return
end

function var_0_1.IsShowingPopWindow(arg_25_0)
	return arg_25_0.boxOpen == true
end

function var_0_1.ClosePopWindow(arg_26_0)
	if arg_26_0.boxOpen then
		arg_26_0:showBoxPanel(false)
	end

	return
end

function var_0_1.OnDestroy(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_27_0, arg_27_0.boxTF)
	var_0_1.super.OnDestroy(arg_27_0)

	return
end

local function var_0_2(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.SdkMgr.GetInstance()
	local var_28_1 = var_1.GetChannelUIDIncludeHarmony(var_28_0)
	local var_28_2 = arg_28_0._tf
	local var_28_3 = var_2.Find(var_28_2, "AD/bg_1/Role_right/hx_ch" .. var_28_1)
	local var_28_4 = arg_28_0._tf
	local var_28_5 = var_3.Find(var_28_4, "AD/bg_1/Role_left/hx_ch" .. var_28_1)

	return var_28_3, var_28_5
end

function var_0_1.Hx4Channel(arg_29_0)
	local var_29_0, var_29_1 = var_0_2(arg_29_0)

	IsNil = var_1_10003

	if not var_1_10003(var_29_0) then
		setActive = var_3

		local var_29_2 = var_29_0

		HXSet = var_1_10005

		var_3(var_29_2, var_1_10005.isHx())
	end

	IsNil = var_3

	if not var_3(var_29_1) then
		setActive = var_3

		local var_29_3 = var_29_1

		HXSet = var_1_10005

		var_3(var_29_3, var_1_10005.isHx())
	end

	return
end

return var_0_1
