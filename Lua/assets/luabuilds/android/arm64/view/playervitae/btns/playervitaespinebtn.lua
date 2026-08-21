local var_0_0 = class("PlayerVitaeSpineBtn", import(".PlayerVitaeBaseBtn"))

function var_0_0.GetBgName(arg_1_0)
	if arg_1_0:IsHrzType() then
		return "share/btn_l2d_atlas", "spine_painting_bg"
	else
		return "AdmiralUI_atlas", "sp"
	end

	return
end

function var_0_0.IsActive(arg_2_0, arg_2_1)
	return (checkABExist((HXSet.autoHxShiftPath("spinepainting/" .. arg_2_1:getPainting()))))
end

function var_0_0.GetDefaultValue(arg_3_0)
	return getProxy(SettingsProxy):getCharacterSetting(arg_3_0.ship.id, SHIP_FLAG_SP)
end

function var_0_0.OnSwitch(arg_4_0, arg_4_1)
	if not not ShipSkin.GetChangeSkinData(arg_4_0.ship:getSkinId()) and not Live2dConst.GetLive2DArm32MatchAble() then
		getProxy(SettingsProxy):setCharacterSetting(arg_4_0.ship.id, SHIP_FLAG_L2D, arg_4_1)
	end

	getProxy(SettingsProxy):setCharacterSetting(arg_4_0.ship.id, SHIP_FLAG_SP, arg_4_1)

	return true
end

function var_0_0.Load(arg_5_0, arg_5_1)
	var_0_0.super.Load(arg_5_0, arg_5_1)

	if arg_5_0:IsHrzType() then
		arg_5_1.gameObject.name = "spine"
	end

	return
end

return var_0_0
