local StoreHouseScene = class("StoreHouseScene", import("view.base.BaseUI"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3

function StoreHouseScene:getUIName()
	return "StoreHouseUI"
end

function StoreHouseScene:setEquipments(arg_2_1)
	self.equipmentVOs = arg_2_1

	self:setEquipmentByIds(arg_2_1)

	return
end

function StoreHouseScene:setEquipmentByIds(arg_3_1)
	self.equipmentVOByIds = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if not iter_3_1.isSkin then
			self.equipmentVOByIds[iter_3_1.id] = iter_3_1
		end
	end

	return
end

local EquipmentSortCfg = require("view.equipment.EquipmentSortCfg")
local SpWeaponSortCfg = require("view.equipment.SpWeaponSortCfg")

function StoreHouseScene:init()
	self.filterEquipWaitting = 0

	local var_4_0 = self.contextData

	self.topItems = self._tf:Find("topItems")
	self.equipmentView = self._tf:Find("adapt/equipment_scrollview")
	self.blurPanel = self._tf:Find("blur_panel")
	self.topPanel = self.blurPanel:Find("adapt/top")
	self.indexBtn = self.topPanel:Find("buttons/index_button")
	self.sortBtn = self.topPanel:Find("buttons/sort_button")
	self.sortPanel = self.topItems:Find("sort")
	self.sortPanelTG = self.sortPanel:GetComponent("ToggleGroup")
	self.sortPanelTG.allowSwitchOff = true
	self.sortContain = self.sortPanel:Find("adapt/mask/panel")
	self.sortTpl = self.sortContain:Find("tpl")

	setActive(self.sortTpl, false)

	self.equipSkinFilteBtn = self.topPanel:Find("buttons/EquipSkinFilteBtn")
	self.searchBar = RecordableSearchBar.New(RecordableSearchBar.CreateData({
		enabledFlag = false,
		holder = i18n("search_equipment"),
		onInputChanged = function()
			self:filterEquipment()

			return
		end,
		key = self.__cname,
		parent = self.topPanel:Find("buttons"),
		expand_parent = self.blurPanel:Find("adapt"),
		anchoredPosition = Vector3(-1305, self.topPanel.sizeDelta.y * -0.5, 0)
	}))
	self.itemView = self._tf:Find("adapt/item_scrollview")

	local var_4_1 = (NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and self.itemView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2

	self.equipmentView:Find("equipment_grid"):GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_1 and 8 or 7
	self.itemView:Find("item_grid"):GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_1 and 8 or 7
	self.decBtn = findTF(self.topPanel, "buttons/dec_btn")
	self.sortImgAsc = findTF(self.decBtn, "asc")
	self.sortImgDec = findTF(self.decBtn, "desc")
	self.equipmentToggle = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_root")

	setActive(self.equipmentToggle, false)

	self.filterBusyToggle = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_equip")

	setActive(self.filterBusyToggle, false)

	self.designTabRoot = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_design")

	setActive(self.designTabRoot, false)

	self.designTabs = CustomIndexLayer.Clone2Full(self.designTabRoot, 3)
	self.bottomBack = self.topItems:Find("adapt/bottom_back")
	self.bottomPanel = self.bottomBack:Find("types")
	self.materialToggle = self.bottomPanel:Find("material")
	self.weaponToggle = self.bottomPanel:Find("weapon")
	self.designToggle = self.bottomPanel:Find("design")
	self.capacityTF = self.bottomBack:Find("bottom_left/tip/capcity/Text")
	self.tipTF = self.bottomBack:Find("bottom_left/tip")
	self.tip = self.tipTF:Find("label")
	self.helpBtn = self.topItems:Find("adapt/help_btn")

	setActive(self.helpBtn, true)

	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.selectedMin = defaultValue(var_4_0.selectedMin, 1)
	self.selectedMax = defaultValue(var_4_0.selectedMax, pg.gameset.equip_select_limit.key_value or 0)
	self.selectedIds = Clone(var_4_0.selectedIds or {})
	self.checkEquipment = var_4_0.onEquipment or function(arg_6_0, arg_6_1, arg_6_2)
		return true
	end
	self.onSelected = var_4_0.onSelected or function()
		warning("not implemented.")

		return
	end
	self.BatchDisposeBtn = self.bottomPanel:Find("dispos") or self.bottomBack:Find("dispos")
	self.selectPanel = self.topItems:Find("adapt/select_panel")

	setActive(self.selectPanel, true)
	setAnchoredPosition(self.selectPanel, {
		y = -124
	})

	self.selectTransformPanel = self.topItems:Find("adapt/select_transform_panel")

	setActive(self.selectTransformPanel, false)

	self.listEmptyTF = self._tf:Find("adapt/empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")
	self.destroyConfirmView = DestroyConfirmView.New(self.topItems, self.event)
	self.assignedItemView = AssignedItemView.New(self.topItems, self.event)
	self.blueprintAssignedItemView = BlueprintAssignedItemView.New(self.topItems, self.event)
	self.equipDestroyConfirmWindow = EquipDestoryConfirmWindow.New(self.topItems, self.event)
	self.isEquipingOn = false
	self.msgBox = SelectSkinMsgbox.New(self._tf, self.event)

	return
end

function StoreHouseScene:setEquipment(arg_8_1)
	local var_8_0 = #self.equipmentVOs + 1

	for iter_8_0, iter_8_1 in ipairs(self.equipmentVOs) do
		if not iter_8_1.shipId and iter_8_1.id == arg_8_1.id then
			var_8_0 = iter_8_0

			break
		end
	end

	if arg_8_1.count > 0 then
		self.equipmentVOs[var_8_0] = arg_8_1
		self.equipmentVOByIds[arg_8_1.id] = arg_8_1
	else
		table.remove(self.equipmentVOs, var_8_0)

		self.equipmentVOByIds[arg_8_1.id] = nil
	end

	return
end

function StoreHouseScene:setEquipmentUpdate()
	if self.contextData.warp == StoreHouseConst.WARP_TO_WEAPON then
		self:filterEquipment()
		self:updateCapacity()
	end

	return
end

function StoreHouseScene:addShipEquipment(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.equipmentVOs) do
		if EquipmentProxy.SameEquip(iter_10_1, arg_10_1) then
			self.equipmentVOs[iter_10_0] = arg_10_1

			return
		end
	end

	table.insert(self.equipmentVOs, arg_10_1)

	return
end

function StoreHouseScene:removeShipEquipment(arg_11_1)
	for iter_11_0 = #self.equipmentVOs, 1, -1 do
		if EquipmentProxy.SameEquip(self.equipmentVOs[iter_11_0], arg_11_1) then
			table.remove(self.equipmentVOs, iter_11_0)
		end
	end

	return
end

function StoreHouseScene:setEquipmentSkin(arg_12_1)
	local var_12_0 = true

	for iter_12_0, iter_12_1 in pairs(self.equipmentVOs) do
		if iter_12_1.id == arg_12_1.id and iter_12_1.isSkin then
			self.equipmentVOs[iter_12_0] = {
				isSkin = true,
				id = arg_12_1.id,
				count = arg_12_1.count
			}
			var_12_0 = false
		end
	end

	if var_12_0 then
		table.insert(self.equipmentVOs, {
			isSkin = true,
			id = arg_12_1.id,
			count = arg_12_1.count
		})
	end

	return
end

function StoreHouseScene:setEquipmentSkinUpdate()
	if self.contextData.warp == StoreHouseConst.WARP_TO_WEAPON then
		self:filterEquipment()
		self:updateCapacity()
	end

	return
end

function StoreHouseScene:SetSpWeapons(arg_14_1)
	self.spweaponVOs = arg_14_1

	return
end

function StoreHouseScene:SetSpWeaponUpdate()
	if self.contextData.warp == StoreHouseConst.WARP_TO_WEAPON and self.page == var_0_4 then
		self:filterEquipment()
		self:UpdateSpweaponCapacity()
	elseif self.contextData.warp == StoreHouseConst.WARP_TO_DESIGN and self.contextData.designPage == var_0_6 then
		self:UpdateSpweaponCapacity()
	end

	return
end

function StoreHouseScene:didEnter()
	setText(self.selectPanel:Find("tip"), i18n("equipment_select_device_destroy_tip"))
	setActive(self.topItems:Find("adapt/stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())
	onButton(self, self.topItems:Find("adapt/stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(2)

		return
	end, SFX_CONFIRM)
	onButton(self, self.helpBtn, function()
		local var_18_0

		if self.contextData.warp == StoreHouseConst.WARP_TO_WEAPON then
			if self.page == var_0_2 then
				var_18_0 = pg.gametip.help_equipment.tip
			elseif self.page == var_0_3 then
				var_18_0 = pg.gametip.help_equipment_skin.tip
			elseif self.page == var_0_4 then
				var_18_0 = pg.gametip.spweapon_help_storage.tip
			end
		elseif self.contextData.warp == StoreHouseConst.WARP_TO_DESIGN then
			if self.contextData.designPage == var_0_5 then
				var_18_0 = pg.gametip.help_equipment.tip
			elseif self.contextData.designPage == var_0_6 then
				var_18_0 = pg.gametip.spweapon_help_storage.tip
			end
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = var_18_0
		})

		return
	end, SFX_PANEL)
	onToggle(self, self.equipmentToggle:Find("equipment"), function(arg_19_0)
		if arg_19_0 then
			self.page = var_0_2

			self:SwitchEquipmentType(var_0_2)
			self:UpdateWeaponWrapButtons()
			self:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.equipmentToggle:Find("skin"), function(arg_20_0)
		if arg_20_0 then
			self.page = var_0_3

			self:SwitchEquipmentType(var_0_3)
			self:UpdateWeaponWrapButtons()
			self:filterEquipment()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.equipmentToggle:Find("spweapon"), function(arg_21_0)
		if arg_21_0 then
			self.page = var_0_4

			self:SwitchEquipmentType(var_0_4)
			self:UpdateWeaponWrapButtons()
			self:filterEquipment()
		end

		return
	end, SFX_PANEL)
	setActive(self.equipmentToggle:Find("spweapon"), not LOCK_SP_WEAPON)
	onToggle(self, self.designTabs[var_0_5], function(arg_22_0)
		if arg_22_0 then
			self.contextData.designPage = var_0_5

			self:emit(EquipmentMediator.OPEN_DESIGN)
			self:updateCapacity()
			setActive(self.tip, false)
			setActive(self.listEmptyTF, false)
		else
			self:emit(EquipmentMediator.CLOSE_DESIGN_LAYER)
		end

		setActive(self.designTabs[var_0_7], arg_22_0)

		return
	end, SFX_PANEL)
	onToggle(self, self.designTabs[var_0_6], function(arg_23_0)
		if arg_23_0 then
			self.contextData.designPage = var_0_6

			self:emit(EquipmentMediator.OPEN_SPWEAPON_DESIGN)
			self:UpdateSpweaponCapacity()
			setActive(self.tip, false)
			setActive(self.listEmptyTF, false)
		else
			self:emit(EquipmentMediator.CLOSE_SPWEAPON_DESIGN_LAYER)
		end

		return
	end, SFX_PANEL)
	setActive(self.designTabs[var_0_7], self.contextData.designPage == var_0_5)

	self.isShowAllDesign = false

	onToggle(self, self.designTabs[var_0_7], function(arg_24_0)
		self.isShowAllDesign = arg_24_0

		self:emit(EquipmentMediator.DESIGN_FILTER_CHANGED, self.isShowAllDesign)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		if self.mode == StoreHouseConst.DESTROY then
			triggerButton(self.BatchDisposeBtn)

			return
		end

		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:emit(StoreHouseScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onToggle(self, self.sortBtn, function(arg_26_0)
		if arg_26_0 then
			self:OverlayPanel(self.sortPanel)
			setActive(self.sortPanel, true)
			onNextTick(function()
				self.sortPanelTG.allowSwitchOff = false

				return
			end)
		else
			self:UnOverlayPanel(self.sortPanel, self.topItems)
			setActive(self.sortPanel, false)

			self.sortPanelTG.allowSwitchOff = true
		end

		return
	end, SFX_PANEL)
	onButton(self, self.sortPanel, function()
		triggerToggle(self.sortBtn, false)

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		self:emit(EquipmentMediator.OPEN_EQUIPMENT_INDEX, (switch(self.page, {
			[var_0_2] = function()
				return setmetatable({
					indexDatas = Clone(self.contextData.indexDatas),
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
				}, {
					__index = StoreHouseConst.EQUIPMENT_INDEX_COMMON
				})
			end,
			[var_0_4] = function()
				return setmetatable({
					indexDatas = Clone(self.contextData.spweaponIndexDatas),
					callback = function(self)
						self.contextData.spweaponIndexDatas.typeIndex = self.typeIndex
						self.contextData.spweaponIndexDatas.rarityIndex = self.rarityIndex

						self:filterEquipment()

						return
					end
				}, {
					__index = StoreHouseConst.SPWEAPON_INDEX_COMMON
				})
			end
		})))

		return
	end, SFX_PANEL)
	onButton(self, self.equipSkinFilteBtn, function()
		local var_34_0 = {
			display = {
				equipSkinIndex = IndexConst.FlagRange2Bits(IndexConst.EquipSkinIndexAll, IndexConst.EquipSkinIndexAux),
				equipSkinTheme = IndexConst.FlagRange2Str(IndexConst.EquipSkinThemeAll, IndexConst.EquipSkinThemeEnd)
			}
		}

		var_34_0.equipSkinSort = self.equipSkinSort or IndexConst.EquipSkinSortType
		var_34_0.equipSkinIndex = self.equipSkinIndex or IndexConst.Flags2Bits({
			IndexConst.EquipSkinIndexAll
		})
		var_34_0.equipSkinTheme = self.equipSkinTheme or IndexConst.Flags2Str({
			IndexConst.EquipSkinThemeAll
		})

		function var_34_0:callback()
			self.equipSkinSort = self.equipSkinSort
			self.equipSkinIndex = self.equipSkinIndex
			self.equipSkinTheme = self.equipSkinTheme

			self:filterEquipment()

			return
		end

		self:emit(EquipmentMediator.OPEN_EQUIPSKIN_INDEX_LAYER, var_34_0)

		return
	end, SFX_PANEL)

	self.equipmetItems = {}
	self.itemCards = {}

	self:initItems()
	self:initEquipments()

	self.asc = self.contextData.asc or false
	self.contextData.sortData = self.contextData.sortData or EquipmentSortCfg.sort[1]
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.contextData.spweaponIndexDatas = self.contextData.spweaponIndexDatas or {}
	self.contextData.spweaponSortData = self.contextData.spweaponSortData or SpWeaponSortCfg.sort[1]

	self:initSort()
	setActive(self.itemView, false)
	setActive(self.equipmentView, false)
	onToggle(self, self.materialToggle, function(arg_36_0)
		self.inMaterial = arg_36_0

		if arg_36_0 and self.contextData.warp ~= StoreHouseConst.WARP_TO_MATERIAL then
			self.contextData.warp = StoreHouseConst.WARP_TO_MATERIAL

			setText(self.tip, i18n("equipment_select_materials_tip"))
			setActive(self.capacityTF.parent, false)
			setActive(self.tip, true)
			self:sortItems()
		end

		setActive(self.helpBtn, not arg_36_0)

		return
	end, SFX_PANEL)
	onToggle(self, self.weaponToggle, function(arg_37_0)
		if arg_37_0 then
			if self.contextData.warp ~= StoreHouseConst.WARP_TO_WEAPON then
				self.contextData.warp = StoreHouseConst.WARP_TO_WEAPON

				setActive(self.tip, false)
				setActive(self.capacityTF.parent, true)

				if self.page == var_0_3 then
					triggerToggle(self.equipmentToggle:Find("skin"), true)
				elseif self.page == var_0_4 then
					triggerToggle(self.equipmentToggle:Find("spweapon"), true)
				else
					triggerToggle(self.equipmentToggle:Find("equipment"), true)
				end
			end
		else
			setActive(self.BatchDisposeBtn, false)
			setActive(self.filterBusyToggle, false)
			setActive(self.equipmentToggle, false)
		end

		self.searchBar:EnableOrDisable(arg_37_0)

		return
	end, SFX_PANEL)
	onToggle(self, self.designToggle, function(arg_38_0)
		if arg_38_0 then
			self.contextData.warp = StoreHouseConst.WARP_TO_DESIGN

			triggerToggle(self.designTabs[self.contextData.designPage or var_0_5], true)
			setActive(self.capacityTF.parent, true)
		else
			self:emit(EquipmentMediator.CLOSE_DESIGN_LAYER)
			self:emit(EquipmentMediator.CLOSE_SPWEAPON_DESIGN_LAYER)
		end

		setActive(self.designTabRoot, arg_38_0 and not LOCK_SP_WEAPON)

		return
	end, SFX_PANEL)
	onToggle(self, self.filterBusyToggle, function(arg_39_0)
		self:SetShowBusyFlag(arg_39_0)
		self:filterEquipment()

		return
	end, SFX_PANEL)

	self.filterEquipWaitting = self.filterEquipWaitting + 1

	triggerToggle(self.filterBusyToggle, self.shipVO)
	onButton(self, self.BatchDisposeBtn, function()
		if self.mode == StoreHouseConst.DESTROY then
			self.mode = StoreHouseConst.OVERVIEW
			self.asc = self.lastasc
			self.lastasc = nil
			self.filterImportance = nil

			shiftPanel(self.bottomBack, nil, 0, nil, 0, true, true)
			shiftPanel(self.selectPanel, nil, -124, nil, 0, true, true)
			self:filterEquipment()
		else
			self.mode = StoreHouseConst.DESTROY
			self.lastasc = self.asc
			self.filterImportance = true
			self.asc = true

			shiftPanel(self.bottomBack, nil, -124, nil, 0, true, true)
			shiftPanel(self.selectPanel, nil, 0, nil, 0, true, true)

			self.contextData.asc = self.asc
			self.contextData.sortData = EquipmentSortCfg.sort[1]

			self:filterEquipment()
		end

		self:UpdateWeaponWrapButtons()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.selectPanel, "cancel_button"), function()
		self:unselecteAllEquips()
		triggerButton(self.BatchDisposeBtn)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.selectPanel, "confirm_button"), function()
		local var_42_0 = {}

		if underscore.any(self.selectedIds, function(arg_43_0)
			return self.equipmentVOByIds[arg_43_0[1]]:getConfig("rarity") >= 4 or self.equipmentVOByIds[arg_43_0[1]]:getConfig("level") > 1
		end) then
			table.insert(var_42_0, function(arg_44_0)
				self.equipDestroyConfirmWindow:Load()
				self.equipDestroyConfirmWindow:ActionInvoke("Show", underscore.map(self.selectedIds, function(arg_45_0)
					return setmetatable({
						count = arg_45_0[2]
					}, {
						__index = self.equipmentVOByIds[arg_45_0[1]]
					})
				end), arg_44_0)

				return
			end)
		end

		seriesAsync(var_42_0, function()
			self.destroyConfirmView:Load()
			self.destroyConfirmView:ActionInvoke("Show")
			self.destroyConfirmView:ActionInvoke("DisplayDestroyBonus", self.selectedIds)
			self.destroyConfirmView:ActionInvoke("SetConfirmBtnCB", function()
				self:unselecteAllEquips()

				return
			end)

			return
		end)

		return
	end, SFX_CONFIRM)
	self:OverlayPanel(self.blurPanel)
	self:PlayUIAnimation(self.blurPanel, "enter")
	self:OverlayPanel(self.topItems)

	local var_16_0 = self.contextData.warp or StoreHouseConst.WARP_TO_MATERIAL
	local var_16_1 = self.contextData.mode or StoreHouseConst.OVERVIEW

	self.contextData.warp = nil
	self.contextData.mode = nil
	self.mode = self.mode or StoreHouseConst.OVERVIEW

	if var_16_0 == StoreHouseConst.WARP_TO_DESIGN then
		triggerToggle(self.designToggle, true)
	elseif var_16_0 == StoreHouseConst.WARP_TO_MATERIAL then
		triggerToggle(self.materialToggle, true)
	elseif var_16_0 == StoreHouseConst.WARP_TO_WEAPON then
		if var_16_1 == StoreHouseConst.DESTROY then
			self.filterEquipWaitting = self.filterEquipWaitting + 1

			triggerToggle(self.weaponToggle, true)
			triggerButton(self.BatchDisposeBtn)
		else
			self.page = var_16_1 == StoreHouseConst.SKIN and var_0_3 or var_16_1 == StoreHouseConst.SPWEAPON and var_0_4 or var_0_2

			triggerToggle(self.weaponToggle, true)
		end
	end

	self.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(self, self.topItems)

	return
end

function StoreHouseScene:isDefaultStatus()
	return underscore(self.contextData.indexDatas):chain():keys():all(function(arg_49_0)
		return self.contextData.indexDatas[arg_49_0] == StoreHouseConst.EQUIPMENT_INDEX_COMMON.customPanels[arg_49_0].options[1]
	end):value()
end

function StoreHouseScene:isDefaultSpWeaponIndexData()
	return underscore(self.contextData.spweaponIndexDatas):chain():keys():all(function(arg_51_0)
		return self.contextData.spweaponIndexDatas[arg_51_0] == StoreHouseConst.SPWEAPON_INDEX_COMMON.customPanels[arg_51_0].options[1]
	end):value()
end

function StoreHouseScene:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self.sortPanel) then
		triggerButton(self.sortPanel)
	elseif self.destroyConfirmView:isShowing() then
		self.destroyConfirmView:Hide()
	elseif self.assignedItemView:isShowing() then
		self.assignedItemView:Hide()
	elseif self.blueprintAssignedItemView:isShowing() then
		self.blueprintAssignedItemView:Hide()
	elseif self.equipDestroyConfirmWindow:isShowing() then
		self.equipDestroyConfirmWindow:Hide()
	else
		triggerButton(self.backBtn)
	end

	return
end

function StoreHouseScene:updateCapacity()
	if self.contextData.warp == StoreHouseConst.WARP_TO_MATERIAL then
		return
	end

	setText(self.tip, "")
	setText(self.capacityTF, self.capacity .. "/" .. self.player:getMaxEquipmentBag())

	return
end

function StoreHouseScene:setCapacity(arg_54_1)
	self.capacity = arg_54_1

	return
end

function StoreHouseScene:UpdateSpweaponCapacity()
	local var_55_0 = getProxy(EquipmentProxy)

	setText(self.capacityTF, var_55_0:GetSpWeaponCount() .. "/" .. var_55_0:GetSpWeaponCapacity())

	return
end

function StoreHouseScene:setShip(arg_56_1)
	self.shipVO = arg_56_1

	setActive(self.bottomPanel, not tobool(arg_56_1))

	return
end

function StoreHouseScene:setPlayer(arg_57_1)
	self.player = arg_57_1

	if self.contextData.warp == StoreHouseConst.WARP_TO_WEAPON and self.page == var_0_2 then
		self:updateCapacity()
	elseif self.contextData.warp == StoreHouseConst.WARP_TO_DESIGN and self.contextData.designPage == var_0_5 then
		self:updateCapacity()
	end

	return
end

function StoreHouseScene:initSort()
	onButton(self, self.decBtn, function()
		self.asc = not self.asc
		self.contextData.asc = self.asc

		self:filterEquipment()

		return
	end)

	self.sortButtons = {}

	eachChild(self.sortContain, function(arg_60_0)
		setActive(arg_60_0, false)

		return
	end)

	for iter_58_0, iter_58_1 in ipairs(EquipmentSortCfg.sort) do
		local var_58_0 = iter_58_0 <= self.sortContain.childCount and self.sortContain:GetChild(iter_58_0 - 1) or cloneTplTo(self.sortTpl, self.sortContain)

		setActive(var_58_0, true)
		setImageSprite(findTF(var_58_0, "Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", iter_58_1.spr), true)
		onToggle(self, var_58_0, function(arg_61_0)
			if arg_61_0 then
				if self.page == var_0_2 then
					self.contextData.sortData = iter_58_1
				elseif self.page == var_0_4 then
					self.contextData.spweaponSortData = SpWeaponSortCfg.sort[iter_58_0]
				end

				self:filterEquipment()
				triggerToggle(self.sortBtn, false)
			end

			return
		end, SFX_PANEL)

		self.sortButtons[iter_58_0] = var_58_0
	end

	return
end

function StoreHouseScene:UpdateWeaponWrapButtons()
	setActive(self.indexBtn, self.page == var_0_2 or self.page == var_0_4)
	setActive(self.sortBtn, self.page == var_0_2 or self.page == var_0_4)
	setActive(self.BatchDisposeBtn, self.page == var_0_2)
	setActive(self.capacityTF.parent, self.page == var_0_2 or self.page == var_0_4)
	setActive(self.equipSkinFilteBtn, self.page == var_0_3)
	setActive(self.filterBusyToggle, self.mode == StoreHouseConst.OVERVIEW)
	setActive(self.equipmentToggle, self.mode == StoreHouseConst.OVERVIEW and not self.contextData.shipId)
	self:updatePageFilterButtons(self.page)

	return
end

function StoreHouseScene:updatePageFilterButtons(arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(EquipmentSortCfg.sort) do
		triggerToggle(self.sortButtons[iter_63_0], false)
		setActive(self.sortButtons[iter_63_0], table.contains(iter_63_1.pages, arg_63_1))
	end

	return
end

function StoreHouseScene:initEquipments()
	self.isInitWeapons = true
	self.equipmentRect = self.equipmentView:GetComponent("LScrollRect")

	function self.equipmentRect.onInitItem(arg_65_0)
		self:initEquipment(arg_65_0)

		return
	end

	function self.equipmentRect.onUpdateItem(arg_66_0, arg_66_1)
		self:updateEquipment(arg_66_0, arg_66_1)

		return
	end

	function self.equipmentRect.onReturnItem(arg_67_0, arg_67_1)
		self:returnEquipment(arg_67_0, arg_67_1)

		return
	end

	function self.equipmentRect.onStart()
		self:updateSelected()

		return
	end

	self.equipmentRect.decelerationRate = 0.07

	return
end

function StoreHouseScene:initEquipment(arg_69_1)
	local var_69_0 = EquipmentItem.New(arg_69_1)

	onButton(self, var_69_0.unloadBtn, function()
		if self.page == var_0_3 then
			self:emit(EquipmentMediator.ON_UNEQUIP_EQUIPMENT_SKIN)
		elseif self.page == var_0_2 then
			self:emit(EquipmentMediator.ON_UNEQUIP_EQUIPMENT)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_69_0.reduceBtn, function()
		self:selectEquip(var_69_0.equipmentVO, 1)

		return
	end, SFX_PANEL)

	self.equipmetItems[arg_69_1] = var_69_0

	return
end

function StoreHouseScene:updateEquipment(arg_72_1, arg_72_2)
	assert(self.equipmetItems[arg_72_2], "without init item")

	local var_72_0 = self.loadEquipmentVOs[arg_72_1 + 1]

	self.equipmetItems[arg_72_2]:update(self.loadEquipmentVOs[arg_72_1 + 1])

	local var_72_1 = false
	local var_72_2 = 0

	if self.loadEquipmentVOs[arg_72_1 + 1] then
		for iter_72_0, iter_72_1 in ipairs(self.selectedIds) do
			if self.loadEquipmentVOs[arg_72_1 + 1].id == iter_72_1[1] then
				var_72_1 = true
				var_72_2 = iter_72_1[2]

				break
			end
		end
	end

	self.equipmetItems[arg_72_2]:updateSelected(var_72_1, var_72_2)

	if not self.loadEquipmentVOs[arg_72_1 + 1] then
		removeOnButton(self.equipmetItems[arg_72_2].go)
	elseif isa(self.loadEquipmentVOs[arg_72_1 + 1], SpWeapon) then
		onButton(self, self.equipmetItems[arg_72_2].go, function()
			local var_73_0

			if self.shipVO then
				var_73_0 = {
					type = EquipmentInfoMediator.TYPE_REPLACE,
					shipId = self.contextData.shipId,
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
					end
				end
			end

			self:emit(StoreHouseScene.ON_SPWEAPON, var_73_0)

			return
		end, SFX_PANEL)
	elseif self.equipmetItems[arg_72_2].equipmentVO.isSkin then
		if self.loadEquipmentVOs[arg_72_1 + 1].shipId then
			onButton(self, self.equipmetItems[arg_72_2].go, function()
				assert(var_72_0.shipPos, "equipment skin pos is nil")
				self:emit(EquipmentMediator.ON_EQUIPMENT_SKIN_INFO, var_72_0.id, self.contextData.pos, {
					id = var_72_0.shipId,
					pos = var_72_0.shipPos
				})

				return
			end, SFX_PANEL)
		else
			onButton(self, self.equipmetItems[arg_72_2].go, function()
				self:emit(EquipmentMediator.ON_EQUIPMENT_SKIN_INFO, var_72_0.id, self.contextData.pos)

				return
			end, SFX_PANEL)
		end
	elseif self.loadEquipmentVOs[arg_72_1 + 1].mask then
		removeOnButton(self.equipmetItems[arg_72_2].go)
	elseif self.mode == StoreHouseConst.DESTROY then
		onButton(self, self.equipmetItems[arg_72_2].go, function()
			self:selectEquip(var_72_0, var_72_0.count)

			return
		end, SFX_PANEL)
	else
		onButton(self, self.equipmetItems[arg_72_2].go, function()
			self:emit(StoreHouseScene.ON_EQUIPMENT, self.shipVO and {
				type = EquipmentInfoMediator.TYPE_REPLACE,
				equipmentId = var_72_0.id,
				shipId = self.contextData.shipId,
				pos = self.contextData.pos,
				oldShipId = var_72_0.shipId,
				oldPos = var_72_0.shipPos
			} or var_72_0.shipId and {
				showTransformTip = true,
				type = EquipmentInfoMediator.TYPE_DISPLAY,
				equipmentId = var_72_0.id,
				shipId = var_72_0.shipId,
				pos = var_72_0.shipPos
			} or {
				destroy = true,
				type = EquipmentInfoMediator.TYPE_DEFAULT,
				equipmentId = var_72_0.id
			})

			return
		end, SFX_PANEL)
	end

	return
end

function StoreHouseScene:returnEquipment(arg_78_1, arg_78_2)
	if self.exited then
		return
	end

	local var_78_0 = self.equipmetItems[arg_78_2]

	if self.equipmetItems[arg_78_2] then
		removeOnButton(var_78_0.go)
		var_78_0:clear()
	end

	return
end

function StoreHouseScene:updateEquipmentCount(arg_79_1)
	self.equipmentRect:SetTotalCount(arg_79_1 or #self.loadEquipmentVOs, -1)
	setActive(self.listEmptyTF, (arg_79_1 or #self.loadEquipmentVOs) <= 0)
	setText(self.listEmptyTxt, i18n("list_empty_tip_storehouseui_equip"))
	Canvas.ForceUpdateCanvases()

	return
end

function StoreHouseScene:filterEquipment()
	if self.filterEquipWaitting > 0 then
		self.filterEquipWaitting = self.filterEquipWaitting - 1

		return
	end

	if self.page == var_0_3 then
		self:filterEquipSkin()

		return
	else
		local var_80_0

		if self.page == var_0_4 then
			self:filterSpWeapon()

			do return end

			var_80_0 = GetSpriteFromAtlasAsync
		end
	end

	var_80_0("ui/share/index_atlas", self:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_81_0)
		setImageSprite(self.indexBtn, arg_81_0, true)

		return
	end)

	local var_80_1 = {}

	self.loadEquipmentVOs = {}

	for iter_80_0, iter_80_1 in pairs(self.equipmentVOs) do
		if not iter_80_1.isSkin then
			table.insert(var_80_1, iter_80_1)
		end
	end

	local var_80_2 = {
		self.contextData.indexDatas.equipPropertyIndex,
		self.contextData.indexDatas.equipPropertyIndex2
	}

	for iter_80_2, iter_80_3 in pairs(var_80_1) do
		if (iter_80_3.count > 0 or iter_80_3.shipId) and self:checkFitBusyCondition(iter_80_3) and IndexConst.filterEquipByType(iter_80_3, self.contextData.indexDatas.typeIndex) and IndexConst.filterEquipByProperty(iter_80_3, var_80_2) and IndexConst.filterEquipAmmo1(iter_80_3, self.contextData.indexDatas.equipAmmoIndex1) and IndexConst.filterEquipAmmo2(iter_80_3, self.contextData.indexDatas.equipAmmoIndex2) and IndexConst.filterEquipByCamp(iter_80_3, self.contextData.indexDatas.equipCampIndex) and IndexConst.filterEquipByRarity(iter_80_3, self.contextData.indexDatas.rarityIndex) and IndexConst.filterEquipByExtra(iter_80_3, self.contextData.indexDatas.extraIndex) then
			table.insert(self.loadEquipmentVOs, iter_80_3)
		end
	end

	if self.filterImportance ~= nil then
		for iter_80_4 = #self.loadEquipmentVOs, 1, -1 do
			if self.loadEquipmentVOs[iter_80_4].isSkin or not self.loadEquipmentVOs[iter_80_4].isSkin and self.loadEquipmentVOs[iter_80_4]:isImportance() then
				table.remove(self.loadEquipmentVOs, iter_80_4)
			end
		end
	end

	local var_80_3 = self.searchBar:GetInputText()

	if var_80_3 and var_80_3 ~= "" then
		self.loadEquipmentVOs = underscore.filter(self.loadEquipmentVOs, function(arg_82_0)
			return arg_82_0:IsMatchKey(var_80_3)
		end)
	end

	local var_80_4 = self.contextData.sortData

	if self.contextData.sortData then
		table.sort(self.loadEquipmentVOs, CompareFuncs(EquipmentSortCfg.sortFunc(var_80_4, self.asc)))
	end

	if self.contextData.qiutBtn then
		table.insert(self.loadEquipmentVOs, 1, false)
	end

	self:updateSelected()
	self:updateEquipmentCount()
	setImageSprite(self.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", var_80_4.spr), true)
	setActive(self.sortImgAsc, self.asc)
	setActive(self.sortImgDec, not self.asc)
	self:updateCapacity()

	return
end

function StoreHouseScene:filterEquipSkin()
	local var_83_0 = {}

	self.loadEquipmentVOs = {}

	if self.page ~= var_0_3 then
		assert(false, "不是外观分页")
	end

	local var_83_1 = self.searchBar:GetInputText()

	for iter_83_0, iter_83_1 in pairs(self.equipmentVOs) do
		if iter_83_1.isSkin and iter_83_1.count > 0 and (var_83_1 == "" or EquipmentTools.IsMatchEquipmentSkinKey(iter_83_1.id, var_83_1)) then
			table.insert(var_83_0, iter_83_1)
		end
	end

	for iter_83_2, iter_83_3 in pairs(var_83_0) do
		if IndexConst.filterEquipSkinByIndex(iter_83_3, self.equipSkinIndex) and IndexConst.filterEquipSkinByTheme(iter_83_3, self.equipSkinTheme) and self:checkFitBusyCondition(iter_83_3) then
			table.insert(self.loadEquipmentVOs, iter_83_3)
		end
	end

	if self.filterImportance ~= nil then
		for iter_83_4 = #self.loadEquipmentVOs, 1, -1 do
			if self.loadEquipmentVOs[iter_83_4].isSkin or not self.loadEquipmentVOs[iter_83_4].isSkin and self.loadEquipmentVOs[iter_83_4]:isImportance() then
				table.remove(self.loadEquipmentVOs, iter_83_4)
			end
		end
	end

	if self.contextData.sortData then
		table.sort(self.loadEquipmentVOs, CompareFuncs(EquipmentSortCfg.sortFunc(self.contextData.sortData, self.asc)))
	end

	if self.contextData.qiutBtn then
		table.insert(self.loadEquipmentVOs, 1, false)
	end

	self:updateSelected()
	self:updateEquipmentCount()
	setActive(self.sortImgAsc, self.asc)
	setActive(self.sortImgDec, not self.asc)

	return
end

function StoreHouseScene:filterSpWeapon()
	local var_84_0

	if self.page ~= var_0_4 then
		assert(false, "不是特殊兵装分页")

		var_84_0 = GetSpriteFromAtlasAsync
	end

	var_84_0("ui/share/index_atlas", self:isDefaultSpWeaponIndexData() and "shaixuan_off" or "shaixuan_on", function(arg_85_0)
		setImageSprite(self.indexBtn, arg_85_0, true)

		return
	end)

	self.loadEquipmentVOs = {}

	for iter_84_0, iter_84_1 in pairs(self.spweaponVOs) do
		if IndexConst.filterSpWeaponByType(iter_84_1, self.contextData.spweaponIndexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_84_1, self.contextData.spweaponIndexDatas.rarityIndex) and self:checkFitBusyCondition(iter_84_1) and (self.filterImportance == nil or iter_84_1:IsImportant()) then
			table.insert(self.loadEquipmentVOs, iter_84_1)
		end
	end

	local var_84_1 = self.searchBar:GetInputText()

	if var_84_1 and var_84_1 ~= "" then
		local var_84_2 = EquipmentTools.GetMatchSpEquipmentListKeyByShip(var_84_1)

		self.loadEquipmentVOs = underscore.filter(self.loadEquipmentVOs, function(arg_86_0)
			return arg_86_0:IsMatchKey(var_84_1) or table.contains(var_84_2, arg_86_0.id)
		end)
	end

	local var_84_3 = self.contextData.spweaponSortData

	if self.contextData.spweaponSortData then
		table.sort(self.loadEquipmentVOs, CompareFuncs(SpWeaponSortCfg.sortFunc(var_84_3, self.asc)))
	end

	if self.contextData.qiutBtn then
		table.insert(self.loadEquipmentVOs, 1, false)
	end

	self:updateSelected()
	self:updateEquipmentCount()
	setImageSprite(self.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", var_84_3.spr), true)
	setActive(self.sortImgAsc, self.asc)
	setActive(self.sortImgDec, not self.asc)
	self:UpdateSpweaponCapacity()

	return
end

function StoreHouseScene:GetShowBusyFlag()
	return self.isEquipingOn
end

function StoreHouseScene:SetShowBusyFlag(arg_88_1)
	self.isEquipingOn = arg_88_1

	return
end

function StoreHouseScene:Scroll2Equip(arg_89_1)
	if self.contextData.warp ~= StoreHouseConst.WARP_TO_WEAPON or self.page ~= var_0_2 then
		return
	end

	for iter_89_0, iter_89_1 in ipairs(self.loadEquipmentVOs) do
		if EquipmentProxy.SameEquip(iter_89_1, arg_89_1) then
			local var_89_0 = self.equipmentView:Find("equipment_grid"):GetComponent(typeof(GridLayoutGroup))

			self:ScrollEquipPos((var_89_0.cellSize.y + var_89_0.spacing.y) * math.floor((iter_89_0 - 1) / var_89_0.constraintCount) + self.equipmentRect.paddingFront + self.equipmentView.rect.height * 0.5 - self.equipmentRect.paddingFront)

			break
		end
	end

	return
end

function StoreHouseScene:ScrollEquipPos(arg_90_1)
	local var_90_0 = self.equipmentView:Find("equipment_grid")
	local var_90_1 = var_90_0:GetComponent(typeof(GridLayoutGroup))
	local var_90_2 = var_90_0 - self.equipmentView.rect.height

	var_90_2 = var_90_0 - self.equipmentView.rect.height > 0 and var_90_2 or (var_90_1.cellSize.y + var_90_1.spacing.y) * math.ceil(#self.loadEquipmentVOs / var_90_1.constraintCount) - var_90_1.spacing.y + self.equipmentRect.paddingFront + self.equipmentRect.paddingEnd

	self.equipmentRect:ScrollTo((arg_90_1 - self.equipmentView.rect.height * 0.5) / var_90_2)

	return
end

function StoreHouseScene:checkFitBusyCondition(arg_91_1)
	return not arg_91_1.shipId or self:GetShowBusyFlag() and self.mode ~= StoreHouseConst.DESTROY
end

function StoreHouseScene:setItems(arg_92_1)
	self.itemVOs = arg_92_1

	if self.isInitItems and self.contextData.warp == StoreHouseConst.WARP_TO_MATERIAL then
		self:sortItems()
	end

	return
end

function StoreHouseScene:initItems()
	self.isInitItems = true
	self.itemRect = self.itemView:GetComponent("LScrollRect")

	function self.itemRect.onInitItem(arg_94_0)
		self:initItem(arg_94_0)

		return
	end

	function self.itemRect.onUpdateItem(arg_95_0, arg_95_1)
		self:updateItem(arg_95_0, arg_95_1)

		return
	end

	function self.itemRect.onReturnItem(arg_96_0, arg_96_1)
		self:returnItem(arg_96_0, arg_96_1)

		return
	end

	self.itemRect.decelerationRate = 0.07

	return
end

function StoreHouseScene:sortItems()
	table.sort(self.itemVOs, CompareFuncs({
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
	self.itemRect:SetTotalCount(#self.itemVOs, -1)
	setActive(self.listEmptyTF, #self.itemVOs <= 0)
	setText(self.listEmptyTxt, i18n("list_empty_tip_storehouseui_item"))
	Canvas.ForceUpdateCanvases()

	return
end

function StoreHouseScene:initItem(arg_101_1)
	self.itemCards[arg_101_1] = ItemCard.New(arg_101_1)

	return
end

function StoreHouseScene:updateItem(arg_102_1, arg_102_2)
	assert(self.itemCards[arg_102_2], "without init item")

	local var_102_0 = self.itemVOs[arg_102_1 + 1]

	self.itemCards[arg_102_2]:update(self.itemVOs[arg_102_1 + 1])

	if not self.itemVOs[arg_102_1 + 1] then
		removeOnButton(self.itemCards[arg_102_2].go)
	elseif tobool(getProxy(TechnologyProxy):getItemCanUnlockBluePrint(self.itemVOs[arg_102_1 + 1].id)) then
		local var_102_1 = getProxy(TechnologyProxy)
		local var_102_2 = underscore.map(var_102_1:getItemCanUnlockBluePrint(self.itemVOs[arg_102_1 + 1].id), function(arg_103_0)
			return var_102_1:getBluePrintById(arg_103_0)
		end)
		local var_102_3 = underscore.detect(var_102_2, function(arg_104_0)
			return not arg_104_0:isUnlock()
		end)

		if var_102_3 then
			onButton(self, self.itemCards[arg_102_2].go, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM,
					item = var_102_0,
					blueprints = var_102_2,
					onYes = function()
						self:emit(EquipmentMediator.ITEM_GO_SCENE, SCENE.SHIPBLUEPRINT, {
							shipBluePrintVO = var_102_3
						})

						return
					end,
					yesText = i18n("text_forward")
				})

				return
			end, SFX_PANEL)
		else
			onButton(self, self.itemCards[arg_102_2].go, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_BLUEPRINT_UNLOCK_ITEM,
					windowSize = Vector2(1010, 685),
					item = var_102_0,
					blueprints = var_102_2,
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
								self:emit(EquipmentMediator.ON_USE_ITEM, var_102_0.id, 1)

								return
							end
						})

						return
					end
				})

				return
			end, SFX_PANEL)
		end
	elseif self.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.INVITATION_TYPE then
		onButton(self, self.itemCards[arg_102_2].go, function()
			self:emit(EquipmentMediator.ITEM_GO_SCENE, SCENE.INVITATION, {
				itemVO = var_102_0
			})

			return
		end, SFX_PANEL)
	elseif self.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.ASSIGNED_TYPE or self.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.EQUIPMENT_ASSIGNED_TYPE then
		if self.itemVOs[arg_102_1 + 1]:getConfig("usage") == ItemUsage.EX_RE_MAP then
			onButton(self, self.itemCards[arg_102_2].go, function()
				self:emit(StoreHouseScene.ON_ITEM, var_102_0.id)

				return
			end, SFX_PANEL)
		elseif underscore.any(pg.gameset.general_blueprint_list.description, function(arg_113_0)
			return var_102_0.id == arg_113_0
		end) then
			onButton(self, self.itemCards[arg_102_2].go, function()
				self.blueprintAssignedItemView:Load()
				self.blueprintAssignedItemView:ActionInvoke("Show")
				self.blueprintAssignedItemView:ActionInvoke("update", var_102_0)

				return
			end, SFX_PANEL)
		else
			onButton(self, self.itemCards[arg_102_2].go, function()
				self.assignedItemView:Load()
				self.assignedItemView:ActionInvoke("Show")
				self.assignedItemView:ActionInvoke("update", var_102_0)

				return
			end, SFX_PANEL)
		end
	elseif Item.IsLoveLetterCheckItem(self.itemVOs[arg_102_1 + 1].id) then
		onButton(self, self.itemCards[arg_102_2].go, function()
			self:emit(StoreHouseScene.ON_ITEM_EXTRA, var_102_0.id, var_102_0.extra)

			return
		end, SFX_PANEL)
	elseif self.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.LOVE_LETTER_TYPE then
		onButton(self, self.itemCards[arg_102_2].go, function()
			self:emit(StoreHouseScene.ON_ITEM_EXTRA, var_102_0.id, var_102_0.extra)

			return
		end, SFX_PANEL)
	elseif self.itemVOs[arg_102_1 + 1]:getConfig("type") == Item.SKIN_ASSIGNED_TYPE then
		onButton(self, self.itemCards[arg_102_2].go, function()
			self:emit(StoreHouseScene.ON_ITEM, var_102_0.id, function()
				local var_119_0 = var_102_0:getConfig("usage_arg")

				if var_102_0:IsAllSkinOwner() then
					local var_119_1 = Drop.New({
						count = 1,
						type = DROP_TYPE_ITEM,
						id = var_119_0[5]
					})

					self.msgBox:ExecuteAction("Show", {
						content = i18n("blackfriday_pack_select_skinall_dialog", var_102_0:getConfig("name"), var_119_1:getName()),
						leftDrop = {
							count = 1,
							type = DROP_TYPE_ITEM,
							id = var_102_0.id
						},
						rightDrop = var_119_1,
						onYes = function()
							self:emit(EquipmentMediator.ON_USE_ITEM, var_102_0.id, 1, {
								0
							})

							return
						end
					})
				else
					local var_119_2 = {}

					for iter_119_0, iter_119_1 in ipairs(var_119_0[2]) do
						var_119_2[iter_119_1] = true
					end

					self:emit(EquipmentMediator.ITEM_ADD_LAYER, Context.New({
						viewComponent = NewSelectSkinLayer,
						mediator = NewSkinAtlasMediator,
						data = {
							mode = SelectSkinLayer.MODE_SELECT,
							itemId = var_102_0.id,
							selectableSkinList = underscore.map(var_102_0:GetValidSkinList(), function(arg_121_0)
								local var_121_0 = {
									id = arg_121_0
								}

								var_121_0.isTimeLimit = var_119_2[arg_121_0] or false

								return SelectableSkin.New(var_121_0)
							end),
							OnConfirm = function(arg_122_0)
								self:emit(EquipmentMediator.ON_USE_ITEM, var_102_0.id, 1, {
									arg_122_0
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
		onButton(self, self.itemCards[arg_102_2].go, function()
			self:emit(StoreHouseScene.ON_ITEM, var_102_0.id)

			return
		end, SFX_PANEL)
	end

	return
end

function StoreHouseScene:returnItem(arg_124_1, arg_124_2)
	if self.exited then
		return
	end

	local var_124_0 = self.itemCards[arg_124_2]

	if self.itemCards[arg_124_2] then
		removeOnButton(var_124_0.go)
		var_124_0:clear()
	end

	return
end

function StoreHouseScene:selectCount()
	local var_125_0 = 0

	for iter_125_0, iter_125_1 in ipairs(self.selectedIds) do
		var_125_0 = var_125_0 + iter_125_1[2]
	end

	return var_125_0
end

function StoreHouseScene:selectEquip(arg_126_1, arg_126_2)
	if not self:checkDestroyGold(arg_126_1, arg_126_2) then
		return
	end

	if self.mode == StoreHouseConst.DESTROY then
		local var_126_0 = false
		local var_126_1
		local var_126_2 = 0

		for iter_126_0, iter_126_1 in pairs(self.selectedIds) do
			if iter_126_1[1] == arg_126_1.id then
				var_126_0 = true
				var_126_1 = iter_126_0
				var_126_2 = iter_126_1[2]

				break
			end
		end

		if not var_126_0 then
			local var_126_3, var_126_4 = self.checkEquipment(arg_126_1, function()
				self:selectEquip(arg_126_1, arg_126_2)

				return
			end, self.selectedIds)

			if not var_126_3 then
				if var_126_4 then
					pg.TipsMgr.GetInstance():ShowTips(var_126_4)
				end

				return
			end

			local var_126_5 = self:selectCount()

			if self.selectedMax > 0 and var_126_5 + arg_126_2 > self.selectedMax then
				arg_126_2 = self.selectedMax - var_126_5
			end

			if self.selectedMax == 0 or var_126_5 < self.selectedMax then
				table.insert(self.selectedIds, {
					arg_126_1.id,
					arg_126_2
				})
			elseif self.selectedMax == 1 then
				self.selectedIds[1] = {
					arg_126_1.id,
					arg_126_2
				}
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_equipmentScene_selectError_more", self.selectedMax))

				return
			end
		elseif var_126_2 - arg_126_2 > 0 then
			self.selectedIds[var_126_1][2] = var_126_2 - arg_126_2
		else
			table.remove(self.selectedIds, var_126_1)
		end
	end

	self:updateSelected()

	return
end

function StoreHouseScene:unselecteAllEquips()
	self.selectedIds = {}

	self:updateSelected()

	return
end

function StoreHouseScene:checkDestroyGold(arg_129_1, arg_129_2)
	local var_129_0 = 0
	local var_129_1 = false

	for iter_129_0, iter_129_1 in pairs(self.selectedIds) do
		if Equipment.CanInBag(iter_129_1[1]) then
			var_129_0 = var_129_0 + (Equipment.getConfigData(iter_129_1[1]).destory_gold or 0) * iter_129_1[2]
		end

		if arg_129_1 and iter_129_1[1] == arg_129_1.configId then
			var_129_1 = true
		end
	end

	if not var_129_1 and arg_129_1 and arg_129_2 > 0 then
		var_129_0 = var_129_0 + (arg_129_1:getConfig("destory_gold") or 0) * arg_129_2
	end

	if self.player:GoldMax(var_129_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_destroy"))

		return false
	end

	return true
end

function StoreHouseScene:updateSelected()
	for iter_130_0, iter_130_1 in pairs(self.equipmetItems) do
		if iter_130_1.equipmentVO then
			local var_130_0 = false
			local var_130_1 = 0

			for iter_130_2, iter_130_3 in pairs(self.selectedIds) do
				if iter_130_1.equipmentVO.id == iter_130_3[1] then
					var_130_0 = true
					var_130_1 = iter_130_3[2]

					break
				end
			end

			iter_130_1:updateSelected(var_130_0, var_130_1)
		end
	end

	if self.mode == StoreHouseConst.DESTROY then
		local var_130_2 = self:selectCount()

		if self.selectedMax == 0 then
			setText(findTF(self.selectPanel, "bottom_info/bg_input/count"), var_130_2)
		else
			setText(findTF(self.selectPanel, "bottom_info/bg_input/count"), var_130_2 .. "/" .. self.selectedMax)
		end

		if #self.selectedIds < self.selectedMin then
			setActive(findTF(self.selectPanel, "confirm_button/mask"), true)
		else
			setActive(findTF(self.selectPanel, "confirm_button/mask"), false)
		end
	end

	return
end

function StoreHouseScene:SwitchToDestroy()
	self.page = var_0_2
	self.filterEquipWaitting = self.filterEquipWaitting + 1

	triggerToggle(self.weaponToggle, true)
	triggerButton(self.BatchDisposeBtn)

	return
end

function StoreHouseScene:SwitchToSpWeaponStoreHouse()
	self.page = var_0_4

	triggerToggle(self.weaponToggle, true)

	return
end

function StoreHouseScene:SwitchEquipmentType(arg_133_1)
	self.searchBar:UpdateHolder(arg_133_1 == var_0_4 and i18n("search_sp_equipment") or arg_133_1 == var_0_3 and i18n("search_equipment_appearance") or i18n("search_equipment"))
	self.searchBar:ClearInputText()

	return
end

function StoreHouseScene:willExit()
	self:UnOverlayPanel(self.blurPanel, self._tf)
	self:UnOverlayPanel(self.topItems, self._tf)

	if self.bulinTip then
		self.bulinTip:Destroy()

		self.bulinTip = nil
	end

	if self.searchBar then
		self.searchBar:Dispose()

		self.searchBar = nil
	end

	self.destroyConfirmView:Destroy()
	self.assignedItemView:Destroy()
	self.blueprintAssignedItemView:Destroy()
	self.equipDestroyConfirmWindow:Destroy()
	self.msgBox:Destroy()

	return
end

return StoreHouseScene
