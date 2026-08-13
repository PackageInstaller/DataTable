class = var_0_10000

local var_0_0 = "SpWeaponModifyLayer"

BaseUI = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "SpWeaponModifyUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.equipmentPanel = var_1.Find(var_2_0, "Main/panel/equipment_panel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.materialPanel = var_1.Find(var_2_1, "Main/panel/material_panel")

	local var_2_2 = arg_2_0.equipmentPanel

	arg_2_0.equipmentIcon = var_1.Find(var_2_2, "Icon")

	local var_2_3 = arg_2_0.equipmentPanel

	arg_2_0.equipmentName = var_1.Find(var_2_3, "Name")

	local var_2_4 = arg_2_0.equipmentPanel

	arg_2_0.attributeList = var_1.Find(var_2_4, "Attribute/Rect/Attrs")

	local var_2_5 = arg_2_0.equipmentPanel

	arg_2_0.attributeButtons = var_1.Find(var_2_5, "Attribute/Rect/Buttons")

	local var_2_6 = arg_2_0.attributeButtons

	arg_2_0.attributeExchangeButton = var_1.Find(var_2_6, "Exchange")

	local var_2_7 = arg_2_0.attributeButtons

	arg_2_0.attributeDiscardButton = var_1.Find(var_2_7, "Discard")
	setText = var_1

	local var_2_8 = arg_2_0.equipmentPanel
	local var_2_9 = var_3.Find(var_2_8, "Attribute/Text")

	i18n = var_4

	var_1(var_2_9, var_4("spweapon_ui_transform_attr_text"))

	setText = var_1

	local var_2_10 = arg_2_0.attributeExchangeButton
	local var_2_11 = var_3.Find(var_2_10, "Text")

	i18n = var_4

	var_1(var_2_11, var_4("spweapon_ui_change_attr"))

	setText = var_1

	local var_2_12 = arg_2_0.attributeDiscardButton
	local var_2_13 = var_3.Find(var_2_12, "Text")

	i18n = var_4

	var_1(var_2_13, var_4("spweapon_ui_keep_attr"))

	CustomIndexLayer = var_1

	local var_2_14 = var_1.Clone2Full
	local var_2_15 = arg_2_0.materialPanel

	arg_2_0.materialItems = var_2_14(var_3.Find(var_2_15, "materials/materials"), 3)

	local var_2_16 = arg_2_0.materialPanel

	arg_2_0.materialLimit = var_1.Find(var_2_16, "materials/limit")

	local var_2_17 = arg_2_0.materialPanel

	arg_2_0.materialCostText = var_1.Find(var_2_17, "cost/consume")

	local var_2_18 = arg_2_0.materialPanel

	arg_2_0.materialStartButton = var_1.Find(var_2_18, "start_btn")
	setText = var_1

	local var_2_19 = arg_2_0.materialPanel
	local var_2_20 = var_3.Find(var_2_19, "materials/panel_title")

	i18n = var_4

	var_1(var_2_20, var_4("spweapon_ui_need_resource"))

	setText = var_1

	local var_2_21 = arg_2_0.materialStartButton
	local var_2_22 = var_3.Find(var_2_21, "Image")

	i18n = var_4

	var_1(var_2_22, var_4("spweapon_ui_transform"))

	return
end

function var_0_1.SetSpweaponVO(arg_3_0, arg_3_1)
	arg_3_0.spWeaponVO = arg_3_1

	return
end

function var_0_1.SetItems(arg_4_0, arg_4_1)
	arg_4_0.itemVOs = arg_4_1

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	var_1_10001(var_5_0, var_4.Find(var_5_1, "BG"), function()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end)
	arg_5_0:UpdateView()

	pg = var_1

	local var_5_2 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_2, arg_5_0._tf)

	return
end

function var_0_1.ResetMaterialMask(arg_7_0)
	arg_7_0.confirmUpgrade = nil

	return
end

