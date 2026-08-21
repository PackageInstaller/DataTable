local var_0_0 = class("StoreHouseScene", import("view.base.BaseUI"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3

function var_0_0.getUIName(arg_1_0)
	return "StoreHouseUI"
end

function var_0_0.setEquipments(arg_2_0, arg_2_1)
	arg_2_0.equipmentVOs = arg_2_1

	arg_2_0:setEquipmentByIds(arg_2_1)

	return
end

function var_0_0.setEquipmentByIds(arg_3_0, arg_3_1)
	arg_3_0.equipmentVOByIds = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if not iter_3_1.isSkin then
			arg_3_0.equipmentVOByIds[iter_3_1.id] = iter_3_1
		end
	end

	return
end

local var_0_8 = require("view.equipment.EquipmentSortCfg")
local var_0_9 = require("view.equipment.SpWeaponSortCfg")

function var_0_0.init(arg_4_0)
	arg_4_0.filterEquipWaitting = 0

	local var_4_0 = arg_4_0.contextData

	arg_4_0.topItems = arg_4_0._tf:Find("topItems")
	arg_4_0.equipmentView = arg_4_0._tf:Find("adapt/equipment_scrollview")
	arg_4_0.blurPanel = arg_4_0._tf:Find("blur_panel")
	arg_4_0.topPanel = arg_4_0.blurPanel:Find("adapt/top")
	arg_4_0.indexBtn = arg_4_0.topPanel:Find("buttons/index_button")
	arg_4_0.sortBtn = arg_4_0.topPanel:Find("buttons/sort_button")
	arg_4_0.sortPanel = arg_4_0.topItems:Find("sort")
	arg_4_0.sortPanelTG = arg_4_0.sortPanel:GetComponent("ToggleGroup")
	arg_4_0.sortPanelTG.allowSwitchOff = true
	arg_4_0.sortContain = arg_4_0.sortPanel:Find("adapt/mask/panel")
	arg_4_0.sortTpl = arg_4_0.sortContain:Find("tpl")

	setActive(arg_4_0.sortTpl, false)

	arg_4_0.equipSkinFilteBtn = arg_4_0.topPanel:Find("buttons/EquipSkinFilteBtn")
	arg_4_0.searchBar = RecordableSearchBar.New(RecordableSearchBar.CreateData({
		enabledFlag = false,
		holder = i18n("search_equipment"),
		onInputChanged = function()
			arg_4_0:filterEquipment()

			return
		end,
		key = arg_4_0.__cname,
		parent = arg_4_0.topPanel:Find("buttons"),
		expand_parent = arg_4_0.blurPanel:Find("adapt"),
		anchoredPosition = Vector3(-1305, arg_4_0.topPanel.sizeDelta.y * -0.5, 0)
	}))
	arg_4_0.itemView = arg_4_0._tf:Find("adapt/item_scrollview")

	local var_4_1 = (NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and arg_4_0.itemView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2
	local var_4_2 = arg_4_0.equipmentView:Find("equipment_grid")

	var_4_2:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_1 and 8 or 7

	local var_4_3 = arg_4_0.itemView:Find("item_grid")

	var_4_3:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_1 and 8 or 7
	arg_4_0.decBtn = findTF(arg_4_0.topPanel, "buttons/dec_btn")
	arg_4_0.sortImgAsc = findTF(arg_4_0.decBtn, "asc")
	arg_4_0.sortImgDec = findTF(arg_4_0.decBtn, "desc")
	arg_4_0.equipmentToggle = arg_4_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_root")

	setActive(arg_4_0.equipmentToggle, false)

	arg_4_0.filterBusyToggle = arg_4_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_equip")

	setActive(arg_4_0.filterBusyToggle, false)

	arg_4_0.designTabRoot = arg_4_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_design")

	setActive(arg_4_0.designTabRoot, false)

	arg_4_0.designTabs = CustomIndexLayer.Clone2Full(arg_4_0.designTabRoot, 3)
	arg_4_0.bottomBack = arg_4_0.topItems:Find("adapt/bottom_back")
	arg_4_0.bottomPanel = arg_4_0.bottomBack:Find("types")
	arg_4_0.materialToggle = arg_4_0.bottomPanel:Find("material")
	arg_4_0.weaponToggle = arg_4_0.bottomPanel:Find("weapon")
	arg_4_0.designToggle = arg_4_0.bottomPanel:Find("design")
	arg_4_0.capacityTF = arg_4_0.bottomBack:Find("bottom_left/tip/capcity/Text")
	arg_4_0.tipTF = arg_4_0.bottomBack:Find("bottom_left/tip")
	arg_4_0.tip = arg_4_0.tipTF:Find("label")
	arg_4_0.helpBtn = arg_4_0.topItems:Find("adapt/help_btn")

	setActive(arg_4_0.helpBtn, true)

	arg_4_0.backBtn = arg_4_0._tf:Find("blur_panel/adapt/top/back_btn")
	arg_4_0.selectedMin = defaultValue(var_4_0.selectedMin, 1)

	local var_4_4 = pg.gameset.equip_select_limit.key_value or 0

	arg_4_0.selectedMax = defaultValue(var_4_0.selectedMax, var_4_4)

	local var_4_5 = var_4_0.selectedIds or {}

	arg_4_0.selectedIds = Clone(var_4_5)
	arg_4_0.checkEquipment = var_4_0.onEquipment or function(arg_6_0, arg_6_1, arg_6_2)
		return true
	end
	arg_4_0.onSelected = var_4_0.onSelected or function()
		warning("not implemented.")

		return
	end
	arg_4_0.BatchDisposeBtn = arg_4_0.bottomPanel:Find("dispos") or arg_4_0.bottomBack:Find("dispos")
	arg_4_0.selectPanel = arg_4_0.topItems:Find("adapt/select_panel")

	setActive(arg_4_0.selectPanel, true)
	setAnchoredPosition(arg_4_0.selectPanel, {
		y = -124
	})

	arg_4_0.selectTransformPanel = arg_4_0.topItems:Find("adapt/select_transform_panel")

	setActive(arg_4_0.selectTransformPanel, false)

	arg_4_0.listEmptyTF = arg_4_0._tf:Find("adapt/empty")

	setActive(arg_4_0.listEmptyTF, false)

	arg_4_0.listEmptyTxt = arg_4_0.listEmptyTF:Find("Text")
	arg_4_0.destroyConfirmView = DestroyConfirmView.New(arg_4_0.topItems, arg_4_0.event)
	arg_4_0.assignedItemView = AssignedItemView.New(arg_4_0.topItems, arg_4_0.event)
	arg_4_0.blueprintAssignedItemView = BlueprintAssignedItemView.New(arg_4_0.topItems, arg_4_0.event)
	arg_4_0.equipDestroyConfirmWindow = EquipDestoryConfirmWindow.New(arg_4_0.topItems, arg_4_0.event)
	arg_4_0.isEquipingOn = false
	arg_4_0.msgBox = SelectSkinMsgbox.New(arg_4_0._tf, arg_4_0.event)

	return
end

function var_0_0.setEquipment(arg_8_0, arg_8_1)
	local var_8_0 = #arg_8_0.equipmentVOs + 1

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.equipmentVOs) do
		if not iter_8_1.shipId and iter_8_1.id == arg_8_1.id then
			var_8_0 = iter_8_0

			break
		end
	end

	if arg_8_1.count > 0 then
		arg_8_0.equipmentVOs[var_8_0] = arg_8_1
		arg_8_0.equipmentVOByIds[arg_8_1.id] = arg_8_1
	else
		table.remove(arg_8_0.equipmentVOs, var_8_0)

		arg_8_0.equipmentVOByIds[arg_8_1.id] = nil
	end

	return
end

function var_0_0.setEquipmentUpdate(arg_9_0)
	if arg_9_0.contextData.warp == StoreHouseConst.WARP_TO_WEAPON then
		arg_9_0:filterEquipment()
		arg_9_0:updateCapacity()
	end

	return
end

function var_0_0.addShipEquipment(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.equipmentVOs) do
		if EquipmentProxy.SameEquip(iter_10_1, arg_10_1) then
			arg_10_0.equipmentVOs[iter_10_0] = arg_10_1

			return
		end
	end

	table.insert(arg_10_0.equipmentVOs, arg_10_1)

	return
end

function var_0_0.removeShipEquipment(arg_11_0, arg_11_1)
	for iter_11_0 = #arg_11_0.equipmentVOs, 1, -1 do
		if EquipmentProxy.SameEquip(arg_11_0.equipmentVOs[iter_11_0], arg_11_1) then
			table.remove(arg_11_0.equipmentVOs, iter_11_0)
		end
	end

	return
end

function var_0_0.setEquipmentSkin(arg_12_0, arg_12_1)
	local var_12_0 = true

	for iter_12_0, iter_12_1 in pairs(arg_12_0.equipmentVOs) do
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
		table.insert(arg_12_0.equipmentVOs, {
			isSkin = true,
			id = arg_12_1.id,
			count = arg_12_1.count
		})
	end

	return
end

function var_0_0.setEquipmentSkinUpdate(arg_13_0)
	if arg_13_0.contextData.warp == StoreHouseConst.WARP_TO_WEAPON then
		arg_13_0:filterEquipment()
		arg_13_0:updateCapacity()
	end

	return
end

function var_0_0.SetSpWeapons(arg_14_0, arg_14_1)
	arg_14_0.spweaponVOs = arg_14_1

	return
end

function var_0_0.SetSpWeaponUpdate(arg_15_0)
	if arg_15_0.contextData.warp == StoreHouseConst.WARP_TO_WEAPON and arg_15_0.page == var_0_4 then
		arg_15_0:filterEquipment()
		arg_15_0:UpdateSpweaponCapacity()
	elseif arg_15_0.contextData.warp == StoreHouseConst.WARP_TO_DESIGN and arg_15_0.contextData.designPage == var_0_6 then
		arg_15_0:UpdateSpweaponCapacity()
	end

	return
end

function var_0_0.didEnter(arg_16_0)
	setText(arg_16_0.selectPanel:Find("tip"), i18n("equipment_select_device_destroy_tip"))
	setActive(arg_16_0.topItems:Find("adapt/stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())
	onButton(arg_16_0, arg_16_0.topItems:Find("adapt/stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(2)

		return
	end, SFX_CONFIRM)
	onButton(arg_16_0, arg_16_0.helpBtn, function()
		local var_18_0

		if arg_16_0.contextData.warp == StoreHouseConst.WARP_TO_WEAPON then
			if arg_16_0.page == var_0_2 then
				var_18_0 = pg.gametip.help_equipment.tip
			elseif arg_16_0.page == var_0_3 then
				var_18_0 = pg.gametip.help_equipment_skin.tip
			elseif arg_16_0.page == var_0_4 then
				var_18_0 = pg.gametip.spweapon_help_storage.tip
			end
		elseif arg_16_0.contextData.warp == StoreHouseConst.WARP_TO_DESIGN then
			if arg_16_0.contextData.designPage == var_0_5 then
				var_18_0 = pg.gametip.help_equipment.tip
			elseif arg_16_0.contextData.designPage == var_0_6 then
				var_18_0 = pg.gametip.spweapon_help_storage.tip
			end
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = var_18_0
		})

		return
	end, SFX_PANEL)
	onToggle(arg_16_0, arg_16_0.equipmentToggle:Find("equipment"), function(arg_19_0)
		if arg_19_0 then
			arg_16_0.page = var_0_2

			arg_16_0:SwitchEquipmentType(var_0_2)
			arg_16_0:UpdateWeaponWrapButtons()
			arg_16_0:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onToggle(arg_16_0, arg_16_0.equipmentToggle:Find("skin"), function(arg_20_0)
		if arg_20_0 then
			arg_16_0.page = var_0_3

			arg_16_0:SwitchEquipmentType(var_0_3)
			arg_16_0:UpdateWeaponWrapButtons()
			arg_16_0:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onToggle(arg_16_0, arg_16_0.equipmentToggle:Find("spweapon"), function(arg_21_0)
		if arg_21_0 then
			arg_16_0.page = var_0_4

			arg_16_0:SwitchEquipmentType(var_0_4)
			arg_16_0:UpdateWeaponWrapButtons()
			arg_16_0:filterEquipment()
		end

		return
	end, SFX_PANEL)
	setActive(arg_16_0.equipmentToggle:Find("spweapon"), not LOCK_SP_WEAPON)
	onToggle(arg_16_0, arg_16_0.designTabs[var_0_5], function(arg_22_0)
		if arg_22_0 then
			arg_16_0.contextData.designPage = var_0_5

			arg_16_0:emit(EquipmentMediator.OPEN_DESIGN)
			arg_16_0:updateCapacity()
			setActive(arg_16_0.tip, false)
			setActive(arg_16_0.listEmptyTF, false)
		else
			arg_16_0:emit(EquipmentMediator.CLOSE_DESIGN_LAYER)
		end

		setActive(arg_16_0.designTabs[var_0_7], arg_22_0)

		return
	end, SFX_PANEL)
	onToggle(arg_16_0, arg_16_0.designTabs[var_0_6], function(arg_23_0)
		if arg_23_0 then
			arg_16_0.contextData.designPage = var_0_6

			arg_16_0:emit(EquipmentMediator.OPEN_SPWEAPON_DESIGN)
			arg_16_0:UpdateSpweaponCapacity()
			setActive(arg_16_0.tip, false)
			setActive(arg_16_0.listEmptyTF, false)
		else
			arg_16_0:emit(EquipmentMediator.CLOSE_SPWEAPON_DESIGN_LAYER)
		end

		return
	end, SFX_PANEL)
	setActive(arg_16_0.designTabs[var_0_7], arg_16_0.contextData.designPage == var_0_5)

	arg_16_0.isShowAllDesign = false

	onToggle(arg_16_0, arg_16_0.designTabs[var_0_7], function(arg_24_0)
		arg_16_0.isShowAllDesign = arg_24_0

		arg_16_0:emit(EquipmentMediator.DESIGN_FILTER_CHANGED, arg_16_0.isShowAllDesign)

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.backBtn, function()
		if arg_16_0.mode == StoreHouseConst.DESTROY then
			triggerButton(arg_16_0.BatchDisposeBtn)

			return
		end

		GetOrAddComponent(arg_16_0._tf, typeof(CanvasGroup)).interactable = false

		arg_16_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onToggle(arg_16_0, arg_16_0.sortBtn, function(arg_26_0)
		if arg_26_0 then
			arg_16_0:OverlayPanel(arg_16_0.sortPanel)
			setActive(arg_16_0.sortPanel, true)
			onNextTick(function()
				arg_16_0.sortPanelTG.allowSwitchOff = false

				return
			end)
		else
			arg_16_0:UnOverlayPanel(arg_16_0.sortPanel, arg_16_0.topItems)
			setActive(arg_16_0.sortPanel, false)

			arg_16_0.sortPanelTG.allowSwitchOff = true
		end

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.sortPanel, function()
		triggerToggle(arg_16_0.sortBtn, false)

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.indexBtn, function()
		arg_16_0:emit(EquipmentMediator.OPEN_EQUIPMENT_INDEX, (switch(arg_16_0.page, {
			[var_0_2] = function()
				return setmetatable({
					indexDatas = Clone(arg_16_0.contextData.indexDatas),
					callback = function(arg_31_0)
						arg_16_0.contextData.indexDatas.typeIndex = arg_31_0.typeIndex
						arg_16_0.contextData.indexDatas.equipPropertyIndex = arg_31_0.equipPropertyIndex
						arg_16_0.contextData.indexDatas.equipPropertyIndex2 = arg_31_0.equipPropertyIndex2
						arg_16_0.contextData.indexDatas.equipAmmoIndex1 = arg_31_0.equipAmmoIndex1
						arg_16_0.contextData.indexDatas.equipAmmoIndex2 = arg_31_0.equipAmmoIndex2
						arg_16_0.contextData.indexDatas.equipCampIndex = arg_31_0.equipCampIndex
						arg_16_0.contextData.indexDatas.rarityIndex = arg_31_0.rarityIndex
						arg_16_0.contextData.indexDatas.extraIndex = arg_31_0.extraIndex

						if arg_16_0.filterBusyToggle:GetComponent(typeof(Toggle)) then
							if bit.band(arg_31_0.extraIndex, IndexConst.EquipmentExtraEquiping) > 0 then
								arg_16_0:SetShowBusyFlag(true)
							end

							triggerToggle(arg_16_0.filterBusyToggle, arg_16_0:GetShowBusyFlag())
						else
							arg_16_0:filterEquipment()
						end

						return
					end
				}, {
					__index = StoreHouseConst.EQUIPMENT_INDEX_COMMON
				})
			end,
			[var_0_4] = function()
				return setmetatable({
					indexDatas = Clone(arg_16_0.contextData.spweaponIndexDatas),
					callback = function(arg_33_0)
						arg_16_0.contextData.spweaponIndexDatas.typeIndex = arg_33_0.typeIndex
						arg_16_0.contextData.spweaponIndexDatas.rarityIndex = arg_33_0.rarityIndex

						arg_16_0:filterEquipment()

						return
					end
				}, {
					__index = StoreHouseConst.SPWEAPON_INDEX_COMMON
				})
			end
		})))

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.equipSkinFilteBtn, function()
		local var_34_0 = {
			display = {
				equipSkinIndex = IndexConst.FlagRange2Bits(IndexConst.EquipSkinIndexAll, IndexConst.EquipSkinIndexAux),
				equipSkinTheme = IndexConst.FlagRange2Str(IndexConst.EquipSkinThemeAll, IndexConst.EquipSkinThemeEnd)
			}
		}

		var_34_0.equipSkinSort = arg_16_0.equipSkinSort or IndexConst.EquipSkinSortType
		var_34_0.equipSkinIndex = arg_16_0.equipSkinIndex or IndexConst.Flags2Bits({
			IndexConst.EquipSkinIndexAll
		})
		var_34_0.equipSkinTheme = arg_16_0.equipSkinTheme or IndexConst.Flags2Str({
			IndexConst.EquipSkinThemeAll
		})

		function var_34_0.callback(arg_35_0)
			arg_16_0.equipSkinSort = arg_35_0.equipSkinSort
			arg_16_0.equipSkinIndex = arg_35_0.equipSkinIndex
			arg_16_0.equipSkinTheme = arg_35_0.equipSkinTheme

			arg_16_0:filterEquipment()

			return
		end

		arg_16_0:emit(EquipmentMediator.OPEN_EQUIPSKIN_INDEX_LAYER, var_34_0)

		return
	end, SFX_PANEL)

	arg_16_0.equipmetItems = {}
	arg_16_0.itemCards = {}

	arg_16_0:initItems()
	arg_16_0:initEquipments()

	arg_16_0.asc = arg_16_0.contextData.asc or false
	arg_16_0.contextData.sortData = arg_16_0.contextData.sortData or var_0_8.sort[1]
	arg_16_0.contextData.indexDatas = arg_16_0.contextData.indexDatas or {}
	arg_16_0.contextData.spweaponIndexDatas = arg_16_0.contextData.spweaponIndexDatas or {}
	arg_16_0.contextData.spweaponSortData = arg_16_0.contextData.spweaponSortData or var_0_9.sort[1]

	arg_16_0:initSort()
	setActive(arg_16_0.itemView, false)
	setActive(arg_16_0.equipmentView, false)
	onToggle(arg_16_0, arg_16_0.materialToggle, function(arg_36_0)
		arg_16_0.inMaterial = arg_36_0

		if arg_36_0 and arg_16_0.contextData.warp ~= StoreHouseConst.WARP_TO_MATERIAL then
			arg_16_0.contextData.warp = StoreHouseConst.WARP_TO_MATERIAL

			setText(arg_16_0.tip, i18n("equipment_select_materials_tip"))
			setActive(arg_16_0.capacityTF.parent, false)
			setActive(arg_16_0.tip, true)
			arg_16_0:sortItems()
		end

		setActive(arg_16_0.helpBtn, not arg_36_0)

		return
	end, SFX_PANEL)
	onToggle(arg_16_0, arg_16_0.weaponToggle, function(arg_37_0)
		if arg_37_0 then
			if arg_16_0.contextData.warp ~= StoreHouseConst.WARP_TO_WEAPON then
				arg_16_0.contextData.warp = StoreHouseConst.WARP_TO_WEAPON

				setActive(arg_16_0.tip, false)
				setActive(arg_16_0.capacityTF.parent, true)

				if arg_16_0.page == var_0_3 then
					triggerToggle(arg_16_0.equipmentToggle:Find("skin"), true)
				elseif arg_16_0.page == var_0_4 then
					triggerToggle(arg_16_0.equipmentToggle:Find("spweapon"), true)
				else
					triggerToggle(arg_16_0.equipmentToggle:Find("equipment"), true)
				end
			end
		else
			setActive(arg_16_0.BatchDisposeBtn, false)
			setActive(arg_16_0.filterBusyToggle, false)
			setActive(arg_16_0.equipmentToggle, false)
		end

		arg_16_0.searchBar:EnableOrDisable(arg_37_0)

		return
	end, SFX_PANEL)
	onToggle(arg_16_0, arg_16_0.designToggle, function(arg_38_0)
		if arg_38_0 then
			arg_16_0.contextData.warp = StoreHouseConst.WARP_TO_DESIGN

			local var_38_0 = arg_16_0.contextData.designPage or var_0_5

			triggerToggle(arg_16_0.designTabs[var_38_0], true)
			setActive(arg_16_0.capacityTF.parent, true)
		else
			arg_16_0:emit(EquipmentMediator.CLOSE_DESIGN_LAYER)
			arg_16_0:emit(EquipmentMediator.CLOSE_SPWEAPON_DESIGN_LAYER)
		end

		setActive(arg_16_0.designTabRoot, arg_38_0 and not LOCK_SP_WEAPON)

		return
	end, SFX_PANEL)
	onToggle(arg_16_0, arg_16_0.filterBusyToggle, function(arg_39_0)
		arg_16_0:SetShowBusyFlag(arg_39_0)
		arg_16_0:filterEquipment()

		return
	end, SFX_PANEL)

	arg_16_0.filterEquipWaitting = arg_16_0.filterEquipWaitting + 1

	triggerToggle(arg_16_0.filterBusyToggle, arg_16_0.shipVO)
	onButton(arg_16_0, arg_16_0.BatchDisposeBtn, function()
		if arg_16_0.mode == StoreHouseConst.DESTROY then
			arg_16_0.mode = StoreHouseConst.OVERVIEW
			arg_16_0.asc = arg_16_0.lastasc
			arg_16_0.lastasc = nil
			arg_16_0.filterImportance = nil

			shiftPanel(arg_16_0.bottomBack, nil, 0, nil, 0, true, true)
			shiftPanel(arg_16_0.selectPanel, nil, -124, nil, 0, true, true)
			arg_16_0:filterEquipment()
		else
			arg_16_0.mode = StoreHouseConst.DESTROY
			arg_16_0.lastasc = arg_16_0.asc
			arg_16_0.filterImportance = true
			arg_16_0.asc = true

			shiftPanel(arg_16_0.bottomBack, nil, -124, nil, 0, true, true)
			shiftPanel(arg_16_0.selectPanel, nil, 0, nil, 0, true, true)

			arg_16_0.contextData.asc = arg_16_0.asc
			arg_16_0.contextData.sortData = var_0_8.sort[1]

			arg_16_0:filterEquipment()
		end

		arg_16_0:UpdateWeaponWrapButtons()

		return
	end, SFX_PANEL)
	onButton(arg_16_0, findTF(arg_16_0.selectPanel, "cancel_button"), function()
		arg_16_0:unselecteAllEquips()
		triggerButton(arg_16_0.BatchDisposeBtn)

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, findTF(arg_16_0.selectPanel, "confirm_button"), function()
		if underscore.any(arg_16_0.selectedIds, function(arg_43_0)
			return arg_16_0.equipmentVOByIds[arg_43_0[1]]:getConfig("rarity") >= 4 or var_43_0:getConfig("level") > 1
		end) then
			table.insert({}, function(arg_44_0)
				arg_16_0.equipDestroyConfirmWindow:Load()
				arg_16_0.equipDestroyConfirmWindow:ActionInvoke("Show", underscore.map(arg_16_0.selectedIds, function(arg_45_0)
					return setmetatable({
						count = arg_45_0[2]
					}, {
						__index = arg_16_0.equipmentVOByIds[arg_45_0[1]]
					})
				end), arg_44_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_16_0.destroyConfirmView:Load()
			arg_16_0.destroyConfirmView:ActionInvoke("Show")
			arg_16_0.destroyConfirmView:ActionInvoke("DisplayDestroyBonus", arg_16_0.selectedIds)
			arg_16_0.destroyConfirmView:ActionInvoke("SetConfirmBtnCB", function()
				arg_16_0:unselecteAllEquips()

				return
			end)

			return
		end)

		return
	end, SFX_CONFIRM)
	arg_16_0:OverlayPanel(arg_16_0.blurPanel)
	arg_16_0:PlayUIAnimation(arg_16_0.blurPanel, "enter")
	arg_16_0:OverlayPanel(arg_16_0.topItems)

	local var_16_0 = arg_16_0.contextData.warp or StoreHouseConst.WARP_TO_MATERIAL
	local var_16_1 = arg_16_0.contextData.mode or StoreHouseConst.OVERVIEW

	arg_16_0.contextData.warp = nil
	arg_16_0.contextData.mode = nil
	arg_16_0.mode = arg_16_0.mode or StoreHouseConst.OVERVIEW

	if var_16_0 == StoreHouseConst.WARP_TO_DESIGN then
		triggerToggle(arg_16_0.designToggle, true)
	elseif var_16_0 == StoreHouseConst.WARP_TO_MATERIAL then
		triggerToggle(arg_16_0.materialToggle, true)
	elseif var_16_0 == StoreHouseConst.WARP_TO_WEAPON then
		if var_16_1 == StoreHouseConst.DESTROY then
			arg_16_0.filterEquipWaitting = arg_16_0.filterEquipWaitting + 1

			triggerToggle(arg_16_0.weaponToggle, true)
			triggerButton(arg_16_0.BatchDisposeBtn)
		else
			arg_16_0.page = var_16_1 == StoreHouseConst.SKIN and var_0_3 or var_16_1 == StoreHouseConst.SPWEAPON and var_0_4 or var_0_2

			triggerToggle(arg_16_0.weaponToggle, true)
		end
	end

	arg_16_0.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(arg_16_0, arg_16_0.topItems)

	return
end

function var_0_0.isDefaultStatus(arg_48_0)
	return underscore(arg_48_0.contextData.indexDatas):chain():keys():all(function(arg_49_0)
		return arg_48_0.contextData.indexDatas[arg_49_0] == StoreHouseConst.EQUIPMENT_INDEX_COMMON.customPanels[arg_49_0].options[1]
	end):value()
end

function var_0_0.isDefaultSpWeaponIndexData(arg_50_0)
	return underscore(arg_50_0.contextData.spweaponIndexDatas):chain():keys():all(function(arg_51_0)
		return arg_50_0.contextData.spweaponIndexDatas[arg_51_0] == StoreHouseConst.SPWEAPON_INDEX_COMMON.customPanels[arg_51_0].options[1]
	end):value()
end

function var_0_0.onBackPressed(arg_52_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(arg_52_0.sortPanel) then
		triggerButton(arg_52_0.sortPanel)
	elseif arg_52_0.destroyConfirmView:isShowing() then
		arg_52_0.destroyConfirmView:Hide()
	elseif arg_52_0.assignedItemView:isShowing() then
		arg_52_0.assignedItemView:Hide()
	elseif arg_52_0.blueprintAssignedItemView:isShowing() then
		arg_52_0.blueprintAssignedItemView:Hide()
	elseif arg_52_0.equipDestroyConfirmWindow:isShowing() then
		arg_52_0.equipDestroyConfirmWindow:Hide()
	else
		triggerButton(arg_52_0.backBtn)
	end

	return
end

function var_0_0.updateCapacity(arg_53_0)
	if arg_53_0.contextData.warp == StoreHouseConst.WARP_TO_MATERIAL then
		return
	end

	setText(arg_53_0.tip, "")
	setText(arg_53_0.capacityTF, arg_53_0.capacity .. "/" .. arg_53_0.player:getMaxEquipmentBag())

	return
end

function var_0_0.setCapacity(arg_54_0, arg_54_1)
	arg_54_0.capacity = arg_54_1

	return
end

function var_0_0.UpdateSpweaponCapacity(arg_55_0)
	local var_55_0 = getProxy(EquipmentProxy)

	setText(arg_55_0.capacityTF, var_55_0:GetSpWeaponCount() .. "/" .. var_55_0:GetSpWeaponCapacity())

	return
end

function var_0_0.setShip(arg_56_0, arg_56_1)
	arg_56_0.shipVO = arg_56_1

	setActive(arg_56_0.bottomPanel, not tobool(arg_56_1))

	return
end

function var_0_0.setPlayer(arg_57_0, arg_57_1)
	arg_57_0.player = arg_57_1

	if arg_57_0.contextData.warp == StoreHouseConst.WARP_TO_WEAPON and arg_57_0.page == var_0_2 then
		arg_57_0:updateCapacity()
	elseif arg_57_0.contextData.warp == StoreHouseConst.WARP_TO_DESIGN and arg_57_0.contextData.designPage == var_0_5 then
		arg_57_0:updateCapacity()
	end

	return
end

function var_0_0.initSort(arg_58_0)
	onButton(arg_58_0, arg_58_0.decBtn, function()
		arg_58_0.asc = not arg_58_0.asc
		arg_58_0.contextData.asc = arg_58_0.asc

		arg_58_0:filterEquipment()

		return
	end)

	arg_58_0.sortButtons = {}

	eachChild(arg_58_0.sortContain, function(arg_60_0)
		setActive(arg_60_0, false)

		return
	end)

	for iter_58_0, iter_58_1 in ipairs(var_0_8.sort) do
		local var_58_0 = iter_58_0 <= arg_58_0.sortContain.childCount and arg_58_0.sortContain:GetChild(iter_58_0 - 1) or cloneTplTo(arg_58_0.sortTpl, arg_58_0.sortContain)

		setActive(var_58_0, true)
		setImageSprite(findTF(var_58_0, "Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", iter_58_1.spr), true)
		onToggle(arg_58_0, var_58_0, function(arg_61_0)
			if arg_61_0 then
				if arg_58_0.page == var_0_2 then
					arg_58_0.contextData.sortData = iter_58_1
				elseif arg_58_0.page == var_0_4 then
					arg_58_0.contextData.spweaponSortData = var_0_9.sort[iter_58_0]
				end

				arg_58_0:filterEquipment()
				triggerToggle(arg_58_0.sortBtn, false)
			end

			return
		end, SFX_PANEL)

		arg_58_0.sortButtons[iter_58_0] = var_58_0
	end

	return
end

function var_0_0.UpdateWeaponWrapButtons(arg_62_0)
	setActive(arg_62_0.indexBtn, arg_62_0.page == var_0_2 or arg_62_0.page == var_0_4)
	setActive(arg_62_0.sortBtn, arg_62_0.page == var_0_2 or arg_62_0.page == var_0_4)
	setActive(arg_62_0.BatchDisposeBtn, arg_62_0.page == var_0_2)
	setActive(arg_62_0.capacityTF.parent, arg_62_0.page == var_0_2 or arg_62_0.page == var_0_4)
	setActive(arg_62_0.equipSkinFilteBtn, arg_62_0.page == var_0_3)
	setActive(arg_62_0.filterBusyToggle, arg_62_0.mode == StoreHouseConst.OVERVIEW)
	setActive(arg_62_0.equipmentToggle, arg_62_0.mode == StoreHouseConst.OVERVIEW and not arg_62_0.contextData.shipId)
	arg_62_0:updatePageFilterButtons(arg_62_0.page)

	return
end

function var_0_0.updatePageFilterButtons(arg_63_0, arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(var_0_8.sort) do
		triggerToggle(arg_63_0.sortButtons[iter_63_0], false)
		setActive(arg_63_0.sortButtons[iter_63_0], table.contains(iter_63_1.pages, arg_63_1))
	end

	return
end

function var_0_0.initEquipments(arg_64_0)
	arg_64_0.isInitWeapons = true
	arg_64_0.equipmentRect = arg_64_0.equipmentView:GetComponent("LScrollRect")

	function arg_64_0.equipmentRect.onInitItem(arg_65_0)
		arg_64_0:initEquipment(arg_65_0)

		return
	end

	function arg_64_0.equipmentRect.onUpdateItem(arg_66_0, arg_66_1)
		arg_64_0:updateEquipment(arg_66_0, arg_66_1)

		return
	end

	function arg_64_0.equipmentRect.onReturnItem(arg_67_0, arg_67_1)
		arg_64_0:returnEquipment(arg_67_0, arg_67_1)

		return
	end

	function arg_64_0.equipmentRect.onStart()
		arg_64_0:updateSelected()

		return
	end

	arg_64_0.equipmentRect.decelerationRate = 0.07

	return
end

function var_0_0.initEquipment(arg_69_0, arg_69_1)
	local var_69_0 = EquipmentItem.New(arg_69_1)

	onButton(arg_69_0, var_69_0.unloadBtn, function()
		if arg_69_0.page == var_0_3 then
			arg_69_0:emit(EquipmentMediator.ON_UNEQUIP_EQUIPMENT_SKIN)
		elseif arg_69_0.page == var_0_2 then
			arg_69_0:emit(EquipmentMediator.ON_UNEQUIP_EQUIPMENT)
		end

		return
	end, SFX_PANEL)
	onButton(arg_69_0, var_69_0.reduceBtn, function()
		arg_69_0:selectEquip(var_69_0.equipmentVO, 1)

		return
	end, SFX_PANEL)

	arg_69_0.equipmetItems[arg_69_1] = var_69_0

	return
end

function var_0_0.updateEquipment(arg_72_0, arg_72_1, arg_72_2)
	assert(arg_72_0.equipmetItems[arg_72_2], "without init item")

	local var_72_0 = arg_72_0.loadEquipmentVOs[arg_72_1 + 1]

	arg_72_0.equipmetItems[arg_72_2]:update(arg_72_0.loadEquipmentVOs[arg_72_1 + 1])

	local var_72_1 = false
	local var_72_2 = 0

	if arg_72_0.loadEquipmentVOs[arg_72_1 + 1] then
		for iter_72_0, iter_72_1 in ipairs(arg_72_0.selectedIds) do
			if arg_72_0.loadEquipmentVOs[arg_72_1 + 1].id == iter_72_1[1] then
				var_72_1 = true
				var_72_2 = iter_72_1[2]

				break
			end
		end
	end

	arg_72_0.equipmetItems[arg_72_2]:updateSelected(var_72_1, var_72_2)

	if not arg_72_0.loadEquipmentVOs[arg_72_1 + 1] then
		removeOnButton(arg_72_0.equipmetItems[arg_72_2].go)
	elseif isa(arg_72_0.loadEquipmentVOs[arg_72_1 + 1], SpWeapon) then
		onButton(arg_72_0, arg_72_0.equipmetItems[arg_72_2].go, function()
			if arg_72_0.shipVO then
				local var_73_0 = {
					type = EquipmentInfoMediator.TYPE_REPLACE,
					shipId = arg_72_0.contextData.shipId,
					oldSpWeaponUid = var_72_0:GetUID(),
					oldShipId = var_72_0:GetShipId()
				}

				if not var_73_0 then
					if var_72_0:GetShipId() then
						var_73_0 = {
							type = EquipmentInfoMediator.TYPE_DISPLAY,
							spWeaponUid = var_72_0:GetUID(),
							shipId = var_72_0:GetShipId()
						} or {
							type = EquipmentInfoMediator.TYPE_DEFAULT,
							spWeaponUid = var_72_0:GetUID()
						}

						arg_72_0:emit(var_0_0.ON_SPWEAPON, var_73_0)

						return
					end
				end
			end
		end, SFX_PANEL)
	elseif arg_72_0.equipmetItems[arg_72_2].equipmentVO.isSkin then
		if arg_72_0.loadEquipmentVOs[arg_72_1 + 1].shipId then
			onButton(arg_72_0, arg_72_0.equipmetItems[arg_72_2].go, function()
				assert(var_72_0.shipPos, "equipment skin pos is nil")
				arg_72_0:emit(EquipmentMediator.ON_EQUIPMENT_SKIN_INFO, var_72_0.id, arg_72_0.contextData.pos, {
					id = var_72_0.shipId,
					pos = var_72_0.shipPos
				})

				return
			end, SFX_PANEL)
		else
			onButton(arg_72_0, arg_72_0.equipmetItems[arg_72_2].go, function()
				arg_72_0:emit(EquipmentMediator.ON_EQUIPMENT_SKIN_INFO, var_72_0.id, arg_72_0.contextData.pos)

				return
			end, SFX_PANEL)
		end
	elseif arg_72_0.loadEquipmentVOs[arg_72_1 + 1].mask then
		removeOnButton(arg_72_0.equipmetItems[arg_72_2].go)
	elseif arg_72_0.mode == StoreHouseConst.DESTROY then
		onButton(arg_72_0, arg_72_0.equipmetItems[arg_72_2].go, function()
			arg_72_0:selectEquip(var_72_0, var_72_0.count)

			return
		end, SFX_PANEL)
	else
		onButton(arg_72_0, arg_72_0.equipmetItems[arg_72_2].go, function()
			if arg_72_0.shipVO then
				local var_77_0 = {
					type = EquipmentInfoMediator.TYPE_REPLACE,
					equipmentId = var_72_0.id,
					shipId = arg_72_0.contextData.shipId,
					pos = arg_72_0.contextData.pos,
					oldShipId = var_72_0.shipId,
					oldPos = var_72_0.shipPos
				}

				if not {
					type = EquipmentInfoMediator.TYPE_REPLACE,
					equipmentId = var_72_0.id,
					shipId = arg_72_0.contextData.shipId,
					pos = arg_72_0.contextData.pos,
					oldShipId = var_72_0.shipId,
					oldPos = var_72_0.shipPos
				} then
					if var_72_0.shipId then
						var_77_0 = {
							showTransformTip = true,
							type = EquipmentInfoMediator.TYPE_DISPLAY,
							equipmentId = var_72_0.id,
							shipId = var_72_0.shipId,
							pos = var_72_0.shipPos
						}

						if not {
							showTransformTip = true,
							type = EquipmentInfoMediator.TYPE_DISPLAY,
							equipmentId = var_72_0.id,
							shipId = var_72_0.shipId,
							pos = var_72_0.shipPos
						} then
							var_77_0 = {
								destroy = true,
								type = EquipmentInfoMediator.TYPE_DEFAULT,
								equipmentId = var_72_0.id
							}
						end

						arg_72_0:emit(var_0_0.ON_EQUIPMENT, var_77_0)

						return
					end
				end
			end
		end, SFX_PANEL)
	end

	return
end

function var_0_0.returnEquipment(arg_78_0, arg_78_1, arg_78_2)
	if arg_78_0.exited then
		return
	end

	local var_78_0 = arg_78_0.equipmetItems[arg_78_2]

	if arg_78_0.equipmetItems[arg_78_2] then
		removeOnButton(var_78_0.go)
		var_78_0:clear()
	end

	return
end

function var_0_0.updateEquipmentCount(arg_79_0, arg_79_1)
	arg_79_0.equipmentRect:SetTotalCount(arg_79_1 or #arg_79_0.loadEquipmentVOs, -1)
	setActive(arg_79_0.listEmptyTF, (arg_79_1 or #arg_79_0.loadEquipmentVOs) <= 0)
	setText(arg_79_0.listEmptyTxt, i18n("list_empty_tip_storehouseui_equip"))
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.filterEquipment(arg_80_0)
	if arg_80_0.filterEquipWaitting > 0 then
		arg_80_0.filterEquipWaitting = arg_80_0.filterEquipWaitting - 1

		return
	end

	local var_80_0

	if arg_80_0.page == var_0_3 then
		arg_80_0:filterEquipSkin()

		return
	elseif arg_80_0.page == var_0_4 then
		arg_80_0:filterSpWeapon()

		do return end

		var_80_0 = GetSpriteFromAtlasAsync
	end

	var_80_0("ui/share/index_atlas", arg_80_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_81_0)
		setImageSprite(arg_80_0.indexBtn, arg_81_0, true)

		return
	end)

	arg_80_0.loadEquipmentVOs = {}

	for iter_80_0, iter_80_1 in pairs(arg_80_0.equipmentVOs) do
		if not iter_80_1.isSkin then
			table.insert({}, iter_80_1)
		end
	end

	for iter_80_2, iter_80_3 in pairs({}) do
		if (iter_80_3.count > 0 or iter_80_3.shipId) and arg_80_0:checkFitBusyCondition(iter_80_3) and IndexConst.filterEquipByType(iter_80_3, arg_80_0.contextData.indexDatas.typeIndex) and IndexConst.filterEquipByProperty(iter_80_3, {
			arg_80_0.contextData.indexDatas.equipPropertyIndex,
			arg_80_0.contextData.indexDatas.equipPropertyIndex2
		}) and IndexConst.filterEquipAmmo1(iter_80_3, arg_80_0.contextData.indexDatas.equipAmmoIndex1) and IndexConst.filterEquipAmmo2(iter_80_3, arg_80_0.contextData.indexDatas.equipAmmoIndex2) and IndexConst.filterEquipByCamp(iter_80_3, arg_80_0.contextData.indexDatas.equipCampIndex) and IndexConst.filterEquipByRarity(iter_80_3, arg_80_0.contextData.indexDatas.rarityIndex) and IndexConst.filterEquipByExtra(iter_80_3, arg_80_0.contextData.indexDatas.extraIndex) then
			table.insert(arg_80_0.loadEquipmentVOs, iter_80_3)
		end
	end

	if arg_80_0.filterImportance ~= nil then
		for iter_80_4 = #arg_80_0.loadEquipmentVOs, 1, -1 do
			if arg_80_0.loadEquipmentVOs[iter_80_4].isSkin or not arg_80_0.loadEquipmentVOs[iter_80_4].isSkin and arg_80_0.loadEquipmentVOs[iter_80_4]:isImportance() then
				table.remove(arg_80_0.loadEquipmentVOs, iter_80_4)
			end
		end
	end

	local var_80_1 = arg_80_0.searchBar:GetInputText()

	if var_80_1 and var_80_1 ~= "" then
		arg_80_0.loadEquipmentVOs = underscore.filter(arg_80_0.loadEquipmentVOs, function(arg_82_0)
			return arg_82_0:IsMatchKey(var_80_1)
		end)
	end

	local var_80_2 = arg_80_0.contextData.sortData

	if arg_80_0.contextData.sortData then
		table.sort(arg_80_0.loadEquipmentVOs, CompareFuncs(var_0_8.sortFunc(var_80_2, arg_80_0.asc)))
	end

	if arg_80_0.contextData.qiutBtn then
		table.insert(arg_80_0.loadEquipmentVOs, 1, false)
	end

	arg_80_0:updateSelected()
	arg_80_0:updateEquipmentCount()
	setImageSprite(arg_80_0.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", var_80_2.spr), true)
	setActive(arg_80_0.sortImgAsc, arg_80_0.asc)
	setActive(arg_80_0.sortImgDec, not arg_80_0.asc)
	arg_80_0:updateCapacity()

	return
end

function var_0_0.filterEquipSkin(arg_83_0)
	arg_83_0.loadEquipmentVOs = {}

	if arg_83_0.page ~= var_0_3 then
		assert(false, "不是外观分页")
	end

	local var_83_0 = arg_83_0.searchBar:GetInputText()

	for iter_83_0, iter_83_1 in pairs(arg_83_0.equipmentVOs) do
		if iter_83_1.isSkin and iter_83_1.count > 0 and (var_83_0 == "" or EquipmentTools.IsMatchEquipmentSkinKey(iter_83_1.id, var_83_0)) then
			table.insert({}, iter_83_1)
		end
	end

	for iter_83_2, iter_83_3 in pairs({}) do
		if IndexConst.filterEquipSkinByIndex(iter_83_3, arg_83_0.equipSkinIndex) and IndexConst.filterEquipSkinByTheme(iter_83_3, arg_83_0.equipSkinTheme) and arg_83_0:checkFitBusyCondition(iter_83_3) then
			table.insert(arg_83_0.loadEquipmentVOs, iter_83_3)
		end
	end

	if arg_83_0.filterImportance ~= nil then
		for iter_83_4 = #arg_83_0.loadEquipmentVOs, 1, -1 do
			if arg_83_0.loadEquipmentVOs[iter_83_4].isSkin or not arg_83_0.loadEquipmentVOs[iter_83_4].isSkin and arg_83_0.loadEquipmentVOs[iter_83_4]:isImportance() then
				table.remove(arg_83_0.loadEquipmentVOs, iter_83_4)
			end
		end
	end

	if arg_83_0.contextData.sortData then
		table.sort(arg_83_0.loadEquipmentVOs, CompareFuncs(var_0_8.sortFunc(var_83_1, arg_83_0.asc)))
	end

	if arg_83_0.contextData.qiutBtn then
		table.insert(arg_83_0.loadEquipmentVOs, 1, false)
	end

	arg_83_0:updateSelected()
	arg_83_0:updateEquipmentCount()
	setActive(arg_83_0.sortImgAsc, arg_83_0.asc)
	setActive(arg_83_0.sortImgDec, not arg_83_0.asc)

	return
end

function var_0_0.filterSpWeapon(arg_84_0)
	local var_84_0

	if arg_84_0.page ~= var_0_4 then
		assert(false, "不是特殊兵装分页")

		var_84_0 = GetSpriteFromAtlasAsync
	end

	var_84_0("ui/share/index_atlas", arg_84_0:isDefaultSpWeaponIndexData() and "shaixuan_off" or "shaixuan_on", function(arg_85_0)
		setImageSprite(arg_84_0.indexBtn, arg_85_0, true)

		return
	end)

	arg_84_0.loadEquipmentVOs = {}

	for iter_84_0, iter_84_1 in pairs(arg_84_0.spweaponVOs) do
		if IndexConst.filterSpWeaponByType(iter_84_1, arg_84_0.contextData.spweaponIndexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_84_1, arg_84_0.contextData.spweaponIndexDatas.rarityIndex) and arg_84_0:checkFitBusyCondition(iter_84_1) and (arg_84_0.filterImportance == nil or iter_84_1:IsImportant()) then
			table.insert(arg_84_0.loadEquipmentVOs, iter_84_1)
		end
	end

	local var_84_1 = arg_84_0.searchBar:GetInputText()

	if var_84_1 and var_84_1 ~= "" then
		local var_84_2 = EquipmentTools.GetMatchSpEquipmentListKeyByShip(var_84_1)

		arg_84_0.loadEquipmentVOs = underscore.filter(arg_84_0.loadEquipmentVOs, function(arg_86_0)
			return arg_86_0:IsMatchKey(var_84_1) or table.contains(var_84_2, arg_86_0.id)
		end)
	end

	local var_84_3 = arg_84_0.contextData.spweaponSortData

	if arg_84_0.contextData.spweaponSortData then
		table.sort(arg_84_0.loadEquipmentVOs, CompareFuncs(var_0_9.sortFunc(var_84_3, arg_84_0.asc)))
	end

	if arg_84_0.contextData.qiutBtn then
		table.insert(arg_84_0.loadEquipmentVOs, 1, false)
	end

	arg_84_0:updateSelected()
	arg_84_0:updateEquipmentCount()
	setImageSprite(arg_84_0.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", var_84_3.spr), true)
	setActive(arg_84_0.sortImgAsc, arg_84_0.asc)
	setActive(arg_84_0.sortImgDec, not arg_84_0.asc)
	arg_84_0:UpdateSpweaponCapacity()

	return
end

function var_0_0.GetShowBusyFlag(arg_87_0)
	return arg_87_0.isEquipingOn
end

function var_0_0.SetShowBusyFlag(arg_88_0, arg_88_1)
	arg_88_0.isEquipingOn = arg_88_1

	return
end

function var_0_0.Scroll2Equip(arg_89_0, arg_89_1)
	if arg_89_0.contextData.warp ~= StoreHouseConst.WARP_TO_WEAPON or arg_89_0.page ~= var_0_2 then
		return
	end

	for iter_89_0, iter_89_1 in ipairs(arg_89_0.loadEquipmentVOs) do
		if EquipmentProxy.SameEquip(iter_89_1, arg_89_1) then
			local var_89_0 = arg_89_0.equipmentView:Find("equipment_grid"):GetComponent(typeof(GridLayoutGroup))

			arg_89_0:ScrollEquipPos((var_89_0.cellSize.y + var_89_0.spacing.y) * math.floor((iter_89_0 - 1) / var_89_0.constraintCount) + arg_89_0.equipmentRect.paddingFront + arg_89_0.equipmentView.rect.height * 0.5 - arg_89_0.equipmentRect.paddingFront)

			break
		end
	end

	return
end

function var_0_0.ScrollEquipPos(arg_90_0, arg_90_1)
	local var_90_9000
	local var_90_0 = arg_90_0.equipmentView:Find("equipment_grid")
	local var_90_1 = var_90_0.GetComponent(var_90_9000, typeof(GridLayoutGroup))
	local var_90_2 = var_90_0 - arg_90_0.equipmentView.rect.height

	if var_90_0 - arg_90_0.equipmentView.rect.height <= 0 or not var_90_2 then
		var_90_2 = (var_90_1.cellSize.y + var_90_1.spacing.y) * math.ceil(#arg_90_0.loadEquipmentVOs / var_90_1.constraintCount) - var_90_1.spacing.y + arg_90_0.equipmentRect.paddingFront + arg_90_0.equipmentRect.paddingEnd
	end

	arg_90_0.equipmentRect:ScrollTo((arg_90_1 - arg_90_0.equipmentView.rect.height * 0.5) / var_90_2)

	return
end

function var_0_0.checkFitBusyCondition(arg_91_0, arg_91_1)
	return not arg_91_1.shipId or arg_91_0:GetShowBusyFlag() and arg_91_0.mode ~= StoreHouseConst.DESTROY
end

function var_0_0.setItems(arg_92_0, arg_92_1)
	arg_92_0.itemVOs = arg_92_1

	if arg_92_0.isInitItems and arg_92_0.contextData.warp == StoreHouseConst.WARP_TO_MATERIAL then
		arg_92_0:sortItems()
	end

	return
end

function var_0_0.initItems(arg_93_0)
	arg_93_0.isInitItems = true
	arg_93_0.itemRect = arg_93_0.itemView:GetComponent("LScrollRect")

	function arg_93_0.itemRect.onInitItem(arg_94_0)
		arg_93_0:initItem(arg_94_0)

		return
	end

	function arg_93_0.itemRect.onUpdateItem(arg_95_0, arg_95_1)
		arg_93_0:updateItem(arg_95_0, arg_95_1)

		return
	end

	function arg_93_0.itemRect.onReturnItem(arg_96_0, arg_96_1)
		arg_93_0:returnItem(arg_96_0, arg_96_1)

		return
	end

	arg_93_0.itemRect.decelerationRate = 0.07

	return
end

function var_0_0.sortItems(arg_97_0)
	table.sort(arg_97_0.itemVOs, CompareFuncs({
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
	arg_97_0.itemRect:SetTotalCount(#arg_97_0.itemVOs, -1)
	setActive(arg_97_0.listEmptyTF, #arg_97_0.itemVOs <= 0)
	setText(arg_97_0.listEmptyTxt, i18n("list_empty_tip_storehouseui_item"))
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.initItem(arg_101_0, arg_101_1)
	arg_101_0.itemCards[arg_101_1] = ItemCard.New(arg_101_1)

	return
end

function var_0_0.updateItem(arg_102_0, arg_102_1, arg_102_2)
	assert(arg_102_0.itemCards[arg_102_2], "without init item")

	local var_102_0 = arg_102_0.itemVOs[arg_102_1 + 1]

	arg_102_0.itemCards[arg_102_2]:update(arg_102_0.itemVOs[arg_102_1 + 1])

	if not arg_102_0.itemVOs[arg_102_1 + 1] then
		removeOnButton(arg_102_0.itemCards[arg_102_2].go)
	elseif tobool(getProxy(TechnologyProxy):getItemCanUnlockBluePrint(arg_102_0.itemVOs[arg_102_1 + 1].id)) then
		local var_102_1 = getProxy(TechnologyProxy)

		if underscore.detect(underscore.map(getProxy(TechnologyProxy):getItemCanUnlockBluePrint(arg_102_0.itemVOs[arg_102_1 + 1].id), function(arg_103_0)
			return var_102_1:getBluePrintById(arg_103_0)
		end), function(arg_104_0)
			return not arg_104_0:isUnlock()
		end) then
			onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM,
					item = var_102_0,
					blueprints = var_0,
					onYes = function()
						arg_102_0:emit(EquipmentMediator.ITEM_GO_SCENE, SCENE.SHIPBLUEPRINT, {
							shipBluePrintVO = var_0
						})

						return
					end,
					yesText = i18n("text_forward")
				})

				return
			end, SFX_PANEL)
		else
			onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM,
					windowSize = Vector2(1010, 685),
					item = var_102_0,
					blueprints = var_0,
					onYes = function()
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							type = MSGBOX_TYPE_ITEM_BOX,
							content = i18n("techpackage_item_use_confirm"),
							items = underscore.map(var_102_0:getConfig("display_icon"), function(arg_109_0)
								return {
									type = arg_109_0[1],
									id = arg_109_0[2],
									count = arg_109_0[3]
								}
							end),
							onYes = function()
								arg_102_0:emit(EquipmentMediator.ON_USE_ITEM, var_102_0.id, 1)

								return
							end
						})

						return
					end
				})

				return
			end, SFX_PANEL)
		end
	elseif arg_102_0.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.INVITATION_TYPE then
		onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
			arg_102_0:emit(EquipmentMediator.ITEM_GO_SCENE, SCENE.INVITATION, {
				itemVO = var_102_0
			})

			return
		end, SFX_PANEL)
	elseif arg_102_0.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.ASSIGNED_TYPE or arg_102_0.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.EQUIPMENT_ASSIGNED_TYPE then
		if underscore.any(pg.gameset.general_blueprint_list.description, function(arg_112_0)
			return var_102_0.id == arg_112_0
		end) then
			onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
				arg_102_0.blueprintAssignedItemView:Load()
				arg_102_0.blueprintAssignedItemView:ActionInvoke("Show")
				arg_102_0.blueprintAssignedItemView:ActionInvoke("update", var_102_0)

				return
			end, SFX_PANEL)
		else
			onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
				arg_102_0.assignedItemView:Load()
				arg_102_0.assignedItemView:ActionInvoke("Show")
				arg_102_0.assignedItemView:ActionInvoke("update", var_102_0)

				return
			end, SFX_PANEL)
		end
	elseif Item.IsLoveLetterCheckItem(arg_102_0.itemVOs[arg_102_1 + 1].id) then
		onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
			arg_102_0:emit(var_0_0.ON_ITEM_EXTRA, var_102_0.id, var_102_0.extra)

			return
		end, SFX_PANEL)
	elseif arg_102_0.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.LOVE_LETTER_TYPE then
		onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
			arg_102_0:emit(var_0_0.ON_ITEM_EXTRA, var_102_0.id, var_102_0.extra)

			return
		end, SFX_PANEL)
	elseif arg_102_0.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.SKIN_ASSIGNED_TYPE then
		onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
			arg_102_0:emit(var_0_0.ON_ITEM, var_102_0.id, function()
				local var_118_0 = var_102_0:getConfig("usage_arg")

				if var_102_0:IsAllSkinOwner() then
					local var_118_1 = Drop.New({
						count = 1,
						type = DROP_TYPE_ITEM,
						id = var_118_0[5]
					})

					arg_102_0.msgBox:ExecuteAction("Show", {
						content = i18n("blackfriday_pack_select_skinall_dialog", var_102_0:getConfig("name"), var_118_1:getName()),
						leftDrop = {
							count = 1,
							type = DROP_TYPE_ITEM,
							id = var_102_0.id
						},
						rightDrop = var_118_1,
						onYes = function()
							arg_102_0:emit(EquipmentMediator.ON_USE_ITEM, var_102_0.id, 1, {
								0
							})

							return
						end
					})
				else
					local var_118_2 = {}

					for iter_118_0, iter_118_1 in ipairs(var_118_0[2]) do
						var_118_2[iter_118_1] = true
					end

					arg_102_0:emit(EquipmentMediator.ITEM_ADD_LAYER, Context.New({
						viewComponent = NewSelectSkinLayer,
						mediator = NewSkinAtlasMediator,
						data = {
							mode = SelectSkinLayer.MODE_SELECT,
							itemId = var_102_0.id,
							selectableSkinList = underscore.map(var_102_0:GetValidSkinList(), function(arg_120_0)
								({
									id = arg_120_0
								}).isTimeLimit = var_118_2[arg_120_0] or false

								return SelectableSkin.New({
									id = arg_120_0
								})
							end),
							OnConfirm = function(arg_121_0)
								arg_102_0:emit(EquipmentMediator.ON_USE_ITEM, var_102_0.id, 1, {
									arg_121_0
								})

								return
							end
						}
					}))
				end

				return
			end)

			return
		end, SFX_PANEL)
	else
		onButton(arg_102_0, arg_102_0.itemCards[arg_102_2].go, function()
			arg_102_0:emit(var_0_0.ON_ITEM, var_102_0.id)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.returnItem(arg_123_0, arg_123_1, arg_123_2)
	if arg_123_0.exited then
		return
	end

	local var_123_0 = arg_123_0.itemCards[arg_123_2]

	if arg_123_0.itemCards[arg_123_2] then
		removeOnButton(var_123_0.go)
		var_123_0:clear()
	end

	return
end

function var_0_0.selectCount(arg_124_0)
	local var_124_0 = 0

	for iter_124_0, iter_124_1 in ipairs(arg_124_0.selectedIds) do
		var_124_0 = var_124_0 + iter_124_1[2]
	end

	return var_124_0
end

function var_0_0.selectEquip(arg_125_0, arg_125_1, arg_125_2)
	if not arg_125_0:checkDestroyGold(arg_125_1, arg_125_2) then
		return
	end

	if arg_125_0.mode == StoreHouseConst.DESTROY then
		local var_125_0 = false
		local var_125_1
		local var_125_2 = 0

		for iter_125_0, iter_125_1 in pairs(arg_125_0.selectedIds) do
			if iter_125_1[1] == arg_125_1.id then
				var_125_0 = true
				var_125_1 = iter_125_0
				var_125_2 = iter_125_1[2]

				break
			end
		end

		if not var_125_0 then
			local var_125_3, var_125_4 = arg_125_0.checkEquipment(arg_125_1, function()
				arg_125_0:selectEquip(arg_125_1, arg_125_2)

				return
			end, arg_125_0.selectedIds)

			if not var_125_3 then
				if var_125_4 then
					pg.TipsMgr.GetInstance():ShowTips(var_125_4)
				end

				return
			end

			local var_125_5 = arg_125_0:selectCount()

			if arg_125_0.selectedMax > 0 and var_125_5 + arg_125_2 > arg_125_0.selectedMax then
				arg_125_2 = arg_125_0.selectedMax - var_125_5
			end

			if arg_125_0.selectedMax == 0 or var_125_5 < arg_125_0.selectedMax then
				table.insert(arg_125_0.selectedIds, {
					arg_125_1.id,
					arg_125_2
				})
			elseif arg_125_0.selectedMax == 1 then
				arg_125_0.selectedIds[1] = {
					arg_125_1.id,
					arg_125_2
				}
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_equipmentScene_selectError_more", arg_125_0.selectedMax))

				return
			end
		elseif var_125_2 - arg_125_2 > 0 then
			arg_125_0.selectedIds[var_125_1][2] = var_125_2 - arg_125_2
		else
			table.remove(arg_125_0.selectedIds, var_125_1)
		end
	end

	arg_125_0:updateSelected()

	return
end

function var_0_0.unselecteAllEquips(arg_127_0)
	arg_127_0.selectedIds = {}

	arg_127_0:updateSelected()

	return
end

function var_0_0.checkDestroyGold(arg_128_0, arg_128_1, arg_128_2)
	local var_128_0 = 0
	local var_128_1 = false

	for iter_128_0, iter_128_1 in pairs(arg_128_0.selectedIds) do
		if Equipment.CanInBag(iter_128_1[1]) then
			local var_128_2 = Equipment.getConfigData(iter_128_1[1]).destory_gold or 0

			var_128_0 = var_128_0 + var_128_2 * iter_128_1[2]
		end

		if arg_128_1 and iter_128_1[1] == arg_128_1.configId then
			var_128_1 = true
		end
	end

	if not var_128_1 and arg_128_1 and arg_128_2 > 0 then
		local var_128_3 = arg_128_1:getConfig("destory_gold") or 0

		var_128_0 = var_128_0 + var_128_3 * arg_128_2
	end

	if arg_128_0.player:GoldMax(var_128_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_destroy"))

		return false
	end

	return true
end

function var_0_0.updateSelected(arg_129_0)
	for iter_129_0, iter_129_1 in pairs(arg_129_0.equipmetItems) do
		if iter_129_1.equipmentVO then
			local var_129_0 = false
			local var_129_1 = 0

			for iter_129_2, iter_129_3 in pairs(arg_129_0.selectedIds) do
				if iter_129_1.equipmentVO.id == iter_129_3[1] then
					var_129_0 = true
					var_129_1 = iter_129_3[2]

					break
				end
			end

			iter_129_1:updateSelected(var_129_0, var_129_1)
		end
	end

	if arg_129_0.mode == StoreHouseConst.DESTROY then
		local var_129_2 = arg_129_0:selectCount()

		if arg_129_0.selectedMax == 0 then
			setText(findTF(arg_129_0.selectPanel, "bottom_info/bg_input/count"), var_129_2)
		else
			setText(findTF(arg_129_0.selectPanel, "bottom_info/bg_input/count"), var_129_2 .. "/" .. arg_129_0.selectedMax)
		end

		if #arg_129_0.selectedIds < arg_129_0.selectedMin then
			setActive(findTF(arg_129_0.selectPanel, "confirm_button/mask"), true)
		else
			setActive(findTF(arg_129_0.selectPanel, "confirm_button/mask"), false)
		end
	end

	return
end

function var_0_0.SwitchToDestroy(arg_130_0)
	arg_130_0.page = var_0_2
	arg_130_0.filterEquipWaitting = arg_130_0.filterEquipWaitting + 1

	triggerToggle(arg_130_0.weaponToggle, true)
	triggerButton(arg_130_0.BatchDisposeBtn)

	return
end

function var_0_0.SwitchToSpWeaponStoreHouse(arg_131_0)
	arg_131_0.page = var_0_4

	triggerToggle(arg_131_0.weaponToggle, true)

	return
end

function var_0_0.SwitchEquipmentType(arg_132_0, arg_132_1)
	local var_132_0 = arg_132_1 == var_0_4 and i18n("search_sp_equipment") or arg_132_1 == var_0_3 and i18n("search_equipment_appearance") or i18n("search_equipment")

	arg_132_0.searchBar:UpdateHolder(var_132_0)
	arg_132_0.searchBar:ClearInputText()

	return
end

function var_0_0.willExit(arg_133_0)
	arg_133_0:UnOverlayPanel(arg_133_0.blurPanel, arg_133_0._tf)
	arg_133_0:UnOverlayPanel(arg_133_0.topItems, arg_133_0._tf)

	if arg_133_0.bulinTip then
		arg_133_0.bulinTip:Destroy()

		arg_133_0.bulinTip = nil
	end

	if arg_133_0.searchBar then
		arg_133_0.searchBar:Dispose()

		arg_133_0.searchBar = nil
	end

	arg_133_0.destroyConfirmView:Destroy()
	arg_133_0.assignedItemView:Destroy()
	arg_133_0.blueprintAssignedItemView:Destroy()
	arg_133_0.equipDestroyConfirmWindow:Destroy()
	arg_133_0.msgBox:Destroy()

	return
end

return var_0_0
