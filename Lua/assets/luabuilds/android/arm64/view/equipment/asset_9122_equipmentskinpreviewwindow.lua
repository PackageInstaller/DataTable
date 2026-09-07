local EquipmentSkinPreviewWindow = class("EquipmentSkinPreviewWindow", import("view.ship.ShipPreviewLayer"))

function EquipmentSkinPreviewWindow:getUIName()
	return "EquipSkinPreviewUI"
end

function EquipmentSkinPreviewWindow:init()
	self.buttonList = self._tf:Find("left_panel/Buttons")
	self.hitToggle = self.buttonList:Find("HitEffect")
	self.spawnToggle = self.buttonList:Find("SpawnEffect")

	EquipmentSkinPreviewWindow.super.init(self)
	setText(self.hitToggle:Find("Text"), i18n("hit_preview"))
	setText(self.spawnToggle:Find("Text"), i18n("shoot_preview"))

	return
end

function EquipmentSkinPreviewWindow:didEnter()
	local var_3_0 = pg.equip_skin_template[self.equipSkinId]
	local var_3_1 = pg.equip_skin_template[self.equipSkinId].hit_fx_name ~= ""
	local var_3_2 = {
		EquipType.CannonQuZhu,
		EquipType.CannonQingXun,
		EquipType.CannonZhongXun,
		EquipType.Torpedo,
		EquipType.SubmarineTorpedo
	}

	if pg.equip_skin_template[self.equipSkinId].hit_fx_name ~= "" then
		var_3_1 = _.any(var_3_0.equip_type, function(arg_4_0)
			return table.contains(var_3_2, arg_4_0)
		end)
	end

	setActive(self.hitToggle, var_3_1)

	if var_3_1 then
		self.contextData.hitEffect = defaultValue(self.contextData.hitEffect, true)

		triggerToggle(self.hitToggle, self.contextData.hitEffect)
		onToggle(self, self.hitToggle, function(arg_5_0)
			self.contextData.hitEffect = arg_5_0

			self:RefreshFXMode()

			return
		end)
	else
		self.contextData.hitEffect = defaultValue(self.contextData.hitEffect, false)
	end

	local var_3_3 = var_3_0.fire_fx_name ~= ""

	setActive(self.spawnToggle, var_3_0.fire_fx_name ~= "")

	if var_3_3 then
		self.contextData.spawnEffect = defaultValue(self.contextData.spawnEffect, true)

		triggerToggle(self.spawnToggle, self.contextData.spawnEffect)
		onToggle(self, self.spawnToggle, function(arg_6_0)
			self.contextData.spawnEffect = arg_6_0

			self:RefreshFXMode()

			return
		end)
	else
		self.contextData.spawnEffect = defaultValue(self.contextData.spawnEffect, true)
	end

	EquipmentSkinPreviewWindow.super.didEnter(self)

	return
end

function EquipmentSkinPreviewWindow:RefreshFXMode()
	if not self.previewer then
		return
	end

	self.previewer:SetFXMode(self.contextData.spawnEffect, self.contextData.hitEffect)
	self.previewer:onWeaponUpdate()

	return
end

function EquipmentSkinPreviewWindow:showBarrage()
	EquipmentSkinPreviewWindow.super.showBarrage(self)
	self.previewer:SetFXMode(self.contextData.spawnEffect, self.contextData.hitEffect)

	return
end

function EquipmentSkinPreviewWindow:playLoadingAni()
	EquipmentSkinPreviewWindow.super.playLoadingAni(self)
	setActive(self.buttonList, false)

	return
end

function EquipmentSkinPreviewWindow:stopLoadingAni()
	EquipmentSkinPreviewWindow.super.stopLoadingAni(self)
	setActive(self.buttonList, true)

	return
end

return EquipmentSkinPreviewWindow
