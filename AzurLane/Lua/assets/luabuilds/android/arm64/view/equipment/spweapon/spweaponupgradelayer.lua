class = var_0_10000

local var_0_0 = "SpWeaponUpgradeLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = {
	15015,
	15016,
	15017
}
local var_0_8 = {}

IndexConst = var_0_10008
var_0_8.typeIndex = var_0_10008.SpWeaponTypeAll
IndexConst = var_8
var_0_8.rarityIndex = var_8.SpWeaponRarityAll

function var_0_1.getUIName(arg_1_0)
	return "SpWeaponUpgradeUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:InitUI()

	local var_2_0 = {}

	arg_2_0.consumeSpweapons = {}
	arg_2_0.consumeItems = var_2_0
	AutoLoader = var_2_0
	arg_2_0.loader = var_2_0.New()

	return
end

function var_0_1.InitUI(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rightPanel = var_1.Find(var_3_0, "Right")

	local var_3_1 = arg_3_0._tf

	arg_3_0.leftPanel = var_1.Find(var_3_1, "Left")

	local var_3_2 = arg_3_0.rightPanel

	arg_3_0.equipmentPanel = var_1.Find(var_3_2, "EquipmentPanel")

	local var_3_3 = arg_3_0.equipmentPanel

	arg_3_0.equipmentPanelTitleStrengthen = var_1.Find(var_3_3, "Title/Strengthen")

	local var_3_4 = arg_3_0.equipmentPanel

	arg_3_0.equipmentPanelTitleUpgrade = var_1.Find(var_3_4, "Title/Upgrade")

	local var_3_5 = arg_3_0.equipmentPanel

	arg_3_0.equipmentPanelTitleComposite = var_1.Find(var_3_5, "Title/Composite")

	local var_3_6 = arg_3_0.equipmentPanel

	arg_3_0.equipmentPanelIcon1 = var_1.Find(var_3_6, "Container/Equiptpl")

	local var_3_7 = arg_3_0.equipmentPanel

	arg_3_0.equipmentPanelIcon2 = var_1.Find(var_3_7, "Container/Equiptpl2")

	local var_3_8 = arg_3_0.equipmentPanel

	arg_3_0.equipmentPanelArrow = var_1.Find(var_3_8, "Container/Slot")

	local var_3_9 = arg_3_0.equipmentPanel

	arg_3_0.craftTargetCount = var_1.Find(var_3_9, "TotalCount")

	local var_3_10 = arg_3_0.rightPanel

	arg_3_0.materialPanel = var_1.Find(var_3_10, "MaterialPanel")

	local var_3_11 = arg_3_0.materialPanel

	arg_3_0.materialPanelAttrList = var_1.Find(var_3_11, "ScrollView/List")

	local var_3_12 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpLv = var_1.Find(var_3_12, "ExpLv")

	local var_3_13 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpLvText = var_1.Find(var_3_13, "ExpLv/Number")
	setActive = var_1

	var_1(arg_3_0.materialPanelExpLvText, false)

	local var_3_14 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpFullText = var_1.Find(var_3_14, "ExpFull")

	local var_3_15 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpBar = var_1.Find(var_3_15, "ExpBar")

	local var_3_16 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpBarFill = var_1.Find(var_3_16, "ExpBar/Fill")

	local var_3_17 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpBarFull = var_1.Find(var_3_17, "ExpBar/Full")
	setText = var_1

	local var_3_18 = arg_3_0.materialPanel
	local var_3_19 = var_3.Find(var_3_18, "ExpFull")

	i18n = var_4

	var_1(var_3_19, var_4("spweapon_ui_levelmax"))

	local var_3_20 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpTotalText = var_1.Find(var_3_20, "ExpTotal")

	local var_3_21 = arg_3_0.materialPanel

	arg_3_0.materialPanelExpCurrentText = var_1.Find(var_3_21, "ExpTotal/ExpCurrent")

	local var_3_22 = arg_3_0.materialPanel

	arg_3_0.materialPanelMaterialList = var_1.Find(var_3_22, "Materials/List")

	local var_3_23 = arg_3_0.materialPanel

	arg_3_0.materialPanelMaterialListLimit = var_1.Find(var_3_23, "Materials/Limit")
	CustomIndexLayer = var_1
	arg_3_0.materialPanelMaterialItems = var_1.Clone2Full(arg_3_0.materialPanelMaterialList, 3)
	setText = var_1

	local var_3_24 = arg_3_0.materialPanel
	local var_3_25 = var_3.Find(var_3_24, "Materials/Title")

	i18n = var_4

	var_1(var_3_25, var_4("spweapon_ui_need_resource"))

	setText = var_1

	local var_3_26 = arg_3_0.materialPanel
	local var_3_27 = var_3.Find(var_3_26, "Materials/Limit/text")

	i18n = var_4

	var_1(var_3_27, var_4("spweapon_ui_levelmax2"))

	local var_3_28 = arg_3_0.materialPanel

	arg_3_0.materialPanelCostText = var_1.Find(var_3_28, "Cost/Consume")

	local var_3_29 = arg_3_0.materialPanel

	arg_3_0.materialPanelButton = var_1.Find(var_3_29, "Button")

	local var_3_30 = arg_3_0.materialPanel

	arg_3_0.materialPanelButtonUpgrade = var_1.Find(var_3_30, "Button/Upgrade")

	local var_3_31 = arg_3_0.materialPanel

	arg_3_0.materialPanelButtonStrengthen = var_1.Find(var_3_31, "Button/Strengthen")

	local var_3_32 = arg_3_0.materialPanel

	arg_3_0.materialPanelButtonCreate = var_1.Find(var_3_32, "Button/Create")
	setText = var_1

	local var_3_33 = arg_3_0.materialPanelButtonUpgrade

	i18n = var_4

	var_1(var_3_33, var_4("msgbox_text_breakthrough"))

	setText = var_1

	local var_3_34 = arg_3_0.materialPanelButtonStrengthen

	i18n = var_4

	var_1(var_3_34, var_4("msgbox_text_noPos_intensify"))

	setText = var_1

	local var_3_35 = arg_3_0.materialPanelButtonCreate

	i18n = var_4

	var_1(var_3_35, var_4("spweapon_ui_create_button"))

	local var_3_36 = arg_3_0.leftPanel

	arg_3_0.leftPanelAutoSelectButton = var_1.Find(var_3_36, "Title/AutoSelect")

	local var_3_37 = arg_3_0.leftPanel

	arg_3_0.leftPanelClearSelectButton = var_1.Find(var_3_37, "Title/ClearSelect")

	local var_3_38 = arg_3_0.leftPanel

	arg_3_0.leftPanelItem = var_1.Find(var_3_38, "Items")

	local var_3_39 = arg_3_0.leftPanel
	local var_3_40 = var_1.Find(var_3_39, "Items/Content")
	local var_3_41 = arg_3_0.leftPanel
	local var_3_42 = var_2.Find(var_3_41, "Items/EquipItem")

	UIItemList = var_3_39
	arg_3_0.leftPanelItemRect = var_3_39.New(var_3_40, var_3_42)
	setText = var_3

	local var_3_43 = arg_3_0.leftPanel
	local var_3_44 = var_5.Find(var_3_43, "Items/Top/TextName")

	i18n = var_6

	var_3(var_3_44, var_6("spweapon_ui_ptitem"))

	setText = var_3

	local var_3_45 = arg_3_0.leftPanelAutoSelectButton
	local var_3_46 = var_5.Find(var_3_45, "On/Text")

	i18n = var_6

	var_3(var_3_46, var_6("spweapon_ui_autoselect"))

	setText = var_3

	local var_3_47 = arg_3_0.leftPanelAutoSelectButton
	local var_3_48 = var_5.Find(var_3_47, "Off/Text")

	i18n = var_6

	var_3(var_3_48, var_6("spweapon_ui_autoselect"))

	setText = var_3

	local var_3_49 = arg_3_0.leftPanelClearSelectButton
	local var_3_50 = var_5.Find(var_3_49, "On/Text")

	i18n = var_6

	var_3(var_3_50, var_6("spweapon_ui_cancelselect"))

	setText = var_3

	local var_3_51 = arg_3_0.leftPanelClearSelectButton
	local var_3_52 = var_5.Find(var_3_51, "Off/Text")

	i18n = var_6

	var_3(var_3_52, var_6("spweapon_ui_cancelselect"))

	local var_3_53 = arg_3_0.leftPanel

	arg_3_0.LeftPanelEquip = var_3.Find(var_3_53, "Equips")
	GetComponent = var_3

	local var_3_54 = arg_3_0.leftPanel

	arg_3_0.leftPanelEquipScrollComp = var_3(var_5.Find(var_3_54, "Equips/Scroll View"), "LScrollRect")
	setText = var_3

	local var_3_55 = arg_3_0.leftPanel
	local var_3_56 = var_5.Find(var_3_55, "Equips/Top/TextName")

	i18n = var_6

	var_3(var_3_56, var_6("spweapon_ui_spweapon"))

	local var_3_57 = arg_3_0.leftPanel

	arg_3_0.leftPanelFilterButton = var_3.Find(var_3_57, "Equips/Top/Filter")
	setText = var_3

	local var_3_58 = arg_3_0.leftPanel
	local var_3_59 = var_5.Find(var_3_58, "TipText")

	i18n = var_6

	var_3(var_3_59, var_6("spweapon_ui_helptext"))

	setText = var_3

	local var_3_60 = arg_3_0.equipmentPanel
	local var_3_61 = var_5.Find(var_3_60, "Ship/Detail")

	i18n = var_6

	var_3(var_3_61, var_6("spweapon_tip_view"))

	setText = var_3

	local var_3_62 = arg_3_0.equipmentPanel
	local var_3_63 = var_5.Find(var_3_62, "Ship/Title")

	i18n = var_6

	var_3(var_3_63, var_6("spweapon_tip_ship"))

	setText = var_3

	local var_3_64 = arg_3_0.equipmentPanel
	local var_3_65 = var_5.Find(var_3_64, "ShipType/Title")

	i18n = var_6

	var_3(var_3_65, var_6("spweapon_tip_type"))

	setText = var_3

	local var_3_66 = arg_3_0.craftTargetCount
	local var_3_67 = var_5.Find(var_3_66, "Tip")

	i18n = var_6

	var_3(var_3_67, var_6("spweapon_tip_owned", ""))

	Canvas = var_3

	var_3.ForceUpdateCanvases()

	return
end

function var_0_1.setItems(arg_4_0, arg_4_1)
	arg_4_0.itemVOs = arg_4_1

	return
end

function var_0_1.updateRes(arg_5_0, arg_5_1)
	arg_5_0.playerVO = arg_5_1

	return
end

function var_0_1.SetSpWeapon(arg_6_0, arg_6_1)
	arg_6_0.spWeaponVO = arg_6_1

	return
end

function var_0_1.SetSpWeaponList(arg_7_0, arg_7_1)
	arg_7_0.spWeaponList = arg_7_1

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_4.Find(var_8_1, "BG")

	local function var_8_3()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_8_1

	var_1_10001(var_8_0, var_8_2, var_8_3, var_8_1)

	onButton = var_1_10001

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.leftPanelFilterButton

	local function var_8_6()
		local var_10_0 = {}

		Clone = var_2_10001
		var_10_0.indexDatas = var_2_10001(arg_8_0.contextData.indexDatas)

		local var_10_1 = {}
		local var_10_2 = {}

		CustomIndexLayer = var_3
		var_10_2.mode = var_3.Mode.OR
		IndexConst = var_3
		var_10_2.options = var_3.SpWeaponTypeIndexs
		IndexConst = var_3
		var_10_2.names = var_3.SpWeaponTypeNames
		var_10_1.typeIndex = var_10_2

		local var_10_3 = {}

		CustomIndexLayer = var_3
		var_10_3.mode = var_3.Mode.AND
		IndexConst = var_3
		var_10_3.options = var_3.SpWeaponRarityIndexs
		IndexConst = var_3
		var_10_3.names = var_3.SpWeaponRarityNames
		var_10_1.rarityIndex = var_10_3
		var_10_0.customPanels = var_10_1
		var_10_0.groupList = {
			{
				dropdown = false,
				titleENTxt = "indexsort_typeeng",
				titleTxt = "indexsort_type",
				tags = {
					"typeIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_rarityeng",
				titleTxt = "indexsort_rarity",
				tags = {
					"rarityIndex"
				}
			}
		}

		function var_10_0.callback(arg_11_0)
			arg_8_0.contextData.indexDatas.typeIndex = arg_11_0.typeIndex
			arg_8_0.contextData.indexDatas.rarityIndex = arg_11_0.rarityIndex

			local var_11_0 = arg_8_0

			var_1.UpdateAll(var_11_0)

			return
		end

		local var_10_4 = arg_8_0
		local var_10_5 = var_1.emit

		SpWeaponUpgradeMediator = var_2_10004

		var_10_5(var_10_4, var_2_10004.OPEN_EQUIPMENT_INDEX, var_10_0)

		return
	end

	SFX_PANEL = var_8_1

	var_1_10001(var_8_4, var_8_5, var_8_6, var_8_1)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.leftPanelAutoSelectButton, function()
		local var_12_0 = arg_8_0

		var_0.AutoSelectMaterials(var_12_0)

		return
	end)

	onButton = var_1_10001

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0.leftPanelClearSelectButton

	local function var_8_9()
		table = var_2_10000

		var_2_10000.clear(arg_8_0.consumeItems)

		local var_13_0 = arg_8_0

		var_0.UpdateAll(var_13_0, true)

		return
	end

	SFX_CANCEL = var_8_1

	var_1_10001(var_8_7, var_8_8, var_8_9, var_8_1)

	function arg_8_0.leftPanelEquipScrollComp.onInitItem(arg_14_0)
		ClearTweenItemAlphaAndWhite = var_2_10001

		var_2_10001(arg_14_0.gameObject)

		return
	end

	function arg_8_0.leftPanelEquipScrollComp.onUpdateItem(arg_15_0, arg_15_1)
		local var_15_0 = arg_8_0

		var_2.UpdateEquipItemByIndex(var_15_0, arg_15_0, arg_15_1)

		return
	end

	function arg_8_0.leftPanelEquipScrollComp.onReturnItem(arg_16_0, arg_16_1)
		ClearTweenItemAlphaAndWhite = var_2_10002
		go = var_2_10004

		var_2_10002(var_2_10004(arg_16_1))

		return
	end

	local var_8_10 = arg_8_0.leftPanelItemRect

	var_1.make(var_8_10, function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventInit then
			pressPersistTrigger = var_3
			var_2_10007 = arg_17_2
			var_2_10005 = arg_17_2.Find(var_2_10007, "IconTpl")

			local var_17_0 = 0.5

			function var_2_10007(arg_18_0)
				local var_18_0 = arg_8_0.candicateMaterials[arg_17_1].id
				local var_18_1 = arg_8_0
				local var_18_2

				if not var_2.GetSelectMaterial(var_18_1, var_18_0) or not var_18_6.count then
					var_18_2 = 0
				end

				local var_18_3

				if not arg_8_0.itemVOs[var_18_0] or not arg_8_0.itemVOs[var_18_0].count then
					var_18_3 = 0
				end

				local var_18_5

				if arg_8_0.ptMax then
					pg = var_18_5

					local var_18_4 = var_18_5.TipsMgr.GetInstance()

					var_18_5 = var_18_5.ShowTips
					i18n = var_3_10008

					var_18_5(var_18_4, var_3_10008("spweapon_tip_upgrade"))
					arg_18_0()
				elseif var_18_2 == var_18_3 then
					arg_18_0()
				else
					local var_18_6

					if not var_18_6 then
						Item = var_18_5
						var_18_6 = var_18_5.New({
							count = 0,
							id = var_18_0
						})
						table = var_5

						var_5.insert(arg_8_0.consumeItems, var_18_6)
					end

					var_18_6.count = var_18_6.count + 1

					local var_18_7 = arg_8_0

					var_5.UpdateAll(var_18_7, true)
				end

				return
			end

			local var_17_1
			local var_17_2 = true

			var_2_10010 = true

			local var_17_3 = 0.15

			SFX_PANEL = var_2_10012

			var_3(var_2_10005, var_17_0, var_2_10007, var_17_1, var_17_2, var_2_10010, var_17_3, var_2_10012)

			pressPersistTrigger = var_3
			var_2_10007 = arg_17_2
			var_2_10005 = arg_17_2.Find(var_2_10007, "IconTpl/Reduce")

			local var_17_4 = 0.5

			function var_2_10007(arg_19_0)
				local var_19_0 = arg_8_0.candicateMaterials[arg_17_1].id
				local var_19_1 = arg_8_0
				local var_19_2

				if not var_2.GetSelectMaterial(var_19_1, var_19_0) or not var_2.count then
					var_19_2 = 0
				end

				if var_19_2 == 0 then
					arg_19_0()

					return
				end

				var_2.count = var_2.count - 1

				if var_2.count <= 0 then
					table = var_4

					var_4.removebyvalue(arg_8_0.consumeItems, var_2)
				end

				local var_19_3 = arg_8_0

				var_4.UpdateAll(var_19_3, true)

				return
			end

			local var_17_5
			local var_17_6 = true

			var_2_10010 = true

			local var_17_7 = 0.15

			SFX_PANEL = var_2_10012

			var_3(var_2_10005, var_17_4, var_2_10007, var_17_5, var_17_6, var_2_10010, var_17_7, var_2_10012)
		else
			UIItemList = var_3

			if arg_17_0 == var_3.EventUpdate then
				local var_17_8 = arg_8_0.candicateMaterials[arg_17_1]

				updateDrop = var_2_10004

				local var_17_9 = arg_17_2:Find("IconTpl")

				Drop = var_2_10007

				local var_17_10 = var_2_10007.New
				local var_17_11 = {}

				DROP_TYPE_ITEM = var_2_10010
				var_17_11.type = var_2_10010
				var_17_11.id = var_17_8.id
				var_17_11.count = var_17_8.count

				var_2_10004(var_17_9, var_17_10(var_17_11))

				setScrollText = var_2_10004

				var_2_10004(arg_17_2:Find("Mask/NameText"), var_17_8:getConfig("name"))

				local var_17_12 = arg_17_2
				local var_17_13 = arg_17_2.Find(var_17_12, "IconTpl/icon_bg/count")

				setText = var_2_10005

				var_2_10005(var_17_13, var_17_8.count)

				setActive = var_2_10005

				var_2_10005(arg_17_2:Find("IconTpl/mask"), var_17_8.count == 0)

				local var_17_14 = arg_8_0
				local var_17_15 = var_5.GetSelectMaterial(var_17_14, var_17_8.id)

				setActive = var_17_12

				var_17_12(arg_17_2:Find("IconTpl/Reduce"), var_17_15 and var_17_15.count > 0)

				if var_17_15 then
					setText = var_17_12

					var_17_12(arg_17_2:Find("IconTpl/Reduce/Text"), var_17_15.count)
				end
			end
		end

		return
	end)

	pg = var_1

	local var_8_11 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_8_11, arg_8_0._tf)

	local var_8_12 = arg_8_0.contextData
	local var_8_13

	if not arg_8_0.contextData.indexDatas then
		Clone = var_8_13
		var_8_13 = var_8_13(var_0_8)
	end

	var_8_12.indexDatas = var_8_13

	arg_8_0:UpdateAll()

	return
