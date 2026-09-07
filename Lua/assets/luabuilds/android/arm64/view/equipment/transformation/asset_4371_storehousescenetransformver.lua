local StoreHouseSceneTransformVer = class("StoreHouseSceneTransformVer", import("view.base.BaseUI"))
local EquipmentSortCfg = require("view.equipment.EquipmentSortCfg")
local var_0_2 = 0

function StoreHouseSceneTransformVer:getUIName()
	return "StoreHouseUI"
end

function StoreHouseSceneTransformVer:init()
	self.topItems = self._tf:Find("topItems")
	self.equipmentView = self._tf:Find("adapt/equipment_scrollview")
	self.blurPanel = self._tf:Find("blur_panel")
	self.topPanel = self.blurPanel:Find("adapt/top")

	setActive(self.topPanel:Find("buttons"), true)

	self.indexBtn = self.topPanel:Find("buttons/index_button")
	self.sortBtn = self.topPanel:Find("buttons/sort_button")
	self.sortPanel = self.topItems:Find("sort")
	self.sortContain = self.sortPanel:Find("adapt/mask/panel")
	self.sortTpl = self.sortContain:Find("tpl")

	setActive(self.sortTpl, false)

	self.equipSkinFilteBtn = self.topPanel:Find("buttons/EquipSkinFilteBtn")
	self.equipmentView:Find("equipment_grid"):GetComponent(typeof(GridLayoutGroup)).constraintCount = ((NotchAdapt.CheckNotchRatio == 2 or not getProxy(SettingsProxy):CheckLargeScreen()) and self.equipmentView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2) and 8 or 7
	self.decBtn = findTF(self.topPanel, "buttons/dec_btn")
	self.sortImgAsc = findTF(self.decBtn, "asc")
	self.sortImgDec = findTF(self.decBtn, "desc")
	self.equipmentBtn = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_root/equipment")
	self.equipmentSkinBtn = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_root/skin")

	setActive(self.equipmentBtn.parent, false)

	self.filterBusyToggle = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_equip")

	setActive(self.filterBusyToggle, false)

	self.bottomBack = self.topItems:Find("adapt/bottom_back")
	self.bottomPanel = self.bottomBack:Find("types")
	self.materialToggle = self.bottomPanel:Find("material")
	self.weaponToggle = self.bottomPanel:Find("weapon")
	self.designToggle = self.bottomPanel:Find("design")
	self.capacityTF = self.bottomBack:Find("bottom_left/tip/capcity/Text")

	setActive(self.capacityTF.parent, false)

	self.tipTF = self.bottomBack:Find("bottom_left/tip")
	self.tip = self.tipTF:Find("label")

	setActive(self.tip, false)

	self.helpBtn = self.topItems:Find("adapt/help_btn")

	setActive(self.helpBtn, true)

	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.selectedMin = defaultValue(self.contextData.selectedMin, 1)
	self.selectedMax = defaultValue(self.contextData.selectedMax, pg.gameset.equip_select_limit.key_value or 0)
	self.selectedIds = Clone(self.contextData.selectedIds or {})
	self.checkEquipment = self.contextData.onEquipment or function(arg_3_0)
		return true
	end
	self.onSelected = self.contextData.onSelected or function()
		warning("not implemented.")

		return
	end

	setActive(self.bottomBack:Find("dispos"), false)
	setActive(self.topItems:Find("adapt/select_panel"), false)

	self.selectTransformPanel = self.topItems:Find("adapt/select_transform_panel")
	self.listEmptyTF = self._tf:Find("adapt/empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setActive(self.bottomBack, false)
	setActive(self.selectTransformPanel, true)
	setActive(self.indexBtn, false)
	setActive(self.sortBtn, false)
	setActive(self.equipSkinFilteBtn, false)
	setActive(self.equipmentSkinBtn, false)
	setText(self.selectTransformPanel:Find("cancel_button/Image"), i18n("msgbox_text_cancel"))
	setText(self.selectTransformPanel:Find("confirm_button/Image"), i18n("msgbox_text_confirm"))

	return
end

function StoreHouseSceneTransformVer:setSources(arg_5_1)
	self.sourceVOs = arg_5_1

	return
end

function StoreHouseSceneTransformVer:OnMediatorRegister()
	self.warp = self.contextData.warp or StoreHouseConst.WARP_TO_WEAPON
	self.mode = self.contextData.mode or StoreHouseConst.OVERVIEW
	self.page = var_0_2

	return
end

function StoreHouseSceneTransformVer:didEnter()
	onButton(self, self.backBtn, function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:emit(StoreHouseSceneTransformVer.ON_BACK)

		return
	end, SFX_CANCEL)

	self.equipmetItems = {}

	self:initEquipments()

	self.asc = self.contextData.asc or false
	self.contextData.sortData = self.contextData.sortData or EquipmentSortCfg.sort[1]
	self.contextData.indexDatas = self.contextData.indexDatas or {}

	self:initSort()
	setActive(self.equipmentView, true)
	self:filterEquipment()

	self.equipmentRect.isStart = true

	self.equipmentRect:EndLayout()
	self:OverlayPanel(self.blurPanel)
	self:OverlayPanel(self.topItems)
	setActive(self.sortImgAsc, self.asc)
	setActive(self.sortImgDec, not self.asc)

	if self.contextData.equipScrollPos then
		self:ScrollEquipPos(self.contextData.equipScrollPos.y)
	end

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_equipment.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.selectTransformPanel:Find("cancel_button"), function()
		self:emit(StoreHouseSceneTransformVer.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.selectTransformPanel:Find("confirm_button"), function()
		if self.contextData.onConfirm((_.map(self.selectedIds, function(arg_12_0)
			return arg_12_0[1]
		end))) then
			self:closeView()
		end

		return
	end, SFX_PANEL)

	return
end

function StoreHouseSceneTransformVer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self.sortPanel) then
		triggerButton(self.sortPanel)

		return
	end

	triggerButton(self.backBtn)

	return
