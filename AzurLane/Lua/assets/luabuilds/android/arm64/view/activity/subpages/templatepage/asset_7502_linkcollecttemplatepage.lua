class = var_0_10000

local var_0_0 = "LinkCollectTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))
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

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001
	arg_2_0.guideConfig = var_1_10001.activity_limit_item_guide

	arg_2_0:BuildDatas()

	return
end

function var_0_1.BuildDatas(arg_3_0)
	pg = var_1_10001

	local var_3_0

	if not var_1_10001.activity_limit_item_guide.get_id_list_by_activity[arg_3_0.activity.id] then
		var_3_0 = {}
	end

	arg_3_0.dataList = {}
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(var_3_0) do
		local var_3_1 = {
			id = iter_3_1
		}

		var_3_1.config = arg_3_0.guideConfig[var_3_1.id]

		local var_3_2 = arg_3_0.activity

		var_3_1.count = var_8.getKVPList(var_3_2, 1, var_3_1.id)

		if var_3_1.config.count_storage == 1 then
			Drop = var_8

			local var_3_3 = var_8.New({
				type = var_3_1.config.type,
				id = var_3_1.config.drop_id
			})

			var_3_1.count = var_8.getOwnedCount(var_3_3)
		end

		table = var_8

		var_8.insert(arg_3_0.dataList, var_3_1)
	end

	return
end

function var_0_1.GetTogglesDropTypes(arg_4_0)
	local var_4_0 = {}

	DROP_TYPE_EQUIP = var_1_10002
	var_4_0[1] = var_1_10002
	DROP_TYPE_FURNITURE = var_1_10002
	var_4_0[2] = var_1_10002
	DROP_TYPE_EQUIPMENT_SKIN = var_1_10002
	var_4_0[3] = var_1_10002
	DROP_TYPE_SPWEAPON = var_1_10002
	var_4_0[4] = var_1_10002

	return var_4_0
end

function var_0_1.OnFirstFlush(arg_5_0)
	local var_5_0 = arg_5_0.itemList

	var_1.make(var_5_0, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_5_0

			var_3.OnUpdateItem(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)
	arg_5_0:AddTogglesListener()
	arg_5_0:AddSpecialBtnListener()

	local var_5_1

	if not arg_5_0.curPage then
		var_5_1 = arg_5_0:GetTogglesDropTypes()[1]
	end

	arg_5_0.curPage = var_5_1
	triggerToggle = var_5_1

	var_5_1(arg_5_0.toggles[arg_5_0.curPage], true)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	arg_7_0:BuildDatas()
	arg_7_0:UpdatePage(arg_7_0.curPage)

	return
end

function var_0_1.AddTogglesListener(arg_8_0)
	arg_8_0.toggles = {}

	local var_8_0 = arg_8_0:GetTogglesDropTypes()

	assert = var_1_10002

	var_1_10002(#var_8_0 == arg_8_0.togglesTF.childCount, "dropType数量与togglesTF子节点数不匹配")

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(var_8_0) do
		local var_8_1 = arg_8_0.togglesTF
		local var_8_2 = var_7.Find(var_8_1, var_0_1.DropType2Name[iter_8_1])

		onToggle = var_1_10008

		local var_8_3 = arg_8_0
		local var_8_4 = var_8_2

		local function var_8_5(arg_9_0)
			if arg_9_0 then
				local var_9_0 = arg_8_0

				var_1.UpdatePage(var_9_0, iter_8_1)
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_1_10008(var_8_3, var_8_4, var_8_5, var_1_10013)

		var_1_10008 = arg_8_0.toggles
		var_1_10008[iter_8_1] = var_8_2
	end

	return
end

function var_0_1.AddSpecialBtnListener(arg_10_0)
	local var_10_0 = arg_10_0.activity
	local var_10_1 = var_1.getConfig(var_10_0, "config_client")
	local var_10_2 = arg_10_0.btnList

	arg_10_0.furnitureThemeBtn = var_2.Find(var_10_2, "furniture_theme")

	if arg_10_0.furnitureThemeBtn and var_10_1.furniture_theme_link then
		onButton = var_2

		local var_10_3 = arg_10_0
		local var_10_4 = arg_10_0.furnitureThemeBtn

		local function var_10_5()
			local var_11_0 = arg_10_0

			var_0.DoSkip(var_11_0, var_10_1.furniture_theme_link[1], var_10_1.furniture_theme_link[2])

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_10_3, var_10_4, var_10_5, var_1_10007)
	end

	local var_10_6 = arg_10_0.btnList

	arg_10_0.medalBtn = var_2.Find(var_10_6, "medal")

	if arg_10_0.medalBtn and var_10_1.medal_link then
		onButton = var_2

		local var_10_7 = arg_10_0
		local var_10_8 = arg_10_0.medalBtn

		local function var_10_9()
			local var_12_0 = arg_10_0

			var_0.DoSkip(var_12_0, var_10_1.medal_link[1], var_10_1.medal_link[2])

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_10_7, var_10_8, var_10_9, var_1_10007)
	end

	local var_10_10 = arg_10_0.btnList

	arg_10_0.equipSkinBoxBtn = var_2.Find(var_10_10, "equip_skin_box")

	if arg_10_0.equipSkinBoxBtn and var_10_1.equipskin_box_link then
		Drop = var_2

		local var_10_11 = var_2.New({
			type = var_10_1.equipskin_box_link.drop_type,
			id = var_10_1.equipskin_box_link.drop_id
		})
		local var_10_12 = var_2.getOwnedCount(var_10_11)

		onButton = var_10_0

		local var_10_13 = arg_10_0
		local var_10_14 = arg_10_0.equipSkinBoxBtn

		local function var_10_15()
			pg = var_2_10000

			local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_13_1 = var_0.ShowMsgBox
			local var_13_2 = {}

			MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10004
			var_13_2.type = var_2_10004
			Msgbox4LinkCollectGuide = var_2_10004
			var_13_2.show_type = var_2_10004.SHOW_TYPE_NORMAL
			var_13_2.drop_type = var_10_1.equipskin_box_link.drop_type
			var_13_2.drop_id = var_10_1.equipskin_box_link.drop_id
			var_13_2.count = var_10_12
			var_13_2.skipable_list = var_10_1.equipskin_box_link.list

			var_13_1(var_13_0, var_13_2)

			return
		end

		SFX_PANEL = var_1_10008

		var_10_0(var_10_13, var_10_14, var_10_15, var_1_10008)
	end

	return