end

function var_0_1.UpdateEquipItemByIndex(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1 = arg_20_1 + 1
	TweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_20_2)

	local var_20_0 = arg_20_0.candicateSpweapons[arg_20_1]

	arg_20_0:UpdateEquipItem(var_20_0, arg_20_2)

	return
end

function var_0_1.UpdateEquipItem(arg_21_0, arg_21_1, arg_21_2)
	tf = var_1_10003

	local var_21_0 = var_1_10003(arg_21_2)

	onButton = var_1_10004

	var_1_10004(arg_21_0, var_21_0, function()
		local var_22_0 = arg_21_0

		if var_0.GetSelectSpWeapon(var_22_0, arg_21_1) then
			return
		end

		local var_22_2

		if arg_21_0.ptMax then
			pg = var_22_2

			local var_22_1 = var_22_2.TipsMgr.GetInstance()

			var_22_2 = var_22_2.ShowTips
			i18n = var_2_10004

			var_22_2(var_22_1, var_2_10004("spweapon_tip_upgrade"))

			return
		end

		seriesAsync = var_22_2

		var_22_2({
			function(arg_23_0)
				local var_23_0 = arg_21_1

				if not var_1.IsImportant(var_23_0) then
					return arg_23_0()
				end

				pg = var_1

				local var_23_1 = var_1.MsgboxMgr.GetInstance()
				local var_23_2 = var_1.ShowMsgBox
				local var_23_3 = {
					modal = true
				}

				MSGBOX_TYPE_CONFIRM_DELETE = var_3_10005
				var_23_3.type = var_3_10005
				pg = var_3_10005
				var_23_3.title = var_3_10005.MsgboxMgr.TITLE_INFORMATION
				var_23_3.onYes = arg_23_0

				local var_23_4 = {}
				local var_23_5 = arg_21_1

				var_23_4.name = var_6.GetName(var_23_5)
				var_23_3.data = var_23_4

				var_23_2(var_23_1, var_23_3)

				return
			end,
			function()
				table = var_3_10000

				var_3_10000.insert(arg_21_0.consumeSpweapons, arg_21_1)

				local var_24_0 = arg_21_0

				var_0.UpdateAll(var_24_0, true)

				local var_24_1 = arg_21_0

				var_0.UpdateEquipItem(var_24_1, arg_21_1, arg_21_2)

				return
			end
		})

		return
	end)

	onButton = var_1_10004

	var_1_10004(arg_21_0, var_21_0:Find("IconTpl/Reduce"), function()
		local var_25_0 = arg_21_0

		if not var_0.GetSelectSpWeapon(var_25_0, arg_21_1) then
			return
		end

		table = var_2_10001

		var_2_10001.removebyvalue(arg_21_0.consumeSpweapons, var_0)

		local var_25_1 = arg_21_0

		var_1.UpdateEquipItem(var_25_1, arg_21_1, arg_21_2)

		local var_25_2 = arg_21_0

		var_1.UpdateAll(var_25_2, true)

		return
	end)

	updateSpWeapon = var_1_10004

	var_1_10004(var_21_0:Find("IconTpl"), arg_21_1)

	setScrollText = var_1_10004

	var_1_10004(var_21_0:Find("Mask/NameText"), arg_21_1:GetName())

	local var_21_1 = arg_21_1
	local var_21_2 = arg_21_1.GetShipId(var_21_1)

	setActive = var_5

	local var_21_3 = var_21_0

	var_5(var_21_0.Find(var_21_3, "EquipShip"), var_21_2)

	if var_21_2 and 0 < var_21_2 then
		getProxy = var_5
		BayProxy = var_7

		local var_21_4 = var_5(var_7)
		local var_21_5 = var_5.getShipById(var_21_4, var_21_2)

		setImageSprite = var_21_1

		local var_21_6 = var_21_0:Find("EquipShip/Image")

		LoadSprite = var_21_3

		var_21_1(var_21_6, var_21_3("qicon/" .. var_21_5:getPainting()))
	end

	local var_21_7 = arg_21_0:GetSelectSpWeapon(arg_21_1)

	setActive = var_21_1

	var_21_1(var_21_0:Find("IconTpl/Reduce"), var_21_7)

	if var_21_7 then
		setText = var_21_1

		var_21_1(var_21_0:Find("IconTpl/Reduce/Text"), 1)
	end

	return
