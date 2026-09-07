local PlayerVitaeBGBtn = class("PlayerVitaeBGBtn", import(".PlayerVitaeBaseBtn"))

function PlayerVitaeBGBtn:GetBgName()
	if self:IsHrzType() then
		return "AdmiralUI_atlas", "bg_bg"
	else
		return "AdmiralUI_atlas", "bg"
	end

	return
end

function PlayerVitaeBGBtn:IsActive(arg_2_1)
	return arg_2_1:getShipBgPrint() ~= arg_2_1:rarity2bgPrintForGet()
end

function PlayerVitaeBGBtn:GetDefaultValue()
	return getProxy(SettingsProxy):getCharacterSetting(self.ship.id, SHIP_FLAG_BG)
end

function PlayerVitaeBGBtn:OnSwitch(arg_4_1)
	getProxy(SettingsProxy):setCharacterSetting(self.ship.id, SHIP_FLAG_BG, arg_4_1)

	return true
end

function PlayerVitaeBGBtn:Load(arg_5_1)
	PlayerVitaeBGBtn.super.Load(self, arg_5_1)

	if self:IsHrzType() then
		arg_5_1.gameObject.name = "bg"
	end

	return
end

return PlayerVitaeBGBtn
