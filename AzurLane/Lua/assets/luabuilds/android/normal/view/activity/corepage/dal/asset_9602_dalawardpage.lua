class = var_0_10000

local var_0_0 = "DALAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.BRS.HeiYanAwardPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.furmiturebtn = var_1.Find(var_1_1, "btn/furmiturebtn")

	local var_1_2 = arg_1_0.AD

	arg_1_0.commemoratebtn = var_1.Find(var_1_2, "btn/commemoratebtn")

	local var_1_3 = arg_1_0.AD

	arg_1_0.equipmentbtn = var_1.Find(var_1_3, "btn/equipmentbtn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	arg_2_0:InitData()

	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client")

	onButton = var_2_0

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.furmiturebtn

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.DoSkip(var_3_0, var_2_1.furniture_theme_link[1], var_2_1.furniture_theme_link[2])

		return
	end

	SFX_PANEL = var_1_10006

	var_2_0(var_2_2, var_2_3, var_2_4, var_1_10006)

	onButton = var_2_0

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.commemoratebtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.DoSkip(var_4_0, var_2_1.medal_link[1], var_2_1.medal_link[2])

		return
	end

	SFX_PANEL = var_1_10006

	var_2_0(var_2_5, var_2_6, var_2_7, var_1_10006)

	onButton = var_2_0

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.equipmentbtn

	local function var_2_10()
		Drop = var_2_10000

		local var_5_0 = var_2_10000.New({
			type = var_2_1.equipskin_box_link.drop_type,
			id = var_2_1.equipskin_box_link.drop_id
		})
		local var_5_1 = var_0.getOwnedCount(var_5_0)

		pg = var_5_0

		local var_5_2 = var_5_0.MsgboxMgr.GetInstance()
		local var_5_3 = var_1.ShowMsgBox
		local var_5_4 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10004
		var_5_4.type = var_2_10004
		Msgbox4LinkCollectGuide = var_2_10004
		var_5_4.show_type = var_2_10004.SHOW_TYPE_NORMAL
		var_5_4.drop_type = var_2_1.equipskin_box_link.drop_type
		var_5_4.drop_id = var_2_1.equipskin_box_link.drop_id
		var_5_4.count = var_5_1
		var_5_4.skipable_list = var_2_1.equipskin_box_link.list

		var_5_3(var_5_2, var_5_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_2_0(var_2_8, var_2_9, var_2_10, var_1_10006)

	return
end

function var_0_1.InitData(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.table_Top) do
		onToggle = var_1_10006

		local var_6_0 = arg_6_0
		local var_6_1 = iter_6_1

		local function var_6_2(arg_7_0)
			if arg_7_0 then
				local var_7_0 = arg_6_0

				var_7_0.pageIndex = iter_6_0
				SetActive = var_7_0

				var_7_0(arg_6_0.bg_1, false)

				SetActive = var_7_0

				var_7_0(arg_6_0.bg_2, true)

				local var_7_1 = arg_6_0

				var_1.DataList(var_7_1, iter_6_0 + 1)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_6_0, var_6_1, var_6_2, var_1_10010)
	end

	return
end

function var_0_1.DataList(arg_8_0, arg_8_1)
	arg_8_0.showDataList = {}
	ipairs = var_2

	for iter_8_0, iter_8_1 in var_2(arg_8_0.dataList) do
		if arg_8_0.guideConfig[iter_8_1.id].type == 3 and arg_8_1 == 2 then
			table = var_7

			var_7.insert(arg_8_0.showDataList, iter_8_1)
		elseif arg_8_0.guideConfig[iter_8_1.id].type == 21 and arg_8_1 == 3 then
			table = var_7

			var_7.insert(arg_8_0.showDataList, iter_8_1)
		end
	end

	table = var_2

	local var_8_0 = var_2.sort
	local var_8_1 = arg_8_0.showDataList

	CompareFuncs = var_4

	var_8_0(var_8_1, var_4({
		function(arg_9_0)
			return arg_9_0.config.order
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))
	arg_8_0:ShowCharaPage()

	return
end

function var_0_1.OnAnimation(arg_11_0, arg_11_1)
	return
end

function var_0_1.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.showDataList[arg_12_1 + 1]
	local var_12_1 = arg_12_2:Find("icon_mask/icon")
	local var_12_2 = {
		type = var_12_0.config.type,
		id = var_12_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_12_1, var_12_2)

	onButton = var_6

	local var_12_3 = arg_12_0
	local var_12_4 = var_12_1

	local function var_12_5()
		local var_13_0 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10001
		var_13_0.type = var_2_10001
		Msgbox4LinkCollectGuide = var_2_10001
		var_13_0.show_type = var_2_10001.SHOW_TYPE_LIMIT
		var_13_0.drop_type = var_12_0.config.type
		var_13_0.drop_id = var_12_0.config.drop_id
		var_13_0.count = var_12_0.count
		var_13_0.count_limit = var_12_0.config.count
		var_13_0.skipable_list = var_12_0.config.link_params

		local var_13_1 = arg_12_0

		var_1.selectBoxbg(var_13_1, var_13_0)

		local var_13_2 = arg_12_0

		var_1.updateBoxPanel(var_13_2, var_13_0)

		local var_13_3 = arg_12_0

		var_1.showBoxPanel(var_13_3, true)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_12_3, var_12_4, var_12_5, var_1_10010)

	changeToScrollText = var_6

	local var_12_6 = arg_12_2
	local var_12_7 = arg_12_2.Find(var_12_6, "name_mask/name")

	Drop = var_12_6

	local var_12_8 = var_12_6.New({
		type = var_12_0.config.type,
		id = var_12_0.config.drop_id
	})

	var_6(var_12_7, var_8.getName(var_12_8))

	setText = var_6

	var_6(arg_12_2:Find("owner/number"), var_12_0.count .. "/" .. var_12_0.config.count)

	GetOrAddComponent = var_6

	local var_12_9 = arg_12_2
	local var_12_10 = arg_12_2.Find(var_12_9, "owner")

	typeof = var_12_9
	CanvasGroup = var_9
	var_6(var_12_10, var_12_9(var_9)).alpha = var_12_0.count == var_12_0.config.count and 0.5 or 1
	setActive = var_7

	var_7(arg_12_2:Find("got"), var_12_0.count == var_12_0.config.count)

	return
end

function var_0_1.UpdateView(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.table_Top do
		if iter_14_0 == 1 then
			setText = var_1_10005

			local var_14_0 = arg_14_0.table_Top[iter_14_0]
			local var_14_1 = var_6.Find(var_14_0, "type_image/name")

			i18n = var_14_0

			var_1_10005(var_14_1, var_14_0("yumia_award_1"))

			setText = var_1_10005

			local var_14_2 = arg_14_0.table_Top[iter_14_0]
			local var_14_3 = var_6.Find(var_14_2, "on/name")

			i18n = var_14_2

			var_1_10005(var_14_3, var_14_2("yumia_award_1"))

			setText = var_1_10005

			local var_14_4 = arg_14_0.table_Top[iter_14_0]
			local var_14_5 = var_6.Find(var_14_4, "on/name2")

			i18n = var_14_4

			var_1_10005(var_14_5, var_14_4("dal_AwardPage_name_1"))
		elseif iter_14_0 == 2 then
			setText = var_1_10005

			local var_14_6 = arg_14_0.table_Top[iter_14_0]
			local var_14_7 = var_6.Find(var_14_6, "type_image/name")

			i18n = var_14_6

			var_1_10005(var_14_7, var_14_6("yumia_award_4"))

			setText = var_1_10005

			local var_14_8 = arg_14_0.table_Top[iter_14_0]
			local var_14_9 = var_6.Find(var_14_8, "on/name")

			i18n = var_14_8

			var_1_10005(var_14_9, var_14_8("yumia_award_4"))

			setText = var_1_10005

			local var_14_10 = arg_14_0.table_Top[iter_14_0]
			local var_14_11 = var_6.Find(var_14_10, "on/name2")

			i18n = var_14_10

			var_1_10005(var_14_11, var_14_10("dal_AwardPage_name_2"))
		end
	end

	triggerToggle = var_1

	local var_14_12 = arg_14_0.table_Top
	local var_14_13

	if not arg_14_0.pageIndex then
		var_14_13 = 1
	end

	var_1(var_14_12[var_14_13], true)

	return
end

function var_0_1.selectBoxbg(arg_15_0, arg_15_1)
	table = var_1_10002

	if var_1_10002.getCount(arg_15_1.skipable_list) > 1 then
		setImageSprite = var_2

		local var_15_0 = arg_15_0.boxTF
		local var_15_1 = var_3.Find(var_15_0, "Panel/BG")

		LoadSprite = var_15_0

		var_2(var_15_1, var_15_0("ui/DALAwardPage_atlas", "box_bg2"), true)
	else
		table = var_2

		if var_2.getCount(arg_15_1.skipable_list) == 1 then
			setImageSprite = var_2

			local var_15_2 = arg_15_0.boxTF
			local var_15_3 = var_3.Find(var_15_2, "Panel/BG")

			LoadSprite = var_15_2

			var_2(var_15_3, var_15_2("ui/DALAwardPage_atlas", "box_bg1"), true)
		end
	end

	return
end

function var_0_1.RefreshCountText(arg_16_0, arg_16_1, arg_16_2)
	setText = var_1_10003

	var_1_10003(arg_16_2:Find("owner/number"), arg_16_1.count .. "/" .. arg_16_1.config.count)

	return
end

function var_0_1.showBoxPanel(arg_17_0, arg_17_1)
	setActive = var_1_10002

	var_1_10002(arg_17_0.boxTF, arg_17_1)

	if arg_17_1 == true then
		pg = var_1_10002

		local var_17_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_17_0, arg_17_0.boxTF)
	else
		pg = var_1_10002

		local var_17_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_17_1, arg_17_0.boxTF, arg_17_0._tf)
	end

	return
