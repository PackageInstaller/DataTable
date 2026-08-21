local var_0_0 = class("WorldInventoryLayer", import("..base.BaseUI"))
local var_0_1 = require("view.equipment.EquipmentSortCfg")

var_0_0.PAGE = {
	Equipment = 2,
	Property = 1,
	Material = 3
}

function var_0_0.getUIName(arg_1_0)
	return "WorldInventoryUI"
end

function var_0_0.init(arg_2_0)
	function arg_2_0.itemUpdateListenerFunc(...)
		arg_2_0:setItemList(arg_2_0.inventoryProxy:GetItemList())

		return
	end

	arg_2_0.blurPanel = arg_2_0._tf:Find("adapt/blur_panel")
	arg_2_0.backBtn = arg_2_0.blurPanel:Find("adapt/top/back_btn")
	arg_2_0.topItems = arg_2_0._tf:Find("adapt/topItems")
	arg_2_0.itemView = arg_2_0._tf:Find("adapt/item_scrollview")
	arg_2_0.equipmentView = arg_2_0._tf:Find("adapt/equipment_scrollview")
	arg_2_0.materialtView = arg_2_0._tf:Find("adapt/material_scrollview")

	local var_2_0 = (NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and arg_2_0.itemView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2
	local var_2_1 = arg_2_0.itemView:Find("Viewport/item_grid")

	var_2_1:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_2_0 and 8 or 7

	local var_2_2 = arg_2_0.equipmentView:Find("Viewport/moudle_grid")

	var_2_2:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_2_0 and 8 or 7

	local var_2_3 = arg_2_0.materialtView:Find("Viewport/item_grid")

	var_2_3:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_2_0 and 8 or 7
	arg_2_0.itemUsagePanel = ItemUsagePanel.New(arg_2_0._tf:Find("adapt/item_usage_panel"), arg_2_0._tf:Find("adapt"))
	arg_2_0.itemResetPanel = ItemResetPanel.New(arg_2_0._tf:Find("adapt/reset_info_panel"), arg_2_0._tf:Find("adapt"))
	arg_2_0.assignedItemView = WorldAssignedItemView.New(arg_2_0._tf:Find("adapt"), arg_2_0.event)
	arg_2_0.itemCards = {}
	arg_2_0.equipmetItems = {}
	arg_2_0.materialCards = {}
	arg_2_0._itemToggle = arg_2_0.topItems:Find("bottom_back/types/properties")
	arg_2_0._weaponToggle = arg_2_0.topItems:Find("bottom_back/types/siren_weapon")
	arg_2_0._materialToggle = arg_2_0.topItems:Find("bottom_back/types/material")
	arg_2_0.exchangeTips = arg_2_0.topItems:Find("bottom_back/reset_exchange")

	setText(arg_2_0.topItems:Find("bottom_back/reset_exchange/Text"), i18n("world_inventory_tip"))

	arg_2_0.filterBusyToggle = arg_2_0.blurPanel:Find("adapt/left_length/frame/toggle_equip")
	arg_2_0.sortBtn = arg_2_0.blurPanel:Find("adapt/top/buttons/sort_button")
	arg_2_0.indexBtn = arg_2_0.blurPanel:Find("adapt/top/buttons/index_button")
	arg_2_0.decBtn = arg_2_0.blurPanel:Find("adapt/top/buttons/dec_btn")
	arg_2_0.upOrderTF = arg_2_0.decBtn:Find("asc")
	arg_2_0.downOrderTF = arg_2_0.decBtn:Find("desc")
	arg_2_0.sortPanel = arg_2_0.topItems:Find("sort")
	arg_2_0.sortContain = arg_2_0.sortPanel:Find("adapt/mask/panel")
	arg_2_0.sortTpl = arg_2_0.sortContain:Find("tpl")

	setActive(arg_2_0.sortTpl, false)
	arg_2_0:initData()
	arg_2_0:addListener()
	print(arg_2_0._tf:Find("bg").rect.width)

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:initItems()
	arg_4_0:initEquipments()
	arg_4_0:InitMaterials()
	setActive(arg_4_0._weaponToggle, true)
	setActive(arg_4_0._itemToggle, true)

	arg_4_0.contextData.pageNum = nil

	if arg_4_0.contextData.pageNum == var_0_0.PAGE.Property then
		triggerToggle(arg_4_0._itemToggle, true)
	elseif arg_4_0.contextData.pageNum == var_0_0.PAGE.Equipment then
		triggerToggle(arg_4_0._weaponToggle, true)
	elseif arg_4_0.contextData.pageNum == var_0_0.PAGE.Material then
		triggerToggle(arg_4_0._materialToggle, true)
	end

	if arg_4_0.contextData.equipScrollPos then
		arg_4_0:ScrollEquipPos(arg_4_0.contextData.equipScrollPos.y)
	end

	onButton(arg_4_0, arg_4_0.exchangeTips:Find("capcity"), function()
		arg_4_0:emit(var_0_0.ON_DROP, {
			type = DROP_TYPE_RESOURCE,
			id = WorldConst.ResourceID
		})

		return
	end, SFX_PANEL)
	arg_4_0:OverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.onBackPressed(arg_6_0)
	print(arg_6_0._tf:Find("bg").rect.width)

	if isActive(arg_6_0.itemResetPanel._go) then
		arg_6_0.itemResetPanel:Close()
	elseif isActive(arg_6_0.itemUsagePanel._go) then
		arg_6_0.itemUsagePanel:Close()
	elseif arg_6_0.assignedItemView:isShowing() then
		arg_6_0.assignedItemView:Hide()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(arg_6_0.backBtn)
	end

	return
end

function var_0_0.willExit(arg_7_0)
	arg_7_0.assignedItemView:Destroy()
	arg_7_0.inventoryProxy:RemoveListener(WorldInventoryProxy.EventUpdateItem, arg_7_0.itemUpdateListenerFunc)
	arg_7_0:UnOverlayPanel(arg_7_0._tf)

	return
end

function var_0_0.initData(arg_8_0)
	arg_8_0.contextData.pageNum = arg_8_0.contextData.pageNum or var_0_0.PAGE.Property
	arg_8_0.contextData.asc = arg_8_0.contextData.asc or false
	arg_8_0.contextData.sortData = arg_8_0.contextData.sortData or var_0_1.sort[1]

	local var_8_0 = arg_8_0.contextData

	var_8_0.indexDatas = arg_8_0.contextData.indexDatas or {}
	arg_8_0.isEquipingOn = false

	return
end

function var_0_0.GetShowBusyFlag(arg_9_0)
	return arg_9_0.isEquipingOn
end

function var_0_0.SetShowBusyFlag(arg_10_0, arg_10_1)
	arg_10_0.isEquipingOn = arg_10_1

	return
end

function var_0_0.addListener(arg_11_0)
	onButton(arg_11_0, arg_11_0.backBtn, function()
		print(arg_11_0._tf:Find("bg").rect.width)
		arg_11_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_11_0, arg_11_0.decBtn, function()
		arg_11_0.contextData.asc = not arg_11_0.contextData.asc

		if arg_11_0.contextData.pageNum == var_0_0.PAGE.Equipment then
			arg_11_0:filterEquipment()
		end

		return
	end, SFX_PANEL)

	arg_11_0.sortButtons = {}

	eachChild(arg_11_0.sortContain, function(arg_14_0)
		setActive(arg_14_0, false)

		return
	end)

	for iter_11_0, iter_11_1 in ipairs(var_0_1.sort) do
		local var_11_0 = iter_11_0 <= arg_11_0.sortContain.childCount and arg_11_0.sortContain:GetChild(iter_11_0 - 1) or cloneTplTo(arg_11_0.sortTpl, arg_11_0.sortContain)

		setActive(var_11_0, true)
		setImageSprite(findTF(var_11_0, "Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", iter_11_1.spr), true)
		onToggle(arg_11_0, var_11_0, function(arg_15_0)
			if arg_15_0 then
				arg_11_0.contextData.sortData = iter_11_1

				arg_11_0:filterEquipment()
				triggerToggle(arg_11_0.sortBtn, false)
			end

			return
		end, SFX_PANEL)

		arg_11_0.sortButtons[iter_11_0] = var_11_0
	end

	onToggle(arg_11_0, arg_11_0.sortBtn, function(arg_16_0)
		if arg_16_0 then
			arg_11_0:OverlayPanel(arg_11_0.sortPanel)
			setActive(arg_11_0.sortPanel, true)
		else
			arg_11_0:UnOverlayPanel(arg_11_0.sortPanel, arg_11_0.topItems)
			setActive(arg_11_0.sortPanel, false)
		end

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.sortPanel, function()
		triggerToggle(arg_11_0.sortBtn, false)

		return
	end, SFX_PANEL)
	onToggle(arg_11_0, arg_11_0.filterBusyToggle, function(arg_18_0)
		arg_11_0:SetShowBusyFlag(arg_18_0)

		if arg_11_0.contextData.pageNum == var_0_0.PAGE.Equipment then
			arg_11_0:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.indexBtn, function()
		arg_11_0:emit(WorldInventoryMediator.OPEN_EQUIPMENT_INDEX, {
			indexDatas = Clone(arg_11_0.contextData.indexDatas),
			customPanels = {
				minHeight = 650,
				typeIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipmentTypeIndexs,
					names = IndexConst.EquipmentTypeNames
				},
				equipPropertyIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipPropertyIndexs,
					names = IndexConst.EquipPropertyNames
				},
				equipPropertyIndex2 = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipPropertyIndexs,
					names = IndexConst.EquipPropertyNames
				},
				equipAmmoIndex1 = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipAmmoIndexs_1,
					names = IndexConst.EquipAmmoIndexs_1_Names
				},
				equipAmmoIndex2 = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipAmmoIndexs_2,
					names = IndexConst.EquipAmmoIndexs_2_Names
				},
				equipCampIndex = {
					mode = CustomIndexLayer.Mode.AND,
					options = IndexConst.EquipCampIndexs,
					names = IndexConst.EquipCampNames
				},
				rarityIndex = {
					mode = CustomIndexLayer.Mode.AND,
					options = IndexConst.EquipmentRarityIndexs,
					names = IndexConst.RarityNames
				},
				extraIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.EquipmentExtraIndexs,
					names = IndexConst.EquipmentExtraNames
				}
			},
			groupList = {
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
			},
			dropdownLimit = {
				equipPropertyIndex = {
					include = {
						typeIndex = IndexConst.EquipmentTypeAll
					},
					exclude = {}
				},
				equipPropertyIndex2 = {
					include = {
						typeIndex = IndexConst.EquipmentTypeEquip
					},
					exclude = {
						typeIndex = IndexConst.EquipmentTypeAll
					}
				},
				equipAmmoIndex1 = {
					include = {
						typeIndex = IndexConst.BitAll({
							IndexConst.EquipmentTypeSmallCannon,
							IndexConst.EquipmentTypeMediumCannon,
							IndexConst.EquipmentTypeBigCannon
						})
					},
					exclude = {
						typeIndex = IndexConst.EquipmentTypeAll
					}
				},
				equipAmmoIndex2 = {
					include = {
						typeIndex = IndexConst.BitAll({
							IndexConst.EquipmentTypeWarshipTorpedo,
							IndexConst.EquipmentTypeSubmaraineTorpedo
						})
					},
					exclude = {
						typeIndex = IndexConst.EquipmentTypeAll
					}
				}
			},
			callback = function(arg_20_0)
				arg_11_0.contextData.indexDatas.typeIndex = arg_20_0.typeIndex
				arg_11_0.contextData.indexDatas.equipPropertyIndex = arg_20_0.equipPropertyIndex
				arg_11_0.contextData.indexDatas.equipPropertyIndex2 = arg_20_0.equipPropertyIndex2
				arg_11_0.contextData.indexDatas.equipAmmoIndex1 = arg_20_0.equipAmmoIndex1
				arg_11_0.contextData.indexDatas.equipAmmoIndex2 = arg_20_0.equipAmmoIndex2
				arg_11_0.contextData.indexDatas.equipCampIndex = arg_20_0.equipCampIndex
				arg_11_0.contextData.indexDatas.rarityIndex = arg_20_0.rarityIndex
				arg_11_0.contextData.indexDatas.extraIndex = arg_20_0.extraIndex

				if arg_11_0.filterBusyToggle:GetComponent(typeof(Toggle)) then
					if bit.band(arg_20_0.extraIndex, IndexConst.EquipmentExtraEquiping) > 0 then
						arg_11_0:SetShowBusyFlag(true)
					end

					triggerToggle(arg_11_0.filterBusyToggle, arg_11_0:GetShowBusyFlag())
				else
					arg_11_0:filterEquipment()
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onToggle(arg_11_0, arg_11_0._itemToggle, function(arg_21_0)
		if arg_21_0 and arg_11_0.contextData.pageNum ~= var_0_0.PAGE.Property then
			arg_11_0.contextData.pageNum = var_0_0.PAGE.Property

			arg_11_0:activeResetExchange(arg_11_0.contextData.pageNum == var_0_0.PAGE.Property)
			arg_11_0:sortItems()
		end

		return
	end, SFX_PANEL)
	onToggle(arg_11_0, arg_11_0._weaponToggle, function(arg_22_0)
		if arg_22_0 and arg_11_0.contextData.pageNum ~= var_0_0.PAGE.Equipment then
			arg_11_0.contextData.pageNum = var_0_0.PAGE.Equipment

			arg_11_0:activeResetExchange(arg_11_0.contextData.pageNum == var_0_0.PAGE.Property)
			arg_11_0:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onToggle(arg_11_0, arg_11_0._materialToggle, function(arg_23_0)
		if arg_23_0 and arg_11_0.contextData.pageNum ~= var_0_0.PAGE.Material then
			arg_11_0.contextData.pageNum = var_0_0.PAGE.Material

			arg_11_0:activeResetExchange(arg_11_0.contextData.pageNum == var_0_0.PAGE.Property)
			arg_11_0:SortMaterials()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.setWorldFleet(arg_24_0, arg_24_1)
	arg_24_0.worldFleetList = arg_24_1

	return
end

function var_0_0.setInventoryProxy(arg_25_0, arg_25_1)
	arg_25_0.inventoryProxy = arg_25_1

	arg_25_0.inventoryProxy:AddListener(WorldInventoryProxy.EventUpdateItem, arg_25_0.itemUpdateListenerFunc)
	arg_25_0:setItemList(arg_25_0.inventoryProxy:GetItemList())

	return
end

function var_0_0.setItemList(arg_26_0, arg_26_1)
	arg_26_0.itemList = arg_26_1

	if arg_26_0.isInitItems then
		arg_26_0:sortItems()
	end

	return
end

function var_0_0.initItems(arg_27_0)
	arg_27_0.isInitItems = true
	arg_27_0.itemRect = arg_27_0.itemView:GetComponent("LScrollRect")

	function arg_27_0.itemRect.onInitItem(arg_28_0)
		arg_27_0:initItem(arg_28_0)

		return
	end

	function arg_27_0.itemRect.onUpdateItem(arg_29_0, arg_29_1)
		arg_27_0:updateItem(arg_29_0, arg_29_1)

		return
	end

	function arg_27_0.itemRect.onReturnItem(arg_30_0, arg_30_1)
		arg_27_0:returnItem(arg_30_0, arg_30_1)

		return
	end

	return
end

function var_0_0.initItem(arg_31_0, arg_31_1)
	local var_31_0 = WSInventoryItem.New(arg_31_1)

	onButton(arg_31_0, var_31_0.go, function()
		local var_32_0 = var_31_0.itemVO:getWorldItemType()

		if var_32_0 == WorldItem.UsageBuff or var_32_0 == WorldItem.UsageHPRegenerate or var_32_0 == WorldItem.UsageHPRegenerateValue then
			arg_31_0:emit(WorldInventoryMediator.OnOpenAllocateLayer, {
				itemVO = var_31_0.itemVO,
				fleetList = arg_31_0.worldFleetList,
				fleetIndex = arg_31_0.contextData.currentFleetIndex,
				confirmCallback = function(arg_33_0, arg_33_1)
					arg_31_0:emit(WorldInventoryMediator.OnUseItem, arg_33_0, 1, arg_33_1)

					return
				end,
				onResetInfo = function(arg_34_0)
					arg_31_0.itemResetPanel:Open(arg_34_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageWorldMap then
			arg_31_0.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				mode = ItemUsagePanel.SEE,
				onUse = function()
					arg_31_0:PlayOpenBox(var_31_0.itemVO:getWorldItemOpenDisplay(), function()
						arg_31_0:emit(WorldInventoryMediator.OnMap, var_31_0.itemVO.id)
						arg_31_0:closeView()

						return
					end)

					return
				end,
				onResetInfo = function(arg_37_0)
					arg_31_0.itemResetPanel:Open(arg_37_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageDrop or var_32_0 == WorldItem.UsageRecoverAp or var_32_0 == WorldItem.UsageWorldItem or var_32_0 == WorldItem.UsageWorldBuff then
			arg_31_0.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				mode = ItemUsagePanel.BATCH,
				onUseBatch = function(arg_38_0)
					arg_31_0:emit(WorldInventoryMediator.OnUseItem, var_31_0.itemVO.id, arg_38_0, {})

					return
				end,
				onUseOne = function()
					arg_31_0:emit(WorldInventoryMediator.OnUseItem, var_31_0.itemVO.id, 1, {})

					return
				end,
				onResetInfo = function(arg_40_0)
					arg_31_0.itemResetPanel:Open(arg_40_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageLoot then
			arg_31_0.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				mode = ItemUsagePanel.INFO,
				onResetInfo = function(arg_41_0)
					arg_31_0.itemResetPanel:Open(arg_41_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageWorldClean or var_32_0 == WorldItem.UsageWorldFlag then
			arg_31_0.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				onUse = function()
					arg_31_0:emit(WorldInventoryMediator.OnUseItem, var_31_0.itemVO.id, 1, {})

					return
				end,
				onResetInfo = function(arg_43_0)
					arg_31_0.itemResetPanel:Open(arg_43_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageDropAppointed then
			arg_31_0.assignedItemView:Load()
			arg_31_0.assignedItemView:ActionInvoke("update", var_31_0.itemVO)
			arg_31_0.assignedItemView:ActionInvoke("Show")
		end

		return
	end, SFX_PANEL)

	arg_31_0.itemCards[arg_31_1] = var_31_0

	return
end

function var_0_0.updateItem(arg_44_0, arg_44_1, arg_44_2)
	if not arg_44_0.itemCards[arg_44_2] then
		arg_44_0:initItem(arg_44_2)
	end

	arg_44_0.itemCards[arg_44_2]:update(arg_44_0.itemList[arg_44_1 + 1])

	return
end

function var_0_0.returnItem(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0.exited then
		return
	end

	if arg_45_0.itemCards[arg_45_2] then
		var_45_0:clear()
	end

	return
end

function var_0_0.sortItems(arg_46_0)
	table.sort(arg_46_0.itemList, CompareFuncs({
		function(arg_47_0)
			return -arg_47_0:getConfig("sort_priority")
		end,
		function(arg_48_0)
			return arg_48_0:getConfig("id")
		end
	}))
	arg_46_0.itemRect:SetTotalCount(#arg_46_0.itemList, -1)
	arg_46_0:updateResetExchange()

	return
end

function var_0_0.updateResetExchange(arg_49_0)
	setText(arg_49_0.exchangeTips:Find("capcity/Text"), defaultValue(checkExist(arg_49_0.inventoryProxy:CalcResetExchangeResource(), {
		DROP_TYPE_RESOURCE
	}, {
		WorldConst.ResourceID
	}), 0))

	return
end

function var_0_0.activeResetExchange(arg_50_0, arg_50_1)
	setActive(arg_50_0.exchangeTips, nowWorld():IsSystemOpen(WorldConst.SystemResetExchange) and arg_50_1)

	return
end

function var_0_0.PlayOpenBox(arg_51_0, arg_51_1, arg_51_2)
	if not arg_51_1 or arg_51_1 == "" then
		arg_51_2()

		return
	end

	local function var_51_0()
		if arg_51_0.playing or not arg_51_0[arg_51_1] then
			return
		end

		arg_51_0.playing = true

		arg_51_0[arg_51_1]:SetActive(true)

		local var_52_0 = tf(arg_51_0[arg_51_1])

		var_52_0:SetParent(arg_51_0._tf:Find("adapt"), false)
		var_52_0:SetAsLastSibling()

		local var_52_1 = var_52_0:GetComponent("DftAniEvent")

		var_52_1:SetTriggerEvent(function(arg_53_0)
			arg_51_2()

			return
		end)
		var_52_1:SetEndEvent(function(arg_54_0)
			if arg_51_0[arg_51_1] then
				SetActive(arg_51_0[arg_51_1], false)

				arg_51_0.playing = false
			end

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_EQUIPMENT_OPEN)

		return
	end

	local var_51_1 = arg_51_0._tf:Find(arg_51_1 .. "(Clone)")

	if var_51_1 then
		arg_51_0[arg_51_1] = go(var_51_1)
	end

	if not arg_51_0[arg_51_1] then
		PoolMgr.GetInstance():GetPrefab("ui/" .. string.lower(arg_51_1), "", true, function(arg_55_0)
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

function var_0_0.setEquipments(arg_56_0, arg_56_1)
	arg_56_0.equipmentVOs = arg_56_1

	return
end

function var_0_0.setEquipment(arg_57_0, arg_57_1)
	local var_57_0 = #arg_57_0.equipmentVOs + 1

	for iter_57_0, iter_57_1 in ipairs(arg_57_0.equipmentVOs) do
		if not iter_57_1.shipId and iter_57_1.id == arg_57_1.id then
			var_57_0 = iter_57_0

			break
		end
	end

	if arg_57_1.count > 0 then
		arg_57_0.equipmentVOs[var_57_0] = arg_57_1
	else
		table.remove(arg_57_0.equipmentVOs, var_57_0)
	end

	if arg_57_0.contextData.pageNum == var_0_0.PAGE.Equipment then
		arg_57_0:filterEquipment()
	end

	return
end

function var_0_0.initEquipments(arg_58_0)
	arg_58_0.isInitWeapons = true
	arg_58_0.equipmentRect = arg_58_0.equipmentView:GetComponent("LScrollRect")

	function arg_58_0.equipmentRect.onInitItem(arg_59_0)
		arg_58_0:initEquipment(arg_59_0)

		return
	end

	function arg_58_0.equipmentRect.onUpdateItem(arg_60_0, arg_60_1)
		arg_58_0:updateEquipment(arg_60_0, arg_60_1)

		return
	end

	function arg_58_0.equipmentRect.onReturnItem(arg_61_0, arg_61_1)
		arg_58_0:returnEquipment(arg_61_0, arg_61_1)

		return
	end

	arg_58_0.equipmentRect.decelerationRate = 0.07

	return
end

function var_0_0.initEquipment(arg_62_0, arg_62_1)
	local var_62_0 = EquipmentItem.New(arg_62_1)

	onButton(arg_62_0, var_62_0.go, function()
		if arg_62_0.equipmentRect.GetContentAnchoredPositionOriginal then
			arg_62_0.contextData.equipScrollPos = arg_62_0.equipmentRect:GetContentAnchoredPositionOriginal()
		end

		if var_62_0.equipmentVO == nil or var_62_0.equipmentVO.mask then
			return
		end

		if arg_62_0.shipVO then
			local var_63_0 = {
				type = EquipmentInfoMediator.TYPE_REPLACE,
				equipmentId = var_62_0.equipmentVO.id,
				shipId = arg_62_0.contextData.shipId,
				pos = arg_62_0.contextData.pos,
				oldShipId = var_62_0.equipmentVO.shipId,
				oldPos = var_62_0.equipmentVO.shipPos
			}

			if not {
				type = EquipmentInfoMediator.TYPE_REPLACE,
				equipmentId = var_62_0.equipmentVO.id,
				shipId = arg_62_0.contextData.shipId,
				pos = arg_62_0.contextData.pos,
				oldShipId = var_62_0.equipmentVO.shipId,
				oldPos = var_62_0.equipmentVO.shipPos
			} then
				if var_62_0.equipmentVO.shipId then
					var_63_0 = {
						type = EquipmentInfoMediator.TYPE_DISPLAY,
						equipmentId = var_62_0.equipmentVO.id,
						shipId = var_62_0.equipmentVO.shipId,
						pos = var_62_0.equipmentVO.shipPos
					}

					if not {
						type = EquipmentInfoMediator.TYPE_DISPLAY,
						equipmentId = var_62_0.equipmentVO.id,
						shipId = var_62_0.equipmentVO.shipId,
						pos = var_62_0.equipmentVO.shipPos
					} then
						var_63_0 = {
							destroy = true,
							type = EquipmentInfoMediator.TYPE_DEFAULT,
							equipmentId = var_62_0.equipmentVO.id
						}
					end

					arg_62_0:emit(var_0_0.ON_EQUIPMENT, var_63_0)

					return
				end
			end
		end
	end, SFX_PANEL)

	arg_62_0.equipmetItems[arg_62_1] = var_62_0

	return
end

function var_0_0.updateEquipment(arg_64_0, arg_64_1, arg_64_2)
	if not arg_64_0.equipmetItems[arg_64_2] then
		arg_64_0:initEquipment(arg_64_2)
	end

	arg_64_0.equipmetItems[arg_64_2]:update(arg_64_0.loadEquipmentVOs[arg_64_1 + 1])

	return
end

function var_0_0.returnEquipment(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_0.exited then
		return
	end

	if arg_65_0.equipmetItems[arg_65_2] then
		var_65_0:clear()
	end

	return
end

function var_0_0.filterEquipment(arg_66_0)
	arg_66_0.loadEquipmentVOs = arg_66_0.loadEquipmentVOs or {}

	table.clean(arg_66_0.loadEquipmentVOs)

	for iter_66_0, iter_66_1 in pairs(arg_66_0.equipmentVOs) do
		if (not iter_66_1.shipId or arg_66_0:GetShowBusyFlag()) and not iter_66_1.isSkin and IndexConst.filterEquipByType(iter_66_1, arg_66_0.contextData.indexDatas.typeIndex) and IndexConst.filterEquipByProperty(iter_66_1, {
			arg_66_0.contextData.indexDatas.equipPropertyIndex,
			arg_66_0.contextData.indexDatas.equipPropertyIndex2
		}) and IndexConst.filterEquipAmmo1(iter_66_1, arg_66_0.contextData.indexDatas.equipAmmoIndex1) and IndexConst.filterEquipAmmo2(iter_66_1, arg_66_0.contextData.indexDatas.equipAmmoIndex2) and IndexConst.filterEquipByCamp(iter_66_1, arg_66_0.contextData.indexDatas.equipCampIndex) and IndexConst.filterEquipByRarity(iter_66_1, arg_66_0.contextData.indexDatas.rarityIndex) and IndexConst.filterEquipByExtra(iter_66_1, arg_66_0.contextData.indexDatas.extraIndex) then
			table.insert(arg_66_0.loadEquipmentVOs, iter_66_1)
		end
	end

	if arg_66_0.contextData.sortData then
		table.sort(arg_66_0.loadEquipmentVOs, CompareFuncs(var_0_1.sortFunc(arg_66_0.contextData.sortData, arg_66_0.contextData.asc)))
	end

	arg_66_0:updateEquipmentCount()
	setImageSprite(arg_66_0.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", arg_66_0.contextData.sortData.spr), true)
	setActive(arg_66_0.downOrderTF, not arg_66_0.contextData.asc)
	setActive(arg_66_0.upOrderTF, arg_66_0.contextData.asc)

	return
end

function var_0_0.updateEquipmentCount(arg_67_0, arg_67_1)
	arg_67_0.equipmentRect:SetTotalCount(arg_67_1 or #arg_67_0.loadEquipmentVOs, -1)
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.Scroll2Equip(arg_68_0, arg_68_1)
	if arg_68_0.contextData.pageNum ~= var_0_0.PAGE.Equipment then
		return
	end

	for iter_68_0, iter_68_1 in ipairs(arg_68_0.loadEquipmentVOs) do
		if EquipmentProxy.SameEquip(iter_68_1, arg_68_1) then
			local var_68_0 = arg_68_0.equipmentView:Find("Viewport/moudle_grid"):GetComponent(typeof(GridLayoutGroup))

			arg_68_0:ScrollEquipPos((var_68_0.cellSize.y + var_68_0.spacing.y) * math.floor((iter_68_0 - 1) / var_68_0.constraintCount) + arg_68_0.equipmentRect.paddingFront + arg_68_0.equipmentView.rect.height * 0.5 - arg_68_0.equipmentRect.paddingFront)

			break
		end
	end

	return
end

function var_0_0.ScrollEquipPos(arg_69_0, arg_69_1)
	local var_69_9000
	local var_69_0 = arg_69_0.equipmentView:Find("Viewport/moudle_grid")
	local var_69_1 = var_69_0.GetComponent(var_69_9000, typeof(GridLayoutGroup))
	local var_69_2 = var_69_0 - arg_69_0.equipmentView.rect.height

	if var_69_0 - arg_69_0.equipmentView.rect.height <= 0 or not var_69_2 then
		var_69_2 = (var_69_1.cellSize.y + var_69_1.spacing.y) * math.ceil(#arg_69_0.loadEquipmentVOs / var_69_1.constraintCount) - var_69_1.spacing.y + arg_69_0.equipmentRect.paddingFront + arg_69_0.equipmentRect.paddingEnd
	end

	arg_69_0.equipmentRect:ScrollTo((arg_69_1 - arg_69_0.equipmentView.rect.height * 0.5) / var_69_2)

	return
end

function var_0_0.SetMaterials(arg_70_0, arg_70_1)
	arg_70_0.materials = arg_70_1

	if arg_70_0.isInitMaterials and arg_70_0.contextData.pageNum == var_0_0.PAGE.Material then
		arg_70_0:SortMaterials()
	end

	return
end

function var_0_0.InitMaterials(arg_71_0)
	arg_71_0.isInitMaterials = true
	arg_71_0.materialRect = arg_71_0.materialtView:GetComponent("LScrollRect")

	function arg_71_0.materialRect.onInitItem(arg_72_0)
		arg_71_0:InitMaterial(arg_72_0)

		return
	end

	function arg_71_0.materialRect.onUpdateItem(arg_73_0, arg_73_1)
		arg_71_0:UpdateMaterial(arg_73_0, arg_73_1)

		return
	end

	function arg_71_0.materialRect.onReturnItem(arg_74_0, arg_74_1)
		arg_71_0:ReturnMaterial(arg_74_0, arg_74_1)

		return
	end

	arg_71_0.materialRect.decelerationRate = 0.07

	return
end

function var_0_0.SortMaterials(arg_75_0)
	table.sort(arg_75_0.materials, CompareFuncs({
		function(arg_76_0)
			return -arg_76_0:getConfig("rarity")
		end,
		function(arg_77_0)
			return arg_77_0.id
		end
	}))
	arg_75_0.materialRect:SetTotalCount(#arg_75_0.materials, -1)
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.InitMaterial(arg_78_0, arg_78_1)
	local var_78_0 = ItemCard.New(arg_78_1)

	onButton(arg_78_0, var_78_0.go, function()
		if var_78_0.itemVO == nil then
			return
		end

		if var_78_0.itemVO:getConfig("type") == Item.INVITATION_TYPE then
			arg_78_0:emit(EquipmentMediator.ITEM_GO_SCENE, SCENE.INVITATION, {
				itemVO = var_78_0.itemVO
			})
		else
			arg_78_0:emit(var_0_0.ON_ITEM, var_78_0.itemVO.id)
		end

		return
	end, SFX_PANEL)

	arg_78_0.materialCards[arg_78_1] = var_78_0

	return
end

function var_0_0.UpdateMaterial(arg_80_0, arg_80_1, arg_80_2)
	if not arg_80_0.materialCards[arg_80_2] then
		arg_80_0:initItem(arg_80_2)
	end

	arg_80_0.materialCards[arg_80_2]:update(arg_80_0.materials[arg_80_1 + 1])

	return
end

function var_0_0.ReturnMaterial(arg_81_0, arg_81_1, arg_81_2)
	if arg_81_0.exited then
		return
	end

	if arg_81_0.materialCards[arg_81_2] then
		var_81_0:clear()
	end

	return
end

return var_0_0
