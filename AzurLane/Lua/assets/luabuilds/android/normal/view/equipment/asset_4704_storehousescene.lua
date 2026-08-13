class = var_0_10000

local var_0_0 = "StoreHouseScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = 1
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 3

function var_0_1.getUIName(arg_1_0)
	return "StoreHouseUI"
end

function var_0_1.setEquipments(arg_2_0, arg_2_1)
	arg_2_0.equipmentVOs = arg_2_1

	arg_2_0:setEquipmentByIds(arg_2_1)

	return
end

function var_0_1.setEquipmentByIds(arg_3_0, arg_3_1)
	arg_3_0.equipmentVOByIds = {}
	pairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_1) do
		if not iter_3_1.isSkin then
			arg_3_0.equipmentVOByIds[iter_3_1.id] = iter_3_1
		end
	end

	return
end

require = var_8

local var_0_9 = var_8("view.equipment.EquipmentSortCfg")

require = var_9

local var_0_10 = var_9("view.equipment.SpWeaponSortCfg")

function var_0_1.init(arg_4_0)
	arg_4_0.filterEquipWaitting = 0

	local var_4_0 = arg_4_0.contextData
	local var_4_1 = arg_4_0._tf

	arg_4_0.topItems = var_2.Find(var_4_1, "topItems")

	local var_4_2 = arg_4_0._tf

	arg_4_0.equipmentView = var_2.Find(var_4_2, "adapt/equipment_scrollview")

	local var_4_3 = arg_4_0._tf

	arg_4_0.blurPanel = var_2.Find(var_4_3, "blur_panel")

	local var_4_4 = arg_4_0.blurPanel

	arg_4_0.topPanel = var_2.Find(var_4_4, "adapt/top")

	local var_4_5 = arg_4_0.topPanel

	arg_4_0.indexBtn = var_2.Find(var_4_5, "buttons/index_button")

	local var_4_6 = arg_4_0.topPanel

	arg_4_0.sortBtn = var_2.Find(var_4_6, "buttons/sort_button")

	local var_4_7 = arg_4_0.topItems

	arg_4_0.sortPanel = var_2.Find(var_4_7, "sort")

	local var_4_8 = arg_4_0.sortPanel

	arg_4_0.sortPanelTG = var_2.GetComponent(var_4_8, "ToggleGroup")
	arg_4_0.sortPanelTG.allowSwitchOff = true

	local var_4_9 = arg_4_0.sortPanel

	arg_4_0.sortContain = var_2.Find(var_4_9, "adapt/mask/panel")

	local var_4_10 = arg_4_0.sortContain

	arg_4_0.sortTpl = var_2.Find(var_4_10, "tpl")
	setActive = var_2

	var_2(arg_4_0.sortTpl, false)

	local var_4_11 = arg_4_0.topPanel

	arg_4_0.equipSkinFilteBtn = var_2.Find(var_4_11, "buttons/EquipSkinFilteBtn")
	RecordableSearchBar = var_2

	local var_4_12 = var_2.New

	RecordableSearchBar = var_4_11

	local var_4_13 = var_4_11.CreateData
	local var_4_14 = {
		enabledFlag = false
	}

	i18n = var_1_10005
	var_4_14.holder = var_1_10005("search_equipment")

	function var_4_14.onInputChanged()
		local var_5_0 = arg_4_0

		var_0.filterEquipment(var_5_0)

		return
	end

	var_4_14.key = arg_4_0.__cname

	local var_4_15 = arg_4_0.topPanel

	var_4_14.parent = var_5.Find(var_4_15, "buttons")

	local var_4_16 = arg_4_0.blurPanel

	var_4_14.expand_parent = var_5.Find(var_4_16, "adapt")
	Vector3 = var_5
	var_4_14.anchoredPosition = var_5(-1305, arg_4_0.topPanel.sizeDelta.y * -0.5, 0)
	arg_4_0.searchBar = var_4_12(var_4_13(var_4_14))

	local var_4_17 = arg_4_0._tf

	arg_4_0.itemView = var_2.Find(var_4_17, "adapt/item_scrollview")

	local var_4_18

	getProxy = var_4_17
	SettingsProxy = var_4

	local var_4_19 = var_4_17(var_4)

	NotchAdapt = var_4

	if var_4.CheckNotchRatio == 2 or not var_4_19:CheckLargeScreen() then
		var_4_18 = arg_4_0.itemView.rect.width > 2000
	else
		NotchAdapt = var_4
		var_4_18 = var_4.CheckNotchRatio >= 2
	end

	local var_4_20 = arg_4_0.equipmentView
	local var_4_21 = var_4.Find(var_4_20, "equipment_grid")
	local var_4_22 = var_4.GetComponent

	typeof = var_6
	GridLayoutGroup = var_7
	var_4_22(var_4_21, var_6(var_7)).constraintCount = var_4_18 and 8 or 7

	local var_4_23 = arg_4_0.itemView
	local var_4_24 = var_5.Find(var_4_23, "item_grid")
	local var_4_25 = var_5.GetComponent

	typeof = var_7
	GridLayoutGroup = var_8
	var_4_25(var_4_24, var_7(var_8)).constraintCount = var_4_18 and 8 or 7
	findTF = var_6
	arg_4_0.decBtn = var_6(arg_4_0.topPanel, "buttons/dec_btn")
	findTF = var_6
	arg_4_0.sortImgAsc = var_6(arg_4_0.decBtn, "asc")
	findTF = var_6
	arg_4_0.sortImgDec = var_6(arg_4_0.decBtn, "desc")

	local var_4_26 = arg_4_0._tf

	arg_4_0.equipmentToggle = var_6.Find(var_4_26, "blur_panel/adapt/left_length/frame/toggle_root")
	setActive = var_6

	var_6(arg_4_0.equipmentToggle, false)

	local var_4_27 = arg_4_0._tf

	arg_4_0.filterBusyToggle = var_6.Find(var_4_27, "blur_panel/adapt/left_length/frame/toggle_equip")
	setActive = var_6

	var_6(arg_4_0.filterBusyToggle, false)

	local var_4_28 = arg_4_0._tf

	arg_4_0.designTabRoot = var_6.Find(var_4_28, "blur_panel/adapt/left_length/frame/toggle_design")
	setActive = var_6

	var_6(arg_4_0.designTabRoot, false)

	CustomIndexLayer = var_6
	arg_4_0.designTabs = var_6.Clone2Full(arg_4_0.designTabRoot, 3)

	local var_4_29 = arg_4_0.topItems

	arg_4_0.bottomBack = var_6.Find(var_4_29, "adapt/bottom_back")

	local var_4_30 = arg_4_0.bottomBack

	arg_4_0.bottomPanel = var_6.Find(var_4_30, "types")

	local var_4_31 = arg_4_0.bottomPanel

	arg_4_0.materialToggle = var_6.Find(var_4_31, "material")

	local var_4_32 = arg_4_0.bottomPanel

	arg_4_0.weaponToggle = var_6.Find(var_4_32, "weapon")

	local var_4_33 = arg_4_0.bottomPanel

	arg_4_0.designToggle = var_6.Find(var_4_33, "design")

	local var_4_34 = arg_4_0.bottomBack

	arg_4_0.capacityTF = var_6.Find(var_4_34, "bottom_left/tip/capcity/Text")

	local var_4_35 = arg_4_0.bottomBack

	arg_4_0.tipTF = var_6.Find(var_4_35, "bottom_left/tip")

	local var_4_36 = arg_4_0.tipTF

	arg_4_0.tip = var_6.Find(var_4_36, "label")

	local var_4_37 = arg_4_0.topItems

	arg_4_0.helpBtn = var_6.Find(var_4_37, "adapt/help_btn")
	setActive = var_6

	var_6(arg_4_0.helpBtn, true)

	local var_4_38 = arg_4_0._tf

	arg_4_0.backBtn = var_6.Find(var_4_38, "blur_panel/adapt/top/back_btn")
	defaultValue = var_6
	arg_4_0.selectedMin = var_6(var_4_0.selectedMin, 1)
	defaultValue = var_6

	local var_4_39 = var_4_0.selectedMax

	pg = var_8

	local var_4_40

	if not var_8.gameset.equip_select_limit.key_value then
		var_4_40 = 0
	end

	arg_4_0.selectedMax = var_6(var_4_39, var_4_40)
	Clone = var_6

	local var_4_41

	if not var_4_0.selectedIds then
		var_4_41 = {}
	end

	arg_4_0.selectedIds = var_6(var_4_41)

	local var_4_42

	if not var_4_0.onEquipment then
		function var_4_42(arg_6_0, arg_6_1, arg_6_2)
			return true
		end
	end

	arg_4_0.checkEquipment = var_4_42

	local var_4_43

	if not var_4_0.onSelected then
		function var_4_43()
			warning = var_2_10000

			var_2_10000("not implemented.")

			return
		end
	end

	arg_4_0.onSelected = var_4_43

	local var_4_44 = arg_4_0.bottomPanel

	arg_4_0.BatchDisposeBtn = var_6.Find(var_4_44, "dispos")

	if not arg_4_0.BatchDisposeBtn then
		local var_4_45 = arg_4_0.bottomBack

		arg_4_0.BatchDisposeBtn = var_6.Find(var_4_45, "dispos")
	end

	local var_4_46 = arg_4_0.topItems

	arg_4_0.selectPanel = var_6.Find(var_4_46, "adapt/select_panel")
	setActive = var_6

	var_6(arg_4_0.selectPanel, true)

	setAnchoredPosition = var_6

	var_6(arg_4_0.selectPanel, {
		y = -124
	})

	local var_4_47 = arg_4_0.topItems

	arg_4_0.selectTransformPanel = var_6.Find(var_4_47, "adapt/select_transform_panel")
	setActive = var_6

	var_6(arg_4_0.selectTransformPanel, false)

	local var_4_48 = arg_4_0._tf

	arg_4_0.listEmptyTF = var_6.Find(var_4_48, "adapt/empty")
	setActive = var_6

	var_6(arg_4_0.listEmptyTF, false)

	local var_4_49 = arg_4_0.listEmptyTF

	arg_4_0.listEmptyTxt = var_6.Find(var_4_49, "Text")
	DestroyConfirmView = var_6
	arg_4_0.destroyConfirmView = var_6.New(arg_4_0.topItems, arg_4_0.event)
	AssignedItemView = var_6
	arg_4_0.assignedItemView = var_6.New(arg_4_0.topItems, arg_4_0.event)
	BlueprintAssignedItemView = var_6
	arg_4_0.blueprintAssignedItemView = var_6.New(arg_4_0.topItems, arg_4_0.event)
	EquipDestoryConfirmWindow = var_6
	arg_4_0.equipDestroyConfirmWindow = var_6.New(arg_4_0.topItems, arg_4_0.event)
	arg_4_0.isEquipingOn = false
	SelectSkinMsgbox = var_6
	arg_4_0.msgBox = var_6.New(arg_4_0._tf, arg_4_0.event)

	return
end

function var_0_1.setEquipment(arg_8_0, arg_8_1)
	local var_8_0 = #arg_8_0.equipmentVOs + 1

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.equipmentVOs) do
		if not iter_8_1.shipId and iter_8_1.id == arg_8_1.id then
			var_8_0 = iter_8_0

			break
		end
	end

	local var_8_1

	if arg_8_1.count > 0 then
		var_8_1 = arg_8_0.equipmentVOs
		var_8_1[var_8_0] = arg_8_1
		var_8_1 = arg_8_0.equipmentVOByIds
		var_8_1[arg_8_1.id] = arg_8_1
	else
		table = var_8_1

		var_8_1.remove(arg_8_0.equipmentVOs, var_8_0)

		arg_8_0.equipmentVOByIds[arg_8_1.id] = nil
	end

	return
end

function var_0_1.setEquipmentUpdate(arg_9_0)
	local var_9_0 = arg_9_0.contextData.warp

	StoreHouseConst = var_1_10002

	if var_9_0 == var_1_10002.WARP_TO_WEAPON then
		arg_9_0:filterEquipment()
		arg_9_0:updateCapacity()
	end

	return
end

function var_0_1.addShipEquipment(arg_10_0, arg_10_1)
	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.equipmentVOs) do
		EquipmentProxy = var_1_10007

		if var_1_10007.SameEquip(iter_10_1, arg_10_1) then
			var_1_10007 = arg_10_0.equipmentVOs
			var_1_10007[iter_10_0] = arg_10_1

			return
		end
	end

	table = var_2

	var_2.insert(arg_10_0.equipmentVOs, arg_10_1)

	return
end

