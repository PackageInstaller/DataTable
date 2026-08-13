class = var_0_10000

local var_0_0 = "SpWeaponStoreHouseScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SpWeaponStoreHouseUI"
end

function var_0_1.setEquipments(arg_2_0, arg_2_1)
	arg_2_0.equipmentVOs = arg_2_1

	return
end

function var_0_1.SetCraftList(arg_3_0, arg_3_1)
	arg_3_0.craftList = arg_3_1

	return
end

require = var_1

local var_0_2 = var_1("view.equipment.SpWeaponSortCfg")

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.topItems = var_1.Find(var_4_0, "topItems")

	local var_4_1 = arg_4_0.rtAdapt

	arg_4_0.equipmentView = var_1.Find(var_4_1, "ScrollView")

	local var_4_2 = arg_4_0.equipmentView

	arg_4_0.equipmentsGrid = var_1.Find(var_4_2, "Viewport/Content/StoreHouse/Grid")

	local var_4_3 = arg_4_0.equipmentView

	arg_4_0.craftsGrid = var_1.Find(var_4_3, "Viewport/Content/Craft/Grid")
	setActive = var_1

	local var_4_4 = arg_4_0.equipmentView

	var_1(var_3.Find(var_4_4, "Template"), false)

	local var_4_5 = arg_4_0._tf

	arg_4_0.blurPanel = var_1.Find(var_4_5, "blur_panel")

	local var_4_6 = arg_4_0.blurPanel

	arg_4_0.topPanel = var_1.Find(var_4_6, "adapt/top")

	local var_4_7 = arg_4_0.topPanel

	arg_4_0.indexBtn = var_1.Find(var_4_7, "buttons/index_button")

	local var_4_8 = arg_4_0.topPanel

	arg_4_0.sortBtn = var_1.Find(var_4_8, "buttons/sort_button")

	local var_4_9 = arg_4_0.topItems

	arg_4_0.sortPanel = var_1.Find(var_4_9, "sort")

	local var_4_10 = arg_4_0.sortPanel

	arg_4_0.sortContain = var_1.Find(var_4_10, "adapt/mask/panel")

	local var_4_11 = arg_4_0.sortContain

	arg_4_0.sortTpl = var_1.Find(var_4_11, "tpl")
	setActive = var_1

	var_1(arg_4_0.sortTpl, false)

	local var_4_12

	getProxy = var_1_10002
	SettingsProxy = var_4

	local var_4_13 = var_1_10002(var_4)

	NotchAdapt = var_3

	if var_3.CheckNotchRatio == 2 or not var_4_13:CheckLargeScreen() then
		var_4_12 = arg_4_0.equipmentView.rect.width > 2000
	else
		NotchAdapt = var_3
		var_4_12 = var_3.CheckNotchRatio >= 2
	end

	local var_4_14 = arg_4_0.equipmentsGrid
	local var_4_15 = var_3.GetComponent

	typeof = var_6
	GridLayoutGroup = var_1_10008
	var_4_15(var_4_14, var_6(var_1_10008)).constraintCount = var_4_12 and 8 or 7

	local var_4_16 = arg_4_0.craftsGrid
	local var_4_17 = var_4.GetComponent

	typeof = var_1_10007
	GridLayoutGroup = var_1_10009
	var_4_17(var_4_16, var_1_10007(var_1_10009)).constraintCount = var_4_12 and 8 or 7
	findTF = var_4
	arg_4_0.decBtn = var_4(arg_4_0.topPanel, "buttons/dec_btn")
	findTF = var_4
	arg_4_0.sortImgAsc = var_4(arg_4_0.decBtn, "asc")
	findTF = var_4
	arg_4_0.sortImgDec = var_4(arg_4_0.decBtn, "desc")

	local var_4_18 = arg_4_0._tf

	arg_4_0.filterBusyToggle = var_4.Find(var_4_18, "blur_panel/adapt/left_length/frame/toggle_equip")
	setActive = var_4

	var_4(arg_4_0.filterBusyToggle, false)

	local var_4_19 = arg_4_0.topItems

	arg_4_0.bottomBack = var_4.Find(var_4_19, "adapt/bottom_back")

	local var_4_20 = arg_4_0.bottomBack

	arg_4_0.capacityTF = var_4.Find(var_4_20, "bottom_left/tip/capcity/Text")

	local var_4_21 = arg_4_0.bottomBack

	arg_4_0.tipTF = var_4.Find(var_4_21, "bottom_left/tip")

	local var_4_22 = arg_4_0.tipTF

	arg_4_0.tip = var_4.Find(var_4_22, "label")

	local var_4_23 = arg_4_0.topItems

	arg_4_0.helpBtn = var_4.Find(var_4_23, "adapt/help_btn")
	setActive = var_4

	var_4(arg_4_0.helpBtn, true)

	local var_4_24 = arg_4_0._tf

	arg_4_0.backBtn = var_4.Find(var_4_24, "blur_panel/adapt/top/back_btn")

	local var_4_25 = arg_4_0._tf

	arg_4_0.listEmptyTF = var_4.Find(var_4_25, "empty")
	setActive = var_4

	var_4(arg_4_0.listEmptyTF, false)

	local var_4_26 = arg_4_0.listEmptyTF

	arg_4_0.listEmptyTxt = var_4.Find(var_4_26, "Text")
	setText = var_4

	local var_4_27 = arg_4_0.listEmptyTxt

	i18n = var_7

	var_4(var_4_27, var_7("list_empty_tip_storehouseui_equip"))

	setText = var_4

	local var_4_28 = arg_4_0.equipmentView
	local var_4_29 = var_6.Find(var_4_28, "Viewport/Content/Craft/Banner/Text")

	i18n = var_7

	var_4(var_4_29, var_7("spweapon_ui_create"))

	setText = var_4

	local var_4_30 = arg_4_0.equipmentView
	local var_4_31 = var_6.Find(var_4_30, "Viewport/Content/StoreHouse/Banner/Text")

	i18n = var_7

	var_4(var_4_31, var_7("spweapon_ui_storage"))

	arg_4_0.isEquipingOn = false
	arg_4_0.filterImportance = nil

	return