end

function var_0_1.OnUpdateItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.showDataList[arg_14_1 + 1]
	local var_14_1 = arg_14_2:Find("icon_mask/icon")
	local var_14_2 = {
		type = var_14_0.config.type,
		id = var_14_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_14_1, var_14_2)

	onButton = var_6

	local var_14_3 = arg_14_0
	local var_14_4 = var_14_1

	local function var_14_5()
		local var_15_0 = arg_14_0

		var_0.OnClickItem(var_15_0, var_14_0)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_14_3, var_14_4, var_14_5, var_1_10011)

	changeToScrollText = var_6

	local var_14_6 = arg_14_2:Find("name_mask/name")

	Drop = var_14_4

	local var_14_7 = var_14_4.New({
		type = var_14_0.config.type,
		id = var_14_0.config.drop_id
	})

	var_6(var_14_6, var_9.getName(var_14_7))

	setText = var_6

	var_6(arg_14_2:Find("owner/number"), var_14_0.count .. "/" .. var_14_0.config.count)

	GetOrAddComponent = var_6

	local var_14_8 = arg_14_2:Find("owner")

	typeof = var_9
	CanvasGroup = var_11
	var_6(var_14_8, var_9(var_11)).alpha = var_14_0.count == var_14_0.config.count and 0.5 or 1
	setActive = var_7

	var_7(arg_14_2:Find("got"), var_14_0.count == var_14_0.config.count)

	setActive = var_7

	var_7(arg_14_2:Find("new"), var_14_0.config.is_new == "1")

	return
end

function var_0_1.OnClickItem(arg_16_0, arg_16_1)
	pg = var_1_10002

	local var_16_0 = var_1_10002.MsgboxMgr.GetInstance()
	local var_16_1 = var_2.ShowMsgBox
	local var_16_2 = {}

	MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_1_10006
	var_16_2.type = var_1_10006
	Msgbox4LinkCollectGuide = var_1_10006
	var_16_2.show_type = var_1_10006.SHOW_TYPE_LIMIT
	var_16_2.drop_type = arg_16_1.config.type
	var_16_2.drop_id = arg_16_1.config.drop_id
	var_16_2.count = arg_16_1.count
	var_16_2.count_limit = arg_16_1.config.count
	var_16_2.skipable_list = arg_16_1.config.link_params

	var_16_1(var_16_0, var_16_2)

	return
end

function var_0_1.UpdatePage(arg_17_0, arg_17_1)
	arg_17_0.curPage = arg_17_1
	arg_17_0.showDataList = {}
	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_0.dataList) do
		if arg_17_0.guideConfig[iter_17_1.id].type == arg_17_1 then
			table = var_7

			var_7.insert(arg_17_0.showDataList, iter_17_1)
		end
	end

	table = var_2

	local var_17_0 = var_2.sort
	local var_17_1 = arg_17_0.showDataList

	CompareFuncs = iter_17_0

	var_17_0(var_17_1, iter_17_0({
		function(arg_18_0)
			return arg_18_0.count < arg_18_0.config.count and 0 or 1
		end,
		function(arg_19_0)
			return arg_19_0.config.order
		end,
		function(arg_20_0)
			return arg_20_0.id
		end
	}))

	local var_17_2 = arg_17_0.itemList

	var_2.align(var_17_2, #arg_17_0.showDataList)

	return
end

function var_0_1.DoSkip(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 2 then
		pg = var_1_10003

		local var_21_0 = var_1_10003.m02

		var_1_10003 = var_1_10003.sendNotification
		GAME = var_1_10006
		var_1_10006 = var_1_10006.GO_SCENE
		var_1_10007 = arg_21_2[1]

		local var_21_1

		if not arg_21_2[2] then
			var_21_1 = {}
		end

		var_1_10003(var_21_0, var_1_10006, var_1_10007, var_21_1)
	elseif arg_21_1 == 3 then
		pg = var_1_10003

		local var_21_2 = var_1_10003.m02
		local var_21_3 = var_3.sendNotification

		GAME = var_1_10006

		local var_21_4 = var_1_10006.GO_SCENE

		SCENE = var_1_10007

		var_21_3(var_21_2, var_21_4, var_1_10007.ACTIVITY, {
			id = arg_21_2
		})
	end

	return
end

return var_0_1