function var_0_1.removeShipEquipment(arg_11_0, arg_11_1)
	for iter_11_0 = #arg_11_0.equipmentVOs, 1, -1 do
		local var_11_0 = arg_11_0.equipmentVOs[iter_11_0]

		EquipmentProxy = var_1_10007

		if var_1_10007.SameEquip(var_11_0, arg_11_1) then
			table = var_1_10007

			var_1_10007.remove(arg_11_0.equipmentVOs, iter_11_0)
		end
	end

	return
end

function var_0_1.setEquipmentSkin(arg_12_0, arg_12_1)
	local var_12_0 = true

	pairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_0.equipmentVOs) do
		if iter_12_1.id == arg_12_1.id and iter_12_1.isSkin then
			arg_12_0.equipmentVOs[iter_12_0] = {
				isSkin = true,
				id = arg_12_1.id,
				count = arg_12_1.count
			}
			var_12_0 = false
		end
	end

	if var_12_0 then
		table = var_3

		var_3.insert(arg_12_0.equipmentVOs, {
			isSkin = true,
			id = arg_12_1.id,
			count = arg_12_1.count
		})
	end

	return
end

function var_0_1.setEquipmentSkinUpdate(arg_13_0)
	local var_13_0 = arg_13_0.contextData.warp

	StoreHouseConst = var_1_10002

	if var_13_0 == var_1_10002.WARP_TO_WEAPON then
		arg_13_0:filterEquipment()
		arg_13_0:updateCapacity()
	end

	return
end

function var_0_1.SetSpWeapons(arg_14_0, arg_14_1)
	arg_14_0.spweaponVOs = arg_14_1

	return
end

function var_0_1.SetSpWeaponUpdate(arg_15_0)
	local var_15_0 = arg_15_0.contextData.warp

	StoreHouseConst = var_1_10002

	local var_15_1

	if var_15_0 == var_1_10002.WARP_TO_WEAPON and arg_15_0.page == var_0_5 then
		var_15_1 = arg_15_0

		arg_15_0.filterEquipment(var_15_1)

		var_15_1 = arg_15_0

		arg_15_0.UpdateSpweaponCapacity(var_15_1)
	else
		local var_15_2 = arg_15_0.contextData.warp

		StoreHouseConst = var_15_1

		if var_15_2 == var_15_1.WARP_TO_DESIGN and arg_15_0.contextData.designPage == var_0_7 then
			arg_15_0:UpdateSpweaponCapacity()
		end
	end

	return
end

