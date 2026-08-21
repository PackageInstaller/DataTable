local var_0_0 = class("PlayerVitaeBMGBtn", import(".PlayerVitaeBaseBtn"))

function var_0_0.GetBgName(arg_1_0)
	return "AdmiralUI_atlas", "bgm"
end

function var_0_0.IsActive(arg_2_0, arg_2_1)
	return arg_2_1:IsBgmSkin()
end

function var_0_0.GetDefaultValue(arg_3_0)
	return getProxy(SettingsProxy):IsBGMEnable()
end

function var_0_0.OnSwitch(arg_4_0, arg_4_1)
	getProxy(SettingsProxy):SetBgmFlag(arg_4_1)

	local var_4_0 = arg_4_1 and arg_4_0.ship:GetSkinBgm() or "main"

	pg.BgmMgr.GetInstance():Push(PlayerVitaeScene.__cname, var_4_0)

	return true
end

function var_0_0.Load(arg_5_0, arg_5_1)
	var_0_0.super.Load(arg_5_0, arg_5_1)

	if arg_5_0:IsHrzType() then
		arg_5_1.gameObject.name = "bmg"
	end

	return
end

return var_0_0
