class = var_0_10000

local var_0_0 = "AssignedItemView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "StoreHouseItemAssignedView"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "operate")

	UIItemList = var_2_0
	arg_2_0.ulist = var_2_0.New(var_2_1:Find("got/bottom/list"), var_2_1:Find("got/bottom/list/tpl"))
	arg_2_0.confirmBtn = var_2_1:Find("actions/confirm")
	setText = var_2

	local var_2_2 = arg_2_0.confirmBtn
	local var_2_3 = var_3.Find(var_2_2, "Image")

	i18n = var_2_2

	var_2(var_2_3, var_2_2("text_confirm"))

	arg_2_0.cancelBtn = var_2_1:Find("actions/cancel")
	setText = var_2

	local var_2_4 = arg_2_0.cancelBtn
	local var_2_5 = var_3.Find(var_2_4, "Image")

	i18n = var_2_4

	var_2(var_2_5, var_2_4("text_cancel"))

	arg_2_0.rightArr = var_2_1:Find("calc/value_bg/add")
	arg_2_0.leftArr = var_2_1:Find("calc/value_bg/mius")
	arg_2_0.maxBtn = var_2_1:Find("calc/max")
	arg_2_0.valueText = var_2_1:Find("calc/value_bg/Text")
	arg_2_0.itemTF = var_2_1:Find("item")

	local var_2_6 = arg_2_0.itemTF

	arg_2_0.nameTF = var_2.Find(var_2_6, "display_panel/name_container/name/Text")

	local var_2_7 = arg_2_0.itemTF

	arg_2_0.descTF = var_2.Find(var_2_7, "display_panel/desc/Text")
	onButton = var_2

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_4.Find(var_2_9, "bg")

	local function var_2_11()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_8, var_2_10, var_2_11, var_6)

	onButton = var_2

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.cancelBtn

	local function var_2_14()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_12, var_2_13, var_2_14, var_6)

	pressPersistTrigger = var_2

	local var_2_15 = arg_2_0.rightArr
	local var_2_16 = 0.5

	local function var_2_17(arg_5_0)
		if not arg_2_0.itemVO then
			arg_5_0()

			return
		end

		local var_5_0 = arg_2_0

		math = var_2_10002
		var_5_0.count = var_2_10002.min(arg_2_0.count + 1, arg_2_0.itemVO.count)

		local var_5_1 = arg_2_0

		var_1.updateValue(var_5_1)

		return
	end

	local var_2_18
	local var_2_19 = true
	local var_2_20 = true
	local var_2_21 = 0.1

	SFX_PANEL = var_1_10010

	var_2(var_2_15, var_2_16, var_2_17, var_2_18, var_2_19, var_2_20, var_2_21, var_1_10010)

	pressPersistTrigger = var_2

	local var_2_22 = arg_2_0.leftArr
	local var_2_23 = 0.5

	local function var_2_24(arg_6_0)
		if not arg_2_0.itemVO then
			arg_6_0()

			return
		end

		local var_6_0 = arg_2_0

		math = var_2_10002
		var_6_0.count = var_2_10002.max(arg_2_0.count - 1, 1)

		local var_6_1 = arg_2_0

		var_1.updateValue(var_6_1)

		return
	end

	local var_2_25
	local var_2_26 = true
	local var_2_27 = true
	local var_2_28 = 0.1

	SFX_PANEL = var_1_10010

	var_2(var_2_22, var_2_23, var_2_24, var_2_25, var_2_26, var_2_27, var_2_28, var_1_10010)

	onButton = var_2

	local var_2_29 = arg_2_0
	local var_2_30 = arg_2_0.maxBtn

	local function var_2_31()
		if not arg_2_0.itemVO then
			return
		end

		arg_2_0.count = arg_2_0.itemVO.count

		local var_7_0 = arg_2_0

		var_0.updateValue(var_7_0)

		return
	end

	SFX_PANEL = var_2_25

	var_2(var_2_29, var_2_30, var_2_31, var_2_25)

	onButton = var_2

	local var_2_32 = arg_2_0
	local var_2_33 = arg_2_0.confirmBtn

	local function var_2_34()
		if not arg_2_0.selectedIndex or not arg_2_0.itemVO or arg_2_0.count <= 0 then
			return
		end

		local var_8_0 = {}
		local var_8_1 = arg_2_0.itemVO

		if var_1.IsDoaSelectCharItem(var_8_1) then
			table = var_1

			var_1.insert(var_8_0, function(arg_9_0)
				local var_9_0 = arg_2_0.displayDrops[arg_2_0.selectedIndex].id

				HXSet = var_3_10003

				local var_9_1 = var_3_10003.hxLan

				pg = var_3_10004

				local var_9_2 = var_9_1(var_3_10004.ship_data_statistics[var_9_0].name)

				pg = var_4

				local var_9_3 = var_4.MsgboxMgr.GetInstance()
				local var_9_4 = var_4.ShowMsgBox
				local var_9_5 = {}

				i18n = var_3_10007
				var_9_5.content = var_3_10007("doa_character_select_confirm", var_9_2)
				var_9_5.onYes = arg_9_0

				var_9_4(var_9_3, var_9_5)

				return
			end)
		end

		local var_8_2 = arg_2_0.displayDrops[arg_2_0.selectedIndex].type

		DROP_TYPE_ITEM = var_8_3

		local var_8_3, var_8_4

		if var_8_2 == var_8_3 then
			var_8_3 = arg_2_0.displayDrops[arg_2_0.selectedIndex]
			var_8_4 = var_1.getSubClass(var_8_3)
		else
			var_8_4 = false
		end

		if false then
			var_8_4 = true
		end

		if var_8_4 then
			local var_8_5 = var_8_4

			var_8_3 = var_8_4.getConfig(var_8_5, "type")
			Item = var_8_5

			if var_8_3 == var_8_5.SKIN_ASSIGNED_TYPE and var_8_4:IsAllSkinOwner() then
				table = var_8_3

				var_8_3.insert(var_8_0, function(arg_10_0)
					pg = var_3_10001

					local var_10_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_10_1 = var_1.ShowMsgBox
					local var_10_2 = {}

					i18n = var_3_10004
					var_10_2.content = var_3_10004("blackfriday_pack_select_skinall")
					var_10_2.onYes = arg_10_0

					var_10_1(var_10_0, var_10_2)

					return
				end)
			end
		end

		seriesAsync = var_8_3

		var_8_3(var_8_0, function()
			local var_11_0 = arg_2_0
			local var_11_1 = var_0.emit

			EquipmentMediator = var_3_10002

			local var_11_2 = var_3_10002.ON_USE_ITEM
			local var_11_3 = arg_2_0.itemVO.id
			local var_11_4 = arg_2_0.count
			local var_11_5 = arg_2_0.itemVO

			var_11_1(var_11_0, var_11_2, var_11_3, var_11_4, var_5.getConfig(var_11_5, "usage_arg")[arg_2_0.selectedIndex])

			local var_11_6 = arg_2_0

			var_0.Hide(var_11_6)

			return
		end)

		return
	end

	SFX_PANEL = var_2_25

	var_2(var_2_32, var_2_33, var_2_34, var_2_25)

	return