function var_0_1.didEnter(arg_16_0)
	setText = var_1_10001

	local var_16_0 = arg_16_0.selectPanel
	local var_16_1 = var_2.Find(var_16_0, "tip")

	i18n = var_16_0

	var_1_10001(var_16_1, var_16_0("equipment_select_device_destroy_tip"))

	setActive = var_1_10001

	local var_16_2 = arg_16_0.topItems
	local var_16_3 = var_2.Find(var_16_2, "adapt/stamp")

	getProxy = var_16_2
	TaskProxy = var_4

	local var_16_4 = var_16_2(var_4)

	var_1_10001(var_16_3, var_3.mingshiTouchFlagEnabled(var_16_4))

	onButton = var_1_10001

	local var_16_5 = arg_16_0
	local var_16_6 = arg_16_0.topItems
	local var_16_7 = var_3.Find(var_16_6, "adapt/stamp")

	local function var_16_8()
		getProxy = var_2_10000
		TaskProxy = var_2_10001

		local var_17_0 = var_2_10000(var_2_10001)

		var_0.dealMingshiTouchFlag(var_17_0, 2)

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_16_5, var_16_7, var_16_8, var_5)

	onButton = var_1_10001

	local var_16_9 = arg_16_0
	local var_16_10 = arg_16_0.helpBtn

	local function var_16_11()
		local var_18_0
		local var_18_1 = arg_16_0.contextData.warp

		StoreHouseConst = var_2_10002

		if var_18_1 == var_2_10002.WARP_TO_WEAPON then
			if arg_16_0.page == var_0_3 then
				pg = var_18_1
				var_18_0 = var_18_1.gametip.help_equipment.tip
			elseif arg_16_0.page == var_0_4 then
				pg = var_18_1
				var_18_0 = var_18_1.gametip.help_equipment_skin.tip
			elseif arg_16_0.page == var_0_5 then
				pg = var_18_1
				var_18_0 = var_18_1.gametip.spweapon_help_storage.tip
			end
		else
			var_18_1 = arg_16_0.contextData.warp
			StoreHouseConst = var_2

			if var_18_1 == var_2.WARP_TO_DESIGN then
				if arg_16_0.contextData.designPage == var_0_6 then
					pg = var_18_1
					var_18_0 = var_18_1.gametip.help_equipment.tip
				elseif arg_16_0.contextData.designPage == var_0_7 then
					pg = var_18_1
					var_18_0 = var_18_1.gametip.spweapon_help_storage.tip
				end
			end
		end

		pg = var_18_1

		local var_18_2 = var_18_1.MsgboxMgr.GetInstance()
		local var_18_3 = var_1.ShowMsgBox
		local var_18_4 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_18_4.type = var_2_10004
		var_18_4.helps = var_18_0

		var_18_3(var_18_2, var_18_4)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_16_9, var_16_10, var_16_11, var_5)

	onToggle = var_1_10001

	local var_16_12 = arg_16_0
	local var_16_13 = arg_16_0.equipmentToggle
	local var_16_14 = var_3.Find(var_16_13, "equipment")

	local function var_16_15(arg_19_0)
		if arg_19_0 then
			arg_16_0.page = var_0_3

			local var_19_0 = arg_16_0

			var_1.SwitchEquipmentType(var_19_0, var_0_3)

			local var_19_1 = arg_16_0

			var_1.UpdateWeaponWrapButtons(var_19_1)

			local var_19_2 = arg_16_0

			var_1.filterEquipment(var_19_2)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_16_12, var_16_14, var_16_15, var_5)

	onToggle = var_1_10001

	local var_16_16 = arg_16_0
	local var_16_17 = arg_16_0.equipmentToggle
	local var_16_18 = var_3.Find(var_16_17, "skin")

	local function var_16_19(arg_20_0)
		if arg_20_0 then
			arg_16_0.page = var_0_4

			local var_20_0 = arg_16_0

			var_1.SwitchEquipmentType(var_20_0, var_0_4)

			local var_20_1 = arg_16_0

			var_1.UpdateWeaponWrapButtons(var_20_1)

			local var_20_2 = arg_16_0

			var_1.filterEquipment(var_20_2)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_16_16, var_16_18, var_16_19, var_5)

	onToggle = var_1_10001

	local var_16_20 = arg_16_0
	local var_16_21 = arg_16_0.equipmentToggle
	local var_16_22 = var_3.Find(var_16_21, "spweapon")

	local function var_16_23(arg_21_0)
		if arg_21_0 then
			arg_16_0.page = var_0_5

			local var_21_0 = arg_16_0

			var_1.SwitchEquipmentType(var_21_0, var_0_5)

			local var_21_1 = arg_16_0

			var_1.UpdateWeaponWrapButtons(var_21_1)

			local var_21_2 = arg_16_0

			var_1.filterEquipment(var_21_2)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_16_20, var_16_22, var_16_23, var_5)

	setActive = var_1_10001

	local var_16_24 = arg_16_0.equipmentToggle
	local var_16_25 = var_2.Find(var_16_24, "spweapon")

	LOCK_SP_WEAPON = var_16_24

	var_1_10001(var_16_25, not var_16_24)

	onToggle = var_1_10001

	local var_16_26 = arg_16_0
	local var_16_27 = arg_16_0.designTabs[var_0_6]

	local function var_16_28(arg_22_0)
		if arg_22_0 then
			var_2_10001 = arg_16_0.contextData
			var_2_10001.designPage = var_0_6

			local var_22_0 = arg_16_0

			var_2_10001 = var_2_10001.emit
			EquipmentMediator = var_2_10003

			var_2_10001(var_22_0, var_2_10003.OPEN_DESIGN)

			local var_22_1 = arg_16_0

			var_2_10001.updateCapacity(var_22_1)

			setActive = var_2_10001

			var_2_10001(arg_16_0.tip, false)

			setActive = var_2_10001

			var_2_10001(arg_16_0.listEmptyTF, false)
		else
			local var_22_2 = arg_16_0

			var_2_10001 = var_2_10001.emit
			EquipmentMediator = var_2_10003

			var_2_10001(var_22_2, var_2_10003.CLOSE_DESIGN_LAYER)
		end

		setActive = var_2_10001

		var_2_10001(arg_16_0.designTabs[var_0_8], arg_22_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_16_26, var_16_27, var_16_28, var_5)

	onToggle = var_1_10001

	local var_16_29 = arg_16_0
	local var_16_30 = arg_16_0.designTabs[var_0_7]

	local function var_16_31(arg_23_0)
		if arg_23_0 then
			arg_16_0.contextData.designPage = var_0_7

			local var_23_0 = arg_16_0
			local var_23_1 = var_1.emit

			EquipmentMediator = var_2_10003

			var_23_1(var_23_0, var_2_10003.OPEN_SPWEAPON_DESIGN)

			local var_23_2 = arg_16_0

			var_1.UpdateSpweaponCapacity(var_23_2)

			setActive = var_1

			var_1(arg_16_0.tip, false)

			setActive = var_1

			var_1(arg_16_0.listEmptyTF, false)
		else
			local var_23_3 = arg_16_0
			local var_23_4 = var_1.emit

			EquipmentMediator = var_2_10003

			var_23_4(var_23_3, var_2_10003.CLOSE_SPWEAPON_DESIGN_LAYER)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_16_29, var_16_30, var_16_31, var_5)

	setActive = var_1_10001

	var_1_10001(arg_16_0.designTabs[var_0_8], arg_16_0.contextData.designPage == var_0_6)

	arg_16_0.isShowAllDesign = false
	onToggle = var_1

	local var_16_32 = arg_16_0
	local var_16_33 = arg_16_0.designTabs[var_0_8]

	local function var_16_34(arg_24_0)
		arg_16_0.isShowAllDesign = arg_24_0

		local var_24_0 = arg_16_0
		local var_24_1 = var_1.emit

		EquipmentMediator = var_2_10003

		var_24_1(var_24_0, var_2_10003.DESIGN_FILTER_CHANGED, arg_16_0.isShowAllDesign)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_32, var_16_33, var_16_34, var_5)

	onButton = var_1

	local var_16_35 = arg_16_0
	local var_16_36 = arg_16_0.backBtn

	local function var_16_37()
		local var_25_0 = arg_16_0.mode

		StoreHouseConst = var_2_10001

		if var_25_0 == var_2_10001.DESTROY then
			triggerButton = var_25_0

			var_25_0(arg_16_0.BatchDisposeBtn)

			return
		end

		GetOrAddComponent = var_25_0

		local var_25_1 = arg_16_0._tf

		typeof = var_2_10002
		CanvasGroup = var_2_10003
		var_25_0(var_25_1, var_2_10002(var_2_10003)).interactable = false

		local var_25_2 = arg_16_0

		var_1.emit(var_25_2, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_16_35, var_16_36, var_16_37, var_5)

	onToggle = var_1

	local var_16_38 = arg_16_0
	local var_16_39 = arg_16_0.sortBtn

	local function var_16_40(arg_26_0)
		if arg_26_0 then
			local var_26_0 = arg_16_0

			var_1.OverlayPanel(var_26_0, arg_16_0.sortPanel)

			setActive = var_1

			var_1(arg_16_0.sortPanel, true)

			onNextTick = var_1

			var_1(function()
				arg_16_0.sortPanelTG.allowSwitchOff = false

				return
			end)
		else
			local var_26_1 = arg_16_0

			var_1.UnOverlayPanel(var_26_1, arg_16_0.sortPanel, arg_16_0.topItems)

			setActive = var_1

			var_1(arg_16_0.sortPanel, false)

			arg_16_0.sortPanelTG.allowSwitchOff = true
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_38, var_16_39, var_16_40, var_5)

	onButton = var_1

	local var_16_41 = arg_16_0
	local var_16_42 = arg_16_0.sortPanel

	local function var_16_43()
		triggerToggle = var_2_10000

		var_2_10000(arg_16_0.sortBtn, false)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_41, var_16_42, var_16_43, var_5)

	onButton = var_1

	local var_16_44 = arg_16_0
	local var_16_45 = arg_16_0.indexBtn

	local function var_16_46()
		switch = var_2_10000

		local var_29_0 = var_2_10000(arg_16_0.page, {
			[var_0_3] = function()
				setmetatable = var_3_10000

				local var_30_0 = {}

				Clone = var_3_10002
				var_30_0.indexDatas = var_3_10002(arg_16_0.contextData.indexDatas)

				function var_30_0.callback(arg_31_0)
					arg_16_0.contextData.indexDatas.typeIndex = arg_31_0.typeIndex
					arg_16_0.contextData.indexDatas.equipPropertyIndex = arg_31_0.equipPropertyIndex
					arg_16_0.contextData.indexDatas.equipPropertyIndex2 = arg_31_0.equipPropertyIndex2
					arg_16_0.contextData.indexDatas.equipAmmoIndex1 = arg_31_0.equipAmmoIndex1
					arg_16_0.contextData.indexDatas.equipAmmoIndex2 = arg_31_0.equipAmmoIndex2
					arg_16_0.contextData.indexDatas.equipCampIndex = arg_31_0.equipCampIndex
					arg_16_0.contextData.indexDatas.rarityIndex = arg_31_0.rarityIndex
					arg_16_0.contextData.indexDatas.extraIndex = arg_31_0.extraIndex

					local var_31_0 = arg_16_0.filterBusyToggle
					local var_31_1 = var_1.GetComponent

					typeof = var_4_10003
					Toggle = var_4_10004

					if var_31_1(var_31_0, var_4_10003(var_4_10004)) then
						bit = var_31_0

						local var_31_2 = var_31_0.band
						local var_31_3 = arg_31_0.extraIndex

						IndexConst = var_4_10004

						if var_31_2(var_31_3, var_4_10004.EquipmentExtraEquiping) > 0 then
							local var_31_4 = arg_16_0

							var_2.SetShowBusyFlag(var_31_4, true)
						end

						triggerToggle = var_2

						local var_31_5 = arg_16_0.filterBusyToggle
						local var_31_6 = arg_16_0

						var_2(var_31_5, var_4.GetShowBusyFlag(var_31_6))
					else
						local var_31_7 = arg_16_0

						var_2.filterEquipment(var_31_7)
					end

					return
				end

				local var_30_1 = {}

				StoreHouseConst = var_3
				var_30_1.__index = var_3.EQUIPMENT_INDEX_COMMON

				return var_3_10000(var_30_0, var_30_1)
			end,
			[var_0_5] = function()
				setmetatable = var_3_10000

				local var_32_0 = {}

				Clone = var_3_10002
				var_32_0.indexDatas = var_3_10002(arg_16_0.contextData.spweaponIndexDatas)

				function var_32_0.callback(arg_33_0)
					arg_16_0.contextData.spweaponIndexDatas.typeIndex = arg_33_0.typeIndex
					arg_16_0.contextData.spweaponIndexDatas.rarityIndex = arg_33_0.rarityIndex

					local var_33_0 = arg_16_0

					var_1.filterEquipment(var_33_0)

					return
				end

				local var_32_1 = {}

				StoreHouseConst = var_3
				var_32_1.__index = var_3.SPWEAPON_INDEX_COMMON

				return var_3_10000(var_32_0, var_32_1)
			end
		})
		local var_29_1 = arg_16_0
		local var_29_2 = var_1.emit

		EquipmentMediator = var_3

		var_29_2(var_29_1, var_3.OPEN_EQUIPMENT_INDEX, var_29_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_44, var_16_45, var_16_46, var_5)

	onButton = var_1

	local var_16_47 = arg_16_0
	local var_16_48 = arg_16_0.equipSkinFilteBtn

	local function var_16_49()
		local var_34_0 = {}
		local var_34_1 = {}

		IndexConst = var_2_10002

		local var_34_2 = var_2_10002.FlagRange2Bits

		IndexConst = var_2_10003

		local var_34_3 = var_2_10003.EquipSkinIndexAll

		IndexConst = var_2_10004
		var_34_1.equipSkinIndex = var_34_2(var_34_3, var_2_10004.EquipSkinIndexAux)
		IndexConst = var_2

		local var_34_4 = var_2.FlagRange2Str

		IndexConst = var_34_3

		local var_34_5 = var_34_3.EquipSkinThemeAll

		IndexConst = var_4
		var_34_1.equipSkinTheme = var_34_4(var_34_5, var_4.EquipSkinThemeEnd)
		var_34_0.display = var_34_1

		local var_34_6

		if not arg_16_0.equipSkinSort then
			IndexConst = var_34_6
			var_34_6 = var_34_6.EquipSkinSortType
		end

		var_34_0.equipSkinSort = var_34_6

		local var_34_7

		if not arg_16_0.equipSkinIndex then
			IndexConst = var_34_7
			var_34_7 = var_34_7.Flags2Bits

			local var_34_8 = {}

			IndexConst = var_34_5
			var_34_8[1] = var_34_5.EquipSkinIndexAll
			var_34_7 = var_34_7(var_34_8)
		end

		var_34_0.equipSkinIndex = var_34_7

		local var_34_9

		if not arg_16_0.equipSkinTheme then
			IndexConst = var_34_9
			var_34_9 = var_34_9.Flags2Str

			local var_34_10 = {}

			IndexConst = var_34_5
			var_34_10[1] = var_34_5.EquipSkinThemeAll
			var_34_9 = var_34_9(var_34_10)
		end

		var_34_0.equipSkinTheme = var_34_9

		function var_34_0.callback(arg_35_0)
			arg_16_0.equipSkinSort = arg_35_0.equipSkinSort
			arg_16_0.equipSkinIndex = arg_35_0.equipSkinIndex
			arg_16_0.equipSkinTheme = arg_35_0.equipSkinTheme

			local var_35_0 = arg_16_0

			var_1.filterEquipment(var_35_0)

			return
		end

		local var_34_11 = arg_16_0
		local var_34_12 = var_1.emit

		EquipmentMediator = var_34_5

		var_34_12(var_34_11, var_34_5.OPEN_EQUIPSKIN_INDEX_LAYER, var_34_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_47, var_16_48, var_16_49, var_5)

	arg_16_0.equipmetItems = {}
	arg_16_0.itemCards = {}

	arg_16_0:initItems()
	arg_16_0:initEquipments()

	local var_16_50

	if not arg_16_0.contextData.asc then
		var_16_50 = false
	end

	arg_16_0.asc = var_16_50

	local var_16_51 = arg_16_0.contextData
	local var_16_52

	if not arg_16_0.contextData.sortData then
		var_16_52 = var_0_9.sort[1]
	end

	var_16_51.sortData = var_16_52

	local var_16_53 = arg_16_0.contextData
	local var_16_54

	if not arg_16_0.contextData.indexDatas then
		var_16_54 = {}
	end

	var_16_53.indexDatas = var_16_54

	local var_16_55 = arg_16_0.contextData
	local var_16_56

	if not arg_16_0.contextData.spweaponIndexDatas then
		var_16_56 = {}
	end

	var_16_55.spweaponIndexDatas = var_16_56

	local var_16_57 = arg_16_0.contextData
	local var_16_58

	if not arg_16_0.contextData.spweaponSortData then
		var_16_58 = var_0_10.sort[1]
	end

	var_16_57.spweaponSortData = var_16_58

	arg_16_0:initSort()

	setActive = var_1

	var_1(arg_16_0.itemView, false)

	setActive = var_1

	var_1(arg_16_0.equipmentView, false)

	onToggle = var_1

	local var_16_59 = arg_16_0
	local var_16_60 = arg_16_0.materialToggle

	local function var_16_61(arg_36_0)
		local var_36_0 = arg_16_0

		var_36_0.inMaterial = arg_36_0

		if arg_36_0 then
			var_36_0 = arg_16_0.contextData.warp
			StoreHouseConst = var_2_10002

			if var_36_0 ~= var_2_10002.WARP_TO_MATERIAL then
				var_36_0 = arg_16_0.contextData
				StoreHouseConst = var_2
				var_36_0.warp = var_2.WARP_TO_MATERIAL
				setText = var_36_0

				local var_36_1 = arg_16_0.tip

				i18n = var_2_10003

				var_36_0(var_36_1, var_2_10003("equipment_select_materials_tip"))

				setActive = var_36_0

				var_36_0(arg_16_0.capacityTF.parent, false)

				setActive = var_36_0

				var_36_0(arg_16_0.tip, true)

				local var_36_2 = arg_16_0

				var_36_0.sortItems(var_36_2)
			end
		end

		setActive = var_36_0

		var_36_0(arg_16_0.helpBtn, not arg_36_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_59, var_16_60, var_16_61, var_5)

	onToggle = var_1

	local var_16_62 = arg_16_0
	local var_16_63 = arg_16_0.weaponToggle

	local function var_16_64(arg_37_0)
		if arg_37_0 then
			var_2_10001 = arg_16_0.contextData.warp
			StoreHouseConst = var_2_10002

			if var_2_10001 ~= var_2_10002.WARP_TO_WEAPON then
				var_2_10001 = arg_16_0.contextData
				StoreHouseConst = var_2
				var_2_10001.warp = var_2.WARP_TO_WEAPON
				setActive = var_2_10001

				var_2_10001(arg_16_0.tip, false)

				setActive = var_2_10001

				var_2_10001(arg_16_0.capacityTF.parent, true)

				if arg_16_0.page == var_0_4 then
					triggerToggle = var_2_10001

					local var_37_0 = arg_16_0.equipmentToggle

					var_2_10001(var_2.Find(var_37_0, "skin"), true)
				elseif arg_16_0.page == var_0_5 then
					triggerToggle = var_2_10001

					local var_37_1 = arg_16_0.equipmentToggle

					var_2_10001(var_2.Find(var_37_1, "spweapon"), true)
				else
					triggerToggle = var_2_10001

					local var_37_2 = arg_16_0.equipmentToggle

					var_2_10001(var_2.Find(var_37_2, "equipment"), true)
				end
			end
		else
			setActive = var_2_10001

			var_2_10001(arg_16_0.BatchDisposeBtn, false)

			setActive = var_2_10001

			var_2_10001(arg_16_0.filterBusyToggle, false)

			setActive = var_2_10001

			var_2_10001(arg_16_0.equipmentToggle, false)
		end

		local var_37_3 = arg_16_0.searchBar

		var_1.EnableOrDisable(var_37_3, arg_37_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_62, var_16_63, var_16_64, var_5)

	onToggle = var_1

	local var_16_65 = arg_16_0
	local var_16_66 = arg_16_0.designToggle

	local function var_16_67(arg_38_0)
		if arg_38_0 then
			var_2_10001 = arg_16_0.contextData
			StoreHouseConst = var_2_10002
			var_2_10001.warp = var_2_10002.WARP_TO_DESIGN

			if not arg_16_0.contextData.designPage then
				var_2_10001 = var_0_6
			end

			triggerToggle = var_2

			var_2(arg_16_0.designTabs[var_2_10001], true)

			setActive = var_2

			var_2(arg_16_0.capacityTF.parent, true)
		else
			local var_38_0 = arg_16_0

			var_2_10001 = var_2_10001.emit
			EquipmentMediator = var_2_10003

			var_2_10001(var_38_0, var_2_10003.CLOSE_DESIGN_LAYER)

			local var_38_1 = arg_16_0

			var_2_10001 = var_2_10001.emit
			EquipmentMediator = var_2_10003

			var_2_10001(var_38_1, var_2_10003.CLOSE_SPWEAPON_DESIGN_LAYER)
		end

		setActive = var_2_10001

		local var_38_2 = arg_16_0.designTabRoot

		if arg_38_0 then
			::label_38_0::

			LOCK_SP_WEAPON = var_2_10003
			var_2_10003 = not var_2_10003
		end

		var_2_10001(var_38_2, var_2_10003)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_65, var_16_66, var_16_67, var_5)

	onToggle = var_1

	local var_16_68 = arg_16_0
	local var_16_69 = arg_16_0.filterBusyToggle

	local function var_16_70(arg_39_0)
		local var_39_0 = arg_16_0

		var_1.SetShowBusyFlag(var_39_0, arg_39_0)

		local var_39_1 = arg_16_0

		var_1.filterEquipment(var_39_1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_68, var_16_69, var_16_70, var_5)

	arg_16_0.filterEquipWaitting = arg_16_0.filterEquipWaitting + 1
	triggerToggle = var_1

	var_1(arg_16_0.filterBusyToggle, arg_16_0.shipVO)

	onButton = var_1

	local var_16_71 = arg_16_0
	local var_16_72 = arg_16_0.BatchDisposeBtn

	local function var_16_73()
		local var_40_0 = arg_16_0.mode

		StoreHouseConst = var_2_10001

		local var_40_3

		if var_40_0 == var_2_10001.DESTROY then
			local var_40_1 = arg_16_0

			StoreHouseConst = var_40_3
			var_40_1.mode = var_40_3.OVERVIEW
			arg_16_0.asc = arg_16_0.lastasc
			arg_16_0.lastasc = nil

			local var_40_2 = arg_16_0

			var_40_2.filterImportance = nil
			shiftPanel = var_40_2

			var_40_2(arg_16_0.bottomBack, nil, 0, nil, 0, true, true)

			shiftPanel = var_40_2

			var_40_2(arg_16_0.selectPanel, nil, -124, nil, 0, true, true)

			var_40_3 = arg_16_0

			var_0.filterEquipment(var_40_3)
		else
			local var_40_4 = arg_16_0

			StoreHouseConst = var_40_3
			var_40_4.mode = var_40_3.DESTROY
			arg_16_0.lastasc = arg_16_0.asc
			arg_16_0.filterImportance = true

			local var_40_5 = arg_16_0

			var_40_5.asc = true
			shiftPanel = var_40_5

			var_40_5(arg_16_0.bottomBack, nil, -124, nil, 0, true, true)

			shiftPanel = var_40_5

			var_40_5(arg_16_0.selectPanel, nil, 0, nil, 0, true, true)

			arg_16_0.contextData.asc = arg_16_0.asc
			arg_16_0.contextData.sortData = var_0_9.sort[1]

			local var_40_6 = arg_16_0

			var_0.filterEquipment(var_40_6)
		end

		local var_40_7 = arg_16_0

		var_0.UpdateWeaponWrapButtons(var_40_7)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_71, var_16_72, var_16_73, var_5)

	onButton = var_1

	local var_16_74 = arg_16_0

	findTF = var_16_72

	local var_16_75 = var_16_72(arg_16_0.selectPanel, "cancel_button")

	local function var_16_76()
		local var_41_0 = arg_16_0

		var_0.unselecteAllEquips(var_41_0)

		triggerButton = var_0

		var_0(arg_16_0.BatchDisposeBtn)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_16_74, var_16_75, var_16_76, var_5)

	onButton = var_1

	local var_16_77 = arg_16_0

	findTF = var_16_75

	local var_16_78 = var_16_75(arg_16_0.selectPanel, "confirm_button")

	local function var_16_79()
		local var_42_0 = {}

		underscore = var_2_10001

		if var_2_10001.any(arg_16_0.selectedIds, function(arg_43_0)
			local var_43_0 = arg_16_0.equipmentVOByIds[arg_43_0[1]]

			return var_1.getConfig(var_43_0, "rarity") >= 4 or var_1:getConfig("level") > 1
		end) then
			table = var_1

			var_1.insert(var_42_0, function(arg_44_0)
				local var_44_0 = arg_16_0.equipDestroyConfirmWindow

				var_1.Load(var_44_0)

				local var_44_1 = arg_16_0.equipDestroyConfirmWindow
				local var_44_2 = var_1.ActionInvoke
				local var_44_3 = "Show"

				underscore = var_3_10004

				var_44_2(var_44_1, var_44_3, var_3_10004.map(arg_16_0.selectedIds, function(arg_45_0)
					setmetatable = var_4_10001

					return var_4_10001({
						count = arg_45_0[2]
					}, {
						__index = arg_16_0.equipmentVOByIds[arg_45_0[1]]
					})
				end), arg_44_0)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_42_0, function()
			local var_46_0 = arg_16_0.destroyConfirmView

			var_0.Load(var_46_0)

			local var_46_1 = arg_16_0.destroyConfirmView

			var_0.ActionInvoke(var_46_1, "Show")

			local var_46_2 = arg_16_0.destroyConfirmView

			var_0.ActionInvoke(var_46_2, "DisplayDestroyBonus", arg_16_0.selectedIds)

			local var_46_3 = arg_16_0.destroyConfirmView

			var_0.ActionInvoke(var_46_3, "SetConfirmBtnCB", function()
				local var_47_0 = arg_16_0

				var_0.unselecteAllEquips(var_47_0)

				return
			end)

			return
		end)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_16_77, var_16_78, var_16_79, var_5)
	arg_16_0:OverlayPanel(arg_16_0.blurPanel)
	arg_16_0:PlayUIAnimation(arg_16_0.blurPanel, "enter")
	arg_16_0:OverlayPanel(arg_16_0.topItems)

	local var_16_80

	if not arg_16_0.contextData.warp then
		StoreHouseConst = var_16_80
		var_16_80 = var_16_80.WARP_TO_MATERIAL
	end

	local var_16_81

	if not arg_16_0.contextData.mode then
		StoreHouseConst = var_16_81
		var_16_81 = var_16_81.OVERVIEW
	end

	arg_16_0.contextData.warp = nil
	arg_16_0.contextData.mode = nil

	local var_16_82

	if not arg_16_0.mode then
		StoreHouseConst = var_16_82
		var_16_82 = var_16_82.OVERVIEW
	end

	arg_16_0.mode = var_16_82
	StoreHouseConst = var_16_82

	if var_16_80 == var_16_82.WARP_TO_DESIGN then
		triggerToggle = var_3

		var_3(arg_16_0.designToggle, true)
	else
		StoreHouseConst = var_3

		if var_16_80 == var_3.WARP_TO_MATERIAL then
			triggerToggle = var_3

			var_3(arg_16_0.materialToggle, true)
		else
			StoreHouseConst = var_3

			if var_16_80 == var_3.WARP_TO_WEAPON then
				StoreHouseConst = var_3

				if var_16_81 == var_3.DESTROY then
					arg_16_0.filterEquipWaitting = arg_16_0.filterEquipWaitting + 1
					triggerToggle = var_3

					var_3(arg_16_0.weaponToggle, true)

					triggerButton = var_3

					var_3(arg_16_0.BatchDisposeBtn)
				else
					StoreHouseConst = var_3

					if var_16_81 == var_3.SKIN then
						arg_16_0.page = var_0_4
					else
						StoreHouseConst = var_3

						if var_16_81 == var_3.SPWEAPON then
							arg_16_0.page = var_0_5
						else
							arg_16_0.page = var_0_3
						end
					end

					triggerToggle = var_3

					var_3(arg_16_0.weaponToggle, true)
				end
			end
		end
	end

	AprilFoolBulinSubView = var_3
	arg_16_0.bulinTip = var_3.ShowAprilFoolBulin(arg_16_0, arg_16_0.topItems)

	return
