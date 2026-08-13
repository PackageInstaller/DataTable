class = var_0_10000

local var_0_0 = "IslandShipAttrUpgradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.getUIName(arg_1_0)
	return "IslandShipAttrUpgradeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_0, "frame/btn_confirm")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "frame/frame_1/close")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "frame/frame_1/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.contentTxt = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf

	arg_2_0.delBtn = var_1.Find(var_2_5, "frame/frame_2/del")

	local var_2_6 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_6, "frame/frame_2/max")

	local var_2_7 = {}
	local var_2_8 = var_0_2
	local var_2_9 = arg_2_0._tf

	var_2_7[var_2_8] = var_3.Find(var_2_9, "frame/toggles/upgrade")

	local var_2_10 = var_0_3
	local var_2_11 = arg_2_0._tf

	var_2_7[var_2_10] = var_3.Find(var_2_11, "frame/toggles/limit")
	arg_2_0.toggles = var_2_7
	UIItemList = var_2_7

	local var_2_12 = var_2_7.New
	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "frame/attr")
	local var_2_15 = arg_2_0._tf

	arg_2_0.uiAttrList = var_2_12(var_2_14, var_4.Find(var_2_15, "frame/attr/tpl"))
	UIItemList = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_3.Find(var_2_17, "frame/frame_2/items")
	local var_2_19 = arg_2_0._tf

	arg_2_0.uiUpgradeList = var_2_16(var_2_18, var_4.Find(var_2_19, "frame/frame_2/items/tpl"))

	local var_2_20 = arg_2_0._tf

	arg_2_0.emptyTr = var_1.Find(var_2_20, "frame/frame_2/empty")
	UIItemList = var_1

	local var_2_21 = var_1.New
	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "frame/frame_3/items")
	local var_2_24 = arg_2_0._tf

	arg_2_0.uiLimitConsumrList = var_2_21(var_2_23, var_4.Find(var_2_24, "frame/frame_3/items/tpl"))
	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_3.Find(var_2_25, "frame/frame_1/title")

	i18n = var_4

	var_1(var_2_26, var_4("island_ship_title1"))

	setText = var_1

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_3.Find(var_2_27, "frame/toggles/upgrade/Text")

	i18n = var_4

	var_1(var_2_28, var_4("island_ship_title2"))

	setText = var_1

	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_3.Find(var_2_29, "frame/toggles/limit/Text")

	i18n = var_4

	var_1(var_2_30, var_4("island_ship_title3"))

	setText = var_1

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_3.Find(var_2_31, "frame/toggles/upgrade/Text_1")

	i18n = var_4

	var_1(var_2_32, var_4("island_ship_title2"))

	setText = var_1

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_3.Find(var_2_33, "frame/toggles/limit/Text_1")

	i18n = var_4

	var_1(var_2_34, var_4("island_ship_title3"))

	setText = var_1

	local var_2_35 = arg_2_0._tf
	local var_2_36 = var_3.Find(var_2_35, "frame/frame_2/sub_title/Text")

	i18n = var_4

	var_1(var_2_36, var_4("island_ship_title4"))

	setText = var_1

	local var_2_37 = arg_2_0._tf
	local var_2_38 = var_3.Find(var_2_37, "frame/frame_3/sub_title/Text")

	i18n = var_4

	var_1(var_2_38, var_4("island_ship_title4"))

	setText = var_1

	local var_2_39 = arg_2_0.upgradeBtn
	local var_2_40 = var_3.Find(var_2_39, "Text")

	i18n = var_4

	var_1(var_2_40, var_4("island_confirm"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "frame/frame_1/title/help")

	local function var_3_3()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		IslandMsgBox = var_2_10004
		var_4_2.type = var_2_10004.TYPE_WHITOUT_BTN
		i18n = var_4
		var_4_2.content = var_4("island_chara_attr_help")

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.closeBtn

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_7, var_3_8, var_3_9, var_3_1)

	onButton = var_1_10001

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.delBtn

	local function var_3_12()
		arg_3_0.selected = {}

		local var_7_0 = arg_3_0

		var_0.FlushAttrs(var_7_0, arg_3_0.slectedAttrName)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_10, var_3_11, var_3_12, var_3_1)

	onButton = var_1_10001

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.maxBtn

	local function var_3_15()
		local var_8_0 = arg_3_0

		var_0.FillSelected(var_8_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_13, var_3_14, var_3_15, var_3_1)

	onButton = var_1_10001

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.upgradeBtn

	local function var_3_18()
		local var_9_0 = arg_3_0

		var_0.Confirm(var_9_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_16, var_3_17, var_3_18, var_3_1)

	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.toggles) do
		onToggle = var_3_1

		local var_3_19 = arg_3_0
		local var_3_20 = iter_3_1

		local function var_3_21(arg_10_0)
			if arg_10_0 then
				local var_10_0 = arg_3_0

				var_1.SwitchPage(var_10_0, iter_3_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_3_1(var_3_19, var_3_20, var_3_21, var_1_10011)
	end

	return
end

function var_0_1.AddListeners(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.AddListener

	GAME = var_1_10004

	var_11_1(var_11_0, var_1_10004.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_11_0.OnAttrUpgrade)

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.AddListener

	GAME = var_4

	var_11_3(var_11_2, var_4.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE, arg_11_0.OnLimitUnlock)

	return
end

function var_0_1.RemoveListeners(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.RemoveListener

	GAME = var_1_10004

	var_12_1(var_12_0, var_1_10004.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_12_0.OnAttrUpgrade)

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.RemoveListener

	GAME = var_4

	var_12_3(var_12_2, var_4.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE, arg_12_0.OnLimitUnlock)

	return
end

function var_0_1.OnAttrUpgrade(arg_13_0)
	arg_13_0.selected = {}

	arg_13_0:SwitchAttr(arg_13_0.slectedAttrName)

	return
end

function var_0_1.OnLimitUnlock(arg_14_0)
	arg_14_0:SwitchPage(arg_14_0.page)

	return
end

function var_0_1.OnShow(arg_15_0, arg_15_1)
	arg_15_0.ship = arg_15_1
	arg_15_0.selected = {}

	arg_15_0:BlurPanel()

	triggerToggle = var_2

	var_2(arg_15_0.toggles[var_0_2], true)

	return
end

function var_0_1.SwitchPage(arg_16_0, arg_16_1)
	arg_16_0.page = arg_16_1

	arg_16_0:UpdateAttrPanel()
	arg_16_0:UpdateContent()

	if arg_16_0.page == var_0_3 then
		arg_16_0:UpdateLimitUpgradeConsume()
	end

	return
end

function var_0_1.UpdateAttrPanel(arg_17_0)
	local var_17_0 = arg_17_0.ship

	arg_17_0.attrTrs = {}

	local var_17_1 = arg_17_0.uiAttrList

	var_2.make(var_17_1, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			IslandShipAttr = var_3

			local var_18_0 = var_3.ATTRS[arg_18_1 + 1]

			arg_17_0.attrTrs[var_18_0] = arg_18_2

			local var_18_1 = var_17_0
			local var_18_2 = var_4.GetAttrGrade(var_18_1, var_18_0)

			IslandShipAttr = var_2_10005

			local var_18_3 = var_2_10005.Grade2Img(var_18_2)
			local var_18_4 = arg_18_2:Find("grade_bg")
			local var_18_5 = var_6.GetComponent

			typeof = var_9
			Image = var_2_10011

			local var_18_6 = var_18_5(var_18_4, var_9(var_2_10011))

			GetSpriteFromAtlas = var_7
			var_18_6.sprite = var_7("ui/IslandShipUI_atlas", var_18_3[2])
			setText = var_18_6

			local var_18_7 = arg_18_2:Find("name")

			IslandShipAttr = var_9

			var_18_6(var_18_7, var_9.ToChinese(var_18_0))

			local var_18_8 = arg_17_0

			var_6.UpdateAtrrValue(var_18_8, var_17_0, var_18_0)
		end

		return
	end)

	local var_17_2 = arg_17_0.uiAttrList
	local var_17_3 = var_2.align

	IslandShipAttr = var_5

	var_17_3(var_17_2, #var_5.ATTRS)

	return
end

function var_0_1.UpdateAtrrValue(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.ship
	local var_19_1 = arg_19_0.attrTrs[arg_19_2]

	if arg_19_0.page == var_0_2 then
		setText = var_5

		var_5(var_19_1:Find("value/value_1"), var_19_0:GetAttr(arg_19_2))

		setText = var_5

		var_5(var_19_1:Find("value/value_2"), "")

		setActive = var_5

		var_5(var_19_1:Find("value/arr"), false)

		onToggle = var_5

		local var_19_2 = arg_19_0
		local var_19_3 = var_19_1

		local function var_19_4(arg_20_0)
			if arg_20_0 then
				local var_20_0 = arg_19_0

				var_1.SwitchAttr(var_20_0, arg_19_2)
			end

			return
		end

		SFX_PANEL = var_10

		var_5(var_19_2, var_19_3, var_19_4, var_10)

		setToggleEnabled = var_5

		var_5(var_19_1, true)

		if arg_19_0.slectedAttrName and arg_19_2 == arg_19_0.slectedAttrName then
			triggerToggle = var_5

			var_5(var_19_1, true)
		elseif not arg_19_0.slectedAttrName then
			IslandShipAttr = var_5

			if arg_19_2 == var_5.ATTRS[1] then
				triggerToggle = var_5

				var_5(var_19_1, true)
			end
		end
	elseif arg_19_0.page == var_0_3 then
		Clone = var_5

		local var_19_5 = var_5(var_19_0)

		var_5.SetUnlockExtraAttLimit(var_19_5)

		setActive = var_6

		var_6(var_19_1:Find("value/arr"), true)

		setText = var_6

		var_6(var_19_1:Find("value/value_1"), var_19_0:GetExtraAttrLimit(arg_19_2))

		setText = var_6

		local var_19_6 = var_19_1:Find("value/value_2")
		local var_19_7 = var_5

		var_6(var_19_6, var_5.GetExtraAttrLimit(var_19_7, arg_19_2))

		setToggleEnabled = var_6

		var_6(var_19_1, false)

		removeOnToggle = var_6

		var_6(var_19_1)

		pairs = var_6

		for iter_19_0, iter_19_1 in var_6(arg_19_0.attrTrs) do
			setActive = var_19_7

			var_19_7(iter_19_1:Find("Image"), false)
		end
	end

	return
end

function var_0_1.UpdateLimitUpgradeConsume(arg_21_0)
	local var_21_0 = arg_21_0.ship
	local var_21_1 = var_1.IsUnlockExtraAttLimit(var_21_0)

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_21_2 = var_1_10003(var_1_10005)
	local var_21_3 = var_3.GetIsland(var_21_2)
	local var_21_4 = var_3.GetInventoryAgency(var_21_3)
	local var_21_5 = false
	local var_21_7

	if var_1:IsUnlockExtraAttLimit() then
		local var_21_6 = arg_21_0.uiLimitConsumrList

		var_21_7.align(var_21_6, 0)
	else
		var_21_7 = var_1:GetExtraAttrLimitUnlockConsume()

		local var_21_8 = arg_21_0.uiLimitConsumrList

		var_6.make(var_21_8, function(arg_22_0, arg_22_1, arg_22_2)
			UIItemList = var_2_10003

			if arg_22_0 == var_2_10003.EventUpdate then
				local var_22_0 = var_21_7[arg_22_1 + 1]

				updateCustomDrop = var_4

				var_4(arg_22_2, var_22_0)

				local var_22_1 = var_21_4
				local var_22_2 = var_4.GetOwnCount(var_22_1, var_22_0.id)

				setColorStr = var_2_10005

				local var_22_3 = var_22_2

				if var_22_0.count <= var_22_2 then
					COLOR_GREEN = var_8

					if not var_8 then
						COLOR_RED = var_8
					end

					local var_22_4 = var_2_10005(var_22_3, var_8)

					setText = var_22_1

					var_22_1(arg_22_2:Find("icon_bg/count_bg/count"), var_22_4 .. "/" .. var_22_0.count)

					return
				end
			end
		end)

		_ = var_6
		var_21_5 = var_6.all(var_21_7, function(arg_23_0)
			local var_23_0 = var_21_4

			return var_1.GetOwnCount(var_23_0, arg_23_0.id) >= arg_23_0.count
		end)

		local var_21_9 = arg_21_0.uiLimitConsumrList

		var_6.align(var_21_9, #var_21_7)
	end

	setGray = var_21_7

	var_21_7(arg_21_0.upgradeBtn, var_21_1 or not var_21_5)

	return
end

function var_0_1.SwitchAttr(arg_24_0, arg_24_1)
	arg_24_0.selected = {}

	local var_24_0 = arg_24_0.ship

	arg_24_0:ClearUpdateAttrValue(arg_24_0.slectedAttrName)

	arg_24_0.slectedAttrName = arg_24_1

	if arg_24_0:CanAddItemForAttrValue(arg_24_1) then
		arg_24_0:FlushAttrs(arg_24_1)
	else
		local var_24_1 = arg_24_0.uiUpgradeList

		var_4.align(var_24_1, 0)
	end

	arg_24_0:UpdateAttrValue()

	setActive = var_4

	var_4(arg_24_0.emptyTr, not var_3)

	setActive = var_4

	var_4(arg_24_0.delBtn, var_3)

	setActive = var_4

	var_4(arg_24_0.maxBtn, var_3)

	return
end

function var_0_1.FlushAttrs(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.ship
	local var_25_1 = var_2.GetUpgradeExtraAttrConsume(var_25_0, arg_25_1)
	local var_25_2 = arg_25_0.uiUpgradeList

	var_4.make(var_25_2, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate then
			local var_26_0 = var_25_1[arg_26_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_26_2, var_26_0)

			getProxy = var_4
			IslandProxy = var_6

			local var_26_1 = var_4(var_6)
			local var_26_2 = var_4.GetIsland(var_26_1)
			local var_26_3 = var_4.GetInventoryAgency(var_26_2)
			local var_26_4 = var_4.GetOwnCount(var_26_3, var_26_0.id)

			setText = var_26_2

			var_26_2(arg_26_2:Find("icon_bg/count_bg/count"), "X" .. var_26_4)

			onButton = var_26_2

			local var_26_5 = arg_25_0
			local var_26_6 = arg_26_2

			local function var_26_7()
				local var_27_0 = arg_25_0

				if not var_0.CanAddItemForAttrValue(var_27_0, arg_25_1, arg_25_0.selected) then
					return
				end

				local var_27_1 = arg_25_0

				var_0.OpenAtrrCalcPanel(var_27_1, arg_26_2, var_26_0)

				return
			end

			SFX_PANEL = var_11

			var_26_2(var_26_5, var_26_6, var_26_7, var_11)

			onButton = var_26_2

			local var_26_8 = arg_25_0
			local var_26_9 = arg_26_2
			local var_26_10 = arg_26_2.Find(var_26_9, "calc/bg")

			local function var_26_11()
				local var_28_0 = arg_25_0.selected
				local var_28_1 = var_26_0.id
				local var_28_2

				if not arg_25_0.selected[var_26_0.id] then
					var_28_2 = 0
				end

				var_28_0[var_28_1] = var_28_2 - 1

				local var_28_3 = arg_25_0

				var_0.UpdateAttrCalcPanel(var_28_3, arg_26_2, var_26_0)

				return
			end

			SFX_PANEL = var_26_9

			var_26_2(var_26_8, var_26_10, var_26_11, var_26_9)

			local var_26_12 = arg_25_0

			var_6.UpdateAttrCalcPanel(var_26_12, arg_26_2, var_26_0)
		end

		return
	end)

	local var_25_3 = arg_25_0.uiUpgradeList

	var_4.align(var_25_3, #var_25_1)

	return
end

function var_0_1.ClearUpdateAttrValue(arg_29_0, arg_29_1)
	if not arg_29_1 or arg_29_1 == "" then
		return
	end

	local var_29_0 = arg_29_0.ship
	local var_29_1 = arg_29_0.attrTrs[arg_29_1]

	setText = var_1_10004

	var_1_10004(var_29_1:Find("value/value_1"), var_29_0:GetAttr(arg_29_1))

	return
end

function var_0_1.OpenAtrrCalcPanel(arg_30_0, arg_30_1, arg_30_2)
	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_30_0 = var_1_10003(var_1_10005)
	local var_30_1 = var_3.GetIsland(var_30_0)
	local var_30_2 = var_3.GetInventoryAgency(var_30_1)
	local var_30_3 = var_3.GetOwnCount(var_30_2, arg_30_2.id)
	local var_30_4

	if not arg_30_0.selected[arg_30_2.id] then
		var_30_4 = 0
	end

	if var_30_3 <= var_30_4 then
		return
	end

	local var_30_5 = arg_30_0.selected
	local var_30_6 = arg_30_2.id
	local var_30_7

	if not arg_30_0.selected[arg_30_2.id] then
		var_30_7 = 0
	end

	var_30_5[var_30_6] = var_30_7 + 1

	arg_30_0:UpdateAttrCalcPanel(arg_30_1, arg_30_2)

	return
end

function var_0_1.UpdateAttrCalcPanel(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0

	if not arg_31_0.selected[arg_31_2.id] then
		var_31_0 = 0
	end

	setText = var_4

	var_4(arg_31_1:Find("calc/Text"), var_31_0)

	setActive = var_4

	var_4(arg_31_1:Find("calc"), var_31_0 > 0)
	arg_31_0:UpdateAttrValue()

	return
end

function var_0_1.UpdateAttrValue(arg_32_0)
	local var_32_0 = arg_32_0.slectedAttrName
	local var_32_1 = arg_32_0.attrTrs[var_32_0]
	local var_32_2 = arg_32_0.ship
	local var_32_3, var_32_4, var_32_5 = arg_32_0:CanAddItemForAttrValue(var_32_0, arg_32_0.selected)
	local var_32_6

	if var_32_5 <= var_32_4 then
		var_32_6 = "(MAX)"
	else
		string = var_32_6
		var_32_6 = var_32_6.format("(<color=#36a5fb>+%s</color>/%s)", var_32_4, var_32_5)
	end

	setText = var_8

	var_8(var_32_1:Find("value/value_1"), var_32_2:GetAttr(var_32_0) .. var_32_6)

	local var_32_7

	if arg_32_0:NothingSelected() then
		var_32_7 = not var_32_3
	end

	setGray = var_1_10009

	var_1_10009(arg_32_0.upgradeBtn, var_32_7 or arg_32_0:NothingSelected())

	return
end

function var_0_1.CanAddItemForAttrValue(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.ship
	local var_33_1 = var_3.GetExtraAttrValue(var_33_0, arg_33_1)

	pairs = var_1_10005

	for iter_33_0, iter_33_1 in var_1_10005(arg_33_2 or {}) do
		IslandItem = var_1_10010
		var_1_10010 = var_1_10010.New({
			id = iter_33_0
		})
		tonumber = var_1_10011
		var_33_1 = var_33_1 + var_1_10011(var_1_10010:GetUseArg()) * iter_33_1
	end

	return var_33_1 < var_3:GetExtraAttrLimit(arg_33_1), var_33_1, var_5
end

function var_0_1.FillSelected(arg_34_0)
	arg_34_0.selected = {}

	local var_34_0 = arg_34_0.ship
	local var_34_1 = var_1.GetUpgradeExtraAttrConsume(var_34_0, arg_34_0.slectedAttrName)

	getProxy = var_1_10003
	IslandProxy = var_5

	local var_34_2 = var_1_10003(var_5)
	local var_34_3 = var_3.GetIsland(var_34_2)
	local var_34_4 = var_3.GetInventoryAgency(var_34_3)

	_ = var_34_0

	local var_34_5 = var_34_0.map(var_34_1, function(arg_35_0)
		local var_35_0 = var_34_4
		local var_35_1

		if not var_1.GetItemById(var_35_0, arg_35_0.id) then
			IslandItem = var_35_1
			var_35_1 = var_35_1.New({
				number = 0,
				id = arg_35_0.id
			})
		end

		return var_35_1
	end)

	table = var_34_3

	var_34_3.sort(var_34_5, function(arg_36_0, arg_36_1)
		return arg_36_0:GetRarity() > arg_36_1:GetRarity()
	end)

	local var_34_6 = {}

	ipairs = var_6

	for iter_34_0, iter_34_1 in var_6(var_34_5) do
		for iter_34_2 = 1, iter_34_1.count do
			if arg_34_0:CanAddItemForAttrValue(arg_34_0.slectedAttrName, var_34_6) then
				local var_34_7 = iter_34_1.id
				local var_34_8

				if not var_34_6[iter_34_1.id] then
					var_34_8 = 0
				end

				var_34_6[var_34_7] = var_34_8 + 1
			else
				break
			end
		end
	end

	arg_34_0.selected = var_34_6

	arg_34_0:FlushAttrs(arg_34_0.slectedAttrName)

	return
end

function var_0_1.UpdateContent(arg_37_0)
	if arg_37_0.page == var_0_2 then
		local var_37_0 = arg_37_0.contentTxt

		i18n = var_2
		var_37_0.text = var_2("island_ship_lock_attr_tip")
	elseif arg_37_0.page == var_0_3 then
		local var_37_1 = arg_37_0.contentTxt

		i18n = var_2
		var_37_1.text = var_2("island_ship_unlock_limit_tip")
	end

	return
end

function var_0_1.Confirm(arg_38_0)
	if arg_38_0.page == var_0_2 then
		if not arg_38_0.slectedAttrName or not arg_38_0.ship then
			return
		end

		if arg_38_0:NothingSelected() then
			return
		end

		local var_38_0 = arg_38_0

		if not arg_38_0.CanAddItemForAttrValue(var_38_0, arg_38_0.slectedAttrName) then
			return
		end

		table = var_1

		local var_38_1 = var_1.indexof

		IslandShipAttr = var_38_0

		if var_38_1(var_38_0.ATTRS, arg_38_0.slectedAttrName) <= 0 then
			return
		end

		var_1_10004 = arg_38_0

		local var_38_2 = arg_38_0.emit

		IslandMediator = var_1_10005

		var_38_2(var_1_10004, var_1_10005.SHIP_ATTR_UPGRADE, arg_38_0.ship.id, var_1, arg_38_0.selected)
	elseif arg_38_0.page == var_0_3 then
		local var_38_3 = arg_38_0.ship

		if var_1.IsUnlockExtraAttLimit(var_38_3) then
			return
		end

		local var_38_4 = arg_38_0
		local var_38_5 = arg_38_0.emit

		IslandMediator = var_1_10004

		var_38_5(var_38_4, var_1_10004.SHIP_ATTR_LIMIT_UNLOCK, arg_38_0.ship.id)
	end

	return
end

function var_0_1.NothingSelected(arg_39_0)
	pairs = var_1_10001

	for iter_39_0, iter_39_1 in var_1_10001(arg_39_0.selected) do
		if iter_39_1 > 0 then
			return false
		end
	end

	return true
end

function var_0_1.OnHide(arg_40_0)
	arg_40_0:UnBlurPanel()

	return
end

function var_0_1.OnDestroy(arg_41_0)
	arg_41_0:OnHide()

	return
end

return var_0_1
