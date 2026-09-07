local SpWeaponInfoLayer = class("SpWeaponInfoLayer", import("view.base.BaseUI"))

function SpWeaponInfoLayer:getUIName()
	return "SpWeaponInfoUI"
end

SpWeaponInfoLayer.Left = 1
SpWeaponInfoLayer.Middle = 2
SpWeaponInfoLayer.Right = 3
SpWeaponInfoLayer.pos = {
	{
		-353,
		30,
		0
	},
	{
		0,
		30,
		0
	},
	{
		353,
		30,
		0
	}
}
SpWeaponInfoLayer.TYPE_DEFAULT = 1
SpWeaponInfoLayer.TYPE_SHIP = 2
SpWeaponInfoLayer.TYPE_REPLACE = 3
SpWeaponInfoLayer.TYPE_DISPLAY = 4
SpWeaponInfoLayer.SHOW_UNIQUE = {
	1,
	2,
	3,
	4
}

function SpWeaponInfoLayer:init()
	self.toggles = {}

	for iter_2_0, iter_2_1 in ipairs({
		"default",
		"replace",
		"display"
	}) do
		self[iter_2_1 .. "Panel"] = self._tf:Find(iter_2_1)
		self.toggles[iter_2_1 .. "Panel"] = self._tf:Find("toggle_controll/" .. iter_2_1)
	end

	Canvas.ForceUpdateCanvases()

	self.sample = self._tf:Find("sample")

	setActive(self.sample, false)

	self.txtQuickEnable = findTF(self._tf, "txtQuickEnable")

	setText(self.txtQuickEnable, i18n("ship_equip_check"))
	setText(self._tf:Find("sample/empty/Text"), i18n("spweapon_ui_empty"))

	return
end

function SpWeaponInfoLayer:setEquipment(arg_3_1, arg_3_2)
	self.equipmentVO = arg_3_1
	self.oldEquipmentVO = arg_3_2

	return
end

function SpWeaponInfoLayer:setShip(arg_4_1, arg_4_2)
	self.shipVO = arg_4_1
	self.oldShipVO = arg_4_2

	return
end

function SpWeaponInfoLayer:setPlayer(arg_5_1)
	self.player = arg_5_1

	return
end

function SpWeaponInfoLayer:checkOverGold(arg_6_1)
	if self.player:GoldMax(_.detect(arg_6_1, function(arg_7_0)
		return arg_7_0.type == DROP_TYPE_RESOURCE and arg_7_0.id == 1
	end).count or 0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_destroy"))

		return false
	end

	return true
end

function SpWeaponInfoLayer:didEnter()
	setActive(self.txtQuickEnable, self.contextData.quickFlag or false)

	local var_8_1 = defaultValue(self.contextData.type, SpWeaponInfoLayer.TYPE_DEFAULT)

	self.isShowUnique = table.contains(SpWeaponInfoLayer.SHOW_UNIQUE, var_8_1)

	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SOUND_BACK)
	self:initAndSetBtn(var_8_1)

	if var_8_1 == SpWeaponInfoLayer.TYPE_DEFAULT then
		self:updateOperation1()
	elseif var_8_1 == SpWeaponInfoLayer.TYPE_SHIP then
		self:updateOperation2()
	elseif var_8_1 == SpWeaponInfoLayer.TYPE_REPLACE then
		self:updateOperation3()
	elseif var_8_1 == SpWeaponInfoLayer.TYPE_DISPLAY then
		self:updateOperation4()
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

local var_0_1 = {
	{
		"Enhance",
		"msgbox_text_noPos_intensify"
	},
	{
		"Replace",
		"msgbox_text_replace"
	},
	{
		"Unload",
		"msgbox_text_unload"
	},
	{
		"Modify",
		"msgbox_text_modify"
	}
}

