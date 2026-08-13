class = var_0_10000

local var_0_0 = "WorldInventoryLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

require = var_0_0

local var_0_2 = var_0_0("view.equipment.EquipmentSortCfg")

var_0_1.PAGE = {
	Equipment = 2,
	Property = 1,
	Material = 3
}

function var_0_1.getUIName(arg_1_0)
	return "WorldInventoryUI"
end

function var_0_1.init(arg_2_0)
	function arg_2_0.itemUpdateListenerFunc(...)
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.setItemList
		local var_3_2 = arg_2_0.inventoryProxy

		var_3_1(var_3_0, var_2.GetItemList(var_3_2))

		return
	end

	local var_2_0 = arg_2_0._tf

	arg_2_0.blurPanel = var_1.Find(var_2_0, "adapt/blur_panel")

	local var_2_1 = arg_2_0.blurPanel

	arg_2_0.backBtn = var_1.Find(var_2_1, "adapt/top/back_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.topItems = var_1.Find(var_2_2, "adapt/topItems")

	local var_2_3 = arg_2_0._tf

	arg_2_0.itemView = var_1.Find(var_2_3, "adapt/item_scrollview")

	local var_2_4 = arg_2_0._tf

	arg_2_0.equipmentView = var_1.Find(var_2_4, "adapt/equipment_scrollview")

	local var_2_5 = arg_2_0._tf

	arg_2_0.materialtView = var_1.Find(var_2_5, "adapt/material_scrollview")

	local var_2_6

	getProxy = var_2_5
	SettingsProxy = var_3

	local var_2_7 = var_2_5(var_3)

	NotchAdapt = var_3

	if var_3.CheckNotchRatio == 2 or not var_2_7:CheckLargeScreen() then
		var_2_6 = arg_2_0.itemView.rect.width > 2000
	else
		NotchAdapt = var_3
		var_2_6 = var_3.CheckNotchRatio >= 2
	end

	local var_2_8 = arg_2_0.itemView
	local var_2_9 = var_3.Find(var_2_8, "Viewport/item_grid")
	local var_2_10 = var_3.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10006
	var_2_10(var_2_9, var_5(var_1_10006)).constraintCount = var_2_6 and 8 or 7

	local var_2_11 = arg_2_0.equipmentView
	local var_2_12 = var_4.Find(var_2_11, "Viewport/moudle_grid")
	local var_2_13 = var_4.GetComponent

	typeof = var_6
	GridLayoutGroup = var_1_10007
	var_2_13(var_2_12, var_6(var_1_10007)).constraintCount = var_2_6 and 8 or 7

	local var_2_14 = arg_2_0.materialtView
	local var_2_15 = var_5.Find(var_2_14, "Viewport/item_grid")
	local var_2_16 = var_5.GetComponent

	typeof = var_7
	GridLayoutGroup = var_1_10008
	var_2_16(var_2_15, var_7(var_1_10008)).constraintCount = var_2_6 and 8 or 7
	ItemUsagePanel = var_6

	local var_2_17 = var_6.New
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_7.Find(var_2_18, "adapt/item_usage_panel")
	local var_2_20 = arg_2_0._tf

	arg_2_0.itemUsagePanel = var_2_17(var_2_19, var_8.Find(var_2_20, "adapt"))
	ItemResetPanel = var_6

	local var_2_21 = var_6.New
	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_7.Find(var_2_22, "adapt/reset_info_panel")
	local var_2_24 = arg_2_0._tf

	arg_2_0.itemResetPanel = var_2_21(var_2_23, var_8.Find(var_2_24, "adapt"))
	WorldAssignedItemView = var_6

	local var_2_25 = var_6.New
	local var_2_26 = arg_2_0._tf

	arg_2_0.assignedItemView = var_2_25(var_7.Find(var_2_26, "adapt"), arg_2_0.event)
	arg_2_0.itemCards = {}
	arg_2_0.equipmetItems = {}
	arg_2_0.materialCards = {}

	local var_2_27 = arg_2_0.topItems

	arg_2_0._itemToggle = var_6.Find(var_2_27, "bottom_back/types/properties")

	local var_2_28 = arg_2_0.topItems

	arg_2_0._weaponToggle = var_6.Find(var_2_28, "bottom_back/types/siren_weapon")

	local var_2_29 = arg_2_0.topItems

	arg_2_0._materialToggle = var_6.Find(var_2_29, "bottom_back/types/material")

	local var_2_30 = arg_2_0.topItems

	arg_2_0.exchangeTips = var_6.Find(var_2_30, "bottom_back/reset_exchange")
	setText = var_6

	local var_2_31 = arg_2_0.topItems
	local var_2_32 = var_7.Find(var_2_31, "bottom_back/reset_exchange/Text")

	i18n = var_2_31

	var_6(var_2_32, var_2_31("world_inventory_tip"))

	local var_2_33 = arg_2_0.blurPanel

	arg_2_0.filterBusyToggle = var_6.Find(var_2_33, "adapt/left_length/frame/toggle_equip")

	local var_2_34 = arg_2_0.blurPanel

	arg_2_0.sortBtn = var_6.Find(var_2_34, "adapt/top/buttons/sort_button")

	local var_2_35 = arg_2_0.blurPanel

	arg_2_0.indexBtn = var_6.Find(var_2_35, "adapt/top/buttons/index_button")

	local var_2_36 = arg_2_0.blurPanel

	arg_2_0.decBtn = var_6.Find(var_2_36, "adapt/top/buttons/dec_btn")

	local var_2_37 = arg_2_0.decBtn

	arg_2_0.upOrderTF = var_6.Find(var_2_37, "asc")

	local var_2_38 = arg_2_0.decBtn

	arg_2_0.downOrderTF = var_6.Find(var_2_38, "desc")

	local var_2_39 = arg_2_0.topItems

	arg_2_0.sortPanel = var_6.Find(var_2_39, "sort")

	local var_2_40 = arg_2_0.sortPanel

	arg_2_0.sortContain = var_6.Find(var_2_40, "adapt/mask/panel")

	local var_2_41 = arg_2_0.sortContain

	arg_2_0.sortTpl = var_6.Find(var_2_41, "tpl")
	setActive = var_6

	var_6(arg_2_0.sortTpl, false)
	arg_2_0:initData()
	arg_2_0:addListener()

	print = var_6

	local var_2_42 = arg_2_0._tf

	var_6(var_7.Find(var_2_42, "bg").rect.width)

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:initItems()
	arg_4_0:initEquipments()
	arg_4_0:InitMaterials()

	setActive = var_1

	var_1(arg_4_0._weaponToggle, true)

	setActive = var_1

	var_1(arg_4_0._itemToggle, true)

	local var_4_0 = arg_4_0.contextData.pageNum

	arg_4_0.contextData.pageNum = nil

	if var_4_0 == var_0_1.PAGE.Property then
		triggerToggle = var_2

		var_2(arg_4_0._itemToggle, true)
	elseif var_4_0 == var_0_1.PAGE.Equipment then
		triggerToggle = var_2

		var_2(arg_4_0._weaponToggle, true)
	elseif var_4_0 == var_0_1.PAGE.Material then
		triggerToggle = var_2

		var_2(arg_4_0._materialToggle, true)
	end

	if arg_4_0.contextData.equipScrollPos then
		arg_4_0:ScrollEquipPos(arg_4_0.contextData.equipScrollPos.y)
	end

	onButton = var_2

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.exchangeTips
	local var_4_3 = var_4.Find(var_4_2, "capcity")

	local function var_4_4()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit
		local var_5_2 = var_0_1.ON_DROP
		local var_5_3 = {}

		DROP_TYPE_RESOURCE = var_2_10004
		var_5_3.type = var_2_10004
		WorldConst = var_2_10004
		var_5_3.id = var_2_10004.ResourceID

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end

	SFX_PANEL = var_6

	var_2(var_4_1, var_4_3, var_4_4, var_6)
	arg_4_0:OverlayPanel(arg_4_0._tf)

	return
end

function var_0_1.onBackPressed(arg_6_0)
	print = var_1_10001

	local var_6_0 = arg_6_0._tf

	var_1_10001(var_2.Find(var_6_0, "bg").rect.width)

	isActive = var_1_10001

	if var_1_10001(arg_6_0.itemResetPanel._go) then
		local var_6_1 = arg_6_0.itemResetPanel

		var_1.Close(var_6_1)
	else
		isActive = var_1

		if var_1(arg_6_0.itemUsagePanel._go) then
			local var_6_2 = arg_6_0.itemUsagePanel

			var_1.Close(var_6_2)
		else
			local var_6_3 = arg_6_0.assignedItemView

			if var_1.isShowing(var_6_3) then
				local var_6_4 = arg_6_0.assignedItemView

				var_1.Hide(var_6_4)
			else
				pg = var_1

				local var_6_5 = var_1.CriMgr.GetInstance()
				local var_6_6 = var_1.PlaySoundEffect_V3

				SFX_CANCEL = var_6_0

				var_6_6(var_6_5, var_6_0)

				triggerButton = var_6_6

				var_6_6(arg_6_0.backBtn)
			end
		end
	end

	return
end

function var_0_1.willExit(arg_7_0)
	local var_7_0 = arg_7_0.assignedItemView

	var_1.Destroy(var_7_0)

	local var_7_1 = arg_7_0.inventoryProxy
	local var_7_2 = var_1.RemoveListener

	WorldInventoryProxy = var_1_10003

	var_7_2(var_7_1, var_1_10003.EventUpdateItem, arg_7_0.itemUpdateListenerFunc)
	arg_7_0:UnOverlayPanel(arg_7_0._tf)

	return
end

function var_0_1.initData(arg_8_0)
	local var_8_0 = arg_8_0.contextData
	local var_8_1

	if not arg_8_0.contextData.pageNum then
		var_8_1 = var_0_1.PAGE.Property
	end

	var_8_0.pageNum = var_8_1

	local var_8_2 = arg_8_0.contextData
	local var_8_3

	if not arg_8_0.contextData.asc then
		var_8_3 = false
	end

	var_8_2.asc = var_8_3

	if not arg_8_0.contextData.sortData then
		arg_8_0.contextData.sortData = var_0_2.sort[1]
	end

	local var_8_4 = arg_8_0.contextData
	local var_8_5

	if not arg_8_0.contextData.indexDatas then
		var_8_5 = {}
	end

	var_8_4.indexDatas = var_8_5
	arg_8_0.isEquipingOn = false

	return
end

function var_0_1.GetShowBusyFlag(arg_9_0)
	return arg_9_0.isEquipingOn
end

function var_0_1.SetShowBusyFlag(arg_10_0, arg_10_1)
	arg_10_0.isEquipingOn = arg_10_1

	return
end

function var_0_1.addListener(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.backBtn

	local function var_11_2()
		print = var_2_10000

		local var_12_0 = arg_11_0._tf

		var_2_10000(var_1.Find(var_12_0, "bg").rect.width)

		local var_12_1 = arg_11_0

		var_0.closeView(var_12_1)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_11_0, var_11_1, var_11_2, var_1_10005)

	onButton = var_1_10001

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.decBtn

	local function var_11_5()
		arg_11_0.contextData.asc = not arg_11_0.contextData.asc

		if arg_11_0.contextData.pageNum == var_0_1.PAGE.Equipment then
			local var_13_0 = arg_11_0

			var_0.filterEquipment(var_13_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_11_3, var_11_4, var_11_5, var_1_10005)

	arg_11_0.sortButtons = {}
	eachChild = var_1

	var_1(arg_11_0.sortContain, function(arg_14_0)
		setActive = var_2_10001

		var_2_10001(arg_14_0, false)

		return
	end)

	ipairs = var_1

	for iter_11_0, iter_11_1 in var_1(var_0_2.sort) do
		if iter_11_0 <= arg_11_0.sortContain.childCount then
			var_1_10007 = arg_11_0.sortContain

			local var_11_6

			if not var_11_6.GetChild(var_1_10007, iter_11_0 - 1) then
				cloneTplTo = var_11_6
				var_11_6 = var_11_6(arg_11_0.sortTpl, arg_11_0.sortContain)
			end

			setActive = var_1_10007

			var_1_10007(var_11_6, true)

			setImageSprite = var_1_10007
			findTF = var_8

			local var_11_7 = var_8(var_11_6, "Image")

			GetSpriteFromAtlas = var_9

			var_1_10007(var_11_7, var_9("ui/equipmentui_atlas", iter_11_1.spr), true)

			onToggle = var_1_10007

			local var_11_8 = arg_11_0
			local var_11_9 = var_11_6

			local function var_11_10(arg_15_0)
				if arg_15_0 then
					arg_11_0.contextData.sortData = iter_11_1

					local var_15_0 = arg_11_0

					var_1.filterEquipment(var_15_0)

					triggerToggle = var_1

					var_1(arg_11_0.sortBtn, false)
				end

				return
			end

			SFX_PANEL = var_11

			var_1_10007(var_11_8, var_11_9, var_11_10, var_11)

			var_1_10007 = arg_11_0.sortButtons
			var_1_10007[iter_11_0] = var_11_6
		end
	end

	onToggle = var_1

	local var_11_11 = arg_11_0
	local var_11_12 = arg_11_0.sortBtn

	local function var_11_13(arg_16_0)
		if arg_16_0 then
			local var_16_0 = arg_11_0

			var_1.OverlayPanel(var_16_0, arg_11_0.sortPanel)

			setActive = var_1

			var_1(arg_11_0.sortPanel, true)
		else
			local var_16_1 = arg_11_0

			var_1.UnOverlayPanel(var_16_1, arg_11_0.sortPanel, arg_11_0.topItems)

			setActive = var_1

			var_1(arg_11_0.sortPanel, false)
		end

		return
	end

	SFX_PANEL = iter_11_1

	var_1(var_11_11, var_11_12, var_11_13, iter_11_1)

	onButton = var_1

	local var_11_14 = arg_11_0
	local var_11_15 = arg_11_0.sortPanel

	local function var_11_16()
		triggerToggle = var_2_10000

		var_2_10000(arg_11_0.sortBtn, false)

		return
	end

	SFX_PANEL = iter_11_1

	var_1(var_11_14, var_11_15, var_11_16, iter_11_1)

	onToggle = var_1

	local var_11_17 = arg_11_0
	local var_11_18 = arg_11_0.filterBusyToggle

	local function var_11_19(arg_18_0)
		local var_18_0 = arg_11_0

		var_1.SetShowBusyFlag(var_18_0, arg_18_0)

		if arg_11_0.contextData.pageNum == var_0_1.PAGE.Equipment then
			local var_18_1 = arg_11_0

			var_1.filterEquipment(var_18_1)
		end

		return
	end

	SFX_PANEL = iter_11_1

	var_1(var_11_17, var_11_18, var_11_19, iter_11_1)

	onButton = var_1

	local var_11_20 = arg_11_0
	local var_11_21 = arg_11_0.indexBtn

	local function var_11_22()
		local var_19_0 = {}

		Clone = var_2_10001
		var_19_0.indexDatas = var_2_10001(arg_11_0.contextData.indexDatas)

		local var_19_1 = {
			minHeight = 650
		}
		local var_19_2 = {}

		CustomIndexLayer = var_2_10003
		var_19_2.mode = var_2_10003.Mode.OR
		IndexConst = var_3
		var_19_2.options = var_3.EquipmentTypeIndexs
		IndexConst = var_3
		var_19_2.names = var_3.EquipmentTypeNames
		var_19_1.typeIndex = var_19_2

		local var_19_3 = {}

		CustomIndexLayer = var_3
		var_19_3.mode = var_3.Mode.OR
		IndexConst = var_3
		var_19_3.options = var_3.EquipPropertyIndexs
		IndexConst = var_3
		var_19_3.names = var_3.EquipPropertyNames
		var_19_1.equipPropertyIndex = var_19_3

		local var_19_4 = {}

		CustomIndexLayer = var_3
		var_19_4.mode = var_3.Mode.OR
		IndexConst = var_3
		var_19_4.options = var_3.EquipPropertyIndexs
		IndexConst = var_3
		var_19_4.names = var_3.EquipPropertyNames
		var_19_1.equipPropertyIndex2 = var_19_4

		local var_19_5 = {}

		CustomIndexLayer = var_3
		var_19_5.mode = var_3.Mode.OR
		IndexConst = var_3
		var_19_5.options = var_3.EquipAmmoIndexs_1
		IndexConst = var_3
		var_19_5.names = var_3.EquipAmmoIndexs_1_Names
		var_19_1.equipAmmoIndex1 = var_19_5

		local var_19_6 = {}

		CustomIndexLayer = var_3
		var_19_6.mode = var_3.Mode.OR
		IndexConst = var_3
		var_19_6.options = var_3.EquipAmmoIndexs_2
		IndexConst = var_3
		var_19_6.names = var_3.EquipAmmoIndexs_2_Names
		var_19_1.equipAmmoIndex2 = var_19_6

		local var_19_7 = {}

		CustomIndexLayer = var_3
		var_19_7.mode = var_3.Mode.AND
		IndexConst = var_3
		var_19_7.options = var_3.EquipCampIndexs
		IndexConst = var_3
		var_19_7.names = var_3.EquipCampNames
		var_19_1.equipCampIndex = var_19_7

		local var_19_8 = {}

		CustomIndexLayer = var_3
		var_19_8.mode = var_3.Mode.AND
		IndexConst = var_3
		var_19_8.options = var_3.EquipmentRarityIndexs
		IndexConst = var_3
		var_19_8.names = var_3.RarityNames
		var_19_1.rarityIndex = var_19_8

		local var_19_9 = {}

		CustomIndexLayer = var_3
		var_19_9.mode = var_3.Mode.OR
		IndexConst = var_3
		var_19_9.options = var_3.EquipmentExtraIndexs
		IndexConst = var_3
		var_19_9.names = var_3.EquipmentExtraNames
		var_19_1.extraIndex = var_19_9
		var_19_0.customPanels = var_19_1
		var_19_0.groupList = {
			{
				dropdown = false,
				titleENTxt = "indexsort_typeeng",
				titleTxt = "indexsort_type",
				tags = {
					"typeIndex"
				}
			},
			{
				dropdown = true,
				titleENTxt = "indexsort_indexeng",
				titleTxt = "indexsort_index",
				tags = {
					"equipPropertyIndex",
					"equipPropertyIndex2",
					"equipAmmoIndex1",
					"equipAmmoIndex2"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_campeng",
				titleTxt = "indexsort_camp",
				tags = {
					"equipCampIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_rarityeng",
				titleTxt = "indexsort_rarity",
				tags = {
					"rarityIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_indexeng",
				titleTxt = "indexsort_extraindex",
				tags = {
					"extraIndex"
				}
			}
		}

		local var_19_10 = {}
		local var_19_11 = {}
		local var_19_12 = {}

		IndexConst = var_2_10004
		var_19_12.typeIndex = var_2_10004.EquipmentTypeAll
		var_19_11.include = var_19_12
		var_19_11.exclude = {}
		var_19_10.equipPropertyIndex = var_19_11

		local var_19_13 = {}
		local var_19_14 = {}

		IndexConst = var_4
		var_19_14.typeIndex = var_4.EquipmentTypeEquip
		var_19_13.include = var_19_14

		local var_19_15 = {}

		IndexConst = var_4
		var_19_15.typeIndex = var_4.EquipmentTypeAll
		var_19_13.exclude = var_19_15
		var_19_10.equipPropertyIndex2 = var_19_13

		local var_19_16 = {}
		local var_19_17 = {}

		IndexConst = var_4

		local var_19_18 = var_4.BitAll
		local var_19_19 = {}

		IndexConst = var_2_10006
		var_19_19[1] = var_2_10006.EquipmentTypeSmallCannon
		IndexConst = var_6
		var_19_19[2] = var_6.EquipmentTypeMediumCannon
		IndexConst = var_6
		var_19_19[3] = var_6.EquipmentTypeBigCannon
		var_19_17.typeIndex = var_19_18(var_19_19)
		var_19_16.include = var_19_17

		local var_19_20 = {}

		IndexConst = var_4
		var_19_20.typeIndex = var_4.EquipmentTypeAll
		var_19_16.exclude = var_19_20
		var_19_10.equipAmmoIndex1 = var_19_16

		local var_19_21 = {}
		local var_19_22 = {}

		IndexConst = var_4

		local var_19_23 = var_4.BitAll
		local var_19_24 = {}

		IndexConst = var_6
		var_19_24[1] = var_6.EquipmentTypeWarshipTorpedo
		IndexConst = var_6
		var_19_24[2] = var_6.EquipmentTypeSubmaraineTorpedo
		var_19_22.typeIndex = var_19_23(var_19_24)
		var_19_21.include = var_19_22

		local var_19_25 = {}

		IndexConst = var_4
		var_19_25.typeIndex = var_4.EquipmentTypeAll
		var_19_21.exclude = var_19_25
		var_19_10.equipAmmoIndex2 = var_19_21
		var_19_0.dropdownLimit = var_19_10

		function var_19_0.callback(arg_20_0)
			arg_11_0.contextData.indexDatas.typeIndex = arg_20_0.typeIndex
			arg_11_0.contextData.indexDatas.equipPropertyIndex = arg_20_0.equipPropertyIndex
			arg_11_0.contextData.indexDatas.equipPropertyIndex2 = arg_20_0.equipPropertyIndex2
			arg_11_0.contextData.indexDatas.equipAmmoIndex1 = arg_20_0.equipAmmoIndex1
			arg_11_0.contextData.indexDatas.equipAmmoIndex2 = arg_20_0.equipAmmoIndex2
			arg_11_0.contextData.indexDatas.equipCampIndex = arg_20_0.equipCampIndex
			arg_11_0.contextData.indexDatas.rarityIndex = arg_20_0.rarityIndex
			arg_11_0.contextData.indexDatas.extraIndex = arg_20_0.extraIndex

			local var_20_0 = arg_11_0.filterBusyToggle
			local var_20_1 = var_1.GetComponent

			typeof = var_3_10003
			Toggle = var_3_10004

			if var_20_1(var_20_0, var_3_10003(var_3_10004)) then
				bit = var_20_0

				local var_20_2 = var_20_0.band
				local var_20_3 = arg_20_0.extraIndex

				IndexConst = var_3_10004

				if var_20_2(var_20_3, var_3_10004.EquipmentExtraEquiping) > 0 then
					local var_20_4 = arg_11_0

					var_2.SetShowBusyFlag(var_20_4, true)
				end

				triggerToggle = var_2

				local var_20_5 = arg_11_0.filterBusyToggle
				local var_20_6 = arg_11_0

				var_2(var_20_5, var_4.GetShowBusyFlag(var_20_6))
			else
				local var_20_7 = arg_11_0

				var_2.filterEquipment(var_20_7)
			end

			return
		end

		local var_19_26 = arg_11_0
		local var_19_27 = var_1.emit

		WorldInventoryMediator = var_19_25

		var_19_27(var_19_26, var_19_25.OPEN_EQUIPMENT_INDEX, var_19_0)

		return
	end

	SFX_PANEL = iter_11_1

	var_1(var_11_20, var_11_21, var_11_22, iter_11_1)

	onToggle = var_1

	local var_11_23 = arg_11_0
	local var_11_24 = arg_11_0._itemToggle

	local function var_11_25(arg_21_0)
		if arg_21_0 and arg_11_0.contextData.pageNum ~= var_0_1.PAGE.Property then
			arg_11_0.contextData.pageNum = var_0_1.PAGE.Property

			local var_21_0 = arg_11_0

			var_1.activeResetExchange(var_21_0, arg_11_0.contextData.pageNum == var_0_1.PAGE.Property)

			local var_21_1 = arg_11_0

			var_1.sortItems(var_21_1)
		end

		return
	end

	SFX_PANEL = iter_11_1

	var_1(var_11_23, var_11_24, var_11_25, iter_11_1)

	onToggle = var_1

	local var_11_26 = arg_11_0
	local var_11_27 = arg_11_0._weaponToggle

	local function var_11_28(arg_22_0)
		if arg_22_0 and arg_11_0.contextData.pageNum ~= var_0_1.PAGE.Equipment then
			arg_11_0.contextData.pageNum = var_0_1.PAGE.Equipment

			local var_22_0 = arg_11_0

			var_1.activeResetExchange(var_22_0, arg_11_0.contextData.pageNum == var_0_1.PAGE.Property)

			local var_22_1 = arg_11_0

			var_1.filterEquipment(var_22_1)
		end

		return
	end

	SFX_PANEL = iter_11_1

	var_1(var_11_26, var_11_27, var_11_28, iter_11_1)

	onToggle = var_1

	local var_11_29 = arg_11_0
	local var_11_30 = arg_11_0._materialToggle

	local function var_11_31(arg_23_0)
		if arg_23_0 and arg_11_0.contextData.pageNum ~= var_0_1.PAGE.Material then
			arg_11_0.contextData.pageNum = var_0_1.PAGE.Material

			local var_23_0 = arg_11_0

			var_1.activeResetExchange(var_23_0, arg_11_0.contextData.pageNum == var_0_1.PAGE.Property)

			local var_23_1 = arg_11_0

			var_1.SortMaterials(var_23_1)
		end

		return
	end

	SFX_PANEL = iter_11_1

	var_1(var_11_29, var_11_30, var_11_31, iter_11_1)

	return
end

function var_0_1.setWorldFleet(arg_24_0, arg_24_1)
	arg_24_0.worldFleetList = arg_24_1

	return
end

function var_0_1.setInventoryProxy(arg_25_0, arg_25_1)
	arg_25_0.inventoryProxy = arg_25_1

	local var_25_0 = arg_25_0.inventoryProxy
	local var_25_1 = var_2.AddListener

	WorldInventoryProxy = var_1_10004

	var_25_1(var_25_0, var_1_10004.EventUpdateItem, arg_25_0.itemUpdateListenerFunc)

	local var_25_2 = arg_25_0
	local var_25_3 = arg_25_0.setItemList
	local var_25_4 = arg_25_0.inventoryProxy

	var_25_3(var_25_2, var_4.GetItemList(var_25_4))

	return
end

function var_0_1.setItemList(arg_26_0, arg_26_1)
	arg_26_0.itemList = arg_26_1

	if arg_26_0.isInitItems then
		arg_26_0:sortItems()
	end

	return
end

function var_0_1.initItems(arg_27_0)
	arg_27_0.isInitItems = true

	local var_27_0 = arg_27_0.itemView

	arg_27_0.itemRect = var_1.GetComponent(var_27_0, "LScrollRect")

	function arg_27_0.itemRect.onInitItem(arg_28_0)
		local var_28_0 = arg_27_0

		var_1.initItem(var_28_0, arg_28_0)

		return
	end

	function arg_27_0.itemRect.onUpdateItem(arg_29_0, arg_29_1)
		local var_29_0 = arg_27_0

		var_2.updateItem(var_29_0, arg_29_0, arg_29_1)

		return
	end

	function arg_27_0.itemRect.onReturnItem(arg_30_0, arg_30_1)
		local var_30_0 = arg_27_0

		var_2.returnItem(var_30_0, arg_30_0, arg_30_1)

		return
	end

	return
end

function var_0_1.initItem(arg_31_0, arg_31_1)
	WSInventoryItem = var_1_10002

	local var_31_0 = var_1_10002.New(arg_31_1)

	onButton = var_3

	local var_31_1 = arg_31_0
	local var_31_2 = var_31_0.go

	local function var_31_3()
		local var_32_0 = var_31_0.itemVO
		local var_32_1 = var_0.getWorldItemType(var_32_0)

		WorldItem = var_32_0

		if var_32_1 ~= var_32_0.UsageBuff then
			WorldItem = var_32_3

			if var_32_1 ~= var_32_3.UsageHPRegenerate then
				WorldItem = var_32_3

				local var_32_3

				if var_32_1 == var_32_3.UsageHPRegenerateValue then
					local var_32_2 = arg_31_0

					var_32_3 = var_32_3.emit
					WorldInventoryMediator = var_2_10003

					var_32_3(var_32_2, var_2_10003.OnOpenAllocateLayer, {
						itemVO = var_31_0.itemVO,
						fleetList = arg_31_0.worldFleetList,
						fleetIndex = arg_31_0.contextData.currentFleetIndex,
						confirmCallback = function(arg_33_0, arg_33_1)
							local var_33_0 = arg_31_0
							local var_33_1 = var_2.emit

							WorldInventoryMediator = var_3_10004

							var_33_1(var_33_0, var_3_10004.OnUseItem, arg_33_0, 1, arg_33_1)

							return
						end,
						onResetInfo = function(arg_34_0)
							local var_34_0 = arg_31_0.itemResetPanel

							var_1.Open(var_34_0, arg_34_0)

							return
						end
					})

					goto label_32_0
				end

				WorldItem = var_32_3

				local var_32_5

				if var_32_1 == var_32_3.UsageWorldMap then
					local var_32_4 = arg_31_0.itemUsagePanel

					var_32_5 = var_32_5.Open

					local var_32_6 = {
						item = var_31_0.itemVO
					}

					ItemUsagePanel = var_4
					var_32_6.mode = var_4.SEE

					function var_32_6.onUse()
						local var_35_0 = arg_31_0
						local var_35_1 = var_0.PlayOpenBox
						local var_35_2 = var_31_0.itemVO

						var_35_1(var_35_0, var_2.getWorldItemOpenDisplay(var_35_2), function()
							local var_36_0 = arg_31_0
							local var_36_1 = var_0.emit

							WorldInventoryMediator = var_4_10002

							var_36_1(var_36_0, var_4_10002.OnMap, var_31_0.itemVO.id)

							local var_36_2 = arg_31_0

							var_0.closeView(var_36_2)

							return
						end)

						return
					end

					function var_32_6.onResetInfo(arg_37_0)
						local var_37_0 = arg_31_0.itemResetPanel

						var_1.Open(var_37_0, arg_37_0)

						return
					end

					var_32_5(var_32_4, var_32_6)

					goto label_32_0
				end

				WorldItem = var_32_5

				if var_32_1 ~= var_32_5.UsageDrop then
					WorldItem = var_32_8

					if var_32_1 ~= var_32_8.UsageRecoverAp then
						WorldItem = var_32_8

						if var_32_1 ~= var_32_8.UsageWorldItem then
							WorldItem = var_32_8

							local var_32_8

							if var_32_1 == var_32_8.UsageWorldBuff then
								local var_32_7 = arg_31_0.itemUsagePanel

								var_32_8 = var_32_8.Open

								local var_32_9 = {
									item = var_31_0.itemVO
								}

								ItemUsagePanel = var_4
								var_32_9.mode = var_4.BATCH

								function var_32_9.onUseBatch(arg_38_0)
									local var_38_0 = arg_31_0
									local var_38_1 = var_1.emit

									WorldInventoryMediator = var_3_10003

									var_38_1(var_38_0, var_3_10003.OnUseItem, var_31_0.itemVO.id, arg_38_0, {})

									return
								end

								function var_32_9.onUseOne()
									local var_39_0 = arg_31_0
									local var_39_1 = var_0.emit

									WorldInventoryMediator = var_3_10002

									var_39_1(var_39_0, var_3_10002.OnUseItem, var_31_0.itemVO.id, 1, {})

									return
								end

								function var_32_9.onResetInfo(arg_40_0)
									local var_40_0 = arg_31_0.itemResetPanel

									var_1.Open(var_40_0, arg_40_0)

									return
								end

								var_32_8(var_32_7, var_32_9)

								goto label_32_0
							end

							WorldItem = var_32_8

							local var_32_11

							if var_32_1 == var_32_8.UsageLoot then
								local var_32_10 = arg_31_0.itemUsagePanel

								var_32_11 = var_32_11.Open

								local var_32_12 = {
									item = var_31_0.itemVO
								}

								ItemUsagePanel = var_4
								var_32_12.mode = var_4.INFO

								function var_32_12.onResetInfo(arg_41_0)
									local var_41_0 = arg_31_0.itemResetPanel

									var_1.Open(var_41_0, arg_41_0)

									return
								end

								var_32_11(var_32_10, var_32_12)

								goto label_32_0
							end

							WorldItem = var_32_11

							if var_32_1 ~= var_32_11.UsageWorldClean then
								WorldItem = var_1

								if var_32_1 == var_1.UsageWorldFlag then
									local var_32_13 = arg_31_0.itemUsagePanel

									var_1.Open(var_32_13, {
										item = var_31_0.itemVO,
										onUse = function()
											local var_42_0 = arg_31_0
											local var_42_1 = var_0.emit

											WorldInventoryMediator = var_3_10002

											var_42_1(var_42_0, var_3_10002.OnUseItem, var_31_0.itemVO.id, 1, {})

											return
										end,
										onResetInfo = function(arg_43_0)
											local var_43_0 = arg_31_0.itemResetPanel

											var_1.Open(var_43_0, arg_43_0)

											return
										end
									})
								else
									WorldItem = var_1

									if var_32_1 == var_1.UsageDropAppointed then
										local var_32_14 = arg_31_0.assignedItemView

										var_1.Load(var_32_14)

										local var_32_15 = arg_31_0.assignedItemView

										var_1.ActionInvoke(var_32_15, "update", var_31_0.itemVO)

										local var_32_16 = arg_31_0.assignedItemView

										var_1.ActionInvoke(var_32_16, "Show")
									end
								end

								::label_32_0::

								return
							end
						end
					end
				end
			end
		end
	end

	SFX_PANEL = var_1_10007

	var_3(var_31_1, var_31_2, var_31_3, var_1_10007)

	arg_31_0.itemCards[arg_31_1] = var_31_0

	return
end

function var_0_1.updateItem(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0

	if not arg_44_0.itemCards[arg_44_2] then
		arg_44_0:initItem(arg_44_2)

		var_44_0 = arg_44_0.itemCards[arg_44_2]
	end

	local var_44_1 = arg_44_0.itemList[arg_44_1 + 1]

	var_44_0:update(var_44_1)

	return
end

function var_0_1.returnItem(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0.exited then
		return
	end

	if arg_45_0.itemCards[arg_45_2] then
		var_3:clear()
	end

	return
end

function var_0_1.sortItems(arg_46_0)
	table = var_1_10001

	local var_46_0 = var_1_10001.sort
	local var_46_1 = arg_46_0.itemList

	CompareFuncs = var_1_10003

	var_46_0(var_46_1, var_1_10003({
		function(arg_47_0)
			return -arg_47_0:getConfig("sort_priority")
		end,
		function(arg_48_0)
			return arg_48_0:getConfig("id")
		end
	}))

	local var_46_2 = arg_46_0.itemRect

	var_1.SetTotalCount(var_46_2, #arg_46_0.itemList, -1)
	arg_46_0:updateResetExchange()

	return
end

function var_0_1.updateResetExchange(arg_49_0)
	local var_49_0 = arg_49_0.inventoryProxy
	local var_49_1 = var_1.CalcResetExchangeResource(var_49_0)

	setText = var_49_0

	local var_49_2 = arg_49_0.exchangeTips
	local var_49_3 = var_3.Find(var_49_2, "capcity/Text")

	defaultValue = var_49_2
	checkExist = var_5

	local var_49_4 = var_49_1
	local var_49_5 = {}

	DROP_TYPE_RESOURCE = var_1_10008
	var_49_5[1] = var_1_10008

	local var_49_6 = {}

	WorldConst = var_1_10009
	var_49_6[1] = var_1_10009.ResourceID

	var_49_0(var_49_3, var_49_2(var_5(var_49_4, var_49_5, var_49_6), 0))

	return
end

function var_0_1.activeResetExchange(arg_50_0, arg_50_1)
	nowWorld = var_1_10002

	local var_50_0 = var_1_10002()
	local var_50_1 = var_2.IsSystemOpen

	WorldConst = var_1_10004

	local var_50_2 = var_50_1(var_50_0, var_1_10004.SystemResetExchange)

	setActive = var_50_0

	var_50_0(arg_50_0.exchangeTips, var_50_2 and arg_50_1)

	return
end

function var_0_1.PlayOpenBox(arg_51_0, arg_51_1, arg_51_2)
	if not arg_51_1 or arg_51_1 == "" then
		arg_51_2()

		return
	end

	local function var_51_0()
		if arg_51_0.playing or not arg_51_0[arg_51_1] then
			return
		end

		arg_51_0.playing = true

		local var_52_0 = arg_51_0[arg_51_1]

		var_0.SetActive(var_52_0, true)

		tf = var_0

		local var_52_1 = var_0(arg_51_0[arg_51_1])
		local var_52_2 = var_0.SetParent
		local var_52_3 = arg_51_0._tf

		var_52_2(var_52_1, var_3.Find(var_52_3, "adapt"), false)
		var_0:SetAsLastSibling()

		local var_52_4 = var_0:GetComponent("DftAniEvent")

		var_1.SetTriggerEvent(var_52_4, function(arg_53_0)
			arg_51_2()

			return
		end)
		var_1:SetEndEvent(function(arg_54_0)
			if arg_51_0[arg_51_1] then
				SetActive = var_1

				var_1(arg_51_0[arg_51_1], false)

				arg_51_0.playing = false
			end

			return
		end)

		pg = var_2

		local var_52_5 = var_2.CriMgr.GetInstance()
		local var_52_6 = var_2.PlaySoundEffect_V3

		SFX_UI_EQUIPMENT_OPEN = var_4

		var_52_6(var_52_5, var_4)

		return
	end

	local var_51_1 = arg_51_0._tf

	if var_4.Find(var_51_1, arg_51_1 .. "(Clone)") then
		go = var_51_1
		arg_51_0[arg_51_1] = var_51_1(var_4)
	end

	if not arg_51_0[arg_51_1] then
		PoolMgr = var_5

		local var_51_2 = var_5.GetInstance()
		local var_51_3 = var_5.GetPrefab
		local var_51_4 = "ui/"

		string = var_1_10008

		var_51_3(var_51_2, var_51_4 .. var_1_10008.lower(arg_51_1), "", true, function(arg_55_0)
			arg_55_0:SetActive(true)

			arg_51_0[arg_51_1] = arg_55_0

			var_51_0()

			return
		end)
	else
		var_51_0()
	end

	return
end

function var_0_1.setEquipments(arg_56_0, arg_56_1)
	arg_56_0.equipmentVOs = arg_56_1

	return
end

function var_0_1.setEquipment(arg_57_0, arg_57_1)
	local var_57_0 = #arg_57_0.equipmentVOs + 1

	ipairs = var_1_10003

	for iter_57_0, iter_57_1 in var_1_10003(arg_57_0.equipmentVOs) do
		if not iter_57_1.shipId and iter_57_1.id == arg_57_1.id then
			var_57_0 = iter_57_0

			break
		end
	end

	local var_57_1

	if arg_57_1.count > 0 then
		var_57_1 = arg_57_0.equipmentVOs
		var_57_1[var_57_0] = arg_57_1
	else
		table = var_57_1

		var_57_1.remove(arg_57_0.equipmentVOs, var_57_0)
	end

	if arg_57_0.contextData.pageNum == var_0_1.PAGE.Equipment then
		arg_57_0:filterEquipment()
	end

	return
end

function var_0_1.initEquipments(arg_58_0)
	arg_58_0.isInitWeapons = true

	local var_58_0 = arg_58_0.equipmentView

	arg_58_0.equipmentRect = var_1.GetComponent(var_58_0, "LScrollRect")

	function arg_58_0.equipmentRect.onInitItem(arg_59_0)
		local var_59_0 = arg_58_0

		var_1.initEquipment(var_59_0, arg_59_0)

		return
	end

	function arg_58_0.equipmentRect.onUpdateItem(arg_60_0, arg_60_1)
		local var_60_0 = arg_58_0

		var_2.updateEquipment(var_60_0, arg_60_0, arg_60_1)

		return
	end

	function arg_58_0.equipmentRect.onReturnItem(arg_61_0, arg_61_1)
		local var_61_0 = arg_58_0

		var_2.returnEquipment(var_61_0, arg_61_0, arg_61_1)

		return
	end

	arg_58_0.equipmentRect.decelerationRate = 0.07

	return
end

function var_0_1.initEquipment(arg_62_0, arg_62_1)
	EquipmentItem = var_1_10002

	local var_62_0 = var_1_10002.New(arg_62_1)

	onButton = var_3

	local var_62_1 = arg_62_0
	local var_62_2 = var_62_0.go

	local function var_62_3()
		if arg_62_0.equipmentRect.GetContentAnchoredPositionOriginal then
			local var_63_0 = arg_62_0.contextData
			local var_63_1 = arg_62_0.equipmentRect

			var_63_0.equipScrollPos = var_2_10001.GetContentAnchoredPositionOriginal(var_63_1)
		end

		if var_62_0.equipmentVO == nil or var_62_0.equipmentVO.mask then
			return
		end

		if arg_62_0.shipVO then
			local var_63_2 = {}

			EquipmentInfoMediator = var_2_10001
			var_63_2.type = var_2_10001.TYPE_REPLACE
			var_63_2.equipmentId = var_62_0.equipmentVO.id
			var_63_2.shipId = arg_62_0.contextData.shipId
			var_63_2.pos = arg_62_0.contextData.pos
			var_63_2.oldShipId = var_62_0.equipmentVO.shipId
			var_63_2.oldPos = var_62_0.equipmentVO.shipPos

			if not var_63_2 then
				if var_62_0.equipmentVO.shipId then
					var_63_2 = {}
					EquipmentInfoMediator = var_2_10001
					var_63_2.type = var_2_10001.TYPE_DISPLAY
					var_63_2.equipmentId = var_62_0.equipmentVO.id
					var_63_2.shipId = var_62_0.equipmentVO.shipId
					var_63_2.pos = var_62_0.equipmentVO.shipPos

					if not var_63_2 then
						var_63_2 = {
							destroy = true
						}
						EquipmentInfoMediator = var_2_10001
						var_63_2.type = var_2_10001.TYPE_DEFAULT
						var_63_2.equipmentId = var_62_0.equipmentVO.id
					end

					local var_63_3 = arg_62_0

					var_1.emit(var_63_3, var_0_1.ON_EQUIPMENT, var_63_2)

					return
				end
			end
		end
	end

	SFX_PANEL = var_1_10007

	var_3(var_62_1, var_62_2, var_62_3, var_1_10007)

	arg_62_0.equipmetItems[arg_62_1] = var_62_0

	return
end

function var_0_1.updateEquipment(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0

	if not arg_64_0.equipmetItems[arg_64_2] then
		arg_64_0:initEquipment(arg_64_2)

		var_64_0 = arg_64_0.equipmetItems[arg_64_2]
	end

	local var_64_1 = arg_64_0.loadEquipmentVOs[arg_64_1 + 1]

	var_64_0:update(var_64_1)

	return
end

function var_0_1.returnEquipment(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_0.exited then
		return
	end

	if arg_65_0.equipmetItems[arg_65_2] then
		var_3:clear()
	end

	return
end

function var_0_1.filterEquipment(arg_66_0)
	local var_66_0 = arg_66_0.contextData.sortData
	local var_66_1

	if not arg_66_0.loadEquipmentVOs then
		var_66_1 = {}
	end

	arg_66_0.loadEquipmentVOs = var_66_1
	table = var_66_1

	var_66_1.clean(arg_66_0.loadEquipmentVOs)

	local var_66_2 = arg_66_0.loadEquipmentVOs
	local var_66_3 = {
		arg_66_0.contextData.indexDatas.equipPropertyIndex,
		arg_66_0.contextData.indexDatas.equipPropertyIndex2
	}

	pairs = var_4

	for iter_66_0, iter_66_1 in var_4(arg_66_0.equipmentVOs) do
		if (not iter_66_1.shipId or arg_66_0:GetShowBusyFlag()) and not iter_66_1.isSkin then
			IndexConst = var_9

			if var_9.filterEquipByType(iter_66_1, arg_66_0.contextData.indexDatas.typeIndex) then
				IndexConst = var_9

				if var_9.filterEquipByProperty(iter_66_1, var_66_3) then
					IndexConst = var_9

					if var_9.filterEquipAmmo1(iter_66_1, arg_66_0.contextData.indexDatas.equipAmmoIndex1) then
						IndexConst = var_9

						if var_9.filterEquipAmmo2(iter_66_1, arg_66_0.contextData.indexDatas.equipAmmoIndex2) then
							IndexConst = var_9

							if var_9.filterEquipByCamp(iter_66_1, arg_66_0.contextData.indexDatas.equipCampIndex) then
								IndexConst = var_9

								if var_9.filterEquipByRarity(iter_66_1, arg_66_0.contextData.indexDatas.rarityIndex) then
									IndexConst = var_9

									if var_9.filterEquipByExtra(iter_66_1, arg_66_0.contextData.indexDatas.extraIndex) then
										table = var_9

										var_9.insert(arg_66_0.loadEquipmentVOs, iter_66_1)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if var_66_0 then
		local var_66_4 = arg_66_0.contextData.asc

		table = var_5

		local var_66_5 = var_5.sort
		local var_66_6 = var_66_2

		CompareFuncs = iter_66_0

		var_66_5(var_66_6, iter_66_0(var_0_2.sortFunc(var_66_0, var_66_4)))
	end

	arg_66_0:updateEquipmentCount()

	setImageSprite = var_4

	local var_66_7 = arg_66_0.sortBtn
	local var_66_8 = var_5.Find(var_66_7, "Image")

	GetSpriteFromAtlas = var_66_7

	var_4(var_66_8, var_66_7("ui/equipmentui_atlas", var_66_0.spr), true)

	setActive = var_4

	var_4(arg_66_0.downOrderTF, not arg_66_0.contextData.asc)

	setActive = var_4

	var_4(arg_66_0.upOrderTF, arg_66_0.contextData.asc)

	return
end

function var_0_1.updateEquipmentCount(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0.equipmentRect

	var_2.SetTotalCount(var_67_0, arg_67_1 or #arg_67_0.loadEquipmentVOs, -1)

	Canvas = var_2

	var_2.ForceUpdateCanvases()

	return
end

function var_0_1.Scroll2Equip(arg_68_0, arg_68_1)
	if arg_68_0.contextData.pageNum ~= var_0_1.PAGE.Equipment then
		return
	end

	ipairs = var_2

	for iter_68_0, iter_68_1 in var_2(arg_68_0.loadEquipmentVOs) do
		EquipmentProxy = var_1_10007

		if var_1_10007.SameEquip(iter_68_1, arg_68_1) then
			local var_68_0 = arg_68_0.equipmentView
			local var_68_1 = var_1_10007.Find(var_68_0, "Viewport/moudle_grid")

			var_1_10007 = var_1_10007.GetComponent
			typeof = var_9
			GridLayoutGroup = var_1_10010

			local var_68_2 = var_1_10007(var_68_1, var_9(var_1_10010)).cellSize.y + var_1_10007.spacing.y

			math = var_9

			local var_68_3 = var_68_2 * var_9.floor((iter_68_0 - 1) / var_1_10007.constraintCount) + arg_68_0.equipmentRect.paddingFront + arg_68_0.equipmentView.rect.height * 0.5

			arg_68_0:ScrollEquipPos(var_68_3 - arg_68_0.equipmentRect.paddingFront)

			break
		end
	end

	return
end

function var_0_1.ScrollEquipPos(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0.equipmentView
	local var_69_1 = var_2.Find(var_69_0, "Viewport/moudle_grid")
	local var_69_2 = var_2.GetComponent

	typeof = var_4
	GridLayoutGroup = var_1_10005

	local var_69_3 = var_69_2(var_69_1, var_4(var_1_10005)).cellSize.y + var_2.spacing.y

	math = var_4

	local var_69_4 = var_69_3 * var_4.ceil(#arg_69_0.loadEquipmentVOs / var_2.constraintCount) - var_2.spacing.y + arg_69_0.equipmentRect.paddingFront + arg_69_0.equipmentRect.paddingEnd - arg_69_0.equipmentView.rect.height > 0 and var_69_4 or var_4
	local var_69_5 = (arg_69_1 - arg_69_0.equipmentView.rect.height * 0.5) / var_69_4
	local var_69_6 = arg_69_0.equipmentRect

	var_7.ScrollTo(var_69_6, var_69_5)

	return
end

function var_0_1.SetMaterials(arg_70_0, arg_70_1)
	arg_70_0.materials = arg_70_1

	if arg_70_0.isInitMaterials and arg_70_0.contextData.pageNum == var_0_1.PAGE.Material then
		arg_70_0:SortMaterials()
	end

	return
end

function var_0_1.InitMaterials(arg_71_0)
	arg_71_0.isInitMaterials = true

	local var_71_0 = arg_71_0.materialtView

	arg_71_0.materialRect = var_1.GetComponent(var_71_0, "LScrollRect")

	function arg_71_0.materialRect.onInitItem(arg_72_0)
		local var_72_0 = arg_71_0

		var_1.InitMaterial(var_72_0, arg_72_0)

		return
	end

	function arg_71_0.materialRect.onUpdateItem(arg_73_0, arg_73_1)
		local var_73_0 = arg_71_0

		var_2.UpdateMaterial(var_73_0, arg_73_0, arg_73_1)

		return
	end

	function arg_71_0.materialRect.onReturnItem(arg_74_0, arg_74_1)
		local var_74_0 = arg_71_0

		var_2.ReturnMaterial(var_74_0, arg_74_0, arg_74_1)

		return
	end

	arg_71_0.materialRect.decelerationRate = 0.07

	return
end

function var_0_1.SortMaterials(arg_75_0)
	table = var_1_10001

	local var_75_0 = var_1_10001.sort
	local var_75_1 = arg_75_0.materials

	CompareFuncs = var_1_10003

	var_75_0(var_75_1, var_1_10003({
		function(arg_76_0)
			return -arg_76_0:getConfig("rarity")
		end,
		function(arg_77_0)
			return arg_77_0.id
		end
	}))

	local var_75_2 = arg_75_0.materialRect

	var_1.SetTotalCount(var_75_2, #arg_75_0.materials, -1)

	Canvas = var_1

	var_1.ForceUpdateCanvases()

	return
end

function var_0_1.InitMaterial(arg_78_0, arg_78_1)
	ItemCard = var_1_10002

	local var_78_0 = var_1_10002.New(arg_78_1)

	onButton = var_3

	local var_78_1 = arg_78_0
	local var_78_2 = var_78_0.go

	local function var_78_3()
		if var_78_0.itemVO == nil then
			return
		end

		local var_79_0 = var_78_0.itemVO
		local var_79_1 = var_0.getConfig(var_79_0, "type")

		Item = var_79_0

		if var_79_1 == var_79_0.INVITATION_TYPE then
			local var_79_2 = arg_78_0
			local var_79_3 = var_0.emit

			EquipmentMediator = var_2

			local var_79_4 = var_2.ITEM_GO_SCENE

			SCENE = var_2_10003

			var_79_3(var_79_2, var_79_4, var_2_10003.INVITATION, {
				itemVO = var_78_0.itemVO
			})
		else
			local var_79_5 = arg_78_0

			var_0.emit(var_79_5, var_0_1.ON_ITEM, var_78_0.itemVO.id)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_78_1, var_78_2, var_78_3, var_1_10007)

	arg_78_0.materialCards[arg_78_1] = var_78_0

	return
end

function var_0_1.UpdateMaterial(arg_80_0, arg_80_1, arg_80_2)
	local var_80_0

	if not arg_80_0.materialCards[arg_80_2] then
		arg_80_0:initItem(arg_80_2)

		var_80_0 = arg_80_0.materialCards[arg_80_2]
	end

	local var_80_1 = arg_80_0.materials[arg_80_1 + 1]

	var_80_0:update(var_80_1)

	return
end

function var_0_1.ReturnMaterial(arg_81_0, arg_81_1, arg_81_2)
	if arg_81_0.exited then
		return
	end

	if arg_81_0.materialCards[arg_81_2] then
		var_3:clear()
	end

	return
end

return var_0_1
