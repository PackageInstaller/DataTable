local ShipEquipView = class("ShipEquipView", import("...base.BaseSubView"))

ShipEquipView.UNLOCK_EQUIPMENT_SKIN_POS = {
	1,
	2,
	3,
	4,
	5
}

function ShipEquipView:getUIName()
	return "ShipEquipView"
end

function ShipEquipView:OnInit()
	self:InitEquipment()

	return
end

function ShipEquipView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function ShipEquipView:GetShipVO()
	if self.shareData and self.shareData.shipVO then
		return self.shareData.shipVO
	end

	return nil
end

function ShipEquipView:UpdateUI()
	self:UpdateEquipments((self:GetShipVO()))

	return
end

function ShipEquipView:InitEquipment()
	self.mainPanel = self._parentTf.parent
	self.equipRCon = self._parentTf:Find("equipment_r_container")
	self.equipLCon = self._parentTf:Find("equipment_l_container")
	self.equipBCon = self._parentTf:Find("equipment_b_container")
	self.equipmentR = self._tf:Find("equipment_r")
	self.equipmentL = self._tf:Find("equipment_l")
	self.equipmentB = self._tf:Find("equipment_b")
	self.equipmentR1 = self.equipmentR:Find("equipment/equipment_r1")
	self.equipmentR2 = self.equipmentR:Find("equipment/equipment_r2")
	self.equipmentR3 = self.equipmentR:Find("equipment/equipment_r3")
	self.equipmentL1 = self.equipmentL:Find("equipment/equipment_l1")
	self.equipmentL2 = self.equipmentL:Find("equipment/equipment_l2")
	self.equipSkinBtn = self.equipmentR:Find("equipment_skin_btn")
	self.equipmentB1 = self.equipmentB:Find("equipment")
	self.resource = self._tf:Find("resource")
	self.equipSkinLogicPanel = ShipEquipSkinLogicPanel.New(self._tf.gameObject)

	self.equipSkinLogicPanel:attach(self)
	self.equipSkinLogicPanel:setLabelResource(self.resource)
	setActive(self.equipSkinLogicPanel._go, true)
	setParent(self.equipmentR, self.equipRCon)
	setParent(self.equipmentL, self.equipLCon)
	setParent(self.equipmentB, self.equipBCon)
	setActive(self.equipmentR, true)
	setActive(self.equipmentL, true)
	setActive(self.equipmentB, true)
	setActive(self.equipSkinBtn, true)

	self.equipmentPanels = {
		self.equipmentR1,
		self.equipmentR2,
		self.equipmentR3,
		self.equipmentL1,
		self.equipmentL2
	}
	self.onSelected = false

	return
end

function ShipEquipView:InitEvent()
	onButton(self, self.equipSkinBtn, function()
		local var_8_0, var_8_1 = ShipStatus.ShipStatusCheck("onModify", self:GetShipVO())

		if not var_8_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_8_1)

			return
		end

		self:switch2EquipmentSkinPage()

		return
	end)

	if self.contextData.isInEquipmentSkinPage then
		self.contextData.isInEquipmentSkinPage = nil

		triggerButton(self.equipSkinBtn)
	end

	return
end

