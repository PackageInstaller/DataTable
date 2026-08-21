local var_0_0 = class("ReserveHeroCameraTemplate", ReserveCameraTemplate)

function var_0_0.GetTargetCameraGroupID(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2.skinID

	if not SkinCfg[var_1_0] then
		return 1
	end

	local var_1_1 = SkinCfg[var_1_0].hero
	local var_1_2 = HeroPosAndRotCfg[var_1_1]

	if not var_1_2 then
		return 1
	end

	if var_1_2.hero_view_height == 0 then
		return 1
	else
		return var_1_2.hero_view_height
	end
end

return var_0_0
