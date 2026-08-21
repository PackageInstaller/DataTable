local var_0_0 = class("StoreHouseSceneTransformVer", import("view.base.BaseUI"))
local var_0_1 = require("view.equipment.EquipmentSortCfg")
local var_0_2 = 0

function var_0_0.getUIName(arg_1_0)
	return "StoreHouseUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.topItems = arg_2_0._tf:Find("topItems")
	arg_2_0.equipmentView = arg_2_0._tf:Find("adapt/equipment_scrollview")
	arg_2_0.blurPanel = arg_2_0._tf:Find("blur_panel")
	arg_2_0.topPanel = arg_2_0.blurPanel:Find("adapt/top")

	setActive(arg_2_0.topPanel:Find("buttons"), true)

	arg_2_0.indexBtn = arg_2_0.topPanel:Find("buttons/index_button")
	arg_2_0.sortBtn = arg_2_0.topPanel:Find("buttons/sort_button")
	arg_2_0.sortPanel = arg_2_0.topItems:Find("sort")
	arg_2_0.sortContain = arg_2_0.sortPanel:Find("adapt/mask/panel")
	arg_2_0.sortTpl = arg_2_0.sortContain:Find("tpl")

	setActive(arg_2_0.sortTpl, false)

	arg_2_0.equipSkinFilteBtn = arg_2_0.topPanel:Find("buttons/EquipSkinFilteBtn")

	local var_2_0 = (NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and arg_2_0.equipmentView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2
	local var_2_1 = arg_2_0.equipmentView:Find("equipment_grid")

	var_2_1:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_2_0 and 8 or 7
	arg_2_0.decBtn = findTF(arg_2_0.topPanel, "buttons/dec_btn")
	arg_2_0.sortImgAsc = findTF(arg_2_0.decBtn, "asc")
	arg_2_0.sortImgDec = findTF(arg_2_0.decBtn, "desc")
	arg_2_0.equipmentBtn = arg_2_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_root/equipment")
	arg_2_0.equipmentSkinBtn = arg_2_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_root/skin")

	setActive(arg_2_0.equipmentBtn.parent, false)

	arg_2_0.filterBusyToggle = arg_2_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_equip")

	setActive(arg_2_0.filterBusyToggle, false)

	arg_2_0.bottomBack = arg_2_0.topItems:Find("adapt/bottom_back")
	arg_2_0.bottomPanel = arg_2_0.bottomBack:Find("types")
	arg_2_0.materialToggle = arg_2_0.bottomPanel:Find("material")
	arg_2_0.weaponToggle = arg_2_0.bottomPanel:Find("weapon")
	arg_2_0.designToggle = arg_2_0.bottomPanel:Find("design")
	arg_2_0.capacityTF = arg_2_0.bottomBack:Find("bottom_left/tip/capcity/Text")

	setActive(arg_2_0.capacityTF.parent, false)

	arg_2_0.tipTF = arg_2_0.bottomBack:Find("bottom_left/tip")
	arg_2_0.tip = arg_2_0.tipTF:Find("label")

	setActive(arg_2_0.tip, false)

	arg_2_0.helpBtn = arg_2_0.topItems:Find("adapt/help_btn")

	setActive(arg_2_0.helpBtn, true)

	arg_2_0.backBtn = arg_2_0._tf:Find("blur_panel/adapt/top/back_btn")
	arg_2_0.selectedMin = defaultValue(arg_2_0.contextData.selectedMin, 1)

	local var_2_2 = pg.gameset.equip_select_limit.key_value or 0

	arg_2_0.selectedMax = defaultValue(arg_2_0.contextData.selectedMax, var_2_2)

	local var_2_3 = arg_2_0.contextData.selectedIds or {}

	arg_2_0.selectedIds = Clone(var_2_3)
	arg_2_0.checkEquipment = arg_2_0.contextData.onEquipment or function(arg_3_0)
		return true
	end
	arg_2_0.onSelected = arg_2_0.contextData.onSelected or function()
		warning("not implemented.")

		return
	end

	setActive(arg_2_0.bottomBack:Find("dispos"), false)
	setActive(arg_2_0.topItems:Find("adapt/select_panel"), false)

	arg_2_0.selectTransformPanel = arg_2_0.topItems:Find("adapt/select_transform_panel")
	arg_2_0.listEmptyTF = arg_2_0._tf:Find("adapt/empty")

	setActive(arg_2_0.listEmptyTF, false)

	arg_2_0.listEmptyTxt = arg_2_0.listEmptyTF:Find("Text")

	setActive(arg_2_0.bottomBack, false)
	setActive(arg_2_0.selectTransformPanel, true)
	setActive(arg_2_0.indexBtn, false)
	setActive(arg_2_0.sortBtn, false)
	setActive(arg_2_0.equipSkinFilteBtn, false)
	setActive(arg_2_0.equipmentSkinBtn, false)
	setText(arg_2_0.selectTransformPanel:Find("cancel_button/Image"), i18n("msgbox_text_cancel"))
	setText(arg_2_0.selectTransformPanel:Find("confirm_button/Image"), i18n("msgbox_text_confirm"))

	return
end

function var_0_0.setSources(arg_5_0, arg_5_1)
	arg_5_0.sourceVOs = arg_5_1

	return
end

function var_0_0.OnMediatorRegister(arg_6_0)
	arg_6_0.warp = arg_6_0.contextData.warp or StoreHouseConst.WARP_TO_WEAPON
	arg_6_0.mode = arg_6_0.contextData.mode or StoreHouseConst.OVERVIEW
	arg_6_0.page = var_0_2

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		GetOrAddComponent(arg_7_0._tf, typeof(CanvasGroup)).interactable = false

		arg_7_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)

	arg_7_0.equipmetItems = {}

	arg_7_0:initEquipments()

	arg_7_0.asc = arg_7_0.contextData.asc or false
	arg_7_0.contextData.sortData = arg_7_0.contextData.sortData or var_0_1.sort[1]

	local var_7_0 = arg_7_0.contextData

	var_7_0.indexDatas = arg_7_0.contextData.indexDatas or {}

	arg_7_0:initSort()
	setActive(arg_7_0.equipmentView, true)
	arg_7_0:filterEquipment()

	arg_7_0.equipmentRect.isStart = true

	arg_7_0.equipmentRect:EndLayout()
	arg_7_0:OverlayPanel(arg_7_0.blurPanel)
	arg_7_0:OverlayPanel(arg_7_0.topItems)
	setActive(arg_7_0.sortImgAsc, arg_7_0.asc)
	setActive(arg_7_0.sortImgDec, not arg_7_0.asc)

	if arg_7_0.contextData.equipScrollPos then
		arg_7_0:ScrollEquipPos(arg_7_0.contextData.equipScrollPos.y)
	end

	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_equipment.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.selectTransformPanel:Find("cancel_button"), function()
		arg_7_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.selectTransformPanel:Find("confirm_button"), function()
		if arg_7_0.contextData.onConfirm((_.map(arg_7_0.selectedIds, function(arg_12_0)
			return arg_12_0[1]
		end))) then
			arg_7_0:closeView()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onBackPressed(arg_13_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(arg_13_0.sortPanel) then
		triggerButton(arg_13_0.sortPanel)

		return
	end

	triggerButton(arg_13_0.backBtn)

	return
end

function var_0_0.initSort(arg_14_0)
	onButton(arg_14_0, arg_14_0.decBtn, function()
		arg_14_0.asc = not arg_14_0.asc
		arg_14_0.contextData.asc = arg_14_0.asc

		arg_14_0:filterEquipment()

		return
	end)

	return
end

function var_0_0.initEquipments(arg_16_0)
	arg_16_0.isInitWeapons = true
	arg_16_0.equipmentRect = arg_16_0.equipmentView:GetComponent("LScrollRect")

	function arg_16_0.equipmentRect.onInitItem(arg_17_0)
		arg_16_0:initEquipment(arg_17_0)

		return
	end

	arg_16_0.equipmentRect.decelerationRate = 0.07

	function arg_16_0.equipmentRect.onUpdateItem(arg_18_0, arg_18_1)
		arg_16_0:updateEquipment(arg_18_0, arg_18_1)

		return
	end

	function arg_16_0.equipmentRect.onStart()
		arg_16_0:updateSelected()

		return
	end

	arg_16_0.equipmentRect:ScrollTo(0)

	return
end

function var_0_0.updateEquipmentCount(arg_20_0, arg_20_1)
	arg_20_0.equipmentRect:SetTotalCount(arg_20_1 or #arg_20_0.loadEquipmentVOs, -1)
	setActive(arg_20_0.listEmptyTF, (arg_20_1 or #arg_20_0.loadEquipmentVOs) <= 0)
	setText(arg_20_0.listEmptyTxt, i18n("list_empty_tip_storehouseui_equip"))
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.ScrollEquipPos(arg_21_0, arg_21_1)
	local var_21_9000
	local var_21_0 = arg_21_0.equipmentView:Find("equipment_grid")
	local var_21_1 = var_21_0.GetComponent(var_21_9000, typeof(GridLayoutGroup))
	local var_21_2 = var_21_0 - arg_21_0.equipmentView.rect.height

	if var_21_0 - arg_21_0.equipmentView.rect.height <= 0 or not var_21_2 then
		var_21_2 = (var_21_1.cellSize.y + var_21_1.spacing.y) * math.ceil(#arg_21_0.loadEquipmentVOs / var_21_1.constraintCount) - var_21_1.spacing.y + arg_21_0.equipmentRect.paddingFront + arg_21_0.equipmentRect.paddingEnd
	end

	arg_21_0.equipmentRect:ScrollTo((arg_21_1 - arg_21_0.equipmentView.rect.height * 0.5) / var_21_2)

	return
end

function var_0_0.onUIAnimEnd(arg_22_0, arg_22_1)
	arg_22_0.onAnimDoneCallback = arg_22_1

	return
end

function var_0_0.ExecuteAnimDoneCallback(arg_23_0)
	if arg_23_0.onAnimDoneCallback then
		arg_23_0.onAnimDoneCallback()

		arg_23_0.onAnimDoneCallback = nil
	end

	return
end

function var_0_0.selectCount(arg_24_0)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.selectedIds) do
		var_24_0 = var_24_0 + iter_24_1[2]
	end

	return var_24_0
end

function var_0_0.SelectTransformEquip(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = false

	if arg_25_0.selectedIds[1] and EquipmentTransformUtil.SameDrop(arg_25_0.selectedIds[1][1], arg_25_1) then
		var_25_0 = true
	end

	if not var_25_0 then
		if arg_25_0.contextData.onSelect and not arg_25_0.contextData.onSelect(arg_25_1) then
			return
		end

		table.clean(arg_25_0.selectedIds)
		table.insert(arg_25_0.selectedIds, {
			arg_25_1,
			1
		})
	else
		table.clean(arg_25_0.selectedIds)
	end

	arg_25_0:updateSelected()

	return
end

function var_0_0.initEquipment(arg_26_0, arg_26_1)
	local var_26_0 = EquipmentItemTransformVer.New(arg_26_1)

	onButton(arg_26_0, var_26_0.go, function()
		if var_26_0.sourceVO == nil then
			return
		end

		arg_26_0:SelectTransformEquip(var_26_0.sourceVO, var_26_0.sourceVO.count)

		return
	end, SFX_PANEL)

	arg_26_0.equipmetItems[arg_26_1] = var_26_0

	return
end

function var_0_0.updateEquipment(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.equipmetItems[arg_28_2]

	if not arg_28_0.equipmetItems[arg_28_2] then
		arg_28_0:initEquipment(arg_28_2)

		var_28_0 = arg_28_0.equipmetItems[arg_28_2]
	end

	local var_28_1 = arg_28_0.loadEquipmentVOs[arg_28_1 + 1]

	var_28_0:update(arg_28_0.loadEquipmentVOs[arg_28_1 + 1])

	local var_28_2 = false
	local var_28_3 = 0

	if var_28_1 then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.selectedIds) do
			if EquipmentTransformUtil.SameDrop(var_28_1, iter_28_1[1]) then
				var_28_2 = true
				var_28_3 = iter_28_1[2]

				break
			end
		end
	end

	var_28_0:updateSelected(var_28_2, var_28_3)

	return
end

function var_0_0.updateSelected(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.equipmetItems) do
		if iter_29_1.sourceVO then
			local var_29_0 = false
			local var_29_1 = 0

			for iter_29_2, iter_29_3 in pairs(arg_29_0.selectedIds) do
				if EquipmentTransformUtil.SameDrop(iter_29_1.sourceVO, iter_29_3[1]) then
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

function var_0_0.filterEquipment(arg_30_0)
	arg_30_0.loadEquipmentVOs = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_0.sourceVOs) do
		if iter_30_1.type ~= DROP_TYPE_EQUIP or iter_30_1.template.count > 0 then
			table.insert(arg_30_0.loadEquipmentVOs, iter_30_1)
		end
	end

	if arg_30_0.contextData.sortData then
		table.sort(arg_30_0.loadEquipmentVOs, CompareFuncs((table.mergeArray({
			function(arg_31_0)
				return arg_31_0.type
			end,
			function(arg_32_0)
				return arg_32_0.template.shipId or -1
			end
		}, underscore.map(var_0_1.sortFunc(arg_30_0.contextData.sortData, arg_30_0.asc), function(arg_33_0)
			return function(arg_34_0)
				return arg_33_0(arg_34_0.template)
			end
		end)))))
	end

	arg_30_0:updateSelected()
	arg_30_0:updateEquipmentCount()
	setActive(arg_30_0.sortImgAsc, arg_30_0.asc)
	setActive(arg_30_0.sortImgDec, not arg_30_0.asc)

	return
end

function var_0_0.willExit(arg_35_0)
	arg_35_0:UnOverlayPanel(arg_35_0.blurPanel, arg_35_0._tf)
	arg_35_0:UnOverlayPanel(arg_35_0.topItems, arg_35_0._tf)

	return
end

return var_0_0