end

function var_0_1.isDefaultStatus(arg_48_0)
	underscore = var_1_10001

	local var_48_0 = var_1_10001(arg_48_0.contextData.indexDatas)
	local var_48_1 = var_1.chain(var_48_0)
	local var_48_2 = var_1.keys(var_48_1)
	local var_48_3 = var_1.all(var_48_2, function(arg_49_0)
		local var_49_0 = arg_48_0.contextData.indexDatas[arg_49_0]

		StoreHouseConst = var_2_10002

		return var_49_0 == var_2_10002.EQUIPMENT_INDEX_COMMON.customPanels[arg_49_0].options[1]
	end)

	return var_1.value(var_48_3)
end

function var_0_1.isDefaultSpWeaponIndexData(arg_50_0)
	underscore = var_1_10001

	local var_50_0 = var_1_10001(arg_50_0.contextData.spweaponIndexDatas)
	local var_50_1 = var_1.chain(var_50_0)
	local var_50_2 = var_1.keys(var_50_1)
	local var_50_3 = var_1.all(var_50_2, function(arg_51_0)
		local var_51_0 = arg_50_0.contextData.spweaponIndexDatas[arg_51_0]

		StoreHouseConst = var_2_10002

		return var_51_0 == var_2_10002.SPWEAPON_INDEX_COMMON.customPanels[arg_51_0].options[1]
	end)

	return var_1.value(var_50_3)
end

function var_0_1.onBackPressed(arg_52_0)
	pg = var_1_10001

	local var_52_0 = var_1_10001.CriMgr.GetInstance()
	local var_52_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_52_1(var_52_0, var_1_10003)

	isActive = var_52_1

	if var_52_1(arg_52_0.sortPanel) then
		triggerButton = var_1

		var_1(arg_52_0.sortPanel)
	else
		local var_52_2 = arg_52_0.destroyConfirmView

		if var_1.isShowing(var_52_2) then
			local var_52_3 = arg_52_0.destroyConfirmView

			var_1.Hide(var_52_3)
		else
			local var_52_4 = arg_52_0.assignedItemView

			if var_1.isShowing(var_52_4) then
				local var_52_5 = arg_52_0.assignedItemView

				var_1.Hide(var_52_5)
			else
				local var_52_6 = arg_52_0.blueprintAssignedItemView

				if var_1.isShowing(var_52_6) then
					local var_52_7 = arg_52_0.blueprintAssignedItemView

					var_1.Hide(var_52_7)
				else
					local var_52_8 = arg_52_0.equipDestroyConfirmWindow

					if var_1.isShowing(var_52_8) then
						local var_52_9 = arg_52_0.equipDestroyConfirmWindow

						var_1.Hide(var_52_9)
					else
						triggerButton = var_1

						var_1(arg_52_0.backBtn)
					end
				end
			end
		end
	end

	return
end

function var_0_1.updateCapacity(arg_53_0)
	local var_53_0 = arg_53_0.contextData.warp

	StoreHouseConst = var_1_10002

	if var_53_0 == var_1_10002.WARP_TO_MATERIAL then
		return
	end

	setText = var_53_0

	var_53_0(arg_53_0.tip, "")

	setText = var_53_0

	local var_53_1 = arg_53_0.capacityTF
	local var_53_2 = arg_53_0.capacity
	local var_53_3 = "/"
	local var_53_4 = arg_53_0.player

	var_53_0(var_53_1, var_53_2 .. var_53_3 .. var_5.getMaxEquipmentBag(var_53_4))

	return
end

function var_0_1.setCapacity(arg_54_0, arg_54_1)
	arg_54_0.capacity = arg_54_1

	return
end

function var_0_1.UpdateSpweaponCapacity(arg_55_0)
	getProxy = var_1_10001
	EquipmentProxy = var_1_10002

	local var_55_0 = var_1_10001(var_1_10002)

	setText = var_1_10002

	var_1_10002(arg_55_0.capacityTF, var_55_0:GetSpWeaponCount() .. "/" .. var_55_0:GetSpWeaponCapacity())

	return
end

function var_0_1.setShip(arg_56_0, arg_56_1)
	arg_56_0.shipVO = arg_56_1
	setActive = var_1_10002

	local var_56_0 = arg_56_0.bottomPanel

	tobool = var_1_10004

	var_1_10002(var_56_0, not var_1_10004(arg_56_1))

	return
end

function var_0_1.setPlayer(arg_57_0, arg_57_1)
	arg_57_0.player = arg_57_1

	local var_57_0 = arg_57_0.contextData.warp

	StoreHouseConst = var_1_10003

	local var_57_1

	if var_57_0 == var_1_10003.WARP_TO_WEAPON and arg_57_0.page == var_0_3 then
		var_57_1 = arg_57_0

		arg_57_0.updateCapacity(var_57_1)
	else
		local var_57_2 = arg_57_0.contextData.warp

		StoreHouseConst = var_57_1

		if var_57_2 == var_57_1.WARP_TO_DESIGN and arg_57_0.contextData.designPage == var_0_6 then
			arg_57_0:updateCapacity()
		end
	end

	return
end

function var_0_1.initSort(arg_58_0)
	onButton = var_1_10001

	var_1_10001(arg_58_0, arg_58_0.decBtn, function()
		arg_58_0.asc = not arg_58_0.asc
		arg_58_0.contextData.asc = arg_58_0.asc

		local var_59_0 = arg_58_0

		var_0.filterEquipment(var_59_0)

		return
	end)

	arg_58_0.sortButtons = {}
	eachChild = var_1

	var_1(arg_58_0.sortContain, function(arg_60_0)
		setActive = var_2_10001

		var_2_10001(arg_60_0, false)

		return
	end)

	ipairs = var_1

	for iter_58_0, iter_58_1 in var_1(var_0_9.sort) do
		if iter_58_0 <= arg_58_0.sortContain.childCount then
			var_1_10007 = arg_58_0.sortContain

			local var_58_0

			if not var_58_0.GetChild(var_1_10007, iter_58_0 - 1) then
				cloneTplTo = var_58_0
				var_58_0 = var_58_0(arg_58_0.sortTpl, arg_58_0.sortContain)
			end

			setActive = var_1_10007

			var_1_10007(var_58_0, true)

			setImageSprite = var_1_10007
			findTF = var_8

			local var_58_1 = var_8(var_58_0, "Image")

			GetSpriteFromAtlas = var_9

			var_1_10007(var_58_1, var_9("ui/equipmentui_atlas", iter_58_1.spr), true)

			onToggle = var_1_10007

			local var_58_2 = arg_58_0
			local var_58_3 = var_58_0

			local function var_58_4(arg_61_0)
				if arg_61_0 then
					if arg_58_0.page == var_0_3 then
						arg_58_0.contextData.sortData = iter_58_1
					elseif arg_58_0.page == var_0_5 then
						arg_58_0.contextData.spweaponSortData = var_0_10.sort[iter_58_0]
					end

					local var_61_0 = arg_58_0

					var_1.filterEquipment(var_61_0)

					triggerToggle = var_1

					var_1(arg_58_0.sortBtn, false)
				end

				return
			end

			SFX_PANEL = var_11

			var_1_10007(var_58_2, var_58_3, var_58_4, var_11)

			var_1_10007 = arg_58_0.sortButtons
			var_1_10007[iter_58_0] = var_58_0
		end
	end

	return
