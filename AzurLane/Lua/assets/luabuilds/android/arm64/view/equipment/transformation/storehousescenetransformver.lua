class = var_0_10000

local var_0_0 = "StoreHouseSceneTransformVer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

require = var_0_10001

local var_0_2 = var_0_10001("view.equipment.EquipmentSortCfg")
local var_0_3 = 0

function var_0_1.getUIName(arg_1_0)
	return "StoreHouseUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0.contextData
	local var_2_1 = arg_2_0._tf

	arg_2_0.topItems = var_2.Find(var_2_1, "topItems")

	local var_2_2 = arg_2_0._tf

	arg_2_0.equipmentView = var_2.Find(var_2_2, "adapt/equipment_scrollview")

	local var_2_3 = arg_2_0._tf

	arg_2_0.blurPanel = var_2.Find(var_2_3, "blur_panel")

	local var_2_4 = arg_2_0.blurPanel

	arg_2_0.topPanel = var_2.Find(var_2_4, "adapt/top")
	setActive = var_2

	local var_2_5 = arg_2_0.topPanel

	var_2(var_4.Find(var_2_5, "buttons"), true)

	local var_2_6 = arg_2_0.topPanel

	arg_2_0.indexBtn = var_2.Find(var_2_6, "buttons/index_button")

	local var_2_7 = arg_2_0.topPanel

	arg_2_0.sortBtn = var_2.Find(var_2_7, "buttons/sort_button")

	local var_2_8 = arg_2_0.topItems

	arg_2_0.sortPanel = var_2.Find(var_2_8, "sort")

	local var_2_9 = arg_2_0.sortPanel

	arg_2_0.sortContain = var_2.Find(var_2_9, "adapt/mask/panel")

	local var_2_10 = arg_2_0.sortContain

	arg_2_0.sortTpl = var_2.Find(var_2_10, "tpl")
	setActive = var_2

	var_2(arg_2_0.sortTpl, false)

	local var_2_11 = arg_2_0.topPanel

	arg_2_0.equipSkinFilteBtn = var_2.Find(var_2_11, "buttons/EquipSkinFilteBtn")

	local var_2_12

	getProxy = var_1_10003
	SettingsProxy = var_5

	local var_2_13 = var_1_10003(var_5)

	NotchAdapt = var_2_11

	if var_2_11.CheckNotchRatio == 2 or not var_2_13:CheckLargeScreen() then
		var_2_12 = arg_2_0.equipmentView.rect.width > 2000
	else
		NotchAdapt = var_4
		var_2_12 = var_4.CheckNotchRatio >= 2
	end

	local var_2_14 = arg_2_0.equipmentView
	local var_2_15 = var_4.Find(var_2_14, "equipment_grid")
	local var_2_16 = var_4.GetComponent

	typeof = var_7
	GridLayoutGroup = var_1_10009
	var_2_16(var_2_15, var_7(var_1_10009)).constraintCount = var_2_12 and 8 or 7
	findTF = var_5
	arg_2_0.decBtn = var_5(arg_2_0.topPanel, "buttons/dec_btn")
	findTF = var_5
	arg_2_0.sortImgAsc = var_5(arg_2_0.decBtn, "asc")
	findTF = var_5
	arg_2_0.sortImgDec = var_5(arg_2_0.decBtn, "desc")

	local var_2_17 = arg_2_0._tf

	arg_2_0.equipmentBtn = var_5.Find(var_2_17, "blur_panel/adapt/left_length/frame/toggle_root/equipment")

	local var_2_18 = arg_2_0._tf

	arg_2_0.equipmentSkinBtn = var_5.Find(var_2_18, "blur_panel/adapt/left_length/frame/toggle_root/skin")
	setActive = var_5

	var_5(arg_2_0.equipmentBtn.parent, false)

	local var_2_19 = arg_2_0._tf

	arg_2_0.filterBusyToggle = var_5.Find(var_2_19, "blur_panel/adapt/left_length/frame/toggle_equip")
	setActive = var_5

	var_5(arg_2_0.filterBusyToggle, false)

	local var_2_20 = arg_2_0.topItems

	arg_2_0.bottomBack = var_5.Find(var_2_20, "adapt/bottom_back")

	local var_2_21 = arg_2_0.bottomBack

	arg_2_0.bottomPanel = var_5.Find(var_2_21, "types")

	local var_2_22 = arg_2_0.bottomPanel

	arg_2_0.materialToggle = var_5.Find(var_2_22, "material")

	local var_2_23 = arg_2_0.bottomPanel

	arg_2_0.weaponToggle = var_5.Find(var_2_23, "weapon")

	local var_2_24 = arg_2_0.bottomPanel

	arg_2_0.designToggle = var_5.Find(var_2_24, "design")

	local var_2_25 = arg_2_0.bottomBack

	arg_2_0.capacityTF = var_5.Find(var_2_25, "bottom_left/tip/capcity/Text")
	setActive = var_5

	var_5(arg_2_0.capacityTF.parent, false)

	local var_2_26 = arg_2_0.bottomBack

	arg_2_0.tipTF = var_5.Find(var_2_26, "bottom_left/tip")

	local var_2_27 = arg_2_0.tipTF

	arg_2_0.tip = var_5.Find(var_2_27, "label")
	setActive = var_5

	var_5(arg_2_0.tip, false)

	local var_2_28 = arg_2_0.topItems

	arg_2_0.helpBtn = var_5.Find(var_2_28, "adapt/help_btn")
	setActive = var_5

	var_5(arg_2_0.helpBtn, true)

	local var_2_29 = arg_2_0._tf

	arg_2_0.backBtn = var_5.Find(var_2_29, "blur_panel/adapt/top/back_btn")
	defaultValue = var_5
	arg_2_0.selectedMin = var_5(var_2_0.selectedMin, 1)
	defaultValue = var_5

	local var_2_30 = var_2_0.selectedMax

	pg = var_8

	local var_2_31

	if not var_8.gameset.equip_select_limit.key_value then
		var_2_31 = 0
	end

	arg_2_0.selectedMax = var_5(var_2_30, var_2_31)
	Clone = var_5

	local var_2_32

	if not var_2_0.selectedIds then
		var_2_32 = {}
	end

	arg_2_0.selectedIds = var_5(var_2_32)

	local var_2_33

	if not var_2_0.onEquipment then
		function var_2_33(arg_3_0)
			return true
		end
	end

	arg_2_0.checkEquipment = var_2_33

	local var_2_34

	if not var_2_0.onSelected then
		function var_2_34()
			warning = var_2_10000

			var_2_10000("not implemented.")

			return
		end
	end

	arg_2_0.onSelected = var_2_34
	setActive = var_2_34

	local var_2_35 = arg_2_0.bottomBack

	var_2_34(var_7.Find(var_2_35, "dispos"), false)

	setActive = var_2_34

	local var_2_36 = arg_2_0.topItems

	var_2_34(var_7.Find(var_2_36, "adapt/select_panel"), false)

	local var_2_37 = arg_2_0.topItems

	arg_2_0.selectTransformPanel = var_5.Find(var_2_37, "adapt/select_transform_panel")

	local var_2_38 = arg_2_0._tf

	arg_2_0.listEmptyTF = var_5.Find(var_2_38, "adapt/empty")
	setActive = var_5

	var_5(arg_2_0.listEmptyTF, false)

	local var_2_39 = arg_2_0.listEmptyTF

	arg_2_0.listEmptyTxt = var_5.Find(var_2_39, "Text")
	setActive = var_5

	var_5(arg_2_0.bottomBack, false)

	setActive = var_5

	var_5(arg_2_0.selectTransformPanel, true)

	setActive = var_5

	var_5(arg_2_0.indexBtn, false)

	setActive = var_5

	var_5(arg_2_0.sortBtn, false)

	setActive = var_5

	var_5(arg_2_0.equipSkinFilteBtn, false)

	setActive = var_5

	var_5(arg_2_0.equipmentSkinBtn, false)

	setText = var_5

	local var_2_40 = arg_2_0.selectTransformPanel
	local var_2_41 = var_7.Find(var_2_40, "cancel_button/Image")

	i18n = var_8

	var_5(var_2_41, var_8("msgbox_text_cancel"))

	setText = var_5

	local var_2_42 = arg_2_0.selectTransformPanel
	local var_2_43 = var_7.Find(var_2_42, "confirm_button/Image")

	i18n = var_8

	var_5(var_2_43, var_8("msgbox_text_confirm"))

	return