end

function var_0_1.UpdateSelectPt(arg_26_0)
	arg_26_0.nextSpWeaponVO = nil
	arg_26_0.upgradeType = nil
	arg_26_0.upgradeMaxLevel = false
	arg_26_0.ptMax = false

	local var_26_0 = arg_26_0.spWeaponVO
	local var_26_1 = var_1.GetPt(var_26_0)

	SpWeapon = var_1_10002

	local var_26_2 = var_26_1 + var_1_10002.CalculateHistoryPt(arg_26_0.consumeItems, arg_26_0.consumeSpweapons)
	local var_26_3 = arg_26_0.spWeaponVO
	local var_26_4 = var_2.GetConfigID(var_26_3)
	local var_26_5 = 0
	local var_26_6 = 0
	local var_26_7 = 0
	local var_26_8 = 0
	local var_26_9 = {}

	local function var_26_10(arg_27_0)
		ipairs = var_2_10001

		for iter_27_0, iter_27_1 in var_2_10001(arg_27_0) do
			local var_27_0 = iter_27_1[1]

			underscore = var_2_10007

			if not var_2_10007.detect(var_26_9, function(arg_28_0)
				return arg_28_0.id == var_27_0
			end) then
				Item = var_2_10008
				var_2_10007 = var_2_10008.New({
					id = var_27_0
				})
				var_2_10007.count = 0
				table = var_2_10008

				var_2_10008.insert(var_26_9, var_2_10007)
			end

			var_2_10007.count = var_2_10007.count + iter_27_1[2]
		end

		return
	end

	if arg_26_0.craftMode == var_0_2 then
		SpWeapon = var_9

		local var_26_11 = var_9.New({
			id = var_26_4
		})

		var_26_6 = var_26_6 + var_9.GetUpgradeConfig(var_26_11).create_use_pt

		var_26_10(var_10.create_use_item)

		var_26_8 = var_26_8 + var_10.create_use_gold
		arg_26_0.upgradeType = var_0_4
	end

	if var_26_6 <= var_26_2 then
		arg_26_0.upgradeType = var_0_5

		repeat
			SpWeapon = var_9

			local var_26_12 = var_9.New({
				id = var_26_4
			})

			if var_9.GetNextUpgradeID(var_26_12) == 0 then
				break
			end

			local var_26_13 = var_9:GetUpgradeConfig()

			var_26_5 = var_26_6
			var_26_6 = var_26_6 + var_26_13.upgrade_use_pt
			SpWeapon = var_12

			local var_26_14 = var_12.New({
				id = var_10
			})

			if var_26_7 > 0 and var_26_14:GetRarity() > var_9:GetRarity() then
				break
			end

			if var_26_14:GetRarity() > var_9:GetRarity() then
				arg_26_0.upgradeType = var_0_6
			end

			if var_26_2 < var_26_6 then
				break
			end

			var_26_10(var_26_13.upgrade_use_item)

			var_26_8 = var_26_8 + var_26_13.upgrade_use_gold
			var_26_7 = var_26_7 + 1
			var_26_4 = var_10
		until var_26_14:GetRarity() > var_9:GetRarity()
	end

	arg_26_0.ptMax = var_26_6 <= var_26_2
	math = var_9

	local var_26_15 = var_9.min(var_26_2, var_26_6)

	arg_26_0.upgradeLevel = var_26_7
	arg_26_0.upgradePtOrigin = var_26_5
	arg_26_0.upgradePtTotal = var_26_15
	arg_26_0.upgradePtMax = var_26_6
	arg_26_0.upgradNeedMaterials = var_26_9
	arg_26_0.upgradNeedGold = var_26_8

	local var_26_16 = arg_26_0.spWeaponVO

	arg_26_0.nextSpWeaponVO = var_9.MigrateTo(var_26_16, var_26_4)

	if arg_26_0.craftMode == var_0_3 then
		local var_26_17 = arg_26_0.spWeaponVO

		arg_26_0.upgradeMaxLevel = var_10.GetNextUpgradeID(var_26_17) == 0
	end

	return
