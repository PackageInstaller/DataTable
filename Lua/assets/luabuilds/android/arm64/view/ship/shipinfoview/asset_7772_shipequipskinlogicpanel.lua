local ShipEquipSkinLogicPanel = class("ShipEquipSkinLogicPanel", import("...base.BasePanel"))
local var_0_1 = 0.2

function ShipEquipSkinLogicPanel:init()
	self.equipmentTFs = {
		self._tf:Find("equipment_r/skin/equipment_r1"),
		self._tf:Find("equipment_r/skin/equipment_r2"),
		self._tf:Find("equipment_r/skin/equipment_r3"),
		self._tf:Find("equipment_l/skin/equipment_l1"),
		self._tf:Find("equipment_l/skin/equipment_l2")
	}
	self.equipmentNormalTFs = {
		self._tf:Find("equipment_r/equipment/equipment_r1"),
		self._tf:Find("equipment_r/equipment/equipment_r2"),
		self._tf:Find("equipment_r/equipment/equipment_r3"),
		self._tf:Find("equipment_l/equipment/equipment_l1"),
		self._tf:Find("equipment_l/equipment/equipment_l2")
	}
	self.spweaponNormalTF = self._tf:Find("equipment_b/equipment")
	self.equipmentR = self._tf:Find("equipment_r/equipment")
	self.equipmentL = self._tf:Find("equipment_l/equipment")
	self.skinR = self._tf:Find("equipment_r/skin")
	self.skinL = self._tf:Find("equipment_l/skin")
	self.infoPanel = self.equipmentTFs[1]:Find("info")
	self.inSkinPage = true

	for iter_1_0 = 1, 3 do
		setText(findTF(self.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/info/unMatch/txt"), i18n("equipskin_typewrong"))
		setText(findTF(self.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/info/unMatch/forbid_en"), i18n("equipskin_typewrong_en"))
		setText(findTF(self.skinR, "equipment_r" .. iter_1_0 .. "/info/equip/add/Text"), i18n("equipskin_add"))
		setText(findTF(self.skinR, "equipment_r" .. iter_1_0 .. "/info/forbid"), i18n("equipskin_none"))
	end

	for iter_1_1 = 1, 2 do
		if IsNil((self.equipmentTFs[3 + iter_1_1]:Find("info"))) then
			local var_1_0 = cloneTplTo(self.infoPanel, self.equipmentTFs[3 + iter_1_1], "info")
		end

		setActive(findTF(self.skinL, "equipment_l" .. iter_1_1 .. "/forbid"), false)
		setText(findTF(self.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/info/unMatch/txt"), i18n("equipskin_typewrong"))
		setText(findTF(self.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/info/unMatch/forbid_en"), i18n("equipskin_typewrong_en"))
		setText(findTF(self.skinL, "equipment_l" .. iter_1_1 .. "/info/equip/add/Text"), i18n("equipskin_add"))
		setText(findTF(self.skinL, "equipment_l" .. iter_1_1 .. "/info/forbid"), i18n("equipskin_none"))
	end

	for iter_1_2 = 1, #self.equipmentNormalTFs do
		setText(findTF(self.equipmentNormalTFs[iter_1_2], "empty/tip"), i18n("equip_add"))
	end

	setText(findTF(self.spweaponNormalTF, "empty/tip"), i18n("equip_add"))

	return
end

function ShipEquipSkinLogicPanel:setLabelResource(arg_2_1)
	self.resource = arg_2_1

	return
end

function ShipEquipSkinLogicPanel:doSwitchAnim(arg_3_1)
	if self:isTweening() then
		return
	end

	self.inSkinPage = arg_3_1

	self:doAnim(self.equipmentR, self.skinR)
	self:doAnim(self.equipmentL, self.skinL)

	return
end

function ShipEquipSkinLogicPanel:isTweening()
	if LeanTween.isTweening(go(self.equipmentR)) or LeanTween.isTweening(go(self.skinR)) or LeanTween.isTweening(go(self.equipmentL)) or LeanTween.isTweening(go(self.skinL)) then
		return true
	end

	return false
end

function ShipEquipSkinLogicPanel:doAnim(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetComponent(typeof(CanvasGroup))
	local var_5_1 = arg_5_2:GetComponent(typeof(CanvasGroup))

	LeanTween.moveLocal(go(arg_5_1), arg_5_2.localPosition, var_0_1)
	LeanTween.moveLocal(go(arg_5_2), arg_5_1.localPosition, var_0_1)

	local var_5_2 = 0.8
	local var_5_3 = 1

	if not self.inSkinPage then
		var_5_3 = 0.8
		var_5_2 = 1
	end

	LeanTween.value(go(arg_5_1), var_5_2, var_5_3, var_0_1):setOnUpdate(System.Action_float(function(arg_6_0)
		var_5_0.alpha = arg_6_0

		return
	end))
	LeanTween.value(go(arg_5_2), var_5_3, var_5_2, var_0_1):setOnUpdate(System.Action_float(function(arg_7_0)
		var_5_1.alpha = arg_7_0

		return
	end))

	var_5_1.blocksRaycasts = not self.inSkinPage
	var_5_0.blocksRaycasts = self.inSkinPage

	;(not self.inSkinPage and arg_5_2 or arg_5_1):SetAsLastSibling()

	return
end

function ShipEquipSkinLogicPanel:updateAll(arg_8_1)
	if arg_8_1 then
		for iter_8_0, iter_8_1 in ipairs(self.equipmentTFs) do
			if not not table.contains(ShipEquipView.UNLOCK_EQUIPMENT_SKIN_POS, iter_8_0) then
				self:updateEquipmentTF(arg_8_1, iter_8_0)
			end

			local var_8_0 = iter_8_1:Find("shadow")

			if var_8_0 then
				setActive(var_8_0, self.inSkinPage)
			end
		end

		for iter_8_2, iter_8_3 in ipairs(self.equipmentNormalTFs) do
			local var_8_1 = iter_8_3:Find("shadow")

			if var_8_1 then
				setActive(var_8_1, not self.inSkinPage)
			end
		end
	end

	return
end

function ShipEquipSkinLogicPanel:updateEquipmentTF(arg_9_1, arg_9_2)
	self.shipVO = arg_9_1

	if arg_9_1 then
		removeOnButton(self.equipmentTFs[arg_9_2])

		local var_9_0 = arg_9_1:getEquip(arg_9_2)
		local var_9_1 = arg_9_1:getEquipSkin(arg_9_2)
		local var_9_2 = self.equipmentTFs[arg_9_2]:Find("info")

		if IsNil(var_9_2) then
			var_9_2 = cloneTplTo(self.infoPanel, self.equipmentTFs[arg_9_2], "info")
		end

		self.equipmentTFs[arg_9_2]:Find("panel_title/type"):GetComponent(typeof(Text)).text = EquipType.LabelToName((EquipType.Types2Title(arg_9_2, self.shipVO.configId)))

		setActive(self.equipmentTFs[arg_9_2]:Find("unequip"), false)

		local var_9_3 = arg_9_1:getCanEquipSkin(arg_9_2)

		setActive(var_9_2:Find("forbid"), not var_9_3)

		local var_9_4 = var_9_2:Find("equip")

		setActive(var_9_4, var_9_3)

		if var_9_3 then
			self:updateEquipmentPanel(var_9_4, arg_9_2)
		end
	end

	return
end

function ShipEquipSkinLogicPanel:updateEquipmentPanel(arg_10_1, arg_10_2)
	if not self.shipVO:getCanEquipSkin(arg_10_2) then
		return
	end

	local var_10_0 = self.shipVO:getEquipSkin(arg_10_2) ~= 0
	local var_10_1 = self.shipVO:getEquip(arg_10_2)
	local var_10_2 = self.shipVO:getEquipSkin(arg_10_2)
	local var_10_3 = false

	if var_10_2 ~= 0 then
		if var_10_1 then
			if not table.contains(pg.equip_skin_template[var_10_2].equip_type, (var_10_1:getType())) then
				var_10_3 = true
			end
		else
			var_10_3 = true
		end
	end

	local var_10_4 = arg_10_1:Find("add")
	local var_10_5 = arg_10_1:Find("info")

	setActive(var_10_5, var_10_0)
	setActive(var_10_4, not var_10_0)
	setActive(var_10_5:Find("unMatch"), var_10_3)
	setActive(var_10_5:Find("desc"), not var_10_3)

	if var_10_0 then
		self:updateSkinInfo(var_10_5, var_10_2)
		onButton(self, self.equipmentTFs[arg_10_2], function()
			self:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_10_2)

			return
		end, SFX_PANEL)
	else
		onButton(self, var_10_4:Find("icon"), function()
			self:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_10_2)

			return
		end, SFX_PANEL)
	end

	return
end

function ShipEquipSkinLogicPanel:updateSkinInfo(arg_13_1, arg_13_2)
	assert(pg.equip_skin_template[arg_13_2], "miss config equip_skin_template >>" .. arg_13_2)
	setText(arg_13_1:Find("desc"), pg.equip_skin_template[arg_13_2].desc)
	setText(arg_13_1:Find("cont/name_mask/name"), shortenString(pg.equip_skin_template[arg_13_2].name, 10))
	updateDrop(arg_13_1:Find("IconTpl"), {
		type = DROP_TYPE_EQUIPMENT_SKIN,
		id = arg_13_2
	})

	return
end

return ShipEquipSkinLogicPanel