end

function var_0_1.UpdateWeaponWrapButtons(arg_62_0)
	local var_62_0 = arg_62_0.page

	setActive = var_1_10002

	var_1_10002(arg_62_0.indexBtn, var_62_0 == var_0_3 or var_62_0 == var_0_5)

	setActive = var_1_10002

	var_1_10002(arg_62_0.sortBtn, var_62_0 == var_0_3 or var_62_0 == var_0_5)

	setActive = var_1_10002

	var_1_10002(arg_62_0.BatchDisposeBtn, var_62_0 == var_0_3)

	setActive = var_1_10002

	var_1_10002(arg_62_0.capacityTF.parent, var_62_0 == var_0_3 or var_62_0 == var_0_5)

	setActive = var_1_10002

	var_1_10002(arg_62_0.equipSkinFilteBtn, var_62_0 == var_0_4)

	setActive = var_1_10002

	local var_62_1 = arg_62_0.filterBusyToggle
	local var_62_2 = arg_62_0.mode

	StoreHouseConst = var_1_10005

	var_1_10002(var_62_1, var_62_2 == var_1_10005.OVERVIEW)

	setActive = var_1_10002

	local var_62_3 = arg_62_0.equipmentToggle
	local var_62_4 = arg_62_0.mode

	StoreHouseConst = var_5

	var_1_10002(var_62_3, var_62_4 == var_5.OVERVIEW and not arg_62_0.contextData.shipId)
	arg_62_0:updatePageFilterButtons(var_62_0)

	return
end

function var_0_1.updatePageFilterButtons(arg_63_0, arg_63_1)
	ipairs = var_1_10002

	for iter_63_0, iter_63_1 in var_1_10002(var_0_9.sort) do
		triggerToggle = var_1_10007

		var_1_10007(arg_63_0.sortButtons[iter_63_0], false)

		setActive = var_1_10007

		local var_63_0 = arg_63_0.sortButtons[iter_63_0]

		table = var_9

		var_1_10007(var_63_0, var_9.contains(iter_63_1.pages, arg_63_1))
	end

	return
end

function var_0_1.initEquipments(arg_64_0)
	arg_64_0.isInitWeapons = true

	local var_64_0 = arg_64_0.equipmentView

	arg_64_0.equipmentRect = var_1.GetComponent(var_64_0, "LScrollRect")

	function arg_64_0.equipmentRect.onInitItem(arg_65_0)
		local var_65_0 = arg_64_0

		var_1.initEquipment(var_65_0, arg_65_0)

		return
	end

	function arg_64_0.equipmentRect.onUpdateItem(arg_66_0, arg_66_1)
		local var_66_0 = arg_64_0

		var_2.updateEquipment(var_66_0, arg_66_0, arg_66_1)

		return
	end

	function arg_64_0.equipmentRect.onReturnItem(arg_67_0, arg_67_1)
		local var_67_0 = arg_64_0

		var_2.returnEquipment(var_67_0, arg_67_0, arg_67_1)

		return
	end

	function arg_64_0.equipmentRect.onStart()
		local var_68_0 = arg_64_0

		var_0.updateSelected(var_68_0)

		return
	end

	arg_64_0.equipmentRect.decelerationRate = 0.07

	return
end

function var_0_1.initEquipment(arg_69_0, arg_69_1)
	EquipmentItem = var_1_10002

	local var_69_0 = var_1_10002.New(arg_69_1)

	onButton = var_3

	local var_69_1 = arg_69_0
	local var_69_2 = var_69_0.unloadBtn

	local function var_69_3()
		if arg_69_0.page == var_0_4 then
			local var_70_0 = arg_69_0
			local var_70_1 = var_0.emit

			EquipmentMediator = var_2_10002

			var_70_1(var_70_0, var_2_10002.ON_UNEQUIP_EQUIPMENT_SKIN)
		elseif arg_69_0.page == var_0_3 then
			local var_70_2 = arg_69_0
			local var_70_3 = var_0.emit

			EquipmentMediator = var_2_10002

			var_70_3(var_70_2, var_2_10002.ON_UNEQUIP_EQUIPMENT)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_69_1, var_69_2, var_69_3, var_1_10007)

	onButton = var_3

	local var_69_4 = arg_69_0
	local var_69_5 = var_69_0.reduceBtn

	local function var_69_6()
		local var_71_0 = arg_69_0

		var_0.selectEquip(var_71_0, var_69_0.equipmentVO, 1)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_69_4, var_69_5, var_69_6, var_1_10007)

	arg_69_0.equipmetItems[arg_69_1] = var_69_0

	return
end