function ShipEquipView:OnSelected(arg_9_1)
	if arg_9_1 then
		local var_9_0 = {}
		local var_9_1 = {}
		local var_9_2 = {}

		local function var_9_3(arg_10_0, arg_10_1)
			eachChild(arg_10_0, function(arg_11_0)
				table.insert(arg_10_1, arg_11_0)

				return
			end)

			return
		end

		var_9_3(self.equipmentR:Find("skin"), var_9_1)
		var_9_3(self.equipmentR:Find("equipment"), var_9_1)
		var_9_3(self.equipmentL:Find("skin"), var_9_0)
		var_9_3(self.equipmentL:Find("equipment"), var_9_0)
		var_9_3(self.equipmentB, var_9_2)
		table.insert(var_9_0, self.equipmentL:Find("equipment/equipment_l1"))
		self:OverlayPanel(self.equipRCon, {
			groupDelta = -1,
			pbList = var_9_1,
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
		self:OverlayPanel(self.equipLCon, {
			groupDelta = -1,
			pbList = var_9_0,
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
		self:OverlayPanel(self.equipBCon, {
			groupDelta = -1,
			pbList = var_9_2,
			overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
		})
	else
		self:UnOverlayPanel(self.equipRCon, self._parentTf)
		self:UnOverlayPanel(self.equipLCon, self._parentTf)
		self:UnOverlayPanel(self.equipBCon, self._parentTf)
	end

	self.onSelected = arg_9_1

	return
end

function ShipEquipView:UpdateEquipments(arg_12_1)
	local var_12_0 = arg_12_1:getActiveEquipments()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.equipments) do
		self:UpdateEquipmentPanel(iter_12_0, iter_12_1, var_12_0[iter_12_0])
	end

	if self.equipSkinLogicPanel then
		self.equipSkinLogicPanel:updateAll(arg_12_1)
	end

	if self.contextData.openEquipUpgrade == true then
		self.contextData.openEquipUpgrade = false

		local var_12_1 = 0

		for iter_12_2, iter_12_3 in ipairs(self:GetShipVO().equipments) do
			if iter_12_3 then
				var_12_1 = var_12_1 + 1
			end
		end

		if var_12_1 > 0 then
			self:emit(ShipMainMediator.OPEN_EQUIP_UPGRADE, self:GetShipVO().id)
		end

		local var_12_2

		do
			pg.TipsMgr.GetInstance():ShowTips(i18n("fightfail_noequip"))

			var_12_2 = arg_12_1:IsSpweaponUnlock() and not LOCK_SP_WEAPON
		end
	end

	setActive(self.equipmentB, var_12_2)
	self:UpdateSpWeaponPanel((arg_12_1:GetSpWeapon()))

	return
end

function ShipEquipView:UpdateEquipmentPanel(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = self.equipmentPanels[arg_13_1]
	local var_13_1 = findTF(self.equipmentPanels[arg_13_1], "info")
	local var_13_2 = findTF(var_13_1, "efficiency")

	setActive(var_13_1, arg_13_2)
	setActive(findTF(self.equipmentPanels[arg_13_1], "empty"), not arg_13_2)

	local var_13_3 = self:GetShipVO()
	local var_13_4 = {}
	local var_13_5 = {}
	local var_13_6 = var_13_3:GetSpWeapon()

	if var_13_6 then
		for iter_13_0, iter_13_1 in ipairs((var_13_6:GetUpgradableSkillInfo())) do
			if iter_13_1.unlock then
				table.insert(var_13_5, var_13_6:GetUpgradableSkillIds()[1][1])

				local var_13_7 = ys.Battle.BattleDataFunction.GetBuffTemplate(iter_13_1.skillId, iter_13_1.lv)

				if var_13_7.shipInfoScene and var_13_7.shipInfoScene.equip then
					for iter_13_2, iter_13_3 in ipairs(var_13_7.shipInfoScene.equip) do
						table.insert(var_13_4, iter_13_3)
					end
				end
			end
		end
	end

	for iter_13_4, iter_13_5 in pairs(var_13_3.skills) do
		if not table.contains(var_13_5, iter_13_5.id) then
			local var_13_8 = ys.Battle.BattleDataFunction.GetBuffTemplate(iter_13_5.id, iter_13_5.level)

			if var_13_8.shipInfoScene and var_13_8.shipInfoScene.equip then
				for iter_13_6, iter_13_7 in ipairs(var_13_8.shipInfoScene.equip) do
					table.insert(var_13_4, iter_13_7)
				end
			end
		end
	end

	if var_13_6 and var_13_6:GetEffect() ~= 0 then
		local var_13_9 = ys.Battle.BattleDataFunction.GetBuffTemplate(var_13_6:GetEffect(), 1)

		if var_13_9.shipInfoScene and var_13_9.shipInfoScene.equip then
			for iter_13_8, iter_13_9 in ipairs(var_13_9.shipInfoScene.equip) do
				table.insert(var_13_4, iter_13_9)
			end
		end
	end

	local var_13_10 = findTF(var_13_0, "panel_title/type")
	local var_13_11 = findTF(var_13_0, "skin_icon")

	if var_13_11 then
		setActive(var_13_11, arg_13_2 and arg_13_2:hasSkin())
	end

	var_13_10:GetComponent(typeof(Text)).text = EquipType.LabelToName((EquipType.Types2Title(arg_13_1, var_13_3.configId)))

	if arg_13_2 then
		setActive(var_13_2, not arg_13_2:isDevice())

		if not arg_13_2:isDevice() then
			local var_13_13 = var_13_3:getEquipProficiencyByPos(arg_13_1)
			local var_13_14

			if var_13_13 then
				var_13_14 = var_13_13 * 100 or 0
			end

			local var_13_15 = false
			local var_13_16 = var_13_3:getFlag("inWorld")

			var_13_16 = var_13_16 and self.contextData.fromMediatorName == WorldMediator.__cname and WorldConst.FetchWorldShip(var_13_3.id):IsBroken()

			if not var_13_16 then
				for iter_13_10, iter_13_11 in ipairs(var_13_4) do
					print(self:equipmentCheck(iter_13_11), self.equipmentEnhance(iter_13_11, arg_13_2))

					if self:equipmentCheck(iter_13_11) and self.equipmentEnhance(iter_13_11, arg_13_2) then
						var_13_14 = var_13_14 + iter_13_11.number
						var_13_15 = true
					end
				end
			end

			if var_13_14 - calcFloor(var_13_14) > 1e-09 then
				var_13_14 = string.format("%.1f", var_13_14)
				GetComponent(findTF(var_13_2, "Text"), typeof(Text)).fontSize = 45
			end

			local var_13_17

			do
				GetComponent(findTF(var_13_2, "Text"), typeof(Text)).fontSize = 50
				var_13_17 = var_13_15 and setColorStr(var_13_14 .. "%", COLOR_GREEN) or var_13_14 .. "%"
			end

			setButtonText(var_13_2, var_13_17)
		end

		updateEquipment(var_13_1:Find("IconTpl"), arg_13_2)

		local var_13_18 = arg_13_2:getConfig("name")

		if arg_13_2:getConfig("ammo_icon")[1] then
			setActive(findTF(var_13_1, "cont/icon_ammo"), true)
			setImageSprite(findTF(var_13_1, "cont/icon_ammo"), GetSpriteFromAtlas("ammo", arg_13_2:getConfig("ammo_icon")[1]))
		else
			setActive(findTF(var_13_1, "cont/icon_ammo"), false)
		end

		setScrollText(self.equipmentPanels[arg_13_1]:Find("info/cont/name_mask/name"), var_13_18)

		local var_13_19 = var_13_1:Find("attrs")

		eachChild(var_13_19, function(arg_14_0)
			setActive(arg_14_0, false)

			return
		end)

		local var_13_20 = underscore.filter(arg_13_2:GetPropertiesInfo().attrs, function(arg_15_0)
			return not arg_15_0.type or arg_15_0.type ~= AttributeType.AntiSiren
		end)
		local var_13_21 = arg_13_2:getConfig("skill_id")
		local var_13_22 = var_13_21[1] and var_13_21[1][1]

		for iter_13_12, iter_13_13 in ipairs(var_13_22 and arg_13_2:isDevice() and {
			1,
			2,
			5
		} or {
			1,
			4,
			2,
			3
		}) do
			local var_13_23 = var_13_19:Find("attr_" .. iter_13_13)
			local var_13_24 = findTF(var_13_23, "panel")
			local var_13_25 = findTF(var_13_23, "lock")

			setActive(var_13_23, true)

			if iter_13_13 == 5 then
				setText(var_13_24:Find("values/value"), "")

				if PLATFORM_CODE == PLATFORM_US and string.len((getSkillName(var_13_22))) > 15 then
					GetComponent(var_13_24:Find("values/value_1"), typeof(Text)).fontSize = 24
				end

				setText(var_13_24:Find("values/value_1"), getSkillName(var_13_22))
				setActive(var_13_25, false)
			elseif #var_13_20 > 0 then
				local var_13_26 = table.remove(var_13_20, 1)

				if arg_13_2:isAircraft() and var_13_26.type == AttributeType.CD then
					var_13_26 = var_13_3:getAircraftReloadCD()
				end

				local var_13_27, var_13_28 = Equipment.GetInfoTrans(var_13_26, var_13_3)

				setText(var_13_24:Find("tag"), var_13_27)

				local var_13_29 = string.split(tostring(var_13_28), "/")

				if #var_13_29 >= 2 then
					setText(var_13_24:Find("values/value"), var_13_29[1] .. "/")
					setText(var_13_24:Find("values/value_1"), var_13_29[2])
				else
					setText(var_13_24:Find("values/value"), var_13_28)
					setText(var_13_24:Find("values/value_1"), "")
				end

				setActive(var_13_25, false)
			else
				setText(var_13_24:Find("tag"), "")
				setText(var_13_24:Find("values/value"), "")
				setText(var_13_24:Find("values/value_1"), "")
				setActive(var_13_25, true)
			end
		end

		onButton(self, var_13_0, function()
			self:emit(BaseUI.ON_EQUIPMENT, {
				type = EquipmentInfoMediator.TYPE_SHIP,
				shipId = var_13_3.id,
				pos = arg_13_1,
				onRemoved = function()
					self:setEquipDescVisible(true)

					return
				end
			})
			self:setEquipDescVisible(false)

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	else
		onButton(self, var_13_0, function()
			if var_13_3 then
				local var_18_0, var_18_1 = ShipStatus.ShipStatusCheck("onModify", var_13_3)

				if not var_18_0 then
					pg.TipsMgr.GetInstance():ShowTips(var_18_1)

					return
				end

				self:emit(ShipMainMediator.ON_SELECT_EQUIPMENT, arg_13_1)
			end

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	end

	return
end

function ShipEquipView:setEquipDescVisible(arg_19_1)
	if not self.equipmentPanels then
		return
	end

	for iter_19_0 = 1, #self.equipmentPanels do
		if self.equipmentPanels[iter_19_0] then
			local var_19_0 = GetComponent(self.equipmentPanels[iter_19_0]:Find("info/cont/name_mask/name"), typeof(ScrollText))

			if var_19_0 then
				var_19_0:SetVisible(arg_19_1)
			end
		end
	end

	return
end

function ShipEquipView:equipmentCheck(arg_20_1)
	if not self:GetShipVO() then
		return false
	end

	local var_20_0 = arg_20_1.check_type

	if not arg_20_1.check_type and not arg_20_1.check_indexList and not arg_20_1.check_label then
		return true
	end

	local var_20_3 = Clone(self:GetShipVO().equipments)

	if arg_20_1.check_indexList then
		local var_20_4 = #var_20_3

		while var_20_4 > 0 do
			if not table.contains(arg_20_1.check_indexList, var_20_4) then
				table.remove(var_20_3, var_20_4)
			end

			var_20_4 = var_20_4 - 1
		end
	end

	if var_20_0 then
		local var_20_5 = #var_20_3

		while var_20_5 > 0 do
			if not var_20_3[var_20_5] or not table.contains(var_20_0, var_20_3[var_20_5]:getConfig("type")) then
				table.remove(var_20_3, var_20_5)
			end

			var_20_5 = var_20_5 - 1
		end
	end

	if arg_20_1.check_label then
		local var_20_6 = #var_20_3

		while var_20_6 > 0 do
			if var_20_3[var_20_6] then
				local var_20_7 = 1

				for iter_20_0, iter_20_1 in ipairs(arg_20_1.check_label) do
					if not table.contains(var_20_3[var_20_6]:getConfig("label"), iter_20_1) then
						var_20_7 = var_20_7 * 0
					end
				end

				if var_20_7 == 0 then
					table.remove(var_20_3, var_20_6)
				end
			else
				table.remove(var_20_3, var_20_6)
			end

			var_20_6 = var_20_6 - 1
		end
	end

	return #var_20_3 > 0
end

function ShipEquipView:equipmentEnhance(arg_21_1)
	local var_21_0 = 1
	local var_21_1 = arg_21_1:getConfig("label")

	if self.label then
		var_21_0 = 1

		for iter_21_0, iter_21_1 in ipairs(self.label) do
			if not table.contains(var_21_1, iter_21_1) then
				var_21_0 = 0

				break
			end
		end
	end

	return var_21_0 == 1
end

function ShipEquipView:UpdateSpWeaponPanel(arg_22_1)
	local var_22_0 = findTF(self.equipmentB1, "info")

	setActive(var_22_0, arg_22_1)
	setActive(findTF(self.equipmentB1, "empty"), not arg_22_1)

	local var_22_1 = self:GetShipVO()

	assert(var_22_1)

	if arg_22_1 then
		UpdateSpWeaponSlot(var_22_0, arg_22_1, {
			20,
			20,
			20,
			20
		})

		local var_22_2 = var_22_0:Find("attrs")

		eachChild(var_22_2, function(arg_23_0)
			setActive(arg_23_0, false)

			return
		end)

		local var_22_3 = underscore.filter(arg_22_1:GetPropertiesInfo().attrs, function(arg_24_0)
			return not arg_24_0.type or arg_24_0.type ~= AttributeType.AntiSiren
		end)

		for iter_22_0 = 1, 2 do
			local var_22_4 = var_22_2:GetChild(iter_22_0 - 1)

			setActive(var_22_4, true)

			if #var_22_3 > 0 then
				local var_22_5, var_22_6 = Equipment.GetInfoTrans(table.remove(var_22_3, 1), var_22_1)

				setText(var_22_4:Find("tag"), var_22_5)
				setText(var_22_4:Find("values/value"), var_22_6)
				setText(var_22_4:Find("values/value_1"), "")
			end
		end

		Canvas.ForceUpdateCanvases()

		local var_22_7 = var_22_0:Find("cont")

		;(function()
			local var_25_0 = var_22_7:GetChild(0)

			setText(var_25_0:Find("tag"), i18n("spweapon_ui_effect_tag"))

			local var_25_1 = arg_22_1:GetEffect()

			setActive(var_25_0, var_25_1 and var_25_1 > 0)

			if not var_25_1 or var_25_1 <= 0 then
				return
			end

			setScrollText(var_25_0:Find("value/Text"), getSkillName(var_25_1))

			return
		end)()

		local var_22_8 = arg_22_1:GetActiveUpgradableSkillList(var_22_1)

		if #var_22_8 == 0 then
			setActive(var_22_7:GetChild(1), false)
		else
			(function(arg_26_0)
				local var_26_0 = var_22_7:GetChild(1)

				setText(var_26_0:Find("tag"), i18n("spweapon_ui_skill_tag"))
				setActive(var_26_0, arg_26_0 and arg_26_0 > 0)

				if not arg_26_0 or arg_26_0 <= 0 then
					return
				end

				setScrollText(var_26_0:Find("value/Text"), getSkillName(arg_26_0))

				return
			end)(var_22_8[1].mapSkillID)
		end

		onButton(self, self.equipmentB1, function()
			self:emit(BaseUI.ON_SPWEAPON, {
				type = SpWeaponInfoLayer.TYPE_SHIP,
				shipId = var_22_1.id,
				onRemoved = function()
					self:setEquipDescVisible(true)

					return
				end
			})
			self:setEquipDescVisible(false)

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	else
		onButton(self, self.equipmentB1, function()
			if var_22_1 then
				local var_29_0, var_29_1 = ShipStatus.ShipStatusCheck("onModify", var_22_1)

				if not var_29_0 then
					pg.TipsMgr.GetInstance():ShowTips(var_29_1)

					return
				end

				self:emit(ShipMainMediator.ON_SELECT_SPWEAPON)
			end

			return
		end, SFX_UI_DOCKYARD_EQUIPADD)
	end

	return
end

function ShipEquipView:switch2EquipmentSkinPage()
	if self.equipSkinLogicPanel:isTweening() then
		return
	end

	self.equipSkinLogicPanel:doSwitchAnim(self.contextData.isInEquipmentSkinPage)

	self.contextData.isInEquipmentSkinPage = not self.contextData.isInEquipmentSkinPage

	setActive(self.equipSkinBtn:Find("unsel"), not self.contextData.isInEquipmentSkinPage)
	setActive(self.equipSkinBtn:Find("sel"), self.contextData.isInEquipmentSkinPage)
	self.equipSkinLogicPanel:updateAll(self:GetShipVO())

	return
end

function ShipEquipView:OnDestroy()
	setParent(self.equipmentR, self._tf)
	setParent(self.equipmentL, self._tf)
	setParent(self.equipmentB, self._tf)

	self.shareData = nil

	return
end

return ShipEquipView
