local var_0_0 = class("SpWeaponStoreHouseScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SpWeaponStoreHouseUI"
end

function var_0_0.setEquipments(arg_2_0, arg_2_1)
	arg_2_0.equipmentVOs = arg_2_1

	return
end

function var_0_0.SetCraftList(arg_3_0, arg_3_1)
	arg_3_0.craftList = arg_3_1

	return
end

local var_0_1 = require("view.equipment.SpWeaponSortCfg")

function var_0_0.init(arg_4_0)
	arg_4_0.topItems = arg_4_0._tf:Find("topItems")
	arg_4_0.equipmentView = arg_4_0.rtAdapt:Find("ScrollView")
	arg_4_0.equipmentsGrid = arg_4_0.equipmentView:Find("Viewport/Content/StoreHouse/Grid")
	arg_4_0.craftsGrid = arg_4_0.equipmentView:Find("Viewport/Content/Craft/Grid")

	setActive(arg_4_0.equipmentView:Find("Template"), false)

	arg_4_0.blurPanel = arg_4_0._tf:Find("blur_panel")
	arg_4_0.topPanel = arg_4_0.blurPanel:Find("adapt/top")
	arg_4_0.indexBtn = arg_4_0.topPanel:Find("buttons/index_button")
	arg_4_0.sortBtn = arg_4_0.topPanel:Find("buttons/sort_button")
	arg_4_0.sortPanel = arg_4_0.topItems:Find("sort")
	arg_4_0.sortContain = arg_4_0.sortPanel:Find("adapt/mask/panel")
	arg_4_0.sortTpl = arg_4_0.sortContain:Find("tpl")

	setActive(arg_4_0.sortTpl, false)

	local var_4_0 = (NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and arg_4_0.equipmentView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2

	arg_4_0.equipmentsGrid:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_0 and 8 or 7
	arg_4_0.craftsGrid:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_4_0 and 8 or 7
	arg_4_0.decBtn = findTF(arg_4_0.topPanel, "buttons/dec_btn")
	arg_4_0.sortImgAsc = findTF(arg_4_0.decBtn, "asc")
	arg_4_0.sortImgDec = findTF(arg_4_0.decBtn, "desc")
	arg_4_0.filterBusyToggle = arg_4_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_equip")

	setActive(arg_4_0.filterBusyToggle, false)

	arg_4_0.bottomBack = arg_4_0.topItems:Find("adapt/bottom_back")
	arg_4_0.capacityTF = arg_4_0.bottomBack:Find("bottom_left/tip/capcity/Text")
	arg_4_0.tipTF = arg_4_0.bottomBack:Find("bottom_left/tip")
	arg_4_0.tip = arg_4_0.tipTF:Find("label")
	arg_4_0.helpBtn = arg_4_0.topItems:Find("adapt/help_btn")

	setActive(arg_4_0.helpBtn, true)

	arg_4_0.backBtn = arg_4_0._tf:Find("blur_panel/adapt/top/back_btn")
	arg_4_0.listEmptyTF = arg_4_0._tf:Find("empty")

	setActive(arg_4_0.listEmptyTF, false)

	arg_4_0.listEmptyTxt = arg_4_0.listEmptyTF:Find("Text")

	setText(arg_4_0.listEmptyTxt, i18n("list_empty_tip_storehouseui_equip"))
	setText(arg_4_0.equipmentView:Find("Viewport/Content/Craft/Banner/Text"), i18n("spweapon_ui_create"))
	setText(arg_4_0.equipmentView:Find("Viewport/Content/StoreHouse/Banner/Text"), i18n("spweapon_ui_storage"))

	arg_4_0.isEquipingOn = false
	arg_4_0.filterImportance = nil

	return
end

function var_0_0.setEquipmentUpdate(arg_5_0)
	arg_5_0:filterEquipment()
	arg_5_0:updateCapacity()

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.spweapon_help_storage.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.backBtn, function()
		GetOrAddComponent(arg_6_0._tf, typeof(CanvasGroup)).interactable = false

		arg_6_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onToggle(arg_6_0, arg_6_0.sortBtn, function(arg_9_0)
		if arg_9_0 then
			arg_6_0:OverlayPanel(arg_6_0.sortPanel)
			setActive(arg_6_0.sortPanel, true)
		else
			arg_6_0:UnOverlayPanel(arg_6_0.sortPanel, arg_6_0.topItems)
			setActive(arg_6_0.sortPanel, false)
		end

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.sortPanel, function()
		triggerToggle(arg_6_0.sortBtn, false)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.indexBtn, function()
		arg_6_0:emit(SpWeaponStoreHouseMediator.OPEN_EQUIPMENT_INDEX, {
			indexDatas = Clone(arg_6_0.contextData.indexDatas),
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
			callback = function(arg_12_0)
				arg_6_0.contextData.indexDatas.typeIndex = arg_12_0.typeIndex
				arg_6_0.contextData.indexDatas.rarityIndex = arg_12_0.rarityIndex

				arg_6_0:filterEquipment()

				return
			end
		})

		return
	end, SFX_PANEL)

	local var_6_0 = arg_6_0.equipmentView:Find("Viewport/Content/Craft/Banner/Arrow")

	onToggle(arg_6_0, var_6_0, function(arg_13_0)
		arg_6_0.hideCraft = not arg_13_0

		arg_6_0:UpdateCraftCount()

		return
	end, SFX_PANEL, SFX_PANEL)

	local var_6_1 = arg_6_0.equipmentView:Find("Viewport/Content/StoreHouse/Banner/Arrow")

	onToggle(arg_6_0, var_6_1, function(arg_14_0)
		arg_6_0.hideSpweapon = not arg_14_0

		arg_6_0:updateEquipmentCount()

		return
	end, SFX_PANEL, SFX_PANEL)

	arg_6_0.equipmetItems = {}
	arg_6_0.craftItems = {}

	arg_6_0:initEquipments()

	arg_6_0.asc = arg_6_0.contextData.asc or false
	arg_6_0.contextData.sortData = arg_6_0.contextData.sortData or var_0_1.sort[1]
	arg_6_0.contextData.indexDatas = arg_6_0.contextData.indexDatas or {}

	arg_6_0:initSort()
	onToggle(arg_6_0, arg_6_0.filterBusyToggle, function(arg_15_0)
		arg_6_0:SetShowBusyFlag(arg_15_0)
		arg_6_0:filterEquipment()

		return
	end, SFX_PANEL)
	triggerToggle(arg_6_0.filterBusyToggle, arg_6_0.shipVO)
	arg_6_0:OverlayPanel(arg_6_0.blurPanel)
	arg_6_0:OverlayPanel(arg_6_0.topItems)

	arg_6_0.contextData.mode = arg_6_0.contextData.mode or StoreHouseConst.OVERVIEW

	arg_6_0:updateCapacity()
	setActive(arg_6_0.tip, false)
	setActive(arg_6_0.capacityTF.parent, true)
	setActive(arg_6_0.filterBusyToggle, true)
	setActive(arg_6_0.indexBtn, true)
	setActive(arg_6_0.sortBtn, false)
	triggerToggle(var_6_0, true)
	triggerToggle(var_6_1, true)

	return
end

function var_0_0.isDefaultStatus(arg_16_0)
	return (not arg_16_0.contextData.indexDatas.typeIndex or arg_16_0.contextData.indexDatas.typeIndex == IndexConst.SpWeaponTypeAll) and (not arg_16_0.contextData.indexDatas.rarityIndex or arg_16_0.contextData.indexDatas.rarityIndex == IndexConst.SpWeaponRarityAll)
end

function var_0_0.onBackPressed(arg_17_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(arg_17_0.sortPanel) then
		triggerButton(arg_17_0.sortPanel)
	else
		triggerButton(arg_17_0.backBtn)
	end

	return
end

function var_0_0.updateCapacity(arg_18_0)
	setText(arg_18_0.tip, "")
	setText(arg_18_0.capacityTF, getProxy(EquipmentProxy):GetSpWeaponCount() .. "/" .. getProxy(EquipmentProxy):GetSpWeaponCapacity())

	return
end

function var_0_0.setShip(arg_19_0, arg_19_1)
	arg_19_0.shipVO = arg_19_1

	return
end

function var_0_0.setPlayer(arg_20_0, arg_20_1)
	arg_20_0.player = arg_20_1

	return
end

function var_0_0.initSort(arg_21_0)
	onButton(arg_21_0, arg_21_0.decBtn, function()
		arg_21_0.asc = not arg_21_0.asc
		arg_21_0.contextData.asc = arg_21_0.asc

		arg_21_0:filterEquipment()

		return
	end)

	arg_21_0.sortButtons = {}

	eachChild(arg_21_0.sortContain, function(arg_23_0)
		setActive(arg_23_0, false)

		return
	end)

	for iter_21_0, iter_21_1 in ipairs(var_0_1.sort) do
		local var_21_0 = iter_21_0 <= arg_21_0.sortContain.childCount and arg_21_0.sortContain:GetChild(iter_21_0 - 1) or cloneTplTo(arg_21_0.sortTpl, arg_21_0.sortContain)

		setActive(var_21_0, true)
		setImageSprite(findTF(var_21_0, "Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", iter_21_1.spr), true)
		onToggle(arg_21_0, var_21_0, function(arg_24_0)
			if arg_24_0 then
				arg_21_0.contextData.sortData = iter_21_1

				arg_21_0:filterEquipment()
				triggerToggle(arg_21_0.sortBtn, false)
			end

			return
		end, SFX_PANEL)

		arg_21_0.sortButtons[iter_21_0] = var_21_0
	end

	return
end

function var_0_0.initEquipments(arg_25_0)
	arg_25_0.equipmentRect = UIItemList.New(arg_25_0.equipmentsGrid, arg_25_0.equipmentView:Find("Template"))

	arg_25_0.equipmentRect:make(function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = go(arg_26_2)

		if arg_26_0 == UIItemList.EventInit then
			arg_25_0:InitSpWeapon(var_26_0)
		elseif arg_26_0 == UIItemList.EventUpdate then
			arg_25_0:UpdateSpWeapon(arg_26_1, var_26_0)
		elseif arg_26_0 == UIItemList.EventExcess then
			arg_25_0:ReturnSpWeapon(arg_26_1, var_26_0)
		end

		return
	end)

	arg_25_0.craftRect = UIItemList.New(arg_25_0.craftsGrid, arg_25_0.equipmentView:Find("Template"))

	arg_25_0.craftRect:make(function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = go(arg_27_2)

		if arg_27_0 == UIItemList.EventInit then
			arg_25_0:InitCraftItem(var_27_0)
		elseif arg_27_0 == UIItemList.EventUpdate then
			arg_25_0:UpdateCraftItem(arg_27_1, var_27_0)
		elseif arg_27_0 == UIItemList.EventExcess then
			arg_25_0:ReturnCraftItem(arg_27_1, var_27_0)
		end

		return
	end)

	return
end

function var_0_0.InitSpWeapon(arg_28_0, arg_28_1)
	local var_28_0 = SpWeaponItemView.New(arg_28_1)

	onButton(arg_28_0, var_28_0.unloadBtn, function()
		arg_28_0:emit(SpWeaponStoreHouseMediator.ON_UNEQUIP)

		return
	end, SFX_PANEL)

	arg_28_0.equipmetItems[arg_28_1] = var_28_0

	return
end

function var_0_0.UpdateSpWeapon(arg_30_0, arg_30_1, arg_30_2)
	assert(arg_30_0.equipmetItems[arg_30_2], "without init item")

	local var_30_0 = arg_30_0.loadEquipmentVOs[arg_30_1 + 1]

	arg_30_0.equipmetItems[arg_30_2]:update(arg_30_0.loadEquipmentVOs[arg_30_1 + 1])

	if not arg_30_0.loadEquipmentVOs[arg_30_1 + 1] or arg_30_0.loadEquipmentVOs[arg_30_1 + 1].mask then
		removeOnButton(arg_30_0.equipmetItems[arg_30_2].go)
	else
		onButton(arg_30_0, arg_30_0.equipmetItems[arg_30_2].go, function()
			if arg_30_0.shipVO then
				local var_31_0 = {
					type = EquipmentInfoMediator.TYPE_REPLACE,
					shipId = arg_30_0.contextData.shipId,
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

						arg_30_0:emit(var_0_0.ON_SPWEAPON, var_31_0)

						return
					end
				end
			end
		end, SFX_PANEL)
	end

	return
end

function var_0_0.ReturnSpWeapon(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.exited then
		return
	end

	local var_32_0 = arg_32_0.equipmetItems[arg_32_2]

	if arg_32_0.equipmetItems[arg_32_2] then
		removeOnButton(var_32_0.go)
		var_32_0:clear()
	end

	return
end

function var_0_0.updateEquipmentCount(arg_33_0)
	local var_33_0 = arg_33_0.hideSpweapon and 0 or #arg_33_0.loadEquipmentVOs

	arg_33_0.equipmentRect:align(arg_33_0.hideSpweapon and 0 or #arg_33_0.loadEquipmentVOs)

	local var_33_1 = arg_33_0.equipmentsGrid:GetComponent(typeof(GridLayoutGroup))
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

function var_0_0.filterEquipment(arg_34_0)
	GetSpriteFromAtlasAsync("ui/share/index_atlas", arg_34_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_35_0)
		setImageSprite(arg_34_0.indexBtn, arg_35_0, true)

		return
	end)

	local var_34_0 = arg_34_0.contextData.sortData

	;(function()
		arg_34_0.loadEquipmentVOs = {}

		for iter_36_0, iter_36_1 in pairs(arg_34_0.equipmentVOs) do
			table.insert({}, iter_36_1)
		end

		for iter_36_2, iter_36_3 in pairs({}) do
			if arg_34_0:checkFitBusyCondition(iter_36_3) and IndexConst.filterSpWeaponByType(iter_36_3, arg_34_0.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_36_3, arg_34_0.contextData.indexDatas.rarityIndex) and (arg_34_0.filterImportance == nil or iter_36_3:IsImportant()) then
				table.insert(arg_34_0.loadEquipmentVOs, iter_36_3)
			end
		end

		if var_34_0 then
			table.sort(arg_34_0.loadEquipmentVOs, CompareFuncs(var_0_1.sortFunc(var_34_0, arg_34_0.asc)))
		end

		if arg_34_0.contextData.qiutBtn then
			table.insert(arg_34_0.loadEquipmentVOs, 1, false)
		end

		return
	end)()
	arg_34_0:updateEquipmentCount()
	;(function()
		arg_34_0.showCraftList = {}

		for iter_37_0, iter_37_1 in pairs(arg_34_0.craftList) do
			table.insert({}, iter_37_1)
		end

		for iter_37_2, iter_37_3 in pairs({}) do
			if arg_34_0:checkFitBusyCondition(iter_37_3) and IndexConst.filterSpWeaponByType(iter_37_3, arg_34_0.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_37_3, arg_34_0.contextData.indexDatas.rarityIndex) and (arg_34_0.filterImportance == nil or iter_37_3:IsImportant()) then
				table.insert(arg_34_0.showCraftList, iter_37_3)
			end
		end

		if var_34_0 then
			table.sort(arg_34_0.showCraftList, CompareFuncs(var_0_1.sortFunc(var_34_0, arg_34_0.asc)))
		end

		return
	end)()
	arg_34_0:UpdateCraftCount()
	setImageSprite(arg_34_0.sortBtn:Find("Image"), GetSpriteFromAtlas("ui/equipmentui_atlas", arg_34_0.contextData.sortData.spr), true)
	setActive(arg_34_0.sortImgAsc, arg_34_0.asc)
	setActive(arg_34_0.sortImgDec, not arg_34_0.asc)

	return
end

function var_0_0.InitCraftItem(arg_38_0, arg_38_1)
	arg_38_0.craftItems[arg_38_1] = SpWeaponItemView.New(arg_38_1)

	return
end

function var_0_0.UpdateCraftItem(arg_39_0, arg_39_1, arg_39_2)
	assert(arg_39_0.craftItems[arg_39_2], "without init item")
	arg_39_0.craftItems[arg_39_2]:update(arg_39_0.showCraftList[arg_39_1 + 1])
	onButton(arg_39_0, arg_39_0.craftItems[arg_39_2].go, function()
		arg_39_0:emit(SpWeaponStoreHouseMediator.ON_COMPOSITE, var_0:GetConfigID())

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ReturnCraftItem(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0.craftItems[arg_41_2] then
		removeOnButton(arg_41_0.craftItems[arg_41_2].go)
		arg_41_0.craftItems[arg_41_2]:clear()
	end

	return
end

function var_0_0.UpdateCraftCount(arg_42_0)
	local var_42_0 = arg_42_0.hideCraft and 0 or #arg_42_0.showCraftList

	arg_42_0.craftRect:align(arg_42_0.hideCraft and 0 or #arg_42_0.showCraftList)

	local var_42_1 = arg_42_0.craftsGrid:GetComponent(typeof(GridLayoutGroup))
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

function var_0_0.GetShowBusyFlag(arg_43_0)
	return arg_43_0.isEquipingOn
end

function var_0_0.SetShowBusyFlag(arg_44_0, arg_44_1)
	arg_44_0.isEquipingOn = arg_44_1

	return
end

function var_0_0.checkFitBusyCondition(arg_45_0, arg_45_1)
	return arg_45_0:GetShowBusyFlag() or not arg_45_1:GetShipId()
end

function var_0_0.willExit(arg_46_0)
	arg_46_0:UnOverlayPanel(arg_46_0.blurPanel, arg_46_0._tf)
	arg_46_0:UnOverlayPanel(arg_46_0.topItems, arg_46_0._tf)

	return
end

return var_0_0