function var_0_1.updateEquipment(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = arg_72_0.equipmetItems[arg_72_2]

	assert = var_1_10004

	var_1_10004(var_72_0, "without init item")

	local var_72_1 = arg_72_0.loadEquipmentVOs[arg_72_1 + 1]

	var_72_0:update(var_72_1)

	local var_72_2 = false
	local var_72_3 = 0

	if var_72_1 then
		ipairs = var_7

		for iter_72_0, iter_72_1 in var_7(arg_72_0.selectedIds) do
			if var_72_1.id == iter_72_1[1] then
				var_72_2 = true
				var_72_3 = iter_72_1[2]

				break
			end
		end
	end

	var_72_0:updateSelected(var_72_2, var_72_3)

	if not var_72_1 then
		removeOnButton = var_7

		var_7(var_72_0.go)
	else
		isa = var_7

		local var_72_4 = var_72_1

		SpWeapon = var_9

		if var_7(var_72_4, var_9) then
			onButton = var_7
			var_72_4 = arg_72_0

			local var_72_5 = var_72_0.go

			local function var_72_6()
				if arg_72_0.shipVO then
					local var_73_0 = {}

					EquipmentInfoMediator = var_2_10001
					var_73_0.type = var_2_10001.TYPE_REPLACE
					var_73_0.shipId = arg_72_0.contextData.shipId

					local var_73_1 = var_72_1

					var_73_0.oldSpWeaponUid = var_1.GetUID(var_73_1)

					local var_73_2 = var_72_1

					var_73_0.oldShipId = var_1.GetShipId(var_73_2)

					if not var_73_0 then
						local var_73_3 = var_72_1

						if var_73_0.GetShipId(var_73_3) then
							var_73_0 = {}
							EquipmentInfoMediator = var_73_3
							var_73_0.type = var_73_3.TYPE_DISPLAY

							local var_73_4 = var_72_1

							var_73_0.spWeaponUid = var_73_3.GetUID(var_73_4)

							local var_73_5 = var_72_1

							var_73_0.shipId = var_73_3.GetShipId(var_73_5)

							if not var_73_0 then
								var_73_0 = {}
								EquipmentInfoMediator = var_73_3
								var_73_0.type = var_73_3.TYPE_DEFAULT

								local var_73_6 = var_72_1

								var_73_0.spWeaponUid = var_1.GetUID(var_73_6)
							end

							local var_73_7 = arg_72_0

							var_1.emit(var_73_7, var_0_1.ON_SPWEAPON, var_73_0)

							return
						end
					end
				end
			end

			SFX_PANEL = iter_72_1

			var_7(var_72_4, var_72_5, var_72_6, iter_72_1)
		elseif var_72_0.equipmentVO.isSkin then
			if var_72_1.shipId then
				onButton = var_7
				var_72_4 = arg_72_0

				local var_72_7 = var_72_0.go

				local function var_72_8()
					local var_74_0 = var_72_1.shipId
					local var_74_1 = var_72_1.shipPos

					assert = var_2_10002

					var_2_10002(var_74_1, "equipment skin pos is nil")

					local var_74_2 = arg_72_0
					local var_74_3 = var_2.emit

					EquipmentMediator = var_4

					var_74_3(var_74_2, var_4.ON_EQUIPMENT_SKIN_INFO, var_72_1.id, arg_72_0.contextData.pos, {
						id = var_74_0,
						pos = var_74_1
					})

					return
				end

				SFX_PANEL = iter_72_1

				var_7(var_72_4, var_72_7, var_72_8, iter_72_1)
			else
				onButton = var_7
				var_72_4 = arg_72_0

				local var_72_9 = var_72_0.go

				local function var_72_10()
					local var_75_0 = arg_72_0
					local var_75_1 = var_0.emit

					EquipmentMediator = var_2_10002

					var_75_1(var_75_0, var_2_10002.ON_EQUIPMENT_SKIN_INFO, var_72_1.id, arg_72_0.contextData.pos)

					return
				end

				SFX_PANEL = iter_72_1

				var_7(var_72_4, var_72_9, var_72_10, iter_72_1)
			end
		elseif var_72_1.mask then
			removeOnButton = var_7

			var_7(var_72_0.go)
		else
			local var_72_11 = arg_72_0.mode

			StoreHouseConst = var_72_4

			if var_72_11 == var_72_4.DESTROY then
				onButton = var_72_11

				local var_72_12 = arg_72_0
				local var_72_13 = var_72_0.go

				local function var_72_14()
					local var_76_0 = arg_72_0

					var_0.selectEquip(var_76_0, var_72_1, var_72_1.count)

					return
				end

				SFX_PANEL = iter_72_1

				var_72_11(var_72_12, var_72_13, var_72_14, iter_72_1)
			else
				onButton = var_72_11

				local var_72_15 = arg_72_0
				local var_72_16 = var_72_0.go

				local function var_72_17()
					if arg_72_0.shipVO then
						local var_77_0 = {}

						EquipmentInfoMediator = var_2_10001
						var_77_0.type = var_2_10001.TYPE_REPLACE
						var_77_0.equipmentId = var_72_1.id
						var_77_0.shipId = arg_72_0.contextData.shipId
						var_77_0.pos = arg_72_0.contextData.pos
						var_77_0.oldShipId = var_72_1.shipId
						var_77_0.oldPos = var_72_1.shipPos

						if not var_77_0 then
							if var_72_1.shipId then
								var_77_0 = {
									showTransformTip = true
								}
								EquipmentInfoMediator = var_2_10001
								var_77_0.type = var_2_10001.TYPE_DISPLAY
								var_77_0.equipmentId = var_72_1.id
								var_77_0.shipId = var_72_1.shipId
								var_77_0.pos = var_72_1.shipPos

								if not var_77_0 then
									var_77_0 = {
										destroy = true
									}
									EquipmentInfoMediator = var_2_10001
									var_77_0.type = var_2_10001.TYPE_DEFAULT
									var_77_0.equipmentId = var_72_1.id
								end

								local var_77_1 = arg_72_0

								var_1.emit(var_77_1, var_0_1.ON_EQUIPMENT, var_77_0)

								return
							end
						end
					end
				end

				SFX_PANEL = iter_72_1

				var_72_11(var_72_15, var_72_16, var_72_17, iter_72_1)
			end
		end
	end

	return
end

function var_0_1.returnEquipment(arg_78_0, arg_78_1, arg_78_2)
	if arg_78_0.exited then
		return
	end

	if arg_78_0.equipmetItems[arg_78_2] then
		removeOnButton = var_1_10004

		var_1_10004(var_3.go)
		var_3:clear()
	end

	return
end

function var_0_1.updateEquipmentCount(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0.equipmentRect

	var_2.SetTotalCount(var_79_0, arg_79_1 or #arg_79_0.loadEquipmentVOs, -1)

	setActive = var_2

	var_2(arg_79_0.listEmptyTF, (arg_79_1 or #arg_79_0.loadEquipmentVOs) <= 0)

	setText = var_2

	local var_79_1 = arg_79_0.listEmptyTxt

	i18n = var_4

	var_2(var_79_1, var_4("list_empty_tip_storehouseui_equip"))

	Canvas = var_2

	var_2.ForceUpdateCanvases()

	return
end

function var_0_1.filterEquipment(arg_80_0)
	if arg_80_0.filterEquipWaitting > 0 then
		arg_80_0.filterEquipWaitting = arg_80_0.filterEquipWaitting - 1

		return
	end

	if arg_80_0.page == var_0_4 then
		arg_80_0:filterEquipSkin()

		return
	elseif arg_80_0.page == var_0_5 then
		arg_80_0:filterSpWeapon()

		return
	end

	local var_80_0 = arg_80_0
	local var_80_1 = arg_80_0.isDefaultStatus(var_80_0) and "shaixuan_off" or "shaixuan_on"

	GetSpriteFromAtlasAsync = var_80_0

	var_80_0("ui/share/index_atlas", var_80_1, function(arg_81_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_80_0.indexBtn, arg_81_0, true)

		return
	end)

	local var_80_2 = {}

	arg_80_0.loadEquipmentVOs = {}
	pairs = var_3

	for iter_80_0, iter_80_1 in var_3(arg_80_0.equipmentVOs) do
		if not iter_80_1.isSkin then
			table = var_8

			var_8.insert(var_80_2, iter_80_1)
		end
	end

	local var_80_3 = {
		arg_80_0.contextData.indexDatas.equipPropertyIndex,
		arg_80_0.contextData.indexDatas.equipPropertyIndex2
	}

	pairs = var_4

	for iter_80_4, iter_80_3 in var_4(var_80_2) do
		if (iter_80_3.count > 0 or iter_80_3.shipId) and arg_80_0:checkFitBusyCondition(iter_80_3) then
			IndexConst = var_1_10009

			if var_1_10009.filterEquipByType(iter_80_3, arg_80_0.contextData.indexDatas.typeIndex) then
				IndexConst = var_1_10009

				if var_1_10009.filterEquipByProperty(iter_80_3, var_80_3) then
					IndexConst = var_1_10009

					if var_1_10009.filterEquipAmmo1(iter_80_3, arg_80_0.contextData.indexDatas.equipAmmoIndex1) then
						IndexConst = var_1_10009

						if var_1_10009.filterEquipAmmo2(iter_80_3, arg_80_0.contextData.indexDatas.equipAmmoIndex2) then
							IndexConst = var_1_10009

							if var_1_10009.filterEquipByCamp(iter_80_3, arg_80_0.contextData.indexDatas.equipCampIndex) then
								IndexConst = var_1_10009

								if var_1_10009.filterEquipByRarity(iter_80_3, arg_80_0.contextData.indexDatas.rarityIndex) then
									IndexConst = var_1_10009

									if var_1_10009.filterEquipByExtra(iter_80_3, arg_80_0.contextData.indexDatas.extraIndex) then
										table = var_1_10009

										var_1_10009.insert(arg_80_0.loadEquipmentVOs, iter_80_3)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if arg_80_0.filterImportance ~= nil then
		for iter_80_4 = #arg_80_0.loadEquipmentVOs, 1, -1 do
			if arg_80_0.loadEquipmentVOs[iter_80_4].isSkin or not var_8.isSkin and var_8:isImportance() then
				table = var_1_10009

				var_1_10009.remove(arg_80_0.loadEquipmentVOs, iter_80_4)
			end
		end
	end

	local var_80_4 = arg_80_0.searchBar

	if var_4.GetInputText(var_80_4) and var_4 ~= "" then
		underscore = var_80_4
		arg_80_0.loadEquipmentVOs = var_80_4.filter(arg_80_0.loadEquipmentVOs, function(arg_82_0)
			return arg_82_0:IsMatchKey(var_0)
		end)
	end

	if arg_80_0.contextData.sortData then
		local var_80_5 = arg_80_0.asc

		table = iter_80_4

		local var_80_6 = iter_80_4.sort
		local var_80_7 = arg_80_0.loadEquipmentVOs

		CompareFuncs = var_1_10009

		var_80_6(var_80_7, var_1_10009(var_0_9.sortFunc(var_5, var_80_5)))
	end

	if arg_80_0.contextData.qiutBtn then
		table = var_6

		var_6.insert(arg_80_0.loadEquipmentVOs, 1, false)
	end

	arg_80_0:updateSelected()
	arg_80_0:updateEquipmentCount()

	setImageSprite = var_6

	local var_80_8 = arg_80_0.sortBtn
	local var_80_9 = var_7.Find(var_80_8, "Image")

	GetSpriteFromAtlas = var_80_8

	var_6(var_80_9, var_80_8("ui/equipmentui_atlas", var_5.spr), true)

	setActive = var_6

	var_6(arg_80_0.sortImgAsc, arg_80_0.asc)

	setActive = var_6

	var_6(arg_80_0.sortImgDec, not arg_80_0.asc)
	arg_80_0:updateCapacity()

	return
end

function var_0_1.filterEquipSkin(arg_83_0)
	local var_83_0 = arg_83_0.equipSkinIndex
	local var_83_1 = arg_83_0.equipSkinTheme
	local var_83_2 = arg_83_0.page
	local var_83_3 = {}

	arg_83_0.loadEquipmentVOs = {}

	if var_83_2 ~= var_0_4 then
		assert = var_5

		var_5(false, "不是外观分页")
	end

	local var_83_4 = arg_83_0.searchBar
	local var_83_5 = var_5.GetInputText(var_83_4)

	pairs = var_83_4

	for iter_83_0, iter_83_1 in var_83_4(arg_83_0.equipmentVOs) do
		if iter_83_1.isSkin and iter_83_1.count > 0 then
			if var_83_5 ~= "" then
				EquipmentTools = var_1_10011

				if var_1_10011.IsMatchEquipmentSkinKey(iter_83_1.id, var_83_5) then
					table = var_1_10011

					var_1_10011.insert(var_83_3, iter_83_1)
				end
			end
		end
	end

	pairs = var_6

	for iter_83_2, iter_83_3 in var_6(var_83_3) do
		IndexConst = var_1_10011

		if var_1_10011.filterEquipSkinByIndex(iter_83_3, var_83_0) then
			IndexConst = var_1_10011

			if var_1_10011.filterEquipSkinByTheme(iter_83_3, var_83_1) and arg_83_0:checkFitBusyCondition(iter_83_3) then
				table = var_1_10011

				var_1_10011.insert(arg_83_0.loadEquipmentVOs, iter_83_3)
			end
		end
	end

	if arg_83_0.filterImportance ~= nil then
		for iter_83_4 = #arg_83_0.loadEquipmentVOs, 1, -1 do
			if arg_83_0.loadEquipmentVOs[iter_83_4].isSkin or not iter_83_3.isSkin and iter_83_3:isImportance() then
				table = var_11

				var_11.remove(arg_83_0.loadEquipmentVOs, iter_83_4)
			end
		end
	end

	if arg_83_0.contextData.sortData then
		local var_83_6 = arg_83_0.asc

		table = var_8

		local var_83_7 = var_8.sort
		local var_83_8 = arg_83_0.loadEquipmentVOs

		CompareFuncs = iter_83_3

		var_83_7(var_83_8, iter_83_3(var_0_9.sortFunc(var_6, var_83_6)))
	end

	if arg_83_0.contextData.qiutBtn then
		table = var_7

		var_7.insert(arg_83_0.loadEquipmentVOs, 1, false)
	end

	arg_83_0:updateSelected()
	arg_83_0:updateEquipmentCount()

	setActive = var_7

	var_7(arg_83_0.sortImgAsc, arg_83_0.asc)

	setActive = var_7

	var_7(arg_83_0.sortImgDec, not arg_83_0.asc)

	return
end

function var_0_1.filterSpWeapon(arg_84_0)
	if arg_84_0.page ~= var_0_5 then
		assert = var_2

		var_2(false, "不是特殊兵装分页")
	end

	local var_84_0 = arg_84_0
	local var_84_1 = arg_84_0.isDefaultSpWeaponIndexData(var_84_0) and "shaixuan_off" or "shaixuan_on"

	GetSpriteFromAtlasAsync = var_84_0

	var_84_0("ui/share/index_atlas", var_84_1, function(arg_85_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_84_0.indexBtn, arg_85_0, true)

		return
	end)

	arg_84_0.loadEquipmentVOs = {}

	local var_84_2 = arg_84_0.contextData.spweaponIndexDatas.typeIndex
	local var_84_3 = arg_84_0.contextData.spweaponIndexDatas.rarityIndex

	pairs = var_5

	for iter_84_0, iter_84_1 in var_5(arg_84_0.spweaponVOs) do
		IndexConst = var_1_10010

		if var_1_10010.filterSpWeaponByType(iter_84_1, var_84_2) then
			IndexConst = var_1_10010

			if var_1_10010.filterSpWeaponByRarity(iter_84_1, var_84_3) and arg_84_0:checkFitBusyCondition(iter_84_1) and (arg_84_0.filterImportance == nil or iter_84_1:IsImportant()) then
				table = var_1_10010

				var_1_10010.insert(arg_84_0.loadEquipmentVOs, iter_84_1)
			end
		end
	end

	local var_84_4 = arg_84_0.searchBar

	if var_5.GetInputText(var_84_4) and var_5 ~= "" then
		EquipmentTools = var_84_4

		local var_84_5 = var_84_4.GetMatchSpEquipmentListKeyByShip(var_5)

		underscore = var_7
		arg_84_0.loadEquipmentVOs = var_7.filter(arg_84_0.loadEquipmentVOs, function(arg_86_0)
			local var_86_0

			if not arg_86_0:IsMatchKey(var_0) then
				table = var_86_0
				var_86_0 = var_86_0.contains(var_84_5, arg_86_0.id)
			end

			return var_86_0
		end)
	end

	if arg_84_0.contextData.spweaponSortData then
		local var_84_6 = arg_84_0.asc

		table = iter_84_0

		local var_84_7 = iter_84_0.sort
		local var_84_8 = arg_84_0.loadEquipmentVOs

		CompareFuncs = var_1_10010

		var_84_7(var_84_8, var_1_10010(var_0_10.sortFunc(var_6, var_84_6)))
	end

	if arg_84_0.contextData.qiutBtn then
		table = var_7

		var_7.insert(arg_84_0.loadEquipmentVOs, 1, false)
	end

	arg_84_0:updateSelected()
	arg_84_0:updateEquipmentCount()

	setImageSprite = var_7

	local var_84_9 = arg_84_0.sortBtn
	local var_84_10 = var_8.Find(var_84_9, "Image")

	GetSpriteFromAtlas = var_84_9

	var_7(var_84_10, var_84_9("ui/equipmentui_atlas", var_6.spr), true)

	setActive = var_7

	var_7(arg_84_0.sortImgAsc, arg_84_0.asc)

	setActive = var_7

	var_7(arg_84_0.sortImgDec, not arg_84_0.asc)
	arg_84_0:UpdateSpweaponCapacity()

	return
end

function var_0_1.GetShowBusyFlag(arg_87_0)
	return arg_87_0.isEquipingOn
end

function var_0_1.SetShowBusyFlag(arg_88_0, arg_88_1)
	arg_88_0.isEquipingOn = arg_88_1

	return
end

function var_0_1.Scroll2Equip(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_0.contextData.warp

	StoreHouseConst = var_1_10003

	if var_89_0 ~= var_1_10003.WARP_TO_WEAPON or arg_89_0.page ~= var_0_3 then
		return
	end

	ipairs = var_89_0

	for iter_89_0, iter_89_1 in var_89_0(arg_89_0.loadEquipmentVOs) do
		EquipmentProxy = var_1_10007

		if var_1_10007.SameEquip(iter_89_1, arg_89_1) then
			local var_89_1 = arg_89_0.equipmentView
			local var_89_2 = var_1_10007.Find(var_89_1, "equipment_grid")

			var_1_10007 = var_1_10007.GetComponent
			typeof = var_9
			GridLayoutGroup = var_1_10010

			local var_89_3 = var_1_10007(var_89_2, var_9(var_1_10010)).cellSize.y + var_1_10007.spacing.y

			math = var_9

			local var_89_4 = var_89_3 * var_9.floor((iter_89_0 - 1) / var_1_10007.constraintCount) + arg_89_0.equipmentRect.paddingFront + arg_89_0.equipmentView.rect.height * 0.5

			arg_89_0:ScrollEquipPos(var_89_4 - arg_89_0.equipmentRect.paddingFront)

			break
		end
	end

	return
end

function var_0_1.ScrollEquipPos(arg_90_0, arg_90_1)
	local var_90_0 = arg_90_0.equipmentView
	local var_90_1 = var_2.Find(var_90_0, "equipment_grid")
	local var_90_2 = var_2.GetComponent

	typeof = var_4
	GridLayoutGroup = var_1_10005

	local var_90_3 = var_90_2(var_90_1, var_4(var_1_10005)).cellSize.y + var_2.spacing.y

	math = var_4

	local var_90_4 = var_90_3 * var_4.ceil(#arg_90_0.loadEquipmentVOs / var_2.constraintCount) - var_2.spacing.y + arg_90_0.equipmentRect.paddingFront + arg_90_0.equipmentRect.paddingEnd - arg_90_0.equipmentView.rect.height > 0 and var_90_4 or var_4
	local var_90_5 = (arg_90_1 - arg_90_0.equipmentView.rect.height * 0.5) / var_90_4
	local var_90_6 = arg_90_0.equipmentRect

	var_7.ScrollTo(var_90_6, var_90_5)

	return
end

function var_0_1.checkFitBusyCondition(arg_91_0, arg_91_1)
	if arg_91_1.shipId then
		local var_91_0 = arg_91_0
		local var_91_1

		if arg_91_0.GetShowBusyFlag(var_91_0) then
			var_91_1 = arg_91_0.mode
			StoreHouseConst = var_91_0

			if var_91_1 == var_91_0.DESTROY then
				var_91_1 = false

				goto label_91_0
			end

			var_91_1 = true
		end

		::label_91_0::

		return var_91_1
	end
end

function var_0_1.setItems(arg_92_0, arg_92_1)
	arg_92_0.itemVOs = arg_92_1

	if arg_92_0.isInitItems then
		local var_92_0 = arg_92_0.contextData.warp

		StoreHouseConst = var_1_10003

		if var_92_0 == var_1_10003.WARP_TO_MATERIAL then
			arg_92_0:sortItems()
		end
	end

	return
end

function var_0_1.initItems(arg_93_0)
	arg_93_0.isInitItems = true

	local var_93_0 = arg_93_0.itemView

	arg_93_0.itemRect = var_1.GetComponent(var_93_0, "LScrollRect")

	function arg_93_0.itemRect.onInitItem(arg_94_0)
		local var_94_0 = arg_93_0

		var_1.initItem(var_94_0, arg_94_0)

		return
	end

	function arg_93_0.itemRect.onUpdateItem(arg_95_0, arg_95_1)
		local var_95_0 = arg_93_0

		var_2.updateItem(var_95_0, arg_95_0, arg_95_1)

		return
	end

	function arg_93_0.itemRect.onReturnItem(arg_96_0, arg_96_1)
		local var_96_0 = arg_93_0

		var_2.returnItem(var_96_0, arg_96_0, arg_96_1)

		return
	end

	arg_93_0.itemRect.decelerationRate = 0.07

	return
end

function var_0_1.sortItems(arg_97_0)
	table = var_1_10001

	local var_97_0 = var_1_10001.sort
	local var_97_1 = arg_97_0.itemVOs

	CompareFuncs = var_1_10003

	var_97_0(var_97_1, var_1_10003({
		function(arg_98_0)
			return -arg_98_0:getConfig("order")
		end,
		function(arg_99_0)
			return -arg_99_0:getConfig("rarity")
		end,
		function(arg_100_0)
			return arg_100_0.id
		end
	}))

	local var_97_2 = arg_97_0.itemRect

	var_1.SetTotalCount(var_97_2, #arg_97_0.itemVOs, -1)

	setActive = var_1

	var_1(arg_97_0.listEmptyTF, #arg_97_0.itemVOs <= 0)

	setText = var_1

	local var_97_3 = arg_97_0.listEmptyTxt

	i18n = var_3

	var_1(var_97_3, var_3("list_empty_tip_storehouseui_item"))

	Canvas = var_1

	var_1.ForceUpdateCanvases()

	return
end

function var_0_1.initItem(arg_101_0, arg_101_1)
	local var_101_0 = arg_101_0.itemCards

	ItemCard = var_1_10003
	var_101_0[arg_101_1] = var_1_10003.New(arg_101_1)

	return
end

function var_0_1.updateItem(arg_102_0, arg_102_1, arg_102_2)
	local var_102_0 = arg_102_0.itemCards[arg_102_2]

	assert = var_1_10004

	var_1_10004(var_102_0, "without init item")

	local var_102_1 = arg_102_0.itemVOs[arg_102_1 + 1]
	local var_102_2 = var_102_0

	var_102_0.update(var_102_2, var_102_1)

	if not var_102_1 then
		removeOnButton = var_5

		var_5(var_102_0.go)

		goto label_102_0
	end

	tobool = var_5
	getProxy = var_102_2
	TechnologyProxy = var_7

	local var_102_3 = var_102_2(var_7)

	if var_5(var_6.getItemCanUnlockBluePrint(var_102_3, var_102_1.id)) then
		getProxy = var_5
		TechnologyProxy = var_6

		local var_102_4 = var_5(var_6)

		underscore = var_6

		local var_102_5 = var_6.map(var_102_4:getItemCanUnlockBluePrint(var_102_1.id), function(arg_103_0)
			local var_103_0 = var_102_4

			return var_1.getBluePrintById(var_103_0, arg_103_0)
		end)

		underscore = var_7

		if var_7.detect(var_102_5, function(arg_104_0)
			return not arg_104_0:isUnlock()
		end) then
			onButton = var_8
			var_1_10009 = arg_102_0

			local var_102_6 = var_102_0.go

			local function var_102_7()
				pg = var_2_10000

				local var_105_0 = var_2_10000.MsgboxMgr.GetInstance()
				local var_105_1 = var_0.ShowMsgBox
				local var_105_2 = {}

				MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM = var_2_10003
				var_105_2.type = var_2_10003
				var_105_2.item = var_102_1
				var_105_2.blueprints = var_102_5

				function var_105_2.onYes()
					local var_106_0 = arg_102_0
					local var_106_1 = var_0.emit

					EquipmentMediator = var_3_10002

					local var_106_2 = var_3_10002.ITEM_GO_SCENE

					SCENE = var_3_10003

					var_106_1(var_106_0, var_106_2, var_3_10003.SHIPBLUEPRINT, {
						shipBluePrintVO = var_0
					})

					return
				end

				i18n = var_3
				var_105_2.yesText = var_3("text_forward")

				var_105_1(var_105_0, var_105_2)

				return
			end

			SFX_PANEL = var_1_10012

			var_8(var_1_10009, var_102_6, var_102_7, var_1_10012)
		else
			onButton = var_8
			var_1_10009 = arg_102_0

			local var_102_8 = var_102_0.go

			local function var_102_9()
				pg = var_2_10000

				local var_107_0 = var_2_10000.MsgboxMgr.GetInstance()
				local var_107_1 = var_0.ShowMsgBox
				local var_107_2 = {}

				MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM = var_2_10003
				var_107_2.type = var_2_10003
				Vector2 = var_2_10003
				var_107_2.windowSize = var_2_10003(1010, 685)
				var_107_2.item = var_102_1
				var_107_2.blueprints = var_102_5

				function var_107_2.onYes()
					pg = var_3_10000

					local var_108_0 = var_3_10000.MsgboxMgr.GetInstance()
					local var_108_1 = var_0.ShowMsgBox
					local var_108_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10003
					var_108_2.type = var_3_10003
					i18n = var_3_10003
					var_108_2.content = var_3_10003("techpackage_item_use_confirm")
					underscore = var_3

					local var_108_3 = var_3.map
					local var_108_4 = var_102_1

					var_108_2.items = var_108_3(var_4.getConfig(var_108_4, "display_icon"), function(arg_109_0)
						return {
							type = arg_109_0[1],
							id = arg_109_0[2],
							count = arg_109_0[3]
						}
					end)

					function var_108_2.onYes()
						local var_110_0 = arg_102_0
						local var_110_1 = var_0.emit

						EquipmentMediator = var_4_10002

						var_110_1(var_110_0, var_4_10002.ON_USE_ITEM, var_102_1.id, 1)

						return
					end

					var_108_1(var_108_0, var_108_2)

					return
				end

				var_107_1(var_107_0, var_107_2)

				return
			end

			SFX_PANEL = var_1_10012

			var_8(var_1_10009, var_102_8, var_102_9, var_1_10012)
		end

		goto label_102_0
	end

	local var_102_10 = var_102_1
	local var_102_11 = var_102_1.getConfig(var_102_10, "type")

	Item = var_102_10

	if var_102_11 == var_102_10.INVITATION_TYPE then
		onButton = var_102_11

		local var_102_12 = arg_102_0
		local var_102_13 = var_102_0.go

		local function var_102_14()
			local var_111_0 = arg_102_0
			local var_111_1 = var_0.emit

			EquipmentMediator = var_2_10002

			local var_111_2 = var_2_10002.ITEM_GO_SCENE

			SCENE = var_2_10003

			var_111_1(var_111_0, var_111_2, var_2_10003.INVITATION, {
				itemVO = var_102_1
			})

			return
		end

		SFX_PANEL = var_1_10009

		var_102_11(var_102_12, var_102_13, var_102_14, var_1_10009)

		goto label_102_0
	end

	local var_102_15 = var_102_1
	local var_102_16 = var_102_1.getConfig(var_102_15, "type")

	Item = var_102_15

	if var_102_16 ~= var_102_15.ASSIGNED_TYPE then
		do
			local var_102_17 = var_102_1

			var_102_16 = var_102_1.getConfig(var_102_17, "type")
			Item = var_102_17

			if var_102_16 == var_102_17.EQUIPMENT_ASSIGNED_TYPE then
				underscore = var_102_16
				var_102_16 = var_102_16.any
				pg = var_102_17

				if var_102_16(var_102_17.gameset.general_blueprint_list.description, function(arg_112_0)
					return var_102_1.id == arg_112_0
				end) then
					onButton = var_102_16

					local var_102_18 = arg_102_0
					local var_102_19 = var_102_0.go

					local function var_102_20()
						local var_113_0 = arg_102_0.blueprintAssignedItemView

						var_0.Load(var_113_0)

						local var_113_1 = arg_102_0.blueprintAssignedItemView

						var_0.ActionInvoke(var_113_1, "Show")

						local var_113_2 = arg_102_0.blueprintAssignedItemView

						var_0.ActionInvoke(var_113_2, "update", var_102_1)

						return
					end

					SFX_PANEL = var_1_10009

					var_102_16(var_102_18, var_102_19, var_102_20, var_1_10009)
				else
					onButton = var_102_16

					local var_102_21 = arg_102_0
					local var_102_22 = var_102_0.go

					local function var_102_23()
						local var_114_0 = arg_102_0.assignedItemView

						var_0.Load(var_114_0)

						local var_114_1 = arg_102_0.assignedItemView

						var_0.ActionInvoke(var_114_1, "Show")

						local var_114_2 = arg_102_0.assignedItemView

						var_0.ActionInvoke(var_114_2, "update", var_102_1)

						return
					end

					SFX_PANEL = var_1_10009

					var_102_16(var_102_21, var_102_22, var_102_23, var_1_10009)
				end
			else
				Item = var_102_16

				if var_102_16.IsLoveLetterCheckItem(var_102_1.id) then
					onButton = var_5

					local var_102_24 = arg_102_0
					local var_102_25 = var_102_0.go

					local function var_102_26()
						local var_115_0 = arg_102_0

						var_0.emit(var_115_0, var_0_1.ON_ITEM_EXTRA, var_102_1.id, var_102_1.extra)

						return
					end

					SFX_PANEL = var_1_10009

					var_5(var_102_24, var_102_25, var_102_26, var_1_10009)
				else
					local var_102_27 = var_102_1
					local var_102_28 = var_102_1.getConfig(var_102_27, "type")

					Item = var_102_27

					if var_102_28 == var_102_27.LOVE_LETTER_TYPE then
						onButton = var_102_28

						local var_102_29 = arg_102_0
						local var_102_30 = var_102_0.go

						local function var_102_31()
							local var_116_0 = arg_102_0

							var_0.emit(var_116_0, var_0_1.ON_ITEM_EXTRA, var_102_1.id, var_102_1.extra)

							return
						end

						SFX_PANEL = var_1_10009

						var_102_28(var_102_29, var_102_30, var_102_31, var_1_10009)
					else
						local var_102_32 = var_102_1
						local var_102_33 = var_102_1.getConfig(var_102_32, "type")

						Item = var_102_32

						if var_102_33 == var_102_32.SKIN_ASSIGNED_TYPE then
							onButton = var_102_33

							local var_102_34 = arg_102_0
							local var_102_35 = var_102_0.go

							local function var_102_36()
								local var_117_0 = arg_102_0

								var_0.emit(var_117_0, var_0_1.ON_ITEM, var_102_1.id, function()
									local var_118_0 = var_102_1
									local var_118_1 = var_0.getConfig(var_118_0, "usage_arg")
									local var_118_2 = var_102_1

									if var_1.IsAllSkinOwner(var_118_2) then
										Drop = var_1

										local var_118_3 = var_1.New

										var_118_2 = {
											count = 1
										}
										DROP_TYPE_ITEM = var_3_10003
										var_118_2.type = var_3_10003
										var_118_2.id = var_118_1[5]

										local var_118_4 = var_118_3(var_118_2)
										local var_118_5 = arg_102_0.msgBox

										var_118_2 = var_118_2.ExecuteAction

										local var_118_6 = "Show"
										local var_118_7 = {}

										i18n = var_3_10006
										var_3_10007 = "blackfriday_pack_select_skinall_dialog"

										local var_118_8 = var_102_1

										var_118_7.content = var_3_10006(var_3_10007, var_3_10008.getConfig(var_118_8, "name"), var_118_4:getName())

										local var_118_9 = {
											count = 1
										}

										DROP_TYPE_ITEM = var_3_10007
										var_118_9.type = var_3_10007
										var_118_9.id = var_102_1.id
										var_118_7.leftDrop = var_118_9
										var_118_7.rightDrop = var_118_4

										function var_118_7.onYes()
											local var_119_0 = arg_102_0
											local var_119_1 = var_0.emit

											EquipmentMediator = var_4_10002

											var_119_1(var_119_0, var_4_10002.ON_USE_ITEM, var_102_1.id, 1, {
												0
											})

											return
										end

										var_118_2(var_118_5, var_118_6, var_118_7)
									else
										local var_118_10 = {}

										ipairs = var_118_2

										for iter_118_0, iter_118_1 in var_118_2(var_118_1[2]) do
											var_118_10[iter_118_1] = true
										end

										local var_118_11 = arg_102_0
										local var_118_12 = var_2.emit

										EquipmentMediator = var_4

										local var_118_13 = var_4.ITEM_ADD_LAYER

										Context = iter_118_0

										local var_118_14 = iter_118_0.New
										local var_118_15 = {}

										NewSelectSkinLayer = var_3_10007
										var_118_15.viewComponent = var_3_10007
										NewSkinAtlasMediator = var_3_10007
										var_118_15.mediator = var_3_10007

										local var_118_16 = {}

										SelectSkinLayer = var_3_10008
										var_118_16.mode = var_3_10008.MODE_SELECT
										var_118_16.itemId = var_102_1.id
										underscore = var_8

										local var_118_17 = var_8.map
										local var_118_18 = var_102_1

										var_118_16.selectableSkinList = var_118_17(var_9.GetValidSkinList(var_118_18), function(arg_120_0)
											SelectableSkin = var_4_10001

											local var_120_0 = var_4_10001.New
											local var_120_1 = {
												id = arg_120_0
											}
											local var_120_2

											if not var_118_10[arg_120_0] then
												var_120_2 = false
											end

											var_120_1.isTimeLimit = var_120_2

											return var_120_0(var_120_1)
										end)

										function var_118_16.OnConfirm(arg_121_0)
											local var_121_0 = arg_102_0
											local var_121_1 = var_1.emit

											EquipmentMediator = var_4_10003

											var_121_1(var_121_0, var_4_10003.ON_USE_ITEM, var_102_1.id, 1, {
												arg_121_0
											})

											return
										end

										var_118_15.data = var_118_16

										var_118_12(var_118_11, var_118_13, var_118_14(var_118_15))
									end

									return
								end)

								return
							end

							SFX_PANEL = var_1_10009

							var_102_33(var_102_34, var_102_35, var_102_36, var_1_10009)
						else
							onButton = var_102_33

							local var_102_37 = arg_102_0
							local var_102_38 = var_102_0.go

							local function var_102_39()
								local var_122_0 = arg_102_0

								var_0.emit(var_122_0, var_0_1.ON_ITEM, var_102_1.id)

								return
							end

							SFX_PANEL = var_1_10009

							var_102_33(var_102_37, var_102_38, var_102_39, var_1_10009)
						end
					end
				end
			end
		end

		::label_102_0::

		return
	end
end

function var_0_1.returnItem(arg_123_0, arg_123_1, arg_123_2)
	if arg_123_0.exited then
		return
	end

	if arg_123_0.itemCards[arg_123_2] then
		removeOnButton = var_1_10004

		var_1_10004(var_3.go)
		var_3:clear()
	end

	return
end

function var_0_1.selectCount(arg_124_0)
	local var_124_0 = 0

	ipairs = var_1_10002

	for iter_124_0, iter_124_1 in var_1_10002(arg_124_0.selectedIds) do
		var_124_0 = var_124_0 + iter_124_1[2]
	end

	return var_124_0
end

function var_0_1.selectEquip(arg_125_0, arg_125_1, arg_125_2)
	local var_125_0 = arg_125_0

	if not arg_125_0.checkDestroyGold(var_125_0, arg_125_1, arg_125_2) then
		return
	end

	local var_125_1 = arg_125_0.mode

	StoreHouseConst = var_125_0

	if var_125_1 == var_125_0.DESTROY then
		local var_125_2 = false
		local var_125_3
		local var_125_4 = 0

		pairs = var_6

		for iter_125_0, iter_125_1 in var_6(arg_125_0.selectedIds) do
			if iter_125_1[1] == arg_125_1.id then
				var_125_2 = true
				var_125_3 = iter_125_0
				var_125_4 = iter_125_1[2]

				break
			end
		end

		if not var_125_2 then
			local var_125_5, var_125_6 = arg_125_0.checkEquipment(arg_125_1, function()
				local var_126_0 = arg_125_0

				var_0.selectEquip(var_126_0, arg_125_1, arg_125_2)

				return
			end, arg_125_0.selectedIds)

			if not var_125_5 then
				if var_125_6 then
					pg = var_8

					local var_125_7 = var_8.TipsMgr.GetInstance()

					var_8.ShowTips(var_125_7, var_125_6)
				end

				return
			end

			local var_125_8 = arg_125_0:selectCount()

			if arg_125_0.selectedMax > 0 and var_125_8 + arg_125_2 > arg_125_0.selectedMax then
				arg_125_2 = arg_125_0.selectedMax - var_125_8
			end

			if arg_125_0.selectedMax == 0 or var_125_8 < arg_125_0.selectedMax then
				table = var_9

				var_9.insert(arg_125_0.selectedIds, {
					arg_125_1.id,
					arg_125_2
				})
			else
				local var_125_9

				if arg_125_0.selectedMax == 1 then
					var_125_9 = arg_125_0.selectedIds
					var_125_9[1] = {
						arg_125_1.id,
						arg_125_2
					}
				else
					pg = var_125_9

					local var_125_10 = var_125_9.TipsMgr.GetInstance()
					local var_125_11 = var_9.ShowTips

					i18n = var_1_10011

					var_125_11(var_125_10, var_1_10011("equipment_equipmentScene_selectError_more", arg_125_0.selectedMax))

					return
				end
			end
		else
			local var_125_12

			if var_125_4 - arg_125_2 > 0 then
				var_125_12 = arg_125_0.selectedIds[var_125_3]
				var_125_12[2] = var_125_4 - arg_125_2
			else
				table = var_125_12

				var_125_12.remove(arg_125_0.selectedIds, var_125_3)
			end
		end
	end

	arg_125_0:updateSelected()

	return
end

function var_0_1.unselecteAllEquips(arg_127_0)
	arg_127_0.selectedIds = {}

	arg_127_0:updateSelected()

	return
end

function var_0_1.checkDestroyGold(arg_128_0, arg_128_1, arg_128_2)
	local var_128_0 = 0
	local var_128_1 = false

	pairs = var_1_10005

	for iter_128_0, iter_128_1 in var_1_10005(arg_128_0.selectedIds) do
		local var_128_2 = iter_128_1[2]

		Equipment = var_1_10011

		if var_1_10011.CanInBag(iter_128_1[1]) then
			Equipment = var_1_10011

			local var_128_3

			if not var_1_10011.getConfigData(iter_128_1[1]).destory_gold then
				var_128_3 = 0
			end

			var_128_0 = var_128_0 + var_128_3 * var_128_2
		end

		if arg_128_1 and iter_128_1[1] == arg_128_1.configId then
			var_128_1 = true
		end
	end

	if not var_128_1 and arg_128_1 and arg_128_2 > 0 then
		local var_128_4

		if not arg_128_1:getConfig("destory_gold") then
			var_128_4 = 0
		end

		var_128_0 = var_128_0 + var_128_4 * arg_128_2
	end

	local var_128_5 = arg_128_0.player

	if var_5.GoldMax(var_128_5, var_128_0) then
		pg = var_5

		local var_128_6 = var_5.TipsMgr.GetInstance()
		local var_128_7 = var_5.ShowTips

		i18n = var_7

		local var_128_8 = var_7("gold_max_tip_title")

		i18n = var_8

		var_128_7(var_128_6, var_128_8 .. var_8("resource_max_tip_destroy"))

		return false
	end

	return true
end

function var_0_1.updateSelected(arg_129_0)
	pairs = var_1_10001

	for iter_129_0, iter_129_1 in var_1_10001(arg_129_0.equipmetItems) do
		if iter_129_1.equipmentVO then
			local var_129_0 = false
			local var_129_1 = 0

			pairs = var_1_10008

			for iter_129_2, iter_129_3 in var_1_10008(arg_129_0.selectedIds) do
				if iter_129_1.equipmentVO.id == iter_129_3[1] then
					var_129_0 = true
					var_129_1 = iter_129_3[2]

					break
				end
			end

			iter_129_1:updateSelected(var_129_0, var_129_1)
		end
	end

	local var_129_2 = arg_129_0.mode

	StoreHouseConst = var_2

	if var_129_2 == var_2.DESTROY then
		local var_129_3 = arg_129_0:selectCount()

		if arg_129_0.selectedMax == 0 then
			setText = var_2
			findTF = var_3

			var_2(var_3(arg_129_0.selectPanel, "bottom_info/bg_input/count"), var_129_3)
		else
			setText = var_2
			findTF = var_3

			var_2(var_3(arg_129_0.selectPanel, "bottom_info/bg_input/count"), var_129_3 .. "/" .. arg_129_0.selectedMax)
		end

		if #arg_129_0.selectedIds < arg_129_0.selectedMin then
			setActive = var_2
			findTF = var_3

			var_2(var_3(arg_129_0.selectPanel, "confirm_button/mask"), true)
		else
			setActive = var_2
			findTF = var_3

			var_2(var_3(arg_129_0.selectPanel, "confirm_button/mask"), false)
		end
	end

	return
end

function var_0_1.SwitchToDestroy(arg_130_0)
	arg_130_0.page = var_0_3
	arg_130_0.filterEquipWaitting = arg_130_0.filterEquipWaitting + 1
	triggerToggle = var_1

	var_1(arg_130_0.weaponToggle, true)

	triggerButton = var_1

	var_1(arg_130_0.BatchDisposeBtn)

	return
end

function var_0_1.SwitchToSpWeaponStoreHouse(arg_131_0)
	arg_131_0.page = var_0_5
	triggerToggle = var_1

	var_1(arg_131_0.weaponToggle, true)

	return
end

function var_0_1.SwitchEquipmentType(arg_132_0, arg_132_1)
	local var_132_0

	if arg_132_1 == var_0_5 then
		i18n = var_3
		var_132_0 = var_3("search_sp_equipment")
	elseif arg_132_1 == var_0_4 then
		i18n = var_3
		var_132_0 = var_3("search_equipment_appearance")
	else
		i18n = var_3
		var_132_0 = var_3("search_equipment")
	end

	local var_132_1 = arg_132_0.searchBar

	var_3.UpdateHolder(var_132_1, var_132_0)

	local var_132_2 = arg_132_0.searchBar

	var_3.ClearInputText(var_132_2)

	return
end

function var_0_1.willExit(arg_133_0)
	arg_133_0:UnOverlayPanel(arg_133_0.blurPanel, arg_133_0._tf)
	arg_133_0:UnOverlayPanel(arg_133_0.topItems, arg_133_0._tf)

	if arg_133_0.bulinTip then
		local var_133_0 = arg_133_0.bulinTip

		var_1.Destroy(var_133_0)

		arg_133_0.bulinTip = nil
	end

	if arg_133_0.searchBar then
		local var_133_1 = arg_133_0.searchBar

		var_1.Dispose(var_133_1)

		arg_133_0.searchBar = nil
	end

	local var_133_2 = arg_133_0.destroyConfirmView

	var_1.Destroy(var_133_2)

	local var_133_3 = arg_133_0.assignedItemView

	var_1.Destroy(var_133_3)

	local var_133_4 = arg_133_0.blueprintAssignedItemView

	var_1.Destroy(var_133_4)

	local var_133_5 = arg_133_0.equipDestroyConfirmWindow

	var_1.Destroy(var_133_5)

	local var_133_6 = arg_133_0.msgBox

	var_1.Destroy(var_133_6)

	return
end

return var_0_1