end

function var_0_1.setEquipmentUpdate(arg_5_0)
	arg_5_0:filterEquipment()
	arg_5_0:updateCapacity()

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.helpBtn

	local function var_6_2()
		pg = var_2_10000

		local var_7_0 = var_2_10000.gametip.spweapon_help_storage.tip

		pg = var_2_10001

		local var_7_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_7_2 = var_1.ShowMsgBox
		local var_7_3 = {}

		MSGBOX_TYPE_HELP = var_2_10005
		var_7_3.type = var_2_10005
		var_7_3.helps = var_7_0

		var_7_2(var_7_1, var_7_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.backBtn

	local function var_6_5()
		GetOrAddComponent = var_2_10000

		local var_8_0 = arg_6_0._tf

		typeof = var_2_10003
		CanvasGroup = var_2_10005
		var_2_10000(var_8_0, var_2_10003(var_2_10005)).interactable = false

		local var_8_1 = arg_6_0

		var_1.emit(var_8_1, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	onToggle = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.sortBtn

	local function var_6_8(arg_9_0)
		if arg_9_0 then
			local var_9_0 = arg_6_0

			var_1.OverlayPanel(var_9_0, arg_6_0.sortPanel)

			setActive = var_1

			var_1(arg_6_0.sortPanel, true)
		else
			local var_9_1 = arg_6_0

			var_1.UnOverlayPanel(var_9_1, arg_6_0.sortPanel, arg_6_0.topItems)

			setActive = var_1

			var_1(arg_6_0.sortPanel, false)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10006)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.sortPanel

	local function var_6_11()
		triggerToggle = var_2_10000

		var_2_10000(arg_6_0.sortBtn, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10006)

	onButton = var_1_10001

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.indexBtn

	local function var_6_14()
		local var_11_0 = {}

		Clone = var_2_10001
		var_11_0.indexDatas = var_2_10001(arg_6_0.contextData.indexDatas)

		local var_11_1 = {}
		local var_11_2 = {}

		CustomIndexLayer = var_3
		var_11_2.mode = var_3.Mode.OR
		IndexConst = var_3
		var_11_2.options = var_3.SpWeaponTypeIndexs
		IndexConst = var_3
		var_11_2.names = var_3.SpWeaponTypeNames
		var_11_1.typeIndex = var_11_2

		local var_11_3 = {}

		CustomIndexLayer = var_3
		var_11_3.mode = var_3.Mode.AND
		IndexConst = var_3
		var_11_3.options = var_3.SpWeaponRarityIndexs
		IndexConst = var_3
		var_11_3.names = var_3.SpWeaponRarityNames
		var_11_1.rarityIndex = var_11_3
		var_11_0.customPanels = var_11_1
		var_11_0.groupList = {
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

		function var_11_0.callback(arg_12_0)
			arg_6_0.contextData.indexDatas.typeIndex = arg_12_0.typeIndex
			arg_6_0.contextData.indexDatas.rarityIndex = arg_12_0.rarityIndex

			local var_12_0 = arg_6_0

			var_1.filterEquipment(var_12_0)

			return
		end

		local var_11_4 = arg_6_0
		local var_11_5 = var_1.emit

		SpWeaponStoreHouseMediator = var_2_10004

		var_11_5(var_11_4, var_2_10004.OPEN_EQUIPMENT_INDEX, var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_12, var_6_13, var_6_14, var_1_10006)

	local var_6_15 = arg_6_0.equipmentView
	local var_6_16 = var_1.Find(var_6_15, "Viewport/Content/Craft/Banner/Arrow")

	onToggle = var_1_10002

	local var_6_17 = arg_6_0
	local var_6_18 = var_6_16

	local function var_6_19(arg_13_0)
		arg_6_0.hideCraft = not arg_13_0

		local var_13_0 = arg_6_0

		var_1.UpdateCraftCount(var_13_0)

		return
	end

	SFX_PANEL = var_1_10007
	SFX_PANEL = var_1_10008

	var_1_10002(var_6_17, var_6_18, var_6_19, var_1_10007, var_1_10008)

	local var_6_20 = arg_6_0.equipmentView
	local var_6_21 = var_2.Find(var_6_20, "Viewport/Content/StoreHouse/Banner/Arrow")

	onToggle = var_6_15

	local var_6_22 = arg_6_0
	local var_6_23 = var_6_21

	local function var_6_24(arg_14_0)
		arg_6_0.hideSpweapon = not arg_14_0

		local var_14_0 = arg_6_0

		var_1.updateEquipmentCount(var_14_0)

		return
	end

	SFX_PANEL = var_1_10008
	SFX_PANEL = var_1_10009

	var_6_15(var_6_22, var_6_23, var_6_24, var_1_10008, var_1_10009)

	arg_6_0.equipmetItems = {}
	arg_6_0.craftItems = {}

	arg_6_0:initEquipments()

	local var_6_25

	if not arg_6_0.contextData.asc then
		var_6_25 = false
	end

	arg_6_0.asc = var_6_25

	local var_6_26 = arg_6_0.contextData
	local var_6_27

	if not arg_6_0.contextData.sortData then
		var_6_27 = var_0_2.sort[1]
	end

	var_6_26.sortData = var_6_27

	local var_6_28 = arg_6_0.contextData
	local var_6_29

	if not arg_6_0.contextData.indexDatas then
		var_6_29 = {}
	end

	var_6_28.indexDatas = var_6_29

	arg_6_0:initSort()

	onToggle = var_3

	local var_6_30 = arg_6_0
	local var_6_31 = arg_6_0.filterBusyToggle

	local function var_6_32(arg_15_0)
		local var_15_0 = arg_6_0

		var_1.SetShowBusyFlag(var_15_0, arg_15_0)

		local var_15_1 = arg_6_0

		var_1.filterEquipment(var_15_1)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_6_30, var_6_31, var_6_32, var_1_10008)

	triggerToggle = var_3

	var_3(arg_6_0.filterBusyToggle, arg_6_0.shipVO)
	arg_6_0:OverlayPanel(arg_6_0.blurPanel)
	arg_6_0:OverlayPanel(arg_6_0.topItems)

	local var_6_33

	if not arg_6_0.contextData.mode then
		StoreHouseConst = var_6_33
		var_6_33 = var_6_33.OVERVIEW
	end

	arg_6_0.contextData.mode = var_6_33

	arg_6_0:updateCapacity()

	setActive = var_4

	var_4(arg_6_0.tip, false)

	setActive = var_4

	var_4(arg_6_0.capacityTF.parent, true)

	setActive = var_4

	var_4(arg_6_0.filterBusyToggle, true)

	setActive = var_4

	var_4(arg_6_0.indexBtn, true)

	setActive = var_4

	var_4(arg_6_0.sortBtn, false)

	triggerToggle = var_4

	var_4(var_6_16, true)

	triggerToggle = var_4

	var_4(var_6_21, true)

	return
end

function var_0_1.isDefaultStatus(arg_16_0)
	if arg_16_0.contextData.indexDatas.typeIndex then
		local var_16_0 = arg_16_0.contextData.indexDatas.typeIndex

		IndexConst = var_1_10002

		if var_16_0 == var_1_10002.SpWeaponTypeAll then
			local var_16_2

			if arg_16_0.contextData.indexDatas.rarityIndex then
				local var_16_1 = arg_16_0.contextData.indexDatas.rarityIndex

				IndexConst = var_1_10002

				if var_16_1 ~= var_1_10002.SpWeaponRarityAll then
					var_16_2 = false

					goto label_16_0
				end
			end

			var_16_2 = true

			::label_16_0::

			return var_16_2
		end
	end
end

function var_0_1.onBackPressed(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.CriMgr.GetInstance()
	local var_17_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_17_1(var_17_0, var_1_10004)

	isActive = var_17_1

	if var_17_1(arg_17_0.sortPanel) then
		triggerButton = var_1

		var_1(arg_17_0.sortPanel)
	else
		triggerButton = var_1

		var_1(arg_17_0.backBtn)
	end

	return
end

function var_0_1.updateCapacity(arg_18_0)
	setText = var_1_10001

	var_1_10001(arg_18_0.tip, "")

	getProxy = var_1_10001
	EquipmentProxy = var_3

	local var_18_0 = var_1_10001(var_3)
	local var_18_1 = var_1.GetSpWeaponCount(var_18_0)

	getProxy = var_1_10002
	EquipmentProxy = var_4

	local var_18_2 = var_1_10002(var_4)
	local var_18_3 = var_2.GetSpWeaponCapacity(var_18_2)

	setText = var_18_0

	var_18_0(arg_18_0.capacityTF, var_18_1 .. "/" .. var_18_3)

	return
end

function var_0_1.setShip(arg_19_0, arg_19_1)
	arg_19_0.shipVO = arg_19_1

	return
end

function var_0_1.setPlayer(arg_20_0, arg_20_1)
	arg_20_0.player = arg_20_1

	return
end

function var_0_1.initSort(arg_21_0)
	onButton = var_1_10001

	var_1_10001(arg_21_0, arg_21_0.decBtn, function()
		arg_21_0.asc = not arg_21_0.asc
		arg_21_0.contextData.asc = arg_21_0.asc

		local var_22_0 = arg_21_0

		var_0.filterEquipment(var_22_0)

		return
	end)

	arg_21_0.sortButtons = {}
	eachChild = var_1

	var_1(arg_21_0.sortContain, function(arg_23_0)
		setActive = var_2_10001

		var_2_10001(arg_23_0, false)

		return
	end)

	ipairs = var_1

	for iter_21_0, iter_21_1 in var_1(var_0_2.sort) do
		if iter_21_0 <= arg_21_0.sortContain.childCount then
			local var_21_0 = arg_21_0.sortContain
			local var_21_1

			if not var_21_1.GetChild(var_21_0, iter_21_0 - 1) then
				cloneTplTo = var_21_1
				var_21_1 = var_21_1(arg_21_0.sortTpl, arg_21_0.sortContain)
			end

			setActive = var_1_10007

			var_1_10007(var_21_1, true)

			setImageSprite = var_1_10007
			findTF = var_9

			local var_21_2 = var_9(var_21_1, "Image")

			GetSpriteFromAtlas = var_10

			var_1_10007(var_21_2, var_10("ui/equipmentui_atlas", iter_21_1.spr), true)

			onToggle = var_1_10007

			local var_21_3 = arg_21_0
			local var_21_4 = var_21_1

			local function var_21_5(arg_24_0)
				if arg_24_0 then
					arg_21_0.contextData.sortData = iter_21_1

					local var_24_0 = arg_21_0

					var_1.filterEquipment(var_24_0)

					triggerToggle = var_1

					var_1(arg_21_0.sortBtn, false)
				end

				return
			end

			SFX_PANEL = var_12

			var_1_10007(var_21_3, var_21_4, var_21_5, var_12)

			var_1_10007 = arg_21_0.sortButtons
			var_1_10007[iter_21_0] = var_21_1
		end
	end

	return
end

function var_0_1.initEquipments(arg_25_0)
	UIItemList = var_1_10001

	local var_25_0 = var_1_10001.New
	local var_25_1 = arg_25_0.equipmentsGrid
	local var_25_2 = arg_25_0.equipmentView

	arg_25_0.equipmentRect = var_25_0(var_25_1, var_4.Find(var_25_2, "Template"))

	local var_25_3 = arg_25_0.equipmentRect

	var_1.make(var_25_3, function(arg_26_0, arg_26_1, arg_26_2)
		go = var_2_10003

		local var_26_0 = var_2_10003(arg_26_2)

		UIItemList = var_2_10004

		if arg_26_0 == var_2_10004.EventInit then
			local var_26_1 = arg_25_0

			var_4.InitSpWeapon(var_26_1, var_26_0)
		else
			UIItemList = var_4

			if arg_26_0 == var_4.EventUpdate then
				local var_26_2 = arg_25_0

				var_4.UpdateSpWeapon(var_26_2, arg_26_1, var_26_0)
			else
				UIItemList = var_4

				if arg_26_0 == var_4.EventExcess then
					local var_26_3 = arg_25_0

					var_4.ReturnSpWeapon(var_26_3, arg_26_1, var_26_0)
				end
			end
		end

		return
	end)

	UIItemList = var_1

	local var_25_4 = var_1.New
	local var_25_5 = arg_25_0.craftsGrid
	local var_25_6 = arg_25_0.equipmentView

	arg_25_0.craftRect = var_25_4(var_25_5, var_4.Find(var_25_6, "Template"))

	local var_25_7 = arg_25_0.craftRect

	var_1.make(var_25_7, function(arg_27_0, arg_27_1, arg_27_2)
		go = var_2_10003

		local var_27_0 = var_2_10003(arg_27_2)

		UIItemList = var_2_10004

		if arg_27_0 == var_2_10004.EventInit then
			local var_27_1 = arg_25_0

			var_4.InitCraftItem(var_27_1, var_27_0)
		else
			UIItemList = var_4

			if arg_27_0 == var_4.EventUpdate then
				local var_27_2 = arg_25_0

				var_4.UpdateCraftItem(var_27_2, arg_27_1, var_27_0)
			else
				UIItemList = var_4

				if arg_27_0 == var_4.EventExcess then
					local var_27_3 = arg_25_0

					var_4.ReturnCraftItem(var_27_3, arg_27_1, var_27_0)
				end
			end
		end

		return
	end)

	return
end

function var_0_1.InitSpWeapon(arg_28_0, arg_28_1)
	SpWeaponItemView = var_1_10002

	local var_28_0 = var_1_10002.New(arg_28_1)

	onButton = var_1_10003

	local var_28_1 = arg_28_0
	local var_28_2 = var_28_0.unloadBtn

	local function var_28_3()
		local var_29_0 = arg_28_0
		local var_29_1 = var_0.emit

		SpWeaponStoreHouseMediator = var_2_10003

		var_29_1(var_29_0, var_2_10003.ON_UNEQUIP)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_28_1, var_28_2, var_28_3, var_1_10008)

	arg_28_0.equipmetItems[arg_28_1] = var_28_0

	return
end

function var_0_1.UpdateSpWeapon(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.equipmetItems[arg_30_2]

	assert = var_1_10004

	var_1_10004(var_30_0, "without init item")

	local var_30_1 = arg_30_0.loadEquipmentVOs[arg_30_1 + 1]

	var_30_0:update(var_30_1)

	if not var_30_1 or var_30_1.mask then
		removeOnButton = var_5

		var_5(var_30_0.go)
	else
		onButton = var_5

		local var_30_2 = arg_30_0
		local var_30_3 = var_30_0.go

		local function var_30_4()
			if arg_30_0.shipVO then
				local var_31_0 = {}

				EquipmentInfoMediator = var_2_10001
				var_31_0.type = var_2_10001.TYPE_REPLACE
				var_31_0.shipId = arg_30_0.contextData.shipId

				local var_31_1 = var_30_1

				var_31_0.oldSpWeaponUid = var_2_10001.GetUID(var_31_1)

				local var_31_2 = var_30_1

				var_31_0.oldShipId = var_2_10001.GetShipId(var_31_2)

				if not var_31_0 then
					local var_31_3 = var_30_1

					if var_31_0.GetShipId(var_31_3) then
						var_31_0 = {}
						EquipmentInfoMediator = var_2_10001
						var_31_0.type = var_2_10001.TYPE_DISPLAY

						local var_31_4 = var_30_1

						var_31_0.spWeaponUid = var_2_10001.GetUID(var_31_4)

						local var_31_5 = var_30_1

						var_31_0.shipId = var_2_10001.GetShipId(var_31_5)

						if not var_31_0 then
							var_31_0 = {}
							EquipmentInfoMediator = var_2_10001
							var_31_0.type = var_2_10001.TYPE_DEFAULT

							local var_31_6 = var_30_1

							var_31_0.spWeaponUid = var_1.GetUID(var_31_6)
						end

						local var_31_7 = arg_30_0

						var_1.emit(var_31_7, var_0_1.ON_SPWEAPON, var_31_0)

						return
					end
				end
			end
		end

		SFX_PANEL = var_1_10010

		var_5(var_30_2, var_30_3, var_30_4, var_1_10010)
	end

	return
end

function var_0_1.ReturnSpWeapon(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.exited then
		return
	end

	if arg_32_0.equipmetItems[arg_32_2] then
		removeOnButton = var_1_10004

		var_1_10004(var_3.go)
		var_3:clear()
	end

	return
end

function var_0_1.updateEquipmentCount(arg_33_0)
	local var_33_0 = arg_33_0.hideSpweapon and 0 or #arg_33_0.loadEquipmentVOs
	local var_33_1 = arg_33_0.equipmentRect

	var_2.align(var_33_1, var_33_0)

	local var_33_2 = arg_33_0.equipmentsGrid
	local var_33_3 = var_2.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10007

	local var_33_4 = var_33_3(var_33_2, var_5(var_1_10007)).padding

	if var_33_0 then
		var_33_4.top = 31
		var_33_4.bottom = 25
	else
		var_33_4.top = 0
		var_33_4.bottom = 0
	end

	var_2.padding = var_33_4

	return
end

function var_0_1.filterEquipment(arg_34_0)
	local var_34_0 = arg_34_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on"

	GetSpriteFromAtlasAsync = var_1_10002

	var_1_10002("ui/share/index_atlas", var_34_0, function(arg_35_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_34_0.indexBtn, arg_35_0, true)

		return
	end)

	local var_34_1 = arg_34_0.contextData.sortData

	;(function()
		arg_34_0.loadEquipmentVOs = {}

		local var_36_0 = {}

		pairs = var_1

		for iter_36_0, iter_36_1 in var_1(arg_34_0.equipmentVOs) do
			table = var_2_10006

			var_2_10006.insert(var_36_0, iter_36_1)
		end

		pairs = var_1

		for iter_36_2, iter_36_3 in var_1(var_36_0) do
			local var_36_1 = arg_34_0

			if var_6.checkFitBusyCondition(var_36_1, iter_36_3) then
				IndexConst = var_6

				if var_6.filterSpWeaponByType(iter_36_3, arg_34_0.contextData.indexDatas.typeIndex) then
					IndexConst = var_6

					if var_6.filterSpWeaponByRarity(iter_36_3, arg_34_0.contextData.indexDatas.rarityIndex) and (arg_34_0.filterImportance == nil or iter_36_3:IsImportant()) then
						table = var_6

						var_6.insert(arg_34_0.loadEquipmentVOs, iter_36_3)
					end
				end
			end
		end

		if var_34_1 then
			local var_36_2 = arg_34_0.asc

			table = var_2

			local var_36_3 = var_2.sort
			local var_36_4 = arg_34_0.loadEquipmentVOs

			CompareFuncs = iter_36_3

			var_36_3(var_36_4, iter_36_3(var_0_2.sortFunc(var_34_1, var_36_2)))
		end

		if arg_34_0.contextData.qiutBtn then
			table = var_1

			var_1.insert(arg_34_0.loadEquipmentVOs, 1, false)
		end

		return
	end)()
	arg_34_0:updateEquipmentCount()
	;(function()
		arg_34_0.showCraftList = {}

		local var_37_0 = {}

		pairs = var_1

		for iter_37_0, iter_37_1 in var_1(arg_34_0.craftList) do
			table = var_2_10006

			var_2_10006.insert(var_37_0, iter_37_1)
		end

		pairs = var_1

		for iter_37_2, iter_37_3 in var_1(var_37_0) do
			local var_37_1 = arg_34_0

			if var_6.checkFitBusyCondition(var_37_1, iter_37_3) then
				IndexConst = var_6

				if var_6.filterSpWeaponByType(iter_37_3, arg_34_0.contextData.indexDatas.typeIndex) then
					IndexConst = var_6

					if var_6.filterSpWeaponByRarity(iter_37_3, arg_34_0.contextData.indexDatas.rarityIndex) and (arg_34_0.filterImportance == nil or iter_37_3:IsImportant()) then
						table = var_6

						var_6.insert(arg_34_0.showCraftList, iter_37_3)
					end
				end
			end
		end

		if var_34_1 then
			local var_37_2 = arg_34_0.asc

			table = var_2

			local var_37_3 = var_2.sort
			local var_37_4 = arg_34_0.showCraftList

			CompareFuncs = iter_37_3

			var_37_3(var_37_4, iter_37_3(var_0_2.sortFunc(var_34_1, var_37_2)))
		end

		return
	end)()
	arg_34_0:UpdateCraftCount()

	setImageSprite = var_5

	local var_34_2 = arg_34_0.sortBtn
	local var_34_3 = var_7.Find(var_34_2, "Image")

	GetSpriteFromAtlas = var_1_10008

	var_5(var_34_3, var_1_10008("ui/equipmentui_atlas", var_34_1.spr), true)

	setActive = var_5

	var_5(arg_34_0.sortImgAsc, arg_34_0.asc)

	setActive = var_5

	var_5(arg_34_0.sortImgDec, not arg_34_0.asc)

	return
end

function var_0_1.InitCraftItem(arg_38_0, arg_38_1)
	SpWeaponItemView = var_1_10002

	local var_38_0 = var_1_10002.New(arg_38_1)

	arg_38_0.craftItems[arg_38_1] = var_38_0

	return
end

function var_0_1.UpdateCraftItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0.craftItems[arg_39_2]

	assert = var_1_10004

	var_1_10004(var_39_0, "without init item")

	local var_39_1 = arg_39_0.showCraftList[arg_39_1 + 1]

	var_39_0:update(var_39_1)

	onButton = var_5

	local var_39_2 = arg_39_0
	local var_39_3 = var_39_0.go

	local function var_39_4()
		local var_40_0 = arg_39_0
		local var_40_1 = var_0.emit

		SpWeaponStoreHouseMediator = var_2_10003

		local var_40_2 = var_2_10003.ON_COMPOSITE
		local var_40_3 = var_39_1

		var_40_1(var_40_0, var_40_2, var_4.GetConfigID(var_40_3))

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_39_2, var_39_3, var_39_4, var_1_10010)

	return
end

function var_0_1.ReturnCraftItem(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0.craftItems[arg_41_2] then
		removeOnButton = var_1_10004

		var_1_10004(var_3.go)
		var_3:clear()
	end

	return
end

function var_0_1.UpdateCraftCount(arg_42_0)
	local var_42_0 = arg_42_0.hideCraft and 0 or #arg_42_0.showCraftList
	local var_42_1 = arg_42_0.craftRect

	var_2.align(var_42_1, var_42_0)

	local var_42_2 = arg_42_0.craftsGrid
	local var_42_3 = var_2.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10007

	local var_42_4 = var_42_3(var_42_2, var_5(var_1_10007)).padding

	if var_42_0 > 0 then
		var_42_4.top = 31
		var_42_4.bottom = 25
	else
		var_42_4.top = 0
		var_42_4.bottom = 0
	end

	var_2.padding = var_42_4

	return
end

function var_0_1.GetShowBusyFlag(arg_43_0)
	return arg_43_0.isEquipingOn
end

function var_0_1.SetShowBusyFlag(arg_44_0, arg_44_1)
	arg_44_0.isEquipingOn = arg_44_1

	return
end

function var_0_1.checkFitBusyCondition(arg_45_0, arg_45_1)
	local var_45_0

	if not arg_45_0:GetShowBusyFlag() then
		var_45_0 = not arg_45_1:GetShipId()
	end

	return var_45_0
end

function var_0_1.willExit(arg_46_0)
	arg_46_0:UnOverlayPanel(arg_46_0.blurPanel, arg_46_0._tf)
	arg_46_0:UnOverlayPanel(arg_46_0.topItems, arg_46_0._tf)

	return
end

return var_0_1
