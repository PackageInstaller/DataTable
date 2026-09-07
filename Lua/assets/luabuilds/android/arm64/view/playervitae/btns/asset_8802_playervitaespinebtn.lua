local PlayerVitaeSpineBtn = class("PlayerVitaeSpineBtn", import(".PlayerVitaeBaseBtn"))

function PlayerVitaeSpineBtn:GetBgName()
	if self:IsHrzType() then
		return "share/btn_l2d_atlas", "spine_painting_bg"
	else
		return "AdmiralUI_atlas", "sp"
	end

	return
end

function PlayerVitaeSpineBtn:IsActive(arg_2_1)
	return (checkABExist((HXSet.autoHxShiftPath("spinepainting/" .. arg_2_1:getPainting()))))
end

function PlayerVitaeSpineBtn:GetDefaultValue()
	return getProxy(SettingsProxy):getCharacterSetting(self.ship.id, SHIP_FLAG_SP)
end

function PlayerVitaeSpineBtn:OnSwitch(arg_4_1)
	if not not ShipSkin.GetChangeSkinData(self.ship:getSkinId()) and not Live2dConst.GetLive2DArm32MatchAble() then
		getProxy(SettingsProxy):setCharacterSetting(self.ship.id, SHIP_FLAG_L2D, arg_4_1)
	end

	getProxy(SettingsProxy):setCharacterSetting(self.ship.id, SHIP_FLAG_SP, arg_4_1)

	return true
end

function PlayerVitaeSpineBtn:Load(arg_5_1)
	PlayerVitaeSpineBtn.super.Load(self, arg_5_1)

	if self:IsHrzType() then
		arg_5_1.gameObject.name = "spine"
	end

	return
end

return PlayerVitaeSpineBtn
