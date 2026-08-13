class = var_0_10000

local var_0_0 = "PlayerVitaeSpineBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".PlayerVitaeBaseBtn"))

function var_0_1.GetBgName(arg_1_0)
	if arg_1_0:IsHrzType() then
		return "share/btn_l2d_atlas", "spine_painting_bg"
	else
		return "AdmiralUI_atlas", "sp"
	end

	return
end

function var_0_1.IsActive(arg_2_0, arg_2_1)
	HXSet = var_1_10002

	local var_2_0 = var_1_10002.autoHxShiftPath("spinepainting/" .. arg_2_1:getPainting())

	checkABExist = var_3

	return (var_3(var_2_0))
end

function var_0_1.GetDefaultValue(arg_3_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getCharacterSetting
	local var_3_2 = arg_3_0.ship.id

	SHIP_FLAG_SP = var_1_10004

	return var_3_1(var_3_0, var_3_2, var_1_10004)
end

function var_0_1.OnSwitch(arg_4_0, arg_4_1)
	ShipSkin = var_1_10002

	local var_4_0 = var_1_10002.GetChangeSkinData
	local var_4_1 = arg_4_0.ship
	local var_4_2

	if var_4_0(var_3.getSkinId(var_4_1)) and true or false then
		Live2dConst = var_4_2

		if not var_4_2.GetLive2DArm32MatchAble() then
			getProxy = var_4_2
			SettingsProxy = var_4_1
			var_4_1 = var_4_2(var_4_1)
			var_4_2 = var_4_2.setCharacterSetting

			local var_4_3 = arg_4_0.ship.id

			SHIP_FLAG_L2D = var_1_10006

			var_4_2(var_4_1, var_4_3, var_1_10006, arg_4_1)
		end
	end

	getProxy = var_4_2
	SettingsProxy = var_4_1

	local var_4_4 = var_4_2(var_4_1)
	local var_4_5 = var_3.setCharacterSetting
	local var_4_6 = arg_4_0.ship.id

	SHIP_FLAG_SP = var_1_10006

	var_4_5(var_4_4, var_4_6, var_1_10006, arg_4_1)

	return true
end

function var_0_1.Load(arg_5_0, arg_5_1)
	var_0_1.super.Load(arg_5_0, arg_5_1)

	if arg_5_0:IsHrzType() then
		arg_5_1.gameObject.name = "spine"
	end

	return
end

return var_0_1