end

function var_0_1.Show(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_12_0, arg_12_0._tf)

	setActive = var_1

	var_1(arg_12_0._tf, true)

	return
end

function var_0_1.Hide(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)

	setActive = var_1

	var_1(arg_13_0._tf, false)

	return
end

function var_0_1.updateValue(arg_14_0)
	setText = var_1_10001

	var_1_10001(arg_14_0.valueText, arg_14_0.count)

	local var_14_0 = arg_14_0.ulist

	var_1.each(var_14_0, function(arg_15_0, arg_15_1)
		isActive = var_2_10002

		if not var_2_10002(arg_15_1) then
			return
		end

		setText = var_2

		var_2(arg_15_1:Find("item/icon_bg/count"), arg_14_0.count * arg_14_0.displayDrops[arg_15_0 + 1].count)

		local var_15_0 = arg_14_0
		local var_15_1 = var_2.isOverLimit(var_15_0, arg_15_0 + 1, arg_14_0.count)

		setActive = var_15_0

		var_15_0(arg_15_1:Find("block_mask"), var_15_1)

		if var_15_1 and arg_14_0.selectedIndex == arg_15_0 + 1 then
			triggerToggle = var_3

			var_3(arg_15_1, false)
		end

		return
	end)

	return
end

function var_0_1.isOverLimit(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.displayDrops[arg_16_1]

	underscore = var_1_10004

	local var_16_1 = var_1_10004.detect
	local var_16_2 = arg_16_0.itemVO
	local var_16_3

	var_16_3 = var_16_1(var_5.getConfig(var_16_2, "limit"), function(arg_17_0)
		unpack = var_2_10001

		local var_17_0, var_17_1, var_17_2 = var_2_10001(arg_17_0)

		return var_17_0 == var_16_0.type and var_17_1 == var_16_0.id
	end) and var_4[3] or nil

	if not var_16_3 then
		return false
	else
		return var_16_3 < var_16_0:getOwnedCount() + var_16_0.count * arg_16_0.count
	end

	return
end

local function var_0_2(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.ship_data_template[arg_18_0].group_type

	getProxy = var_1_10002
	CollectionProxy = var_1_10003

	local var_18_1 = var_1_10002(var_1_10003)

	return var_2.getShipGroup(var_18_1, var_18_0) ~= nil
end

function var_0_1.update(arg_19_0, arg_19_1)
	arg_19_0.count = 1
	arg_19_0.selectedIndex = nil
	arg_19_0.selectedItem = nil
	arg_19_0.itemVO = arg_19_1
	underscore = var_2
	arg_19_0.displayDrops = var_2.map(arg_19_1:getConfig("display_icon"), function(arg_20_0)
		Drop = var_2_10001

		return var_2_10001.Create(arg_20_0)
	end)

	local var_19_0 = arg_19_1:getConfig("time_limit") == 1
	local var_19_1 = arg_19_0.ulist

	var_3.make(var_19_1, function(arg_21_0, arg_21_1, arg_21_2)
		arg_21_1 = arg_21_1 + 1
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_0 = arg_19_0.displayDrops[arg_21_1]

			updateDrop = var_2_10004

			var_2_10004(arg_21_2:Find("item"), var_21_0)

			onToggle = var_2_10004

			local var_21_1 = arg_19_0
			local var_21_2 = arg_21_2

			local function var_21_3(arg_22_0)
				if arg_22_0 then
					arg_19_0.selectedIndex = arg_21_1
					arg_19_0.selectedItem = arg_21_2
				elseif arg_19_0.selectedIndex == arg_21_1 then
					arg_19_0.selectedIndex = nil
					arg_19_0.selectedItem = nil
				end

				return
			end

			SFX_PANEL = var_2_10008

			var_2_10004(var_21_1, var_21_2, var_21_3, var_2_10008)

			triggerToggle = var_2_10004

			var_2_10004(arg_21_2, false)

			setScrollText = var_2_10004

			var_2_10004(arg_21_2:Find("name_bg/Text"), var_21_0:getConfig("name"))

			local var_21_4

			if var_19_0 then
				var_21_4 = var_21_0.type
				DROP_TYPE_SHIP = var_5
				var_21_4 = var_21_4 == var_5 and var_0_2(var_21_0.id)
			end

			if var_21_4 then
				setText = var_5

				local var_21_5 = arg_21_2
				local var_21_6 = arg_21_2.Find(var_21_5, "item/tip/Text")

				i18n = var_21_5

				var_5(var_21_6, var_21_5("tech_character_get"))
			end

			setActive = var_5

			var_5(arg_21_2:Find("item/tip"), var_21_4)

			onButton = var_5

			local var_21_7 = arg_19_0
			local var_21_8 = arg_21_2:Find("block_mask")

			local function var_21_9()
				pg = var_3_10000

				local var_23_0 = var_3_10000.TipsMgr.GetInstance()
				local var_23_1 = var_0.ShowTips

				i18n = var_3_10002

				var_23_1(var_23_0, var_3_10002("item_assigned_type_limit_error"))

				return
			end

			SFX_CANCEL = var_9

			var_5(var_21_7, var_21_8, var_21_9, var_9)

			if not arg_19_0.selectedItem then
				local var_21_10 = arg_19_0

				if not var_5.isOverLimit(var_21_10, arg_21_1, arg_19_0.count) then
					arg_19_0.selectedItem = arg_21_2
				end
			end
		end

		return
	end)

	local var_19_2 = arg_19_0.ulist

	var_3.align(var_19_2, #arg_19_0.displayDrops)

	if arg_19_0.selectedItem then
		triggerToggle = var_3

		var_3(arg_19_0.selectedItem, true)
	end

	arg_19_0:updateValue()

	Drop = var_3

	local var_19_3 = var_3.New
	local var_19_4 = {}

	DROP_TYPE_ITEM = var_5
	var_19_4.type = var_5
	var_19_4.id = arg_19_1.id
	var_19_4.count = arg_19_1.count

	local var_19_5 = var_19_3(var_19_4)

	updateDrop = var_19_4

	local var_19_6 = arg_19_0.itemTF
	local var_19_7 = var_5.Find(var_19_6, "left/IconTpl")

	setmetatable = var_19_6

	var_19_4(var_19_7, var_19_6({
		count = 0
	}, {
		__index = var_19_5
	}))

	UpdateOwnDisplay = var_19_4

	local var_19_8 = arg_19_0.itemTF

	var_19_4(var_5.Find(var_19_8, "left/own"), var_19_5)

	underscore = var_19_4

	if not var_19_4.any(arg_19_0.displayDrops, function(arg_24_0)
		local var_24_0 = arg_24_0.type

		DROP_TYPE_ITEM = var_2_10002

		if var_24_0 == var_2_10002 then
			local var_24_1 = arg_24_0
			local var_24_2 = arg_24_0.getConfig(var_24_1, "type")

			Item = var_24_1

			local var_24_3

			if var_24_2 ~= var_24_1.SKIN_ASSIGNED_TYPE then
				var_24_3 = false
			else
				var_24_3 = true
			end

			return var_24_3
		end
	end) then
		local var_19_9 = var_19_5.type

		DROP_TYPE_ITEM = var_5

		if var_19_9 == var_5 then
			local var_19_10 = var_19_5

			var_19_9 = var_19_5.getConfig(var_19_10, "type")
			Item = var_19_10

			if var_19_9 == var_19_10.ASSIGNED_TYPE then
				RegisterDetailButton = var_19_9

				local var_19_11 = arg_19_0
				local var_19_12 = arg_19_0.itemTF

				var_19_9(var_19_11, var_6.Find(var_19_12, "left/detail"), var_19_5)

				goto label_19_0
			end
		end

		removeOnButton = var_19_9

		do
			local var_19_13 = arg_19_0.itemTF

			var_19_9(var_5.Find(var_19_13, "left/detail"))
		end

		::label_19_0::

		setText = var_19_9

		var_19_9(arg_19_0.nameTF, arg_19_1:getConfig("name"))

		setText = var_19_9

		var_19_9(arg_19_0.descTF, arg_19_1:getConfig("display"))

		return
	end
end

function var_0_1.OnDestroy(arg_25_0)
	if arg_25_0:isShowing() then
		arg_25_0:Hide()
	end

	return
end

return var_0_1