end

function var_0_1.AutoSelectMaterials(arg_29_0)
	local var_29_0 = arg_29_0.spWeaponVO
	local var_29_1 = var_1.GetPt(var_29_0)

	SpWeapon = var_1_10002

	local var_29_2 = var_29_1 + var_1_10002.CalculateHistoryPt(arg_29_0.consumeItems, arg_29_0.consumeSpweapons)
	local var_29_3 = arg_29_0.spWeaponVO
	local var_29_4 = var_2.GetConfigID(var_29_3)
	local var_29_5 = 0

	if arg_29_0.craftMode == var_0_2 then
		SpWeapon = var_4

		local var_29_6 = var_4.New({
			id = var_29_4
		})

		var_29_5 = var_4.GetUpgradeConfig(var_29_6).create_use_pt
	end

	while true do
		SpWeapon = var_4

		local var_29_7 = var_4.New({
			id = var_29_4
		})

		if var_4.GetNextUpgradeID(var_29_7) == 0 then
			break
		end

		var_29_5 = var_29_5 + var_4:GetUpgradeConfig().upgrade_use_pt
		SpWeapon = var_7

		local var_29_8 = var_7.New({
			id = var_5
		})
		local var_29_9 = var_7.GetRarity(var_29_8)
		local var_29_10 = arg_29_0.spWeaponVO

		if var_29_9 > var_9.GetRarity(var_29_10) then
			break
		end

		var_29_4 = var_5
	end

	if var_29_5 <= var_29_2 then
		return
	end

	_ = var_4

	local var_29_11 = var_4.values

	_ = var_1_10006

	local var_29_12 = var_29_11(var_1_10006.map(arg_29_0.candicateMaterials, function(arg_30_0)
		local var_30_0 = arg_29_0
		local var_30_1 = var_1.GetSelectMaterial(var_30_0, arg_30_0.id)
		local var_30_2 = arg_30_0.count
		local var_30_3

		if not var_30_1 or not var_30_1.count then
			var_30_3 = 0
		end

		local var_30_4 = var_30_2 - var_30_3

		if 0 < var_30_4 then
			Item = var_3

			local var_30_5

			if not var_3.New({
				id = arg_30_0.id,
				count = var_30_4
			}) then
				var_30_5 = nil
			end

			return var_30_5
		end
	end))

	local function var_29_13(arg_31_0)
		Item = var_2_10001

		return var_2_10001.getConfigData(arg_31_0.id).usage_arg[1]
	end

	table = var_6

	var_6.sort(var_29_12, function(arg_32_0, arg_32_1)
		return var_29_13(arg_32_0) > var_29_13(arg_32_1)
	end)

	local var_29_14 = var_29_5 - var_29_2
	local var_29_15
	local var_29_16, var_29_17 = (function(arg_33_0, arg_33_1, arg_33_2)
		if not var_29_12[arg_33_0] then
			return false
		end

		local var_33_0 = var_29_13(var_3)

		math = var_2_10005

		local var_33_1 = var_2_10005.min

		math = var_2_10007

		local var_33_2 = arg_33_1 - var_33_0 * var_33_1(var_2_10007.ceil(arg_33_1 / var_33_0), var_3.count)

		Clone = var_7
		arg_33_2 = var_7(arg_33_2)

		if var_33_2 == 0 then
			table = var_7

			var_7.insert(arg_33_2, {
				id = var_3.id,
				count = var_5
			})

			return true, arg_33_2
		elseif var_33_2 > 0 then
			local var_33_3, var_33_4 = var_0(arg_33_0 + 1, var_33_2, {})

			if var_33_3 then
				table = var_9

				var_9.insert(arg_33_2, {
					id = var_3.id,
					count = var_5
				})

				table = var_9

				var_9.insertto(arg_33_2, var_33_4)

				return true, arg_33_2
			else
				return false
			end
		elseif var_33_2 < 0 then
			local var_33_5 = var_33_2 + var_33_0
			local var_33_6, var_33_7 = var_0(arg_33_0 + 1, var_33_5, {})
			local var_33_8

			if var_33_6 then
				table = var_33_8
				var_33_8 = var_33_8.insert

				local var_33_9 = arg_33_2
				local var_33_10 = {
					id = var_3.id
				}

				math = var_13
				var_33_10.count = var_13.max(var_5 - 1, 0)

				var_33_8(var_33_9, var_33_10)

				table = var_33_8

				var_33_8.insertto(arg_33_2, var_33_7)

				return true, arg_33_2
			else
				table = var_33_8

				local var_33_11 = var_33_8.insert
				local var_33_12 = arg_33_2
				local var_33_13 = {
					id = var_3.id
				}

				math = var_13
				var_33_13.count = var_13.max(var_5, 0)

				var_33_11(var_33_12, var_33_13)

				return true, arg_33_2
			end
		end

		return
	end)(1, var_29_14, {})

	var_29_17 = var_29_16 and var_29_17 or var_29_12
	_ = var_10

	var_10.each(var_29_17, function(arg_34_0)
		local var_34_0 = arg_29_0

		var_1.UpdateSelectMaterial(var_34_0, arg_34_0.id, arg_34_0.count)

		local var_34_1 = arg_29_0

		var_1.UpdateAll(var_34_1, true)

		return
	end)

	return
