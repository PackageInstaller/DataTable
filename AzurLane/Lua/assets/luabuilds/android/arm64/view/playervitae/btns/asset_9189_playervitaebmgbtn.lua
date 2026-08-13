class = var_0_10000

local var_0_0 = "PlayerVitaeBMGBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerVitaeBaseBtn"))

function var_0_1.GetBgName(arg_1_0)
	return "AdmiralUI_atlas", "bgm"
end

function var_0_1.IsActive(arg_2_0, arg_2_1)
	return arg_2_1:IsBgmSkin()
end

function var_0_1.GetDefaultValue(arg_3_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	return var_1.IsBGMEnable(var_3_0)
end

function var_0_1.OnSwitch(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)

	var_2.SetBgmFlag(var_4_0, arg_4_1)

	local var_4_1

	if arg_4_1 then
		local var_4_2 = arg_4_0.ship

		var_4_1 = var_1_10003.GetSkinBgm(var_4_2)
	else
		var_4_1 = "main"
	end

	pg = var_1_10003

	local var_4_3 = var_1_10003.BgmMgr.GetInstance()
	local var_4_4 = var_3.Push

	PlayerVitaeScene = var_1_10006

	var_4_4(var_4_3, var_1_10006.__cname, var_4_1)

	return true
end

function var_0_1.Load(arg_5_0, arg_5_1)
	var_0_1.super.Load(arg_5_0, arg_5_1)

	if arg_5_0:IsHrzType() then
		arg_5_1.gameObject.name = "bmg"
	end

	return
end

return var_0_1