function var_0_1.UpdateView(arg_8_0)
	setText = var_1_10001

	local var_8_0 = arg_8_0.equipmentName
	local var_8_1 = arg_8_0.spWeaponVO

	var_1_10001(var_8_0, var_4.GetName(var_8_1))

	local var_8_2 = arg_8_0.spWeaponVO
	local var_8_3 = var_1.GetUpgradeConfig(var_8_2)

	table = var_1_10002

	var_1_10002.Foreach(arg_8_0.materialItems, function(arg_9_0, arg_9_1)
		local var_9_0 = var_8_3.reset_use_item[arg_9_0]

		setActive = var_2_10003

		var_2_10003(arg_9_1:Find("Off"), not var_9_0)

		setActive = var_2_10003

		var_2_10003(arg_9_1:Find("Icon"), var_9_0)

		if var_9_0 then
			local var_9_1 = {
				id = var_9_0[1],
				count = var_9_0[2]
			}

			DROP_TYPE_ITEM = var_4
			var_9_1.type = var_4
			updateDrop = var_4

			var_4(arg_9_1:Find("Icon"), var_9_1)

			defaultValue = var_4

			local var_9_2 = var_4(arg_8_0.itemVOs[var_9_0[1]], {
				count = 0
			}).count .. "/" .. var_9_0[2]

			if var_4.count < var_9_0[2] then
				setColorStr = var_6

				local var_9_3 = var_4.count

				COLOR_RED = var_9
				var_9_2 = var_6(var_9_3, var_9) .. "/" .. var_9_0[2]
			end

			local var_9_4 = arg_9_1
			local var_9_5 = arg_9_1.Find(var_9_4, "Icon/icon_bg/count")

			setText = var_7

			var_7(var_9_5, var_9_2)

			onButton = var_7

			var_7(arg_8_0, arg_9_1:Find("Icon"), function()
				local var_10_0 = arg_8_0
				local var_10_1 = var_0.emit

				BaseUI = var_3_10003

				var_10_1(var_10_0, var_3_10003.ON_DROP, var_9_1)

				return
			end)

			local var_9_6 = arg_9_1:Find("Icon/Click")

			setActive = var_9_4

			var_9_4(var_9_6, not arg_8_0.confirmUpgrade)

			onButton = var_9_4

			var_9_4(arg_8_0, var_9_6, function()
				local var_11_0 = arg_8_0

				var_11_0.confirmUpgrade = true
				setActive = var_11_0

				var_11_0(var_9_6, not arg_8_0.confirmUpgrade)

				return
			end)
		end

		return
	end)

	updateSpWeapon = var_2

	var_2(arg_8_0.equipmentIcon, arg_8_0.spWeaponVO)

	local var_8_4 = arg_8_0.spWeaponVO
	local var_8_5 = var_2.GetAttributeOptions(var_8_4)
	local var_8_6 = arg_8_0.spWeaponVO
	local var_8_7 = var_3.GetBaseAttributes(var_8_6)
	local var_8_8 = arg_8_0.spWeaponVO
	local var_8_9 = var_4.GetAttributesRange(var_8_8)
	local var_8_10 = {}
	local var_8_11 = arg_8_0.spWeaponVO

	var_8_10[1] = var_6.getConfig(var_8_11, "attribute_1")

	local var_8_12 = arg_8_0.spWeaponVO

	var_8_10[2] = var_6.getConfig(var_8_12, "attribute_2")
	_ = var_6

	local var_8_13 = var_6.any(var_8_5, function(arg_12_0)
		return arg_12_0 > 0
	end)

	table = var_1_10007

	local var_8_14 = var_1_10007.equal(var_8_7, var_8_9)

	setActive = var_8

	var_8(arg_8_0.attributeButtons, var_8_13)

	UIItemList = var_8

	local var_8_15 = var_8.StaticAlign
	local var_8_16 = arg_8_0.attributeList
	local var_8_17 = arg_8_0.attributeList

	var_8_15(var_8_16, var_11.GetChild(var_8_17, 0), #var_8_7, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_13_1 = arg_13_1 + 1

		local var_13_0 = var_8_7[arg_13_1]
		local var_13_1 = var_8_9[arg_13_1]
		local var_13_2 = var_8_5[arg_13_1]

		AttributeType = var_2_10006

		local var_13_3 = var_2_10006.Type2Name(var_8_10[arg_13_1])

		setText = var_2_10007

		var_2_10007(arg_13_2:Find("Name"), var_13_3)

		setText = var_2_10007

		local var_13_4 = arg_13_2:Find("Values/Min/Value")

		math = var_10

		var_2_10007(var_13_4, var_10.min(1, var_13_1))

		setText = var_2_10007

		var_2_10007(arg_13_2:Find("Values/Max/Value"), var_13_1)

		setText = var_2_10007

		var_2_10007(arg_13_2:Find("Values/Current/Value1"), var_13_0)

		setText = var_2_10007

		var_2_10007(arg_13_2:Find("Values/Current/Value2"), var_13_2)

		setActive = var_2_10007

		var_2_10007(arg_13_2:Find("Values/Current/Symbol"), var_8_13)

		setActive = var_2_10007

		var_2_10007(arg_13_2:Find("Values/Current/Value2"), var_8_13)

		return
	end)

	onButton = var_8_15

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.materialStartButton

	local function var_8_20()
		if not arg_8_0.confirmUpgrade then
			pg = var_0

			local var_14_0 = var_0.TipsMgr.GetInstance()
			local var_14_1 = var_0.ShowTips

			i18n = var_2_10003

			var_14_1(var_14_0, var_2_10003("spweapon_tip_transform_materal_check"))

			return
		end

		local var_14_2 = arg_8_0
		local var_14_3 = var_0.emit

		SpWeaponModifyMediator = var_2_10003

		var_14_3(var_14_2, var_2_10003.ON_REFORGE)

		return
	end

	SFX_PANEL = var_13

	var_8_15(var_8_18, var_8_19, var_8_20, var_13)

	onButton = var_8_15

	local var_8_21 = arg_8_0
	local var_8_22 = arg_8_0.attributeExchangeButton

	local function var_8_23()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON = var_2_10004
		var_15_2.type = var_2_10004
		SpWeapon = var_2_10004
		var_15_2.op = var_2_10004.CONFIRM_OP_EXCHANGE
		_ = var_4
		var_15_2.attrs = var_4.map({
			1,
			2
		}, function(arg_16_0)
			local var_16_0 = var_8_7[arg_16_0]
			local var_16_1 = var_8_5[arg_16_0]

			AttributeType = var_3_10003

			local var_16_2 = var_3_10003.Type2Name(var_8_10[arg_16_0])

			return {
				var_16_2,
				var_16_0,
				var_16_1
			}
		end)

		function var_15_2.onYes()
			local var_17_0 = arg_8_0
			local var_17_1 = var_0.emit

			SpWeaponModifyMediator = var_3_10003

			local var_17_2 = var_3_10003.ON_CONFIRM_REFORGE

			SpWeapon = var_3_10004

			var_17_1(var_17_0, var_17_2, var_3_10004.CONFIRM_OP_EXCHANGE)

			return
		end

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_CANCEL = var_13

	var_8_15(var_8_21, var_8_22, var_8_23, var_13)

	onButton = var_8_15

	local var_8_24 = arg_8_0
	local var_8_25 = arg_8_0.attributeDiscardButton

	local function var_8_26()
		pg = var_2_10000

		local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_18_1 = var_0.ShowMsgBox
		local var_18_2 = {}

		MSGBOX_TYPE_CONFIRM_REFORGE_SPWEAPON = var_2_10004
		var_18_2.type = var_2_10004
		SpWeapon = var_2_10004
		var_18_2.op = var_2_10004.CONFIRM_OP_DISCARD
		_ = var_4
		var_18_2.attrs = var_4.map({
			1,
			2
		}, function(arg_19_0)
			local var_19_0 = var_8_7[arg_19_0]
			local var_19_1 = var_8_5[arg_19_0]

			AttributeType = var_3_10003

			local var_19_2 = var_3_10003.Type2Name(var_8_10[arg_19_0])

			return {
				var_19_2,
				var_19_0,
				var_19_1
			}
		end)

		function var_18_2.onYes()
			local var_20_0 = arg_8_0
			local var_20_1 = var_0.emit

			SpWeaponModifyMediator = var_3_10003

			local var_20_2 = var_3_10003.ON_CONFIRM_REFORGE

			SpWeapon = var_3_10004

			var_20_1(var_20_0, var_20_2, var_3_10004.CONFIRM_OP_DISCARD)

			return
		end

		var_18_1(var_18_0, var_18_2)

		return
	end

	SFX_CANCEL = var_13

	var_8_15(var_8_24, var_8_25, var_8_26, var_13)

	setGray = var_8_15

	var_8_15(arg_8_0.materialStartButton, var_8_13 or var_8_14)

	return
end

function var_0_1.willExit(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0._tf)

	return
end

return var_0_1