end

function var_0_1.UpdateAll(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.spWeaponVO
	local var_35_1

	if var_2.IsReal(var_35_0) or not var_0_2 then
		var_35_1 = var_0_3
	end

	arg_35_0.craftMode = var_35_1

	local var_35_2 = arg_35_0

	arg_35_0.UpdateSelectPt(var_35_2)

	if arg_35_0.craftMode == var_0_3 then
		var_35_2 = arg_35_0.nextSpWeaponVO

		local var_35_3 = var_2.GetConfigID(var_35_2)
		local var_35_4 = arg_35_0.spWeaponVO
		local var_35_5

		if var_35_3 == var_3.GetConfigID(var_35_4) then
			var_35_5 = false
		else
			var_35_5 = true
		end

		setActive = var_3

		var_3(arg_35_0.equipmentPanelIcon2, var_35_5)

		setActive = var_3

		var_3(arg_35_0.equipmentPanelArrow, var_35_5)

		if var_35_5 then
			updateSpWeapon = var_3

			var_3(arg_35_0.equipmentPanelIcon1, arg_35_0.spWeaponVO)

			updateSpWeapon = var_3

			var_3(arg_35_0.equipmentPanelIcon2, arg_35_0.nextSpWeaponVO)
			arg_35_0:UpdateAttrs(arg_35_0.materialPanelAttrList, arg_35_0.spWeaponVO, arg_35_0.nextSpWeaponVO)
		else
			updateSpWeapon = var_3

			var_3(arg_35_0.equipmentPanelIcon1, arg_35_0.nextSpWeaponVO)
			arg_35_0:UpdateAttrs(arg_35_0.materialPanelAttrList, arg_35_0.nextSpWeaponVO)
		end

		setText = var_3

		local var_35_6 = arg_35_0.equipmentPanel
		local var_35_7 = var_5.Find(var_35_6, "Name")
		local var_35_8 = arg_35_0.nextSpWeaponVO

		var_3(var_35_7, var_6.GetName(var_35_8))

		local var_35_9 = arg_35_0.nextSpWeaponVO
		local var_35_10 = var_3.IsUnique(var_35_9)

		setActive = var_35_2

		local var_35_11 = arg_35_0.equipmentPanel

		var_35_2(var_6.Find(var_35_11, "ShipType"), not var_35_10)

		setActive = var_35_2

		local var_35_12 = arg_35_0.equipmentPanel

		var_35_2(var_6.Find(var_35_12, "Ship"), var_35_10)

		if var_35_10 then
			ShipGroup = var_35_2

			local var_35_13 = var_35_2.getDefaultShipConfig
			local var_35_14 = arg_35_0.nextSpWeaponVO

			if not var_35_13(var_6.GetUniqueGroup(var_35_14)) or not var_4.id then
				var_35_9 = nil
			end

			assert = var_6

			var_6(var_35_9 and var_35_9 > 0)

			if var_35_9 and 0 < var_35_9 then
				Ship = var_6

				local var_35_15 = var_6.New({
					configId = var_35_9
				})
				local var_35_16 = arg_35_0.loader
				local var_35_17 = var_7.GetSprite
				local var_35_18 = "qicon/" .. var_35_15:getPainting()
				local var_35_19
				local var_35_20 = arg_35_0.equipmentPanel

				var_35_17(var_35_16, var_35_18, var_35_19, var_12.Find(var_35_20, "Ship/Icon/Image"))

				local function var_35_21()
					local var_36_0 = arg_35_0
					local var_36_1 = var_0.emit

					BaseUI = var_2_10003

					local var_36_2 = var_2_10003.ON_DROP
					local var_36_3 = {}

					DROP_TYPE_SHIP = var_2_10005
					var_36_3.type = var_2_10005
					var_36_3.id = var_35_9

					var_36_1(var_36_0, var_36_2, var_36_3)

					return
				end

				local var_35_22 = arg_35_0.equipmentPanel
				local var_35_23 = var_8.Find(var_35_22, "Ship/Detail")
				local var_35_24 = var_8.GetComponent(var_35_23, "RichText")

				var_8.AddListener(var_35_24, var_35_21)

				onButton = var_8

				local var_35_25 = arg_35_0
				local var_35_26 = arg_35_0.equipmentPanel

				var_8(var_35_25, var_11.Find(var_35_26, "Ship/Icon"), var_35_21)
			end
		else
			local var_35_27 = arg_35_0.nextSpWeaponVO
			local var_35_28 = var_4.GetWearableShipTypes(var_35_27)

			_ = var_35_9

			local var_35_29 = var_35_9.filter(var_35_28, function(arg_37_0)
				table = var_2_10001

				local var_37_0 = var_2_10001.contains

				ShipType = var_2_10003

				return var_37_0(var_2_10003.AllShipType, arg_37_0)
			end)

			ShipType = var_5

			local var_35_30 = var_5.FilterOverQuZhuType(var_35_29)

			CustomIndexLayer = var_5

			local var_35_31 = var_5.Clone2Full
			local var_35_32 = arg_35_0.equipmentPanel

			var_35_31(var_7.Find(var_35_32, "ShipType/List"), #var_35_30)

			ipairs = var_35_31

			for iter_35_0, iter_35_1 in var_35_31(var_35_30) do
				local var_35_33 = arg_35_0.equipmentPanel
				local var_35_34 = var_10.Find(var_35_33, "ShipType/List")
				local var_35_35 = var_10.GetChild(var_35_34, iter_35_0 - 1)
				local var_35_36 = arg_35_0.loader
				local var_35_37 = var_11.GetSprite
				local var_35_38 = "shiptype"

				ShipType = var_1_10015

				var_35_37(var_35_36, var_35_38, var_1_10015.Type2CNLabel(iter_35_1), var_35_35)
			end
		end

		arg_35_0:UpdateExpBar()
		arg_35_0:UpdateMaterials()
		arg_35_0:UpdatePtMaterials(arg_35_1)
		arg_35_0:UpdateCraftTargetCount()

		return
	end
end

function var_0_1.UpdateCraftTargetCount(arg_38_0)
	setActive = var_1_10001

	var_1_10001(arg_38_0.craftTargetCount, arg_38_0.craftMode == var_0_2)

	if not arg_38_0.craftMode == var_0_2 then
		return
	end

	_ = var_1

	local var_38_0 = var_1.reduce(arg_38_0.spWeaponList, 0, function(arg_39_0, arg_39_1)
		local var_39_0 = arg_38_0.nextSpWeaponVO

		if var_2.GetOriginID(var_39_0) == arg_39_1:GetOriginID() then
			arg_39_0 = arg_39_0 + 1
		end

		return arg_39_0
	end)

	setText = var_2

	local var_38_1 = arg_38_0.craftTargetCount

	var_2(var_4.Find(var_38_1, "Text"), var_38_0)

	return
end

function var_0_1.UpdateAttrs(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0
	local var_40_1

	if arg_40_0.craftMode == var_0_2 then
		SpWeaponHelper = var_6
		var_40_0 = var_6.TransformCompositeInfo(arg_40_2)
		var_40_1 = arg_40_2:GetSkillGroup()
		arg_40_3 = arg_40_2
	elseif arg_40_0.craftMode == var_0_3 then
		arg_40_3 = arg_40_3 or arg_40_2
		SpWeaponHelper = var_6
		var_40_0 = var_6.TransformUpgradeInfo(arg_40_2, arg_40_3)
		var_40_1 = arg_40_3:GetSkillGroup()
	end

	arg_40_0:UpdateSpWeaponUpgradeInfo(arg_40_1, var_40_0, var_40_1, arg_40_3)

	return
end

function var_0_1.UpdateSpWeaponUpgradeInfo(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = arg_41_1:Find("attr_tpl")

	removeAllChildren = var_1_10006

	var_1_10006(arg_41_1:Find("attrs"))

	local function var_41_1(arg_42_0, arg_42_1)
		local var_42_0 = arg_42_0:Find("base")
		local var_42_1 = arg_42_1.name
		local var_42_2 = arg_42_1.value

		setText = var_5

		var_5(var_42_0:Find("name"), var_42_1)

		setActive = var_5

		var_5(var_42_0:Find("value"), true)

		setText = var_5

		var_5(var_42_0:Find("value"), var_42_2)

		setActive = var_5

		var_5(var_42_0:Find("effect"), false)

		setActive = var_5

		local var_42_3 = var_42_0:Find("value/up")
		local var_42_4

		if arg_42_1.compare then
			var_42_4 = arg_42_1.compare > 0
		end

		var_5(var_42_3, var_42_4)

		setActive = var_5

		local var_42_5 = var_42_0:Find("value/down")
		local var_42_6

		if arg_42_1.compare then
			var_42_6 = arg_42_1.compare < 0
		end

		var_5(var_42_5, var_42_6)

		triggerToggle = var_5

		var_5(var_42_0, arg_42_1.lock_open)

		local var_42_8

		if not arg_42_1.lock_open and arg_42_1.sub and #arg_42_1.sub > 0 then
			GetComponent = var_42_8

			local var_42_7 = var_42_0

			typeof = var_8
			Toggle = var_10
			var_42_8 = var_42_8(var_42_7, var_8(var_10))
			var_42_8.enabled = true
		else
			setActive = var_42_8

			var_42_8(var_42_0:Find("name/close"), false)

			setActive = var_42_8

			var_42_8(var_42_0:Find("name/open"), false)

			GetComponent = var_42_8

			local var_42_9 = var_42_0

			typeof = var_8
			Toggle = var_10
			var_42_8(var_42_9, var_8(var_10)).enabled = false
		end

		return
	end

	;(function(arg_43_0, arg_43_1, arg_43_2)
		ipairs = var_2_10003

		for iter_43_0, iter_43_1 in var_2_10003(arg_43_2) do
			cloneTplTo = var_2_10008
			var_2_10008 = var_2_10008(arg_43_1, arg_43_0)

			var_41_1(var_2_10008, iter_43_1)
		end

		return
	end)(arg_41_1:Find("attrs"), var_41_0, arg_41_2)

	local var_41_2 = {}
	local var_41_3

	if arg_41_3[1].skillId > 0 then
		table = var_41_3
		var_41_3 = var_41_3.insert

		local var_41_4 = var_41_2
		local var_41_5 = {}

		i18n = var_13
		var_41_5.name = var_13("spweapon_attr_effect")
		var_41_5.effect = arg_41_3[1]

		var_41_3(var_41_4, var_41_5)
	end

	ipairs = var_41_3

	for iter_41_0, iter_41_1 in var_41_3(arg_41_3[2]) do
		table = var_1_10014
		var_1_10014 = var_1_10014.insert

		local var_41_6 = var_41_2
		local var_41_7 = {
			isSkill = true
		}

		i18n = var_1_10018
		var_41_7.name = var_1_10018("spweapon_attr_skillupgrade")
		var_41_7.effect = iter_41_1

		var_1_10014(var_41_6, var_41_7)
	end

	local function var_41_8(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_0:Find("base")
		local var_44_1 = arg_44_1.name
		local var_44_2 = arg_44_1.effect

		setText = var_5

		var_5(var_44_0:Find("name"), var_44_1)

		setActive = var_5

		var_5(var_44_0:Find("value"), false)

		setActive = var_5

		local var_44_3 = var_44_0

		var_5(var_44_0.Find(var_44_3, "effect"), true)

		getSkillName = var_5

		local var_44_4 = var_5(var_44_2.skillId)

		if not var_44_2.unlock then
			setColorStr = var_6
			var_44_4 = var_6(var_44_4, "#a2a2a2")
			setTextColor = var_6

			local var_44_5 = var_44_0:Find("effect")

			SummerFeastScene = var_44_3

			var_6(var_44_5, var_44_3.TransformColor("a2a2a2"))
		else
			setTextColor = var_6

			local var_44_6 = var_44_0:Find("effect")

			SummerFeastScene = var_44_3

			var_6(var_44_6, var_44_3.TransformColor("FFDE00"))
		end

		local var_44_7 = "<material=underline event=displaySkill>" .. var_44_4 .. "</material>"
		local var_44_8 = var_44_0:Find("effect")
		local var_44_9 = var_7.GetComponent(var_44_8, "RichText")

		var_7.AddListener(var_44_9, function(arg_45_0, arg_45_1)
			if arg_45_0 == "displaySkill" then
				getSkillDesc = var_3_10002

				local var_45_0 = var_3_10002(var_44_2.skillId, var_44_2.lv)

				if not var_44_2.unlock then
					setColorStr = var_3
					i18n = var_5
					var_45_0 = var_3(var_5("spweapon_tip_skill_locked") .. var_45_0, "#a2a2a2")
				end

				if not arg_44_1.isSkill then
					pg = var_3

					local var_45_1 = var_3.MsgboxMgr.GetInstance()
					local var_45_2 = var_3.ShowMsgBox

					var_3_10006 = {}
					MSGBOX_TYPE_SINGLE_ITEM = var_3_10007
					var_3_10006.type = var_3_10007

					local var_45_3 = {}

					DROP_TYPE_SPWEAPON = var_3_10008
					var_45_3.type = var_3_10008

					local var_45_4 = arg_41_4

					var_45_3.id = var_8.GetConfigID(var_45_4)
					var_3_10006.drop = var_45_3
					var_3_10006.name = var_44_4
					var_3_10006.content = var_45_0

					var_45_2(var_45_1, var_3_10006)
				else
					local var_45_5 = arg_41_0
					local var_45_6 = var_3.emit

					SpWeaponUpgradeMediator = var_3_10006

					var_45_6(var_45_5, var_3_10006.ON_SKILLINFO, var_44_2.skillId, var_44_2.unlock, 10)
				end
			end

			return
		end)

		setText = var_7

		var_7(var_44_0:Find("effect"), var_44_7)

		setActive = var_7

		var_7(var_44_0:Find("value/up"), false)

		setActive = var_7

		var_7(var_44_0:Find("value/down"), false)

		triggerToggle = var_7

		var_7(var_44_0, false)

		setActive = var_7

		var_7(var_44_0:Find("name/close"), false)

		setActive = var_7

		var_7(var_44_0:Find("name/open"), false)

		GetComponent = var_7

		local var_44_10 = var_44_0

		typeof = var_10
		Toggle = var_12
		var_7(var_44_10, var_10(var_12)).enabled = false

		return
	end

	;(function(arg_46_0, arg_46_1, arg_46_2)
		ipairs = var_2_10003

		for iter_46_0, iter_46_1 in var_2_10003(arg_46_2) do
			cloneTplTo = var_2_10008
			var_2_10008 = var_2_10008(arg_46_1, arg_46_0)

			var_41_8(var_2_10008, iter_46_1)
		end

		return
	end)(arg_41_1:Find("attrs"), var_41_0, var_41_2)

	return
end

function var_0_1.UpdateExpBar(arg_47_0)
	local var_47_0 = arg_47_0.upgradeMaxLevel

	setActive = var_1_10002

	var_1_10002(arg_47_0.materialPanelExpLv, not var_47_0)

	setActive = var_1_10002

	var_1_10002(arg_47_0.materialPanelExpFullText, var_47_0)

	setActive = var_1_10002

	var_1_10002(arg_47_0.materialPanelExpBarFull, var_47_0)

	if not var_47_0 then
		setSlider = var_1_10002

		var_1_10002(arg_47_0.materialPanelExpBar, 0, 1, (arg_47_0.upgradePtTotal - arg_47_0.upgradePtOrigin) / (arg_47_0.upgradePtMax - arg_47_0.upgradePtOrigin))

		if arg_47_0.upgradeType == var_0_4 then
			setText = var_1_10002

			local var_47_1 = arg_47_0.materialPanelExpLv

			i18n = var_5

			var_1_10002(var_47_1, var_5("spweapon_ui_create_exp"))
		elseif arg_47_0.upgradeType == var_0_5 then
			setText = var_1_10002

			local var_47_2 = arg_47_0.materialPanelExpLv

			i18n = var_5

			var_1_10002(var_47_2, var_5("spweapon_ui_upgrade_exp"))
		elseif arg_47_0.upgradeType == var_0_6 then
			setText = var_1_10002

			local var_47_3 = arg_47_0.materialPanelExpLv

			i18n = var_5

			var_1_10002(var_47_3, var_5("spweapon_ui_breakout_exp"))
		end

		setText = var_1_10002

		var_1_10002(arg_47_0.materialPanelExpCurrentText, arg_47_0.upgradePtTotal - arg_47_0.upgradePtOrigin)

		setText = var_1_10002

		var_1_10002(arg_47_0.materialPanelExpTotalText, arg_47_0.upgradePtMax - arg_47_0.upgradePtOrigin)
	else
		setText = var_1_10002

		var_1_10002(arg_47_0.materialPanelExpCurrentText, 0)

		setText = var_1_10002

		var_1_10002(arg_47_0.materialPanelExpTotalText, 0)
	end

	return
end

function var_0_1.UpdateMaterials(arg_48_0)
	local var_48_0 = arg_48_0.upgradNeedMaterials
	local var_48_1 = arg_48_0.upgradNeedGold
	local var_48_2 = arg_48_0.spWeaponVO
	local var_48_3 = var_3.GetNextUpgradeID(var_48_2) == 0

	setActive = var_1_10004

	var_1_10004(arg_48_0.materialPanelMaterialList, not var_48_3)

	setActive = var_1_10004

	var_1_10004(arg_48_0.materialPanelMaterialListLimit, var_48_3)

	local var_48_4
	local var_48_5 = true

	for iter_48_0 = 1, #arg_48_0.materialPanelMaterialItems do
		local var_48_6 = arg_48_0.materialPanelMaterialItems[iter_48_0]

		setActive = var_1_10011
		findTF = var_1_10013

		var_1_10011(var_1_10013(var_48_6, "off"), not var_48_0[iter_48_0])

		setActive = var_1_10011
		findTF = var_1_10013

		var_1_10011(var_1_10013(var_48_6, "Icon"), var_48_0[iter_48_0])

		if var_48_0[iter_48_0] then
			local var_48_7 = var_48_0[iter_48_0].id

			findTF = var_1_10013
			var_1_10013 = var_1_10013(var_48_6, "Icon")

			local var_48_8 = {}

			DROP_TYPE_ITEM = var_15
			var_48_8.type = var_15
			var_48_8.id = var_1_10011.id
			var_48_8.count = var_1_10011.count
			updateDrop = var_15

			var_15(var_1_10013, var_48_8)

			onButton = var_15

			var_15(arg_48_0, var_1_10013, function()
				local var_49_0 = arg_48_0
				local var_49_1 = var_0.emit

				BaseUI = var_2_10003

				var_49_1(var_49_0, var_2_10003.ON_DROP, var_48_8)

				return
			end)

			defaultValue = var_15

			local var_48_9 = var_15(arg_48_0.itemVOs[var_48_7], {
				count = 0
			})
			local var_48_10 = var_1_10011.count .. "/" .. var_48_9.count

			if var_48_9.count < var_1_10011.count then
				setColorStr = var_17

				local var_48_11 = var_48_9.count

				COLOR_RED = var_1_10020
				var_48_10 = var_17(var_48_11, var_1_10020) .. "/" .. var_1_10011.count
				var_48_5 = false
				var_48_4 = var_1_10011.id
			end

			findTF = var_17

			local var_48_12 = var_17(var_1_10013, "icon_bg/count")

			setActive = var_18

			var_18(var_48_12, true)

			setText = var_18

			var_18(var_48_12, var_48_10)

			var_1_10020 = var_1_10013

			local var_48_13 = var_1_10013.Find(var_1_10020, "Click")

			setActive = var_19

			var_19(var_48_13, not arg_48_0.confirmUpgrade and arg_48_0.upgradeType == var_0_6)

			onButton = var_19

			var_19(arg_48_0, var_48_13, function()
				local var_50_0 = arg_48_0

				var_50_0.confirmUpgrade = true
				setActive = var_50_0

				var_50_0(var_48_13, not arg_48_0.confirmUpgrade)

				return
			end)
		end
	end

	setText = var_6

	var_6(arg_48_0.materialPanelCostText, var_48_1)

	setActive = var_6

	var_6(arg_48_0.materialPanelButtonCreate, arg_48_0.craftMode == var_0_2)

	setActive = var_6

	var_6(arg_48_0.materialPanelButtonUpgrade, arg_48_0.craftMode == var_0_3 and arg_48_0.upgradeType == var_0_6)

	setActive = var_6

	var_6(arg_48_0.materialPanelButtonStrengthen, arg_48_0.craftMode == var_0_3 and arg_48_0.upgradeType == var_0_5)

	setActive = var_6

	var_6(arg_48_0.equipmentPanelTitleComposite, arg_48_0.craftMode == var_0_2)

	setActive = var_6

	var_6(arg_48_0.equipmentPanelTitleUpgrade, arg_48_0.craftMode == var_0_3 and arg_48_0.upgradeType == var_0_6)

	setActive = var_6

	var_6(arg_48_0.equipmentPanelTitleStrengthen, arg_48_0.craftMode == var_0_3 and arg_48_0.upgradeType == var_0_5)

	onButton = var_6

	local var_48_14 = arg_48_0
	local var_48_15 = arg_48_0.materialPanelButton

	local function var_48_16()
		if not var_48_5 then
			ItemTipPanel = var_0

			if not var_0.ShowItemTipbyID(var_48_4) then
				pg = var_0
				var_2_10002 = var_0.TipsMgr.GetInstance()

				local var_51_0 = var_0.ShowTips

				i18n = var_2_10003

				var_51_0(var_2_10002, var_2_10003("spweapon_tip_materal_no_enough"))
			end

			return
		end

		if arg_48_0.playerVO.gold < var_48_1 then
			GoShoppingMsgBox = var_0
			i18n = var_2_10002

			local var_51_1 = "switch_to_shop_tip_2"

			i18n = var_2_10005

			local var_51_2 = var_2_10002(var_51_1, var_2_10005("word_gold"))

			ChargeScene = var_2_10003

			var_0(var_51_2, var_2_10003.TYPE_ITEM, {
				{
					59001,
					var_48_1 - arg_48_0.playerVO.gold,
					var_48_1
				}
			})

			return
		end

		if not arg_48_0.confirmUpgrade and arg_48_0.upgradeType == var_0_6 and #arg_48_0.upgradNeedMaterials > 0 then
			pg = var_0

			local var_51_3 = var_0.TipsMgr.GetInstance()
			local var_51_4 = var_0.ShowTips

			i18n = var_2_10003

			var_51_4(var_51_3, var_2_10003("spweapon_tip_breakout_materal_check"))

			return
		end

		if arg_48_0.craftMode == var_0_2 then
			local var_51_5 = arg_48_0
			local var_51_6 = var_0.emit

			SpWeaponUpgradeMediator = var_2_10003
			var_2_10003 = var_2_10003.EQUIPMENT_COMPOSITE

			local var_51_7 = arg_48_0.spWeaponVO

			var_51_6(var_51_5, var_2_10003, var_4.GetConfigID(var_51_7), arg_48_0.consumeItems, arg_48_0.consumeSpweapons)
		elseif arg_48_0.craftMode == var_0_3 then
			local var_51_8 = arg_48_0
			local var_51_9 = var_0.emit

			SpWeaponUpgradeMediator = var_2_10003

			local var_51_10 = var_2_10003.EQUIPMENT_UPGRADE
			local var_51_11 = arg_48_0.spWeaponVO

			var_51_9(var_51_8, var_51_10, var_4.GetUID(var_51_11), arg_48_0.consumeItems, arg_48_0.consumeSpweapons)
		end

		return
	end

	SFX_UI_DOCKYARD_REINFORCE = var_1_10011

	var_6(var_48_14, var_48_15, var_48_16, var_1_10011)

	setGray = var_6

	var_6(arg_48_0.materialPanelButton, arg_48_0.upgradeMaxLevel)

	setButtonEnabled = var_6

	var_6(arg_48_0.materialPanelButton, not arg_48_0.upgradeMaxLevel)

	return
end

function var_0_1.UpdatePtMaterials(arg_52_0, arg_52_1)
	_ = var_1_10002
	arg_52_0.candicateMaterials = var_1_10002.map(var_0_7, function(arg_53_0)
		local var_53_0

		if not arg_52_0.itemVOs[arg_53_0] then
			Item = var_53_0
			var_53_0 = var_53_0.New({
				count = 0,
				id = arg_53_0
			})
		end

		return var_53_0
	end)
	table = var_2

	var_2.sort(arg_52_0.candicateMaterials, function(arg_54_0, arg_54_1)
		return arg_54_0.id < arg_54_1.id
	end)

	table = var_2

	local var_52_0 = var_2.equal(arg_52_0.contextData.indexDatas, var_0_8)

	setActive = var_1_10003

	local var_52_1 = arg_52_0.leftPanelFilterButton

	var_1_10003(var_5.Find(var_52_1, "Off"), var_52_0)

	setActive = var_1_10003

	local var_52_2 = arg_52_0.leftPanelFilterButton

	var_1_10003(var_5.Find(var_52_2, "On"), not var_52_0)

	arg_52_0.candicateSpweapons = {}
	pairs = var_3

	for iter_52_0, iter_52_1 in var_3(arg_52_0.spWeaponList) do
		local var_52_3 = iter_52_1:GetUID()
		local var_52_4 = arg_52_0.spWeaponVO

		if var_52_3 ~= var_9.GetUID(var_52_4) and not iter_52_1:IsUnCraftable() and not iter_52_1:GetShipId() then
			IndexConst = var_52_3

			if var_52_3.filterSpWeaponByType(iter_52_1, arg_52_0.contextData.indexDatas.typeIndex) then
				IndexConst = var_52_3

				if var_52_3.filterSpWeaponByRarity(iter_52_1, arg_52_0.contextData.indexDatas.rarityIndex) then
					table = var_52_3

					var_52_3.insert(arg_52_0.candicateSpweapons, iter_52_1)
				end
			end
		end
	end

	SpWeaponSortCfg = var_3

	local var_52_5 = true

	table = var_5

	local var_52_6 = var_5.sort
	local var_52_7 = arg_52_0.candicateSpweapons

	CompareFuncs = var_52_3

	var_52_6(var_52_7, var_52_3(var_3.sortFunc(var_3.sort[1], var_52_5)))

	local var_52_8 = arg_52_0.leftPanelItemRect

	var_5.align(var_52_8, #arg_52_0.candicateMaterials)

	if not arg_52_1 then
		local var_52_9 = arg_52_0.leftPanelEquipScrollComp

		var_5.SetTotalCount(var_52_9, #arg_52_0.candicateSpweapons)
	end

	setActive = var_5

	local var_52_10 = arg_52_0.leftPanelAutoSelectButton

	var_5(var_7.Find(var_52_10, "On"), not arg_52_0.ptMax)

	setActive = var_5

	local var_52_11 = arg_52_0.leftPanelAutoSelectButton

	var_5(var_7.Find(var_52_11, "Off"), arg_52_0.ptMax)

	setButtonEnabled = var_5

	var_5(arg_52_0.leftPanelAutoSelectButton, not arg_52_0.ptMax)

	local var_52_12 = #arg_52_0.consumeItems
	local var_52_13 = 0 < var_52_12

	setActive = var_6

	local var_52_14 = arg_52_0.leftPanelClearSelectButton

	var_6(var_8.Find(var_52_14, "On"), var_52_13)

	setActive = var_6

	local var_52_15 = arg_52_0.leftPanelClearSelectButton

	var_6(var_8.Find(var_52_15, "Off"), not var_52_13)

	setButtonEnabled = var_6

	var_6(arg_52_0.leftPanelClearSelectButton, var_52_13)

	return
end

function var_0_1.UpdateSelectMaterial(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0

	if not arg_55_0:GetSelectMaterial(arg_55_1) or not var_55_5.count then
		var_55_0 = 0
	end

	local var_55_1

	if not arg_55_0.itemVOs[arg_55_1] or not arg_55_0.itemVOs[arg_55_1].count then
		var_55_1 = 0
	end

	local var_55_5

	if arg_55_2 > 0 then
		local var_55_3

		if arg_55_0.ptMax then
			pg = var_55_3

			local var_55_2 = var_55_3.TipsMgr.GetInstance()

			var_55_3 = var_55_3.ShowTips
			i18n = var_1_10009

			var_55_3(var_55_2, var_1_10009("spweapon_tip_upgrade"))

			return true
		end

		math = var_55_3

		local var_55_4 = var_55_3.max(var_55_1 - var_55_0, 0)

		math = var_1_10007
		arg_55_2 = var_1_10007.min(arg_55_2, var_55_4)

		if 0 < arg_55_2 then
			if not var_55_5 then
				Item = var_1_10007
				var_55_5 = var_1_10007.New({
					count = 0,
					id = arg_55_1
				})
				table = var_1_10007

				var_1_10007.insert(arg_55_0.consumeItems, var_55_5)
			end

			var_55_5.count = var_55_5.count + arg_55_2
		end

		if var_55_1 <= var_55_0 + arg_55_2 then
			return true
		end
	elseif arg_55_2 < 0 then
		local var_55_6 = -var_55_0

		math = var_1_10007

		if var_1_10007.max(arg_55_2, var_55_6) < 0 and var_55_5 then
			var_55_5.count = var_55_5.count + arg_55_2

			if var_55_5.count <= 0 then
				table = var_7

				var_7.removebyvalue(arg_55_0.consumeItems, var_55_5)
			end
		end

		if var_55_0 + arg_55_2 <= 0 then
			return true
		end
	end

	return
end

function var_0_1.GetSelectMaterial(arg_56_0, arg_56_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_56_0.consumeItems, function(arg_57_0)
		return arg_57_0.id == arg_56_1
	end)
end

function var_0_1.GetSelectSpWeapon(arg_58_0, arg_58_1)
	table = var_1_10002

	if var_1_10002.contains(arg_58_0.consumeSpweapons, arg_58_1) then
		return arg_58_1
	end

	return
end

function var_0_1.ClearSelectMaterials(arg_59_0)
	table = var_1_10001

	var_1_10001.clear(arg_59_0.consumeItems)

	table = var_1

	var_1.clear(arg_59_0.consumeSpweapons)

	return
end

function var_0_1.willExit(arg_60_0)
	pg = var_1_10001

	local var_60_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_60_0, arg_60_0._tf)

	ClearLScrollrect = var_1

	var_1(arg_60_0.leftPanelEquipScrollComp)

	local var_60_1 = arg_60_0.loader

	var_1.Clear(var_60_1)

	return
end

return var_0_1