end

function var_0_1.setSources(arg_5_0, arg_5_1)
	arg_5_0.sourceVOs = arg_5_1

	return
end

function var_0_1.OnMediatorRegister(arg_6_0)
	local var_6_0

	if not arg_6_0.contextData.warp then
		StoreHouseConst = var_6_0
		var_6_0 = var_6_0.WARP_TO_WEAPON
	end

	arg_6_0.warp = var_6_0

	local var_6_1

	if not arg_6_0.contextData.mode then
		StoreHouseConst = var_6_1
		var_6_1 = var_6_1.OVERVIEW
	end

	arg_6_0.mode = var_6_1
	arg_6_0.page = var_0_3

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.backBtn

	local function var_7_2()
		GetOrAddComponent = var_2_10000

		local var_8_0 = arg_7_0._tf

		typeof = var_2_10003
		CanvasGroup = var_2_10005
		var_2_10000(var_8_0, var_2_10003(var_2_10005)).interactable = false

		local var_8_1 = arg_7_0

		var_1.emit(var_8_1, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	arg_7_0.equipmetItems = {}

	arg_7_0:initEquipments()

	local var_7_3

	if not arg_7_0.contextData.asc then
		var_7_3 = false
	end

	arg_7_0.asc = var_7_3

	if not arg_7_0.contextData.sortData then
		arg_7_0.contextData.sortData = var_0_2.sort[1]
	end

	local var_7_4 = arg_7_0.contextData
	local var_7_5

	if not arg_7_0.contextData.indexDatas then
		var_7_5 = {}
	end

	var_7_4.indexDatas = var_7_5

	arg_7_0:initSort()

	setActive = var_1

	var_1(arg_7_0.equipmentView, true)
	arg_7_0:filterEquipment()

	arg_7_0.equipmentRect.isStart = true

	local var_7_6 = arg_7_0.equipmentRect

	var_1.EndLayout(var_7_6)
	arg_7_0:OverlayPanel(arg_7_0.blurPanel)
	arg_7_0:OverlayPanel(arg_7_0.topItems)

	setActive = var_1

	var_1(arg_7_0.sortImgAsc, arg_7_0.asc)

	setActive = var_1

	var_1(arg_7_0.sortImgDec, not arg_7_0.asc)

	if arg_7_0.contextData.equipScrollPos then
		arg_7_0:ScrollEquipPos(arg_7_0.contextData.equipScrollPos.y)
	end

	onButton = var_1

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_0.helpBtn

	local function var_7_9()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_9_2.type = var_2_10004
		pg = var_2_10004
		var_9_2.helps = var_2_10004.gametip.help_equipment.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_7, var_7_8, var_7_9, var_1_10006)

	onButton = var_1

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0.selectTransformPanel
	local var_7_12 = var_4.Find(var_7_11, "cancel_button")

	local function var_7_13()
		local var_10_0 = arg_7_0

		var_0.emit(var_10_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_7_11

	var_1(var_7_10, var_7_12, var_7_13, var_7_11)

	onButton = var_1

	local var_7_14 = arg_7_0
	local var_7_15 = arg_7_0.selectTransformPanel
	local var_7_16 = var_4.Find(var_7_15, "confirm_button")

	local function var_7_17()
		_ = var_2_10000

		local var_11_0 = var_2_10000.map(arg_7_0.selectedIds, function(arg_12_0)
			return arg_12_0[1]
		end)

		if arg_7_0.contextData.onConfirm(var_11_0) then
			local var_11_1 = arg_7_0

			var_1.closeView(var_11_1)
		end

		return
	end

	SFX_PANEL = var_7_15

	var_1(var_7_14, var_7_16, var_7_17, var_7_15)

	return
end

function var_0_1.onBackPressed(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.CriMgr.GetInstance()
	local var_13_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_13_1(var_13_0, var_1_10004)

	isActive = var_13_1

	if var_13_1(arg_13_0.sortPanel) then
		triggerButton = var_1

		var_1(arg_13_0.sortPanel)

		return
	end

	triggerButton = var_1

	var_1(arg_13_0.backBtn)

	return
end

function var_0_1.initSort(arg_14_0)
	onButton = var_1_10001

	var_1_10001(arg_14_0, arg_14_0.decBtn, function()
		arg_14_0.asc = not arg_14_0.asc
		arg_14_0.contextData.asc = arg_14_0.asc

		local var_15_0 = arg_14_0

		var_0.filterEquipment(var_15_0)

		return
	end)

	return
end

function var_0_1.initEquipments(arg_16_0)
	arg_16_0.isInitWeapons = true

	local var_16_0 = arg_16_0.equipmentView

	arg_16_0.equipmentRect = var_1.GetComponent(var_16_0, "LScrollRect")

	function arg_16_0.equipmentRect.onInitItem(arg_17_0)
		local var_17_0 = arg_16_0

		var_1.initEquipment(var_17_0, arg_17_0)

		return
	end

	arg_16_0.equipmentRect.decelerationRate = 0.07

	function arg_16_0.equipmentRect.onUpdateItem(arg_18_0, arg_18_1)
		local var_18_0 = arg_16_0

		var_2.updateEquipment(var_18_0, arg_18_0, arg_18_1)

		return
	end

	function arg_16_0.equipmentRect.onStart()
		local var_19_0 = arg_16_0

		var_0.updateSelected(var_19_0)

		return
	end

	local var_16_1 = arg_16_0.equipmentRect

	var_1.ScrollTo(var_16_1, 0)

	return
end

function var_0_1.updateEquipmentCount(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.equipmentRect

	var_2.SetTotalCount(var_20_0, arg_20_1 or #arg_20_0.loadEquipmentVOs, -1)

	setActive = var_2

	var_2(arg_20_0.listEmptyTF, (arg_20_1 or #arg_20_0.loadEquipmentVOs) <= 0)

	setText = var_2

	local var_20_1 = arg_20_0.listEmptyTxt

	i18n = var_5

	var_2(var_20_1, var_5("list_empty_tip_storehouseui_equip"))

	Canvas = var_2

	var_2.ForceUpdateCanvases()

	return
end

function var_0_1.ScrollEquipPos(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.equipmentView
	local var_21_1 = var_2.Find(var_21_0, "equipment_grid")
	local var_21_2 = var_2.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10007

	local var_21_3 = var_21_2(var_21_1, var_5(var_1_10007)).cellSize.y + var_2.spacing.y

	math = var_4

	local var_21_4 = var_21_3 * var_4.ceil(#arg_21_0.loadEquipmentVOs / var_2.constraintCount) - var_2.spacing.y + arg_21_0.equipmentRect.paddingFront + arg_21_0.equipmentRect.paddingEnd - arg_21_0.equipmentView.rect.height > 0 and var_21_4 or var_4
	local var_21_5 = (arg_21_1 - arg_21_0.equipmentView.rect.height * 0.5) / var_21_4
	local var_21_6 = arg_21_0.equipmentRect

	var_7.ScrollTo(var_21_6, var_21_5)

	return
end

function var_0_1.onUIAnimEnd(arg_22_0, arg_22_1)
	arg_22_0.onAnimDoneCallback = arg_22_1

	return
end

function var_0_1.ExecuteAnimDoneCallback(arg_23_0)
	if arg_23_0.onAnimDoneCallback then
		arg_23_0.onAnimDoneCallback()

		arg_23_0.onAnimDoneCallback = nil
	end

	return
end

function var_0_1.selectCount(arg_24_0)
	local var_24_0 = 0

	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.selectedIds) do
		var_24_0 = var_24_0 + iter_24_1[2]
	end

	return var_24_0
end

function var_0_1.SelectTransformEquip(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = false

	if arg_25_0.selectedIds[1] then
		EquipmentTransformUtil = var_4

		if var_4.SameDrop(arg_25_0.selectedIds[1][1], arg_25_1) then
			var_25_0 = true
		end
	end

	if not var_25_0 then
		if arg_25_0.contextData.onSelect and not arg_25_0.contextData.onSelect(arg_25_1) then
			return
		end

		table = var_4

		var_4.clean(arg_25_0.selectedIds)

		table = var_4

		var_4.insert(arg_25_0.selectedIds, {
			arg_25_1,
			1
		})
	else
		table = var_4

		var_4.clean(arg_25_0.selectedIds)
	end

	arg_25_0:updateSelected()

	return
end

function var_0_1.initEquipment(arg_26_0, arg_26_1)
	EquipmentItemTransformVer = var_1_10002

	local var_26_0 = var_1_10002.New(arg_26_1)

	onButton = var_1_10003

	local var_26_1 = arg_26_0
	local var_26_2 = var_26_0.go

	local function var_26_3()
		if var_26_0.sourceVO == nil then
			return
		end

		local var_27_0 = arg_26_0

		var_0.SelectTransformEquip(var_27_0, var_26_0.sourceVO, var_26_0.sourceVO.count)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_26_1, var_26_2, var_26_3, var_1_10008)

	arg_26_0.equipmetItems[arg_26_1] = var_26_0

	return
end

function var_0_1.updateEquipment(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	if not arg_28_0.equipmetItems[arg_28_2] then
		arg_28_0:initEquipment(arg_28_2)

		var_28_0 = arg_28_0.equipmetItems[arg_28_2]
	end

	local var_28_1 = arg_28_0.loadEquipmentVOs[arg_28_1 + 1]
	local var_28_2 = var_28_0

	var_28_0.update(var_28_2, var_28_1)

	local var_28_3 = false
	local var_28_4 = 0

	if var_28_1 then
		ipairs = var_28_2

		for iter_28_0, iter_28_1 in var_28_2(arg_28_0.selectedIds) do
			EquipmentTransformUtil = var_1_10012

			if var_1_10012.SameDrop(var_28_1, iter_28_1[1]) then
				var_28_3 = true
				var_28_4 = iter_28_1[2]

				break
			end
		end
	end

	var_28_0:updateSelected(var_28_3, var_28_4)

	return
end

function var_0_1.updateSelected(arg_29_0)
	pairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.equipmetItems) do
		if iter_29_1.sourceVO then
			local var_29_0 = false
			local var_29_1 = 0

			pairs = var_1_10008

			for iter_29_2, iter_29_3 in var_1_10008(arg_29_0.selectedIds) do
				EquipmentTransformUtil = var_1_10013

				if var_1_10013.SameDrop(iter_29_1.sourceVO, iter_29_3[1]) then
					var_29_0 = true
					var_29_1 = iter_29_3[2]

					break
				end
			end

			iter_29_1:updateSelected(var_29_0, var_29_1)
		end
	end

	return
end

function var_0_1.filterEquipment(arg_30_0)
	local var_30_0 = arg_30_0.contextData.sortData
	local var_30_1 = arg_30_0.sourceVOs

	arg_30_0.loadEquipmentVOs = {}
	pairs = var_3

	for iter_30_0, iter_30_1 in var_3(var_30_1) do
		var_1_10008 = iter_30_1.type
		DROP_TYPE_EQUIP = var_1_10009

		if var_1_10008 == var_1_10009 then
			var_1_10008 = iter_30_1.template.count

			if 0 < var_1_10008 then
				table = var_1_10008

				var_1_10008.insert(arg_30_0.loadEquipmentVOs, iter_30_1)
			end
		end
	end

	if var_30_0 then
		local var_30_2 = arg_30_0.asc
		local var_30_3 = {
			function(arg_31_0)
				return arg_31_0.type
			end,
			function(arg_32_0)
				local var_32_0

				if not arg_32_0.template.shipId then
					var_32_0 = -1
				end

				return var_32_0
			end
		}

		table = var_5

		local var_30_4 = var_5.mergeArray
		local var_30_5 = var_30_3

		underscore = var_1_10008

		local var_30_6 = var_30_4(var_30_5, var_1_10008.map(var_0_2.sortFunc(var_30_0, var_30_2), function(arg_33_0)
			return function(arg_34_0)
				return arg_33_0(arg_34_0.template)
			end
		end))

		table = var_5

		local var_30_7 = var_5.sort
		local var_30_8 = arg_30_0.loadEquipmentVOs

		CompareFuncs = var_8

		var_30_7(var_30_8, var_8(var_30_6))
	end

	arg_30_0:updateSelected()
	arg_30_0:updateEquipmentCount()

	setActive = var_3

	var_3(arg_30_0.sortImgAsc, arg_30_0.asc)

	setActive = var_3

	var_3(arg_30_0.sortImgDec, not arg_30_0.asc)

	return
end

function var_0_1.willExit(arg_35_0)
	arg_35_0:UnOverlayPanel(arg_35_0.blurPanel, arg_35_0._tf)
	arg_35_0:UnOverlayPanel(arg_35_0.topItems, arg_35_0._tf)

	return
end

return var_0_1
