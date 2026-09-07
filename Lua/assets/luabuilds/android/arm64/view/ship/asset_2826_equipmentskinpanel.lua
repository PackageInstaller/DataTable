local EquipmentSkinPanel = class("EquipmentSkinPanel", import("..base.BasePanel"))
local var_0_1 = 0.2

function EquipmentSkinPanel:init()
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
	self.equipmentR = self._tf:Find("equipment_r/equipment")
	self.equipmentL = self._tf:Find("equipment_l/equipment")
	self.skinR = self._tf:Find("equipment_r/skin")
	self.skinL = self._tf:Find("equipment_l/skin")

	setActive(self.skinR, not LOCK_EQUIP_SKIN)
	setActive(self.skinL, not LOCK_EQUIP_SKIN)

	self.infoPanel = self.equipmentTFs[1]:Find("info")
	self.inSkinPage = true

	return
end

function EquipmentSkinPanel:setLabelResource(arg_2_1)
	self.resource = arg_2_1

	return
end

function EquipmentSkinPanel:doSwitchAnim(arg_3_1)
	if self:isTweening() then
		return
	end

	self.inSkinPage = arg_3_1

	self:doAnim(self.equipmentR, self.skinR)
	self:doAnim(self.equipmentL, self.skinL)

	return
end

function EquipmentSkinPanel:isTweening()
	if LeanTween.isTweening(go(self.equipmentR)) or LeanTween.isTweening(go(self.skinR)) or LeanTween.isTweening(go(self.equipmentL)) or LeanTween.isTweening(go(self.skinL)) then
		return true
	end

	return false
end

function EquipmentSkinPanel:doAnim(arg_5_1, arg_5_2)
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

	LeanTween.alphaCanvas(var_5_0, var_5_3, var_0_1):setFrom(var_5_2)
	LeanTween.value(go(arg_5_2), var_5_3, var_5_2, var_0_1):setOnUpdate(System.Action_float(function(arg_6_0)
		var_5_1.alpha = arg_6_0

		return
	end))

	var_5_1.blocksRaycasts = not self.inSkinPage
	var_5_0.blocksRaycasts = self.inSkinPage

	;(not self.inSkinPage and arg_5_2 or arg_5_1):SetAsLastSibling()

	return
end

function EquipmentSkinPanel:updateAll(arg_7_1)
	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(self.equipmentTFs) do
			if not not table.contains(ShipEquipView.UNLOCK_EQUIPMENT_SKIN_POS, iter_7_0) then
				self:updateEquipmentTF(arg_7_1, iter_7_0)
			end

			local var_7_0 = iter_7_1:Find("shadow")

			if var_7_0 then
				setActive(var_7_0, self.inSkinPage)
			end
		end

		for iter_7_2, iter_7_3 in ipairs(self.equipmentNormalTFs) do
			local var_7_1 = iter_7_3:Find("shadow")

			if var_7_1 then
				setActive(var_7_1, not self.inSkinPage)
			end
		end
	end

	return
end

function EquipmentSkinPanel:updateEquipmentTF(arg_8_1, arg_8_2)
	self.shipVO = arg_8_1

	if arg_8_1 then
		removeOnButton(self.equipmentTFs[arg_8_2])

		local var_8_0 = arg_8_1:getEquip(arg_8_2)
		local var_8_1 = self.equipmentTFs[arg_8_2]:Find("info")

		if IsNil(var_8_1) then
			var_8_1 = cloneTplTo(self.infoPanel, self.equipmentTFs[arg_8_2], "info")
		end

		local var_8_2 = self.equipmentTFs[arg_8_2]:Find("panel_title/type")

		var_8_2:GetComponent(typeof(Image)).sprite = self.resource:Find((EquipType.Types2Title(arg_8_2, self.shipVO.configId))):GetComponent(typeof(Image)).sprite

		var_8_2:GetComponent(typeof(Image)):SetNativeSize()
		setActive(var_8_1, var_8_0)
		setActive(self.equipmentTFs[arg_8_2]:Find("unequip"), not var_8_0)

		if var_8_0 then
			local var_8_3 = var_8_0:canEquipSkin()

			setActive(var_8_1:Find("forbid"), not var_8_3)

			local var_8_4 = var_8_1:Find("equip")

			setActive(var_8_4, var_8_3)

			if var_8_3 then
				self:updateEquipmentPanel(var_8_4, arg_8_2)
			end
		end
	end

	return
end

function EquipmentSkinPanel:updateEquipmentPanel(arg_9_1, arg_9_2)
	local var_9_0 = self.shipVO:getEquip(arg_9_2)
	local var_9_1 = var_9_0:hasSkin()
	local var_9_2 = arg_9_1:Find("add")
	local var_9_3 = arg_9_1:Find("info")

	setActive(var_9_3, var_9_1)
	setActive(var_9_2, not var_9_1)

	if var_9_1 then
		self:updateSkinInfo(var_9_3, var_9_0.skinId)
		onButton(self, self.equipmentTFs[arg_9_2], function()
			self:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_9_2)

			return
		end, SFX_PANEL)
	else
		onButton(self, var_9_2:Find("icon"), function()
			self:emit(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, arg_9_2)

			return
		end, SFX_PANEL)
	end

	return
end

function EquipmentSkinPanel:updateSkinInfo(arg_12_1, arg_12_2)
	assert(pg.equip_skin_template[arg_12_2], "miss config equip_skin_template >>" .. arg_12_2)
	setText(arg_12_1:Find("desc"), pg.equip_skin_template[arg_12_2].desc)
	setText(arg_12_1:Find("cont/name_mask/name"), pg.equip_skin_template[arg_12_2].name)
	updateDrop(arg_12_1:Find("IconTpl"), {
		type = DROP_TYPE_EQUIPMENT_SKIN,
		id = arg_12_2
	})

	return
end

return EquipmentSkinPanel
