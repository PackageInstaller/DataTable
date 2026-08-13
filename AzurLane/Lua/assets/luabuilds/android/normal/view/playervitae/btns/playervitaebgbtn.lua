class = var_0_10000

local var_0_0 = "PlayerVitaeBGBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".PlayerVitaeBaseBtn"))

function var_0_1.GetBgName(arg_1_0)
	if arg_1_0:IsHrzType() then
		return "AdmiralUI_atlas", "bg_bg"
	else
		return "AdmiralUI_atlas", "bg"
	end

	return
end

function var_0_1.IsActive(arg_2_0, arg_2_1)
	return arg_2_1:getShipBgPrint() ~= arg_2_1:rarity2bgPrintForGet()
end

function var_0_1.GetDefaultValue(arg_3_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getCharacterSetting
	local var_3_2 = arg_3_0.ship.id

	SHIP_FLAG_BG = var_1_10004

	return var_3_1(var_3_0, var_3_2, var_1_10004)
end

function var_0_1.OnSwitch(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = var_2.setCharacterSetting
	local var_4_2 = arg_4_0.ship.id

	SHIP_FLAG_BG = var_1_10005

	var_4_1(var_4_0, var_4_2, var_1_10005, arg_4_1)

	return true
end

function var_0_1.Load(arg_5_0, arg_5_1)
	var_0_1.super.Load(arg_5_0, arg_5_1)

	if arg_5_0:IsHrzType() then
		arg_5_1.gameObject.name = "bg"
	end

	return
end

return var_0_1