end

function var_0_1.DoSkip(arg_18_0, arg_18_1, arg_18_2)
	Msgbox4LinkCollectGuide = var_1_10003

	local var_18_1

	if arg_18_1 == var_1_10003.SKIP_TYPE_SCENE then
		pg = var_18_1

		local var_18_0 = var_18_1.m02

		var_18_1 = var_18_1.sendNotification
		GAME = var_1_10005
		var_1_10005 = var_1_10005.GO_SCENE
		var_1_10006 = arg_18_2[1]

		local var_18_2

		if not arg_18_2[2] then
			var_18_2 = {}
		end

		var_18_1(var_18_0, var_1_10005, var_1_10006, var_18_2)
	else
		Msgbox4LinkCollectGuide = var_18_1

		if arg_18_1 == var_18_1.SKIP_TYPE_ACTIVITY then
			pg = var_3

			local var_18_3 = var_3.m02
			local var_18_4 = var_3.sendNotification

			GAME = var_1_10005

			local var_18_5 = var_1_10005.GO_SCENE

			SCENE = var_1_10006

			var_18_4(var_18_3, var_18_5, var_1_10006.ACTIVITY, {
				id = arg_18_2
			})
		end
	end

	return
end

function var_0_1.OnDestroy(arg_19_0)
	arg_19_0:showBoxPanel(false)

	return
end

return var_0_1