function SpWeaponInfoLayer:initAndSetBtn(arg_10_1)
	if arg_10_1 == SpWeaponInfoLayer.TYPE_DEFAULT or arg_10_1 == SpWeaponInfoLayer.TYPE_SHIP then
		self.defaultEquipTF = self.defaultPanel:Find("equipment") or self:cloneSampleTo(self.defaultPanel, SpWeaponInfoLayer.Middle, "equipment")

		table.Foreach(var_0_1, function(arg_11_0, arg_11_1)
			local var_11_0 = self.defaultPanel:Find("actions/action_button_" .. arg_11_0)

			self["default" .. arg_11_1[1] .. "Btn"] = var_11_0

			setText(var_11_0:GetChild(0), i18n(arg_11_1[2]))

			return
		end)
		onButton(self, self.defaultReplaceBtn, function()
			self:emit(SpWeaponInfoMediator.ON_CHANGE)

			return
		end, SFX_PANEL)
		onButton(self, self.defaultEnhanceBtn, function()
			self:emit(SpWeaponInfoMediator.ON_INTENSIFY)

			return
		end, SFX_PANEL)
		onButton(self, self.defaultUnloadBtn, function()
			self:emit(SpWeaponInfoMediator.ON_UNEQUIP)

			return
		end, SFX_UI_DOCKYARD_EQUIPOFF)
		onButton(self, self.defaultModifyBtn, function()
			self:emit(SpWeaponInfoMediator.ON_MODIFY)

			return
		end, SFX_PANEL)
	elseif arg_10_1 == SpWeaponInfoLayer.TYPE_REPLACE then
		self.replaceSrcEquipTF = self.replacePanel:Find("equipment") or self:cloneSampleTo(self.replacePanel, SpWeaponInfoLayer.Left, "equipment")
		self.replaceDstEquipTF = self.replacePanel:Find("equipment_on_ship") or self:cloneSampleTo(self.replacePanel, SpWeaponInfoLayer.Right, "equipment_on_ship")
		self.replaceCancelBtn = self.replacePanel:Find("actions/cancel_button")
		self.replaceConfirmBtn = self.replacePanel:Find("actions/action_button_2")

		setText(self.replaceConfirmBtn:Find("label"), i18n("msgbox_text_confirm"))
		setText(self.replaceCancelBtn:Find("label"), i18n("msgbox_text_cancel"))
		onButton(self, self.replaceCancelBtn, function()
			self:closeView()

			return
		end, SFX_CANCEL)
		onButton(self, self.replaceConfirmBtn, function()
			if self.contextData.quickCallback then
				self.contextData.quickCallback()
				self:closeView()
			else
				self:emit(SpWeaponInfoMediator.ON_EQUIP)
			end

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	elseif arg_10_1 == SpWeaponInfoLayer.TYPE_DISPLAY then
		self.displayEquipTF = self.displayPanel:Find("equipment") or self:cloneSampleTo(self.displayPanel, SpWeaponInfoLayer.Middle, "equipment")
		self.displayMoveBtn = self.displayPanel:Find("actions/move_button")

		setText(self.displayMoveBtn:Find("label"), i18n("msgbox_text_equipdetail"))
		onButton(self, self.displayMoveBtn, function()
			self:emit(SpWeaponInfoMediator.ON_MOVE, self.shipVO.id)

			return
		end)
	end

	return
end

function SpWeaponInfoLayer:updateOperation1()
	triggerToggle(self.toggles.defaultPanel, true)
	self:updateEquipmentPanel(self.defaultEquipTF, self.equipmentVO, SpWeaponHelper.TransformNormalInfo(self.equipmentVO))
	setActive(self.defaultEnhanceBtn, true)
	setActive(self.defaultReplaceBtn, false)
	setActive(self.defaultUnloadBtn, false)
	setActive(self.defaultModifyBtn, true)

	return
end

function SpWeaponInfoLayer:updateOperation2()
	triggerToggle(self.toggles.defaultPanel, true)

	local var_20_0 = self.shipVO:GetSpWeapon()

	self:updateEquipmentPanel(self.defaultEquipTF, var_20_0, SpWeaponHelper.TransformNormalInfo(var_20_0))
	setActive(self.defaultEnhanceBtn, true)
	setActive(self.defaultReplaceBtn, true)
	setActive(self.defaultUnloadBtn, true)
	setActive(self.defaultModifyBtn, true)

	local var_20_1 = self.defaultEquipTF:Find("head")

	setActive(var_20_1, self.shipVO)

	if self.shipVO then
		setImageSprite(findTF(var_20_1, "Image"), LoadSprite("qicon/" .. self.shipVO:getPainting()))
	end

	return
end

function SpWeaponInfoLayer:updateOperation3()
	triggerToggle(self.toggles.replacePanel, true)

	if self.equipmentVO then
		local var_21_0, var_21_1 = SpWeaponHelper.CompareNormalInfo(self.equipmentVO, self.oldEquipmentVO)

		self:updateEquipmentPanel(self.replaceSrcEquipTF, self.equipmentVO, var_21_0)
		self:updateEquipmentPanel(self.replaceDstEquipTF, self.oldEquipmentVO, var_21_1)
	else
		self:updateEquipmentPanel(self.replaceSrcEquipTF, nil)
		self:updateEquipmentPanel(self.replaceDstEquipTF, self.oldEquipmentVO, SpWeaponHelper.TransformNormalInfo(self.oldEquipmentVO))
	end

	local var_21_2 = self.replaceDstEquipTF:Find("head")

	setActive(var_21_2, self.oldShipVO)

	if self.oldShipVO then
		setImageSprite(findTF(var_21_2, "Image"), LoadSprite("qicon/" .. self.oldShipVO:getPainting()))
	end

	return
end

function SpWeaponInfoLayer:updateOperation4()
	triggerToggle(self.toggles.displayPanel, true)
	self:updateEquipmentPanel(self.displayEquipTF, self.equipmentVO, SpWeaponHelper.TransformNormalInfo(self.equipmentVO))
	setActive(self.displayMoveBtn, self.shipVO)

	local var_22_0 = self.displayEquipTF:Find("head")

	setActive(var_22_0, self.shipVO)

	if self.shipVO then
		setImageSprite(findTF(var_22_0, "Image"), LoadSprite("qicon/" .. self.shipVO:getPainting()))
	end

	return
end

function SpWeaponInfoLayer:updateOperationAward(arg_23_1, arg_23_2, arg_23_3)
	self.awards = arg_23_3

	if arg_23_1.childCount == 0 then
		for iter_23_0 = 1, #arg_23_3 do
			cloneTplTo(arg_23_2, arg_23_1)
		end
	end

	for iter_23_1 = 1, #arg_23_3 do
		local var_23_0 = arg_23_1:GetChild(iter_23_1 - 1)
		local var_23_1 = arg_23_3[iter_23_1]

		updateDrop(var_23_0, arg_23_3[iter_23_1])
		onButton(self, var_23_0, function()
			self:emit(SpWeaponInfoLayer.ON_DROP, var_23_1)

			return
		end, SFX_PANEL)
		setText(findTF(var_23_0, "name_panel/name"), getText(findTF(var_23_0, "name")))
		setText(findTF(var_23_0, "name_panel/number"), " x " .. getText(findTF(var_23_0, "icon_bg/count")))
		setActive(findTF(var_23_0, "icon_bg/count"), false)
	end

	return
end

function SpWeaponInfoLayer:updateEquipmentPanel(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1:Find("info")

	setActive(var_25_0, arg_25_2)
	setActive(arg_25_1:Find("empty"), not arg_25_2)

	if not arg_25_2 then
		return
	end

	setScrollText(findTF(findTF(var_25_0, "name"), "mask/Text"), arg_25_2:GetName())

	local var_25_1 = findTF(var_25_0, "equip")

	setImageSprite(findTF(var_25_1, "bg"), GetSpriteFromAtlas("ui/equipmentinfoui_atlas", "equip_bg_" .. ItemRarity.Rarity2Print(arg_25_2:GetRarity())))
	updateSpWeapon(var_25_1, arg_25_2, {
		noIconColorful = true
	})
	setActive(findTF(var_25_1, "slv"), arg_25_2:GetLevel() > 1)
	setText(findTF(var_25_1, "slv/Text"), arg_25_2:GetLevel() - 1)
	setActive(findTF(var_25_1, "slv/next"), false)
	setText(findTF(var_25_1, "slv/next/Text"), arg_25_2:GetLevel() - 1)

	local var_25_2 = var_25_1:Find("tier")

	setActive(var_25_2, arg_25_2)

	local var_25_3 = arg_25_2:GetTechTier()

	eachChild(var_25_2, function(arg_26_0)
		setActive(arg_26_0, tostring(var_25_3) == arg_26_0.gameObject.name)

		return
	end)
	updateSpWeaponInfo(var_25_0:Find("attributes/view/content"), arg_25_3, arg_25_2:GetSkillGroup())

	return
end

function SpWeaponInfoLayer:cloneSampleTo(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = cloneTplTo(self.sample, arg_27_1, arg_27_3)

	var_27_0.localPosition = Vector3.New(SpWeaponInfoLayer.pos[arg_27_2][1], SpWeaponInfoLayer.pos[arg_27_2][2], SpWeaponInfoLayer.pos[arg_27_2][3])

	if arg_27_4 then
		var_27_0:SetSiblingIndex(arg_27_4)
	end

	return var_27_0
end

function SpWeaponInfoLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function SpWeaponInfoLayer:onBackPressed()
	self:closeView()

	return
end

return SpWeaponInfoLayer
