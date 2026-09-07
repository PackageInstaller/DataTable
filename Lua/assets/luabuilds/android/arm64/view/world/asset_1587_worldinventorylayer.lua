local WorldInventoryLayer = class("WorldInventoryLayer", import("..base.BaseUI"))
local EquipmentSortCfg = require("view.equipment.EquipmentSortCfg")

WorldInventoryLayer.PAGE = {
	Equipment = 2,
	Property = 1,
	Material = 3
}

function WorldInventoryLayer:getUIName()
	return "WorldInventoryUI"
end

function WorldInventoryLayer:init()
	function self.itemUpdateListenerFunc(...)
		self:setItemList(self.inventoryProxy:GetItemList())

		return
	end

	self.blurPanel = self._tf:Find("adapt/blur_panel")
	self.backBtn = self.blurPanel:Find("adapt/top/back_btn")
	self.topItems = self._tf:Find("adapt/topItems")
	self.itemView = self._tf:Find("adapt/item_scrollview")
	self.equipmentView = self._tf:Find("adapt/equipment_scrollview")
	self.materialtView = self._tf:Find("adapt/material_scrollview")

	local var_2_0 = (NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and self.itemView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2

	self.itemView:Find("Viewport/item_grid"):GetComponent(typeof(GridLayoutGroup)).constraintCount = var_2_0 and 8 or 7
	self.equipmentView:Find("Viewport/moudle_grid"):GetComponent(typeof(GridLayoutGroup)).constraintCount = var_2_0 and 8 or 7
	self.materialtView:Find("Viewport/item_grid"):GetComponent(typeof(GridLayoutGroup)).constraintCount = var_2_0 and 8 or 7
	self.itemUsagePanel = ItemUsagePanel.New(self._tf:Find("adapt/item_usage_panel"), self._tf:Find("adapt"))
	self.itemResetPanel = ItemResetPanel.New(self._tf:Find("adapt/reset_info_panel"), self._tf:Find("adapt"))
	self.assignedItemView = WorldAssignedItemView.New(self._tf:Find("adapt"), self.event)
	self.itemCards = {}
	self.equipmetItems = {}
	self.materialCards = {}
	self._itemToggle = self.topItems:Find("bottom_back/types/properties")
	self._weaponToggle = self.topItems:Find("bottom_back/types/siren_weapon")
	self._materialToggle = self.topItems:Find("bottom_back/types/material")
	self.exchangeTips = self.topItems:Find("bottom_back/reset_exchange")

	setText(self.topItems:Find("bottom_back/reset_exchange/Text"), i18n("world_inventory_tip"))

	self.filterBusyToggle = self.blurPanel:Find("adapt/left_length/frame/toggle_equip")
	self.sortBtn = self.blurPanel:Find("adapt/top/buttons/sort_button")
	self.indexBtn = self.blurPanel:Find("adapt/top/buttons/index_button")
	self.decBtn = self.blurPanel:Find("adapt/top/buttons/dec_btn")
	self.upOrderTF = self.decBtn:Find("asc")
	self.downOrderTF = self.decBtn:Find("desc")
	self.sortPanel = self.topItems:Find("sort")
	self.sortContain = self.sortPanel:Find("adapt/mask/panel")
	self.sortTpl = self.sortContain:Find("tpl")

	setActive(self.sortTpl, false)
	self:initData()
	self:addListener()
	print(self._tf:Find("bg").rect.width)

	return
end

function WorldInventoryLayer:didEnter()
	self:initItems()
	self:initEquipments()
	self:InitMaterials()
	setActive(self._weaponToggle, true)
	setActive(self._itemToggle, true)

	self.contextData.pageNum = nil

	if self.contextData.pageNum == WorldInventoryLayer.PAGE.Property then
		triggerToggle(self._itemToggle, true)
	elseif self.contextData.pageNum == WorldInventoryLayer.PAGE.Equipment then
		triggerToggle(self._weaponToggle, true)
	elseif self.contextData.pageNum == WorldInventoryLayer.PAGE.Material then
		triggerToggle(self._materialToggle, true)
	end

	if self.contextData.equipScrollPos then
		self:ScrollEquipPos(self.contextData.equipScrollPos.y)
	end

	onButton(self, self.exchangeTips:Find("capcity"), function()
		self:emit(WorldInventoryLayer.ON_DROP, {
			type = DROP_TYPE_RESOURCE,
			id = WorldConst.ResourceID
		})

		return
	end, SFX_PANEL)
	self:OverlayPanel(self._tf)

	return
end

function WorldInventoryLayer:onBackPressed()
	print(self._tf:Find("bg").rect.width)

	if isActive(self.itemResetPanel._go) then
		self.itemResetPanel:Close()
	elseif isActive(self.itemUsagePanel._go) then
		self.itemUsagePanel:Close()
	elseif self.assignedItemView:isShowing() then
		self.assignedItemView:Hide()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(self.backBtn)
	end

	return
end

function WorldInventoryLayer:willExit()
	self.assignedItemView:Destroy()
	self.inventoryProxy:RemoveListener(WorldInventoryProxy.EventUpdateItem, self.itemUpdateListenerFunc)
	self:UnOverlayPanel(self._tf)

	return
end

function WorldInventoryLayer:initData()
	self.contextData.pageNum = self.contextData.pageNum or WorldInventoryLayer.PAGE.Property
	self.contextData.asc = self.contextData.asc or false
	self.contextData.sortData = self.contextData.sortData or EquipmentSortCfg.sort[1]
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.isEquipingOn = false

	return
end

function WorldInventoryLayer:GetShowBusyFlag()
	return self.isEquipingOn
end

function WorldInventoryLayer:SetShowBusyFlag(arg_10_1)
	self.isEquipingOn = arg_10_1

	return
end

function WorldInventoryLayer:addListener()
	onButton(self, self.backBtn, function()
		print(self._tf:Find("bg").rect.width)
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.decBtn, function()
		self.contextData.asc = not self.contextData.asc

		if self.contextData.pageNum == WorldInventoryLayer.PAGE.Equipment then
			self:filterEquipment()
		end

		return
	end, SFX_PANEL)

	self.sortButtons = {}

	eachChild(self.sortContain, function(arg_14_0)
		setActive(arg_14_0, false)

		return
	end)

	for iter_11_0, iter_11_1 in ipairs(EquipmentSortCfg.sort) do
		local var_11_0 = iter_11_0 <= self.sortContain.childCount and self.sortContain:GetChild(iter_11_0 - 1) or cloneTplTo(self.sortTpl, self.sortContain)

		setActive(var_11_0, true)
		setImageSprite(findTF(var_11_0, "Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", iter_11_1.spr), true)
		onToggle(self, var_11_0, function(arg_15_0)
			if arg_15_0 then
				self.contextData.sortData = iter_11_1

				self:filterEquipment()
				triggerToggle(self.sortBtn, false)
			end

			return
		end, SFX_PANEL)

		self.sortButtons[iter_11_0] = var_11_0
	end

	onToggle(self, self.sortBtn, function(arg_16_0)
		if arg_16_0 then
			self:OverlayPanel(self.sortPanel)
			setActive(self.sortPanel, true)
		else
			self:UnOverlayPanel(self.sortPanel, self.topItems)
			setActive(self.sortPanel, false)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.sortPanel, function()
		triggerToggle(self.sortBtn, false)

		return
	end, SFX_PANEL)
	onToggle(self, self.filterBusyToggle, function(arg_18_0)
		self:SetShowBusyFlag(arg_18_0)

		if self.contextData.pageNum == WorldInventoryLayer.PAGE.Equipment then
			self:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		self:emit(WorldInventoryMediator.OPEN_EQUIPMENT_INDEX, {
			indexDatas = Clone(self.contextData.indexDatas),
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
			callback = function(self)
				self.contextData.indexDatas.typeIndex = self.typeIndex
				self.contextData.indexDatas.equipPropertyIndex = self.equipPropertyIndex
				self.contextData.indexDatas.equipPropertyIndex2 = self.equipPropertyIndex2
				self.contextData.indexDatas.equipAmmoIndex1 = self.equipAmmoIndex1
				self.contextData.indexDatas.equipAmmoIndex2 = self.equipAmmoIndex2
				self.contextData.indexDatas.equipCampIndex = self.equipCampIndex
				self.contextData.indexDatas.rarityIndex = self.rarityIndex
				self.contextData.indexDatas.extraIndex = self.extraIndex

				if self.filterBusyToggle:GetComponent(typeof(Toggle)) then
					if bit.band(self.extraIndex, IndexConst.EquipmentExtraEquiping) > 0 then
						self:SetShowBusyFlag(true)
					end

					triggerToggle(self.filterBusyToggle, self:GetShowBusyFlag())
				else
					self:filterEquipment()
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onToggle(self, self._itemToggle, function(arg_21_0)
		if arg_21_0 and self.contextData.pageNum ~= WorldInventoryLayer.PAGE.Property then
			self.contextData.pageNum = WorldInventoryLayer.PAGE.Property

			self:activeResetExchange(self.contextData.pageNum == WorldInventoryLayer.PAGE.Property)
			self:sortItems()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self._weaponToggle, function(arg_22_0)
		if arg_22_0 and self.contextData.pageNum ~= WorldInventoryLayer.PAGE.Equipment then
			self.contextData.pageNum = WorldInventoryLayer.PAGE.Equipment

			self:activeResetExchange(self.contextData.pageNum == WorldInventoryLayer.PAGE.Property)
			self:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self._materialToggle, function(arg_23_0)
		if arg_23_0 and self.contextData.pageNum ~= WorldInventoryLayer.PAGE.Material then
			self.contextData.pageNum = WorldInventoryLayer.PAGE.Material

			self:activeResetExchange(self.contextData.pageNum == WorldInventoryLayer.PAGE.Property)
			self:SortMaterials()
		end

		return
	end, SFX_PANEL)

	return
end

function WorldInventoryLayer:setWorldFleet(arg_24_1)
	self.worldFleetList = arg_24_1

	return
end

function WorldInventoryLayer:setInventoryProxy(arg_25_1)
	self.inventoryProxy = arg_25_1

	self.inventoryProxy:AddListener(WorldInventoryProxy.EventUpdateItem, self.itemUpdateListenerFunc)
	self:setItemList(self.inventoryProxy:GetItemList())

	return
end

function WorldInventoryLayer:setItemList(arg_26_1)
	self.itemList = arg_26_1

	if self.isInitItems then
		self:sortItems()
	end

	return
end

function WorldInventoryLayer:initItems()
	self.isInitItems = true
	self.itemRect = self.itemView:GetComponent("LScrollRect")

	function self.itemRect.onInitItem(arg_28_0)
		self:initItem(arg_28_0)

		return
	end

	function self.itemRect.onUpdateItem(arg_29_0, arg_29_1)
		self:updateItem(arg_29_0, arg_29_1)

		return
	end

	function self.itemRect.onReturnItem(arg_30_0, arg_30_1)
		self:returnItem(arg_30_0, arg_30_1)

		return
	end

	return
end

function WorldInventoryLayer:initItem(arg_31_1)
	local var_31_0 = WSInventoryItem.New(arg_31_1)

	onButton(self, var_31_0.go, function()
		local var_32_0 = var_31_0.itemVO:getWorldItemType()

		if var_32_0 == WorldItem.UsageBuff or var_32_0 == WorldItem.UsageHPRegenerate or var_32_0 == WorldItem.UsageHPRegenerateValue then
			self:emit(WorldInventoryMediator.OnOpenAllocateLayer, {
				itemVO = var_31_0.itemVO,
				fleetList = self.worldFleetList,
				fleetIndex = self.contextData.currentFleetIndex,
				confirmCallback = function(arg_33_0, arg_33_1)
					self:emit(WorldInventoryMediator.OnUseItem, arg_33_0, 1, arg_33_1)

					return
				end,
				onResetInfo = function(arg_34_0)
					self.itemResetPanel:Open(arg_34_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageWorldMap then
			self.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				mode = ItemUsagePanel.SEE,
				onUse = function()
					self:PlayOpenBox(var_31_0.itemVO:getWorldItemOpenDisplay(), function()
						self:emit(WorldInventoryMediator.OnMap, var_31_0.itemVO.id)
						self:closeView()

						return
					end)

					return
				end,
				onResetInfo = function(arg_37_0)
					self.itemResetPanel:Open(arg_37_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageDrop or var_32_0 == WorldItem.UsageRecoverAp or var_32_0 == WorldItem.UsageWorldItem or var_32_0 == WorldItem.UsageWorldBuff then
			self.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				mode = ItemUsagePanel.BATCH,
				onUseBatch = function(arg_38_0)
					self:emit(WorldInventoryMediator.OnUseItem, var_31_0.itemVO.id, arg_38_0, {})

					return
				end,
				onUseOne = function()
					self:emit(WorldInventoryMediator.OnUseItem, var_31_0.itemVO.id, 1, {})

					return
				end,
				onResetInfo = function(arg_40_0)
					self.itemResetPanel:Open(arg_40_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageLoot then
			self.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				mode = ItemUsagePanel.INFO,
				onResetInfo = function(arg_41_0)
					self.itemResetPanel:Open(arg_41_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageWorldClean or var_32_0 == WorldItem.UsageWorldFlag then
			self.itemUsagePanel:Open({
				item = var_31_0.itemVO,
				onUse = function()
					self:emit(WorldInventoryMediator.OnUseItem, var_31_0.itemVO.id, 1, {})

					return
				end,
				onResetInfo = function(arg_43_0)
					self.itemResetPanel:Open(arg_43_0)

					return
				end
			})
		elseif var_32_0 == WorldItem.UsageDropAppointed then
			self.assignedItemView:Load()
			self.assignedItemView:ActionInvoke("update", var_31_0.itemVO)
			self.assignedItemView:ActionInvoke("Show")
		end

		return
	end, SFX_PANEL)

	self.itemCards[arg_31_1] = var_31_0

	return
end

function WorldInventoryLayer:updateItem(arg_44_1, arg_44_2)
	if not self.itemCards[arg_44_2] then
		self:initItem(arg_44_2)
	end

	self.itemCards[arg_44_2]:update(self.itemList[arg_44_1 + 1])

	return
end

function WorldInventoryLayer:returnItem(arg_45_1, arg_45_2)
	if self.exited then
		return
	end

	if self.itemCards[arg_45_2] then
		self.itemCards[arg_45_2]:clear()
	end

	return
end

function WorldInventoryLayer:sortItems()
	table.sort(self.itemList, CompareFuncs({
		function(arg_47_0)
			return -arg_47_0:getConfig("sort_priority")
		end,
		function(arg_48_0)
			return arg_48_0:getConfig("id")
		end
	}))
	self.itemRect:SetTotalCount(#self.itemList, -1)
	self:updateResetExchange()

	return
end

function WorldInventoryLayer:updateResetExchange()
	setText(self.exchangeTips:Find("capcity/Text"), defaultValue(checkExist(self.inventoryProxy:CalcResetExchangeResource(), {
		DROP_TYPE_RESOURCE
	}, {
		WorldConst.ResourceID
	}), 0))

	return
end

function WorldInventoryLayer:activeResetExchange(arg_50_1)
	setActive(self.exchangeTips, nowWorld():IsSystemOpen(WorldConst.SystemResetExchange) and arg_50_1)

	return
end

function WorldInventoryLayer:PlayOpenBox(arg_51_1, arg_51_2)
	if not arg_51_1 or arg_51_1 == "" then
		arg_51_2()

		return
	end

	local function var_51_0()
		if self.playing or not self[arg_51_1] then
			return
		end

		self.playing = true

		self[arg_51_1]:SetActive(true)

		local var_52_0 = tf(self[arg_51_1])

		var_52_0:SetParent(self._tf:Find("adapt"), false)
		var_52_0:SetAsLastSibling()

		local var_52_1 = var_52_0:GetComponent("DftAniEvent")

		var_52_1:SetTriggerEvent(function(arg_53_0)
			arg_51_2()

			return
		end)
		var_52_1:SetEndEvent(function(arg_54_0)
			if self[arg_51_1] then
				SetActive(self[arg_51_1], false)

				self.playing = false
			end

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_EQUIPMENT_OPEN)

		return
	end

	local var_51_1 = self._tf:Find(arg_51_1 .. "(Clone)")

	if var_51_1 then
		self[arg_51_1] = go(var_51_1)
	end

	if not self[arg_51_1] then
		PoolMgr.GetInstance():GetPrefab("ui/" .. string.lower(arg_51_1), "", true, function(arg_55_0)
			arg_55_0:SetActive(true)

			self[arg_51_1] = arg_55_0

			var_51_0()

			return
		end)
	else
		var_51_0()
	end

	return
end

function WorldInventoryLayer:setEquipments(arg_56_1)
	self.equipmentVOs = arg_56_1

	return
end

function WorldInventoryLayer:setEquipment(arg_57_1)
	local var_57_0 = #self.equipmentVOs + 1

	for iter_57_0, iter_57_1 in ipairs(self.equipmentVOs) do
		if not iter_57_1.shipId and iter_57_1.id == arg_57_1.id then
			var_57_0 = iter_57_0

			break
		end
	end

	if arg_57_1.count > 0 then
		self.equipmentVOs[var_57_0] = arg_57_1
	else
		table.remove(self.equipmentVOs, var_57_0)
	end

	if self.contextData.pageNum == WorldInventoryLayer.PAGE.Equipment then
		self:filterEquipment()
	end

	return
end

function WorldInventoryLayer:initEquipments()
	self.isInitWeapons = true
	self.equipmentRect = self.equipmentView:GetComponent("LScrollRect")

	function self.equipmentRect.onInitItem(arg_59_0)
		self:initEquipment(arg_59_0)

		return
	end

	function self.equipmentRect.onUpdateItem(arg_60_0, arg_60_1)
		self:updateEquipment(arg_60_0, arg_60_1)

		return
	end

	function self.equipmentRect.onReturnItem(arg_61_0, arg_61_1)
		self:returnEquipment(arg_61_0, arg_61_1)

		return
	end

	self.equipmentRect.decelerationRate = 0.07

	return
end

function WorldInventoryLayer:initEquipment(arg_62_1)
	local var_62_0 = EquipmentItem.New(arg_62_1)

	onButton(self, var_62_0.go, function()
		if self.equipmentRect.GetContentAnchoredPositionOriginal then
			self.contextData.equipScrollPos = self.equipmentRect:GetContentAnchoredPositionOriginal()
		end

		if var_62_0.equipmentVO == nil or var_62_0.equipmentVO.mask then
			return
		end

		self:emit(WorldInventoryLayer.ON_EQUIPMENT, self.shipVO and {
			type = EquipmentInfoMediator.TYPE_REPLACE,
			equipmentId = var_62_0.equipmentVO.id,
			shipId = self.contextData.shipId,
			pos = self.contextData.pos,
			oldShipId = var_62_0.equipmentVO.shipId,
			oldPos = var_62_0.equipmentVO.shipPos
		} or var_62_0.equipmentVO.shipId and {
			type = EquipmentInfoMediator.TYPE_DISPLAY,
			equipmentId = var_62_0.equipmentVO.id,
			shipId = var_62_0.equipmentVO.shipId,
			pos = var_62_0.equipmentVO.shipPos
		} or {
			destroy = true,
			type = EquipmentInfoMediator.TYPE_DEFAULT,
			equipmentId = var_62_0.equipmentVO.id
		})

		return
	end, SFX_PANEL)

	self.equipmetItems[arg_62_1] = var_62_0

	return
end

function WorldInventoryLayer:updateEquipment(arg_64_1, arg_64_2)
	if not self.equipmetItems[arg_64_2] then
		self:initEquipment(arg_64_2)
	end

	self.equipmetItems[arg_64_2]:update(self.loadEquipmentVOs[arg_64_1 + 1])

	return
end

function WorldInventoryLayer:returnEquipment(arg_65_1, arg_65_2)
	if self.exited then
		return
	end

	if self.equipmetItems[arg_65_2] then
		self.equipmetItems[arg_65_2]:clear()
	end

	return
end

function WorldInventoryLayer:filterEquipment()
	self.loadEquipmentVOs = self.loadEquipmentVOs or {}

	table.clean(self.loadEquipmentVOs)

	local var_66_0 = {
		self.contextData.indexDatas.equipPropertyIndex,
		self.contextData.indexDatas.equipPropertyIndex2
	}

	for iter_66_0, iter_66_1 in pairs(self.equipmentVOs) do
		if (not iter_66_1.shipId or self:GetShowBusyFlag()) and not iter_66_1.isSkin and IndexConst.filterEquipByType(iter_66_1, self.contextData.indexDatas.typeIndex) and IndexConst.filterEquipByProperty(iter_66_1, var_66_0) and IndexConst.filterEquipAmmo1(iter_66_1, self.contextData.indexDatas.equipAmmoIndex1) and IndexConst.filterEquipAmmo2(iter_66_1, self.contextData.indexDatas.equipAmmoIndex2) and IndexConst.filterEquipByCamp(iter_66_1, self.contextData.indexDatas.equipCampIndex) and IndexConst.filterEquipByRarity(iter_66_1, self.contextData.indexDatas.rarityIndex) and IndexConst.filterEquipByExtra(iter_66_1, self.contextData.indexDatas.extraIndex) then
			table.insert(self.loadEquipmentVOs, iter_66_1)
		end
	end

	if self.contextData.sortData then
		table.sort(self.loadEquipmentVOs, CompareFuncs(EquipmentSortCfg.sortFunc(self.contextData.sortData, self.contextData.asc)))
	end

	self:updateEquipmentCount()
	setImageSprite(self.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", self.contextData.sortData.spr), true)
	setActive(self.downOrderTF, not self.contextData.asc)
	setActive(self.upOrderTF, self.contextData.asc)

	return
end

function WorldInventoryLayer:updateEquipmentCount(arg_67_1)
	self.equipmentRect:SetTotalCount(arg_67_1 or #self.loadEquipmentVOs, -1)
	Canvas.ForceUpdateCanvases()

	return
end

function WorldInventoryLayer:Scroll2Equip(arg_68_1)
	if self.contextData.pageNum ~= WorldInventoryLayer.PAGE.Equipment then
		return
	end

	for iter_68_0, iter_68_1 in ipairs(self.loadEquipmentVOs) do
		if EquipmentProxy.SameEquip(iter_68_1, arg_68_1) then
			local var_68_0 = self.equipmentView:Find("Viewport/moudle_grid"):GetComponent(typeof(GridLayoutGroup))

			self:ScrollEquipPos((var_68_0.cellSize.y + var_68_0.spacing.y) * math.floor((iter_68_0 - 1) / var_68_0.constraintCount) + self.equipmentRect.paddingFront + self.equipmentView.rect.height * 0.5 - self.equipmentRect.paddingFront)

			break
		end
	end

	return
end

function WorldInventoryLayer:ScrollEquipPos(arg_69_1)
	local var_69_0 = self.equipmentView:Find("Viewport/moudle_grid")
	local var_69_1 = var_69_0:GetComponent(typeof(GridLayoutGroup))
	local var_69_2 = var_69_0 - self.equipmentView.rect.height

	var_69_2 = var_69_0 - self.equipmentView.rect.height > 0 and var_69_2 or (var_69_1.cellSize.y + var_69_1.spacing.y) * math.ceil(#self.loadEquipmentVOs / var_69_1.constraintCount) - var_69_1.spacing.y + self.equipmentRect.paddingFront + self.equipmentRect.paddingEnd

	self.equipmentRect:ScrollTo((arg_69_1 - self.equipmentView.rect.height * 0.5) / var_69_2)

	return
end

function WorldInventoryLayer:SetMaterials(arg_70_1)
	self.materials = arg_70_1

	if self.isInitMaterials and self.contextData.pageNum == WorldInventoryLayer.PAGE.Material then
		self:SortMaterials()
	end

	return
end

function WorldInventoryLayer:InitMaterials()
	self.isInitMaterials = true
	self.materialRect = self.materialtView:GetComponent("LScrollRect")

	function self.materialRect.onInitItem(arg_72_0)
		self:InitMaterial(arg_72_0)

		return
	end

	function self.materialRect.onUpdateItem(arg_73_0, arg_73_1)
		self:UpdateMaterial(arg_73_0, arg_73_1)

		return
	end

	function self.materialRect.onReturnItem(arg_74_0, arg_74_1)
		self:ReturnMaterial(arg_74_0, arg_74_1)

		return
	end

	self.materialRect.decelerationRate = 0.07

	return
end

function WorldInventoryLayer:SortMaterials()
	table.sort(self.materials, CompareFuncs({
		function(arg_76_0)
			return -arg_76_0:getConfig("rarity")
		end,
		function(arg_77_0)
			return arg_77_0.id
		end
	}))
	self.materialRect:SetTotalCount(#self.materials, -1)
	Canvas.ForceUpdateCanvases()

	return
end

function WorldInventoryLayer:InitMaterial(arg_78_1)
	local var_78_0 = ItemCard.New(arg_78_1)

	onButton(self, var_78_0.go, function()
		if var_78_0.itemVO == nil then
			return
		end

		if var_78_0.itemVO:getConfig("type") == Item.INVITATION_TYPE then
			self:emit(EquipmentMediator.ITEM_GO_SCENE, SCENE.INVITATION, {
				itemVO = var_78_0.itemVO
			})
		else
			self:emit(WorldInventoryLayer.ON_ITEM, var_78_0.itemVO.id)
		end

		return
	end, SFX_PANEL)

	self.materialCards[arg_78_1] = var_78_0

	return
end

function WorldInventoryLayer:UpdateMaterial(arg_80_1, arg_80_2)
	if not self.materialCards[arg_80_2] then
		self:initItem(arg_80_2)
	end

	self.materialCards[arg_80_2]:update(self.materials[arg_80_1 + 1])

	return
end

function WorldInventoryLayer:ReturnMaterial(arg_81_1, arg_81_2)
	if self.exited then
		return
	end

	if self.materialCards[arg_81_2] then
		self.materialCards[arg_81_2]:clear()
	end

	return
end

return WorldInventoryLayer
