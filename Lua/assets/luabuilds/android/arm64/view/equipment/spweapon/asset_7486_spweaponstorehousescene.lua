local SpWeaponStoreHouseScene = class("SpWeaponStoreHouseScene", import("view.base.BaseUI"))

function SpWeaponStoreHouseScene:getUIName()
	return "SpWeaponStoreHouseUI"
end

function SpWeaponStoreHouseScene:setEquipments(arg_2_1)
	self.equipmentVOs = arg_2_1

	return
end

function SpWeaponStoreHouseScene:SetCraftList(arg_3_1)
	self.craftList = arg_3_1

	return
end

local SpWeaponSortCfg = require("view.equipment.SpWeaponSortCfg")

function SpWeaponStoreHouseScene:init()
	self.topItems = self._tf:Find("topItems")
	self.equipmentView = self.rtAdapt:Find("ScrollView")
	self.equipmentsGrid = self.equipmentView:Find("Viewport/Content/StoreHouse/Grid")
	self.craftsGrid = self.equipmentView:Find("Viewport/Content/Craft/Grid")

	setActive(self.equipmentView:Find("Template"), false)

	self.blurPanel = self._tf:Find("blur_panel")
	self.topPanel = self.blurPanel:Find("adapt/top")
	self.indexBtn = self.topPanel:Find("buttons/index_button")
	self.sortBtn = self.topPanel:Find("buttons/sort_button")
	self.sortPanel = self.topItems:Find("sort")
	self.sortContain = self.sortPanel:Find("adapt/mask/panel")
	self.sortTpl = self.sortContain:Find("tpl")

	setActive(self.sortTpl, false)

	local var_4_0 = (NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and self.equipmentView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2

	self.equipmentsGrid:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_0 and 8 or 7
	self.craftsGrid:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_0 and 8 or 7
	self.decBtn = findTF(self.topPanel, "buttons/dec_btn")
	self.sortImgAsc = findTF(self.decBtn, "asc")
	self.sortImgDec = findTF(self.decBtn, "desc")
	self.filterBusyToggle = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_equip")

	setActive(self.filterBusyToggle, false)

	self.bottomBack = self.topItems:Find("adapt/bottom_back")
	self.capacityTF = self.bottomBack:Find("bottom_left/tip/capcity/Text")
	self.tipTF = self.bottomBack:Find("bottom_left/tip")
	self.tip = self.tipTF:Find("label")
	self.helpBtn = self.topItems:Find("adapt/help_btn")

	setActive(self.helpBtn, true)

	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_storehouseui_equip"))
	setText(self.equipmentView:Find("Viewport/Content/Craft/Banner/Text"), i18n("spweapon_ui_create"))
	setText(self.equipmentView:Find("Viewport/Content/StoreHouse/Banner/Text"), i18n("spweapon_ui_storage"))

	self.isEquipingOn = false
	self.filterImportance = nil

	return
end

function SpWeaponStoreHouseScene:setEquipmentUpdate()
	self:filterEquipment()
	self:updateCapacity()

	return
end

function SpWeaponStoreHouseScene:didEnter()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.spweapon_help_storage.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:emit(SpWeaponStoreHouseScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onToggle(self, self.sortBtn, function(arg_9_0)
		if arg_9_0 then
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
	onButton(self, self.indexBtn, function()
		self:emit(SpWeaponStoreHouseMediator.OPEN_EQUIPMENT_INDEX, {
			indexDatas = Clone(self.contextData.indexDatas),
			customPanels = {
				typeIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.SpWeaponTypeIndexs,
					names = IndexConst.SpWeaponTypeNames
				},
				rarityIndex = {
					mode = CustomIndexLayer.Mode.AND,
					options = IndexConst.SpWeaponRarityIndexs,
					names = IndexConst.SpWeaponRarityNames
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
					dropdown = false,
					titleENTxt = "indexsort_rarityeng",
					titleTxt = "indexsort_rarity",
					tags = {
						"rarityIndex"
					}
				}
			},
			callback = function(self)
				self.contextData.indexDatas.typeIndex = self.typeIndex
				self.contextData.indexDatas.rarityIndex = self.rarityIndex

				self:filterEquipment()

				return
			end
		})

		return
	end, SFX_PANEL)

	local var_6_0 = self.equipmentView:Find("Viewport/Content/Craft/Banner/Arrow")

	onToggle(self, var_6_0, function(arg_13_0)
		self.hideCraft = not arg_13_0

		self:UpdateCraftCount()

		return
	end, SFX_PANEL, SFX_PANEL)

	local var_6_1 = self.equipmentView:Find("Viewport/Content/StoreHouse/Banner/Arrow")

	onToggle(self, var_6_1, function(arg_14_0)
		self.hideSpweapon = not arg_14_0

		self:updateEquipmentCount()

		return
	end, SFX_PANEL, SFX_PANEL)

	self.equipmetItems = {}
	self.craftItems = {}

	self:initEquipments()

	self.asc = self.contextData.asc or false
	self.contextData.sortData = self.contextData.sortData or SpWeaponSortCfg.sort[1]
	self.contextData.indexDatas = self.contextData.indexDatas or {}

	self:initSort()
	onToggle(self, self.filterBusyToggle, function(arg_15_0)
		self:SetShowBusyFlag(arg_15_0)
		self:filterEquipment()

		return
	end, SFX_PANEL)
	triggerToggle(self.filterBusyToggle, self.shipVO)
	self:OverlayPanel(self.blurPanel)
	self:OverlayPanel(self.topItems)

	self.contextData.mode = self.contextData.mode or StoreHouseConst.OVERVIEW

	self:updateCapacity()
	setActive(self.tip, false)
	setActive(self.capacityTF.parent, true)
	setActive(self.filterBusyToggle, true)
	setActive(self.indexBtn, true)
	setActive(self.sortBtn, false)
	triggerToggle(var_6_0, true)
	triggerToggle(var_6_1, true)

	return
end

function SpWeaponStoreHouseScene:isDefaultStatus()
	return (not self.contextData.indexDatas.typeIndex or self.contextData.indexDatas.typeIndex == IndexConst.SpWeaponTypeAll) and (not self.contextData.indexDatas.rarityIndex or self.contextData.indexDatas.rarityIndex == IndexConst.SpWeaponRarityAll)
end

function SpWeaponStoreHouseScene:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self.sortPanel) then
		triggerButton(self.sortPanel)
	else
		triggerButton(self.backBtn)
	end

	return
end

function SpWeaponStoreHouseScene:updateCapacity()
	setText(self.tip, "")
	setText(self.capacityTF, getProxy(EquipmentProxy):GetSpWeaponCount() .. "/" .. getProxy(EquipmentProxy):GetSpWeaponCapacity())

	return
end

function SpWeaponStoreHouseScene:setShip(arg_19_1)
	self.shipVO = arg_19_1

	return
end

function SpWeaponStoreHouseScene:setPlayer(arg_20_1)
	self.player = arg_20_1

	return
end

function SpWeaponStoreHouseScene:initSort()
	onButton(self, self.decBtn, function()
		self.asc = not self.asc
		self.contextData.asc = self.asc

		self:filterEquipment()

		return
	end)

	self.sortButtons = {}

	eachChild(self.sortContain, function(arg_23_0)
		setActive(arg_23_0, false)

		return
	end)

	for iter_21_0, iter_21_1 in ipairs(SpWeaponSortCfg.sort) do
		local var_21_0 = iter_21_0 <= self.sortContain.childCount and self.sortContain:GetChild(iter_21_0 - 1) or cloneTplTo(self.sortTpl, self.sortContain)

		setActive(var_21_0, true)
		setImageSprite(findTF(var_21_0, "Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", iter_21_1.spr), true)
		onToggle(self, var_21_0, function(arg_24_0)
			if arg_24_0 then
				self.contextData.sortData = iter_21_1

				self:filterEquipment()
				triggerToggle(self.sortBtn, false)
			end

			return
		end, SFX_PANEL)

		self.sortButtons[iter_21_0] = var_21_0
	end

	return
end

function SpWeaponStoreHouseScene:initEquipments()
	self.equipmentRect = UIItemList.New(self.equipmentsGrid, self.equipmentView:Find("Template"))

	self.equipmentRect:make(function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = go(arg_26_2)

		if arg_26_0 == UIItemList.EventInit then
			self:InitSpWeapon(var_26_0)
		elseif arg_26_0 == UIItemList.EventUpdate then
			self:UpdateSpWeapon(arg_26_1, var_26_0)
		elseif arg_26_0 == UIItemList.EventExcess then
			self:ReturnSpWeapon(arg_26_1, var_26_0)
		end

		return
	end)

	self.craftRect = UIItemList.New(self.craftsGrid, self.equipmentView:Find("Template"))

	self.craftRect:make(function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = go(arg_27_2)

		if arg_27_0 == UIItemList.EventInit then
			self:InitCraftItem(var_27_0)
		elseif arg_27_0 == UIItemList.EventUpdate then
			self:UpdateCraftItem(arg_27_1, var_27_0)
		elseif arg_27_0 == UIItemList.EventExcess then
			self:ReturnCraftItem(arg_27_1, var_27_0)
		end

		return
	end)

	return
end

function SpWeaponStoreHouseScene:InitSpWeapon(arg_28_1)
	local var_28_0 = SpWeaponItemView.New(arg_28_1)

	onButton(self, var_28_0.unloadBtn, function()
		self:emit(SpWeaponStoreHouseMediator.ON_UNEQUIP)

		return
	end, SFX_PANEL)

	self.equipmetItems[arg_28_1] = var_28_0

	return
end

function SpWeaponStoreHouseScene:UpdateSpWeapon(arg_30_1, arg_30_2)
	assert(self.equipmetItems[arg_30_2], "without init item")

	local var_30_0 = self.loadEquipmentVOs[arg_30_1 + 1]

	self.equipmetItems[arg_30_2]:update(self.loadEquipmentVOs[arg_30_1 + 1])

	if not self.loadEquipmentVOs[arg_30_1 + 1] or self.loadEquipmentVOs[arg_30_1 + 1].mask then
		removeOnButton(self.equipmetItems[arg_30_2].go)
	else
		onButton(self, self.equipmetItems[arg_30_2].go, function()
			local var_31_0

			if self.shipVO then
				var_31_0 = {
					type = EquipmentInfoMediator.TYPE_REPLACE,
					shipId = self.contextData.shipId,
					oldSpWeaponUid = var_30_0:GetUID(),
					oldShipId = var_30_0:GetShipId()
				}

				if not var_31_0 then
					if var_30_0:GetShipId() then
						var_31_0 = {
							type = EquipmentInfoMediator.TYPE_DISPLAY,
							spWeaponUid = var_30_0:GetUID(),
							shipId = var_30_0:GetShipId()
						} or {
							type = EquipmentInfoMediator.TYPE_DEFAULT,
							spWeaponUid = var_30_0:GetUID()
						}
					end
				end
			end

			self:emit(SpWeaponStoreHouseScene.ON_SPWEAPON, var_31_0)

			return
		end, SFX_PANEL)
	end

	return
end

function SpWeaponStoreHouseScene:ReturnSpWeapon(arg_32_1, arg_32_2)
	if self.exited then
		return
	end

	local var_32_0 = self.equipmetItems[arg_32_2]

	if self.equipmetItems[arg_32_2] then
		removeOnButton(var_32_0.go)
		var_32_0:clear()
	end

	return
end

function SpWeaponStoreHouseScene:updateEquipmentCount()
	local var_33_0 = self.hideSpweapon and 0 or #self.loadEquipmentVOs

	self.equipmentRect:align(self.hideSpweapon and 0 or #self.loadEquipmentVOs)

	local var_33_1 = self.equipmentsGrid:GetComponent(typeof(GridLayoutGroup))
	local var_33_2 = var_33_1.padding

	if var_33_0 then
		var_33_2.top = 31
		var_33_2.bottom = 25
	else
		var_33_2.top = 0
		var_33_2.bottom = 0
	end

	var_33_1.padding = var_33_2

	return
end

function SpWeaponStoreHouseScene:filterEquipment()
	GetSpriteFromAtlasAsync("ui/share/index_atlas", self:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_35_0)
		setImageSprite(self.indexBtn, arg_35_0, true)

		return
	end)

	local var_34_0 = self.contextData.sortData

	;(function()
		self.loadEquipmentVOs = {}

		local var_36_0 = {}

		for iter_36_0, iter_36_1 in pairs(self.equipmentVOs) do
			table.insert(var_36_0, iter_36_1)
		end

		for iter_36_2, iter_36_3 in pairs(var_36_0) do
			if self:checkFitBusyCondition(iter_36_3) and IndexConst.filterSpWeaponByType(iter_36_3, self.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_36_3, self.contextData.indexDatas.rarityIndex) and (self.filterImportance == nil or iter_36_3:IsImportant()) then
				table.insert(self.loadEquipmentVOs, iter_36_3)
			end
		end

		if var_34_0 then
			table.sort(self.loadEquipmentVOs, CompareFuncs(SpWeaponSortCfg.sortFunc(var_34_0, self.asc)))
		end

		if self.contextData.qiutBtn then
			table.insert(self.loadEquipmentVOs, 1, false)
		end

		return
	end)()
	self:updateEquipmentCount()
	;(function()
		self.showCraftList = {}

		local var_37_0 = {}

		for iter_37_0, iter_37_1 in pairs(self.craftList) do
			table.insert(var_37_0, iter_37_1)
		end

		for iter_37_2, iter_37_3 in pairs(var_37_0) do
			if self:checkFitBusyCondition(iter_37_3) and IndexConst.filterSpWeaponByType(iter_37_3, self.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_37_3, self.contextData.indexDatas.rarityIndex) and (self.filterImportance == nil or iter_37_3:IsImportant()) then
				table.insert(self.showCraftList, iter_37_3)
			end
		end

		if var_34_0 then
			table.sort(self.showCraftList, CompareFuncs(SpWeaponSortCfg.sortFunc(var_34_0, self.asc)))
		end

		return
	end)()
	self:UpdateCraftCount()
	setImageSprite(self.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", self.contextData.sortData.spr), true)
	setActive(self.sortImgAsc, self.asc)
	setActive(self.sortImgDec, not self.asc)

	return
end

function SpWeaponStoreHouseScene:InitCraftItem(arg_38_1)
	self.craftItems[arg_38_1] = SpWeaponItemView.New(arg_38_1)

	return
end

function SpWeaponStoreHouseScene:UpdateCraftItem(arg_39_1, arg_39_2)
	assert(self.craftItems[arg_39_2], "without init item")

	local var_39_0 = self.showCraftList[arg_39_1 + 1]

	self.craftItems[arg_39_2]:update(self.showCraftList[arg_39_1 + 1])
	onButton(self, self.craftItems[arg_39_2].go, function()
		self:emit(SpWeaponStoreHouseMediator.ON_COMPOSITE, var_39_0:GetConfigID())

		return
	end, SFX_PANEL)

	return
end

function SpWeaponStoreHouseScene:ReturnCraftItem(arg_41_1, arg_41_2)
	if self.craftItems[arg_41_2] then
		removeOnButton(self.craftItems[arg_41_2].go)
		self.craftItems[arg_41_2]:clear()
	end

	return
end

function SpWeaponStoreHouseScene:UpdateCraftCount()
	local var_42_0 = self.hideCraft and 0 or #self.showCraftList

	self.craftRect:align(self.hideCraft and 0 or #self.showCraftList)

	local var_42_1 = self.craftsGrid:GetComponent(typeof(GridLayoutGroup))
	local var_42_2 = var_42_1.padding

	if var_42_0 > 0 then
		var_42_2.top = 31
		var_42_2.bottom = 25
	else
		var_42_2.top = 0
		var_42_2.bottom = 0
	end

	var_42_1.padding = var_42_2

	return
end

function SpWeaponStoreHouseScene:GetShowBusyFlag()
	return self.isEquipingOn
end

function SpWeaponStoreHouseScene:SetShowBusyFlag(arg_44_1)
	self.isEquipingOn = arg_44_1

	return
end

function SpWeaponStoreHouseScene:checkFitBusyCondition(arg_45_1)
	return self:GetShowBusyFlag() or not arg_45_1:GetShipId()
end

function SpWeaponStoreHouseScene:willExit()
	self:UnOverlayPanel(self.blurPanel, self._tf)
	self:UnOverlayPanel(self.topItems, self._tf)

	return
end

return SpWeaponStoreHouseScene