end

function StoreHouseSceneTransformVer:initSort()
	onButton(self, self.decBtn, function()
		self.asc = not self.asc
		self.contextData.asc = self.asc

		self:filterEquipment()

		return
	end)

	return
end

function StoreHouseSceneTransformVer:initEquipments()
	self.isInitWeapons = true
	self.equipmentRect = self.equipmentView:GetComponent("LScrollRect")

	function self.equipmentRect.onInitItem(arg_17_0)
		self:initEquipment(arg_17_0)

		return
	end

	self.equipmentRect.decelerationRate = 0.07

	function self.equipmentRect.onUpdateItem(arg_18_0, arg_18_1)
		self:updateEquipment(arg_18_0, arg_18_1)

		return
	end

	function self.equipmentRect.onStart()
		self:updateSelected()

		return
	end

	self.equipmentRect:ScrollTo(0)

	return
end

function StoreHouseSceneTransformVer:updateEquipmentCount(arg_20_1)
	self.equipmentRect:SetTotalCount(arg_20_1 or #self.loadEquipmentVOs, -1)
	setActive(self.listEmptyTF, (arg_20_1 or #self.loadEquipmentVOs) <= 0)
	setText(self.listEmptyTxt, i18n("list_empty_tip_storehouseui_equip"))
	Canvas.ForceUpdateCanvases()

	return
end

function StoreHouseSceneTransformVer:ScrollEquipPos(arg_21_1)
	local var_21_0 = self.equipmentView:Find("equipment_grid")
	local var_21_1 = var_21_0:GetComponent(typeof(GridLayoutGroup))
	local var_21_2 = var_21_0 - self.equipmentView.rect.height

	var_21_2 = var_21_0 - self.equipmentView.rect.height > 0 and var_21_2 or (var_21_1.cellSize.y + var_21_1.spacing.y) * math.ceil(#self.loadEquipmentVOs / var_21_1.constraintCount) - var_21_1.spacing.y + self.equipmentRect.paddingFront + self.equipmentRect.paddingEnd

	self.equipmentRect:ScrollTo((arg_21_1 - self.equipmentView.rect.height * 0.5) / var_21_2)

	return
end

function StoreHouseSceneTransformVer:onUIAnimEnd(arg_22_1)
	self.onAnimDoneCallback = arg_22_1

	return
end

function StoreHouseSceneTransformVer:ExecuteAnimDoneCallback()
	if self.onAnimDoneCallback then
		self.onAnimDoneCallback()

		self.onAnimDoneCallback = nil
	end

	return
end

function StoreHouseSceneTransformVer:selectCount()
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(self.selectedIds) do
		var_24_0 = var_24_0 + iter_24_1[2]
	end

	return var_24_0
end

function StoreHouseSceneTransformVer:SelectTransformEquip(arg_25_1, arg_25_2)
	if not (self.selectedIds[1] and EquipmentTransformUtil.SameDrop(self.selectedIds[1][1], arg_25_1)) then
		if self.contextData.onSelect and not self.contextData.onSelect(arg_25_1) then
			return
		end

		table.clean(self.selectedIds)
		table.insert(self.selectedIds, {
			arg_25_1,
			1
		})
	else
		table.clean(self.selectedIds)
	end

	self:updateSelected()

	return
end

function StoreHouseSceneTransformVer:initEquipment(arg_26_1)
	local var_26_0 = EquipmentItemTransformVer.New(arg_26_1)

	onButton(self, var_26_0.go, function()
		if var_26_0.sourceVO == nil then
			return
		end

		self:SelectTransformEquip(var_26_0.sourceVO, var_26_0.sourceVO.count)

		return
	end, SFX_PANEL)

	self.equipmetItems[arg_26_1] = var_26_0

	return
end

function StoreHouseSceneTransformVer:updateEquipment(arg_28_1, arg_28_2)
	local var_28_0 = self.equipmetItems[arg_28_2]

	if not self.equipmetItems[arg_28_2] then
		self:initEquipment(arg_28_2)

		var_28_0 = self.equipmetItems[arg_28_2]
	end

	local var_28_1 = self.loadEquipmentVOs[arg_28_1 + 1]

	var_28_0:update(self.loadEquipmentVOs[arg_28_1 + 1])

	local var_28_2 = false
	local var_28_3 = 0

	if var_28_1 then
		for iter_28_0, iter_28_1 in ipairs(self.selectedIds) do
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

function StoreHouseSceneTransformVer:updateSelected()
	for iter_29_0, iter_29_1 in pairs(self.equipmetItems) do
		if iter_29_1.sourceVO then
			local var_29_0 = false
			local var_29_1 = 0

			for iter_29_2, iter_29_3 in pairs(self.selectedIds) do
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

function StoreHouseSceneTransformVer:filterEquipment()
	self.loadEquipmentVOs = {}

	for iter_30_0, iter_30_1 in pairs(self.sourceVOs) do
		if iter_30_1.type ~= DROP_TYPE_EQUIP or iter_30_1.template.count > 0 then
			table.insert(self.loadEquipmentVOs, iter_30_1)
		end
	end

	if self.contextData.sortData then
		table.sort(self.loadEquipmentVOs, CompareFuncs((table.mergeArray({
			function(arg_31_0)
				return arg_31_0.type
			end,
			function(arg_32_0)
				return arg_32_0.template.shipId or -1
			end
		}, underscore.map(EquipmentSortCfg.sortFunc(self.contextData.sortData, self.asc), function(arg_33_0)
			return function(arg_34_0)
				return arg_33_0(arg_34_0.template)
			end
		end)))))
	end

	self:updateSelected()
	self:updateEquipmentCount()
	setActive(self.sortImgAsc, self.asc)
	setActive(self.sortImgDec, not self.asc)

	return
end

function StoreHouseSceneTransformVer:willExit()
	self:UnOverlayPanel(self.blurPanel, self._tf)
	self:UnOverlayPanel(self.topItems, self._tf)

	return
end

return StoreHouseSceneTransformVer
