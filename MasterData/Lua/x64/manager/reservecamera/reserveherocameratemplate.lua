local ReserveHeroCameraTemplate = class("ReserveHeroCameraTemplate", ReserveCameraTemplate)

function ReserveHeroCameraTemplate:GetTargetCameraGroupID(arg_1_1, arg_1_2)
	if not SkinCfg[arg_1_2.skinID] then
		return 1
	end

	local var_1_0 = HeroPosAndRotCfg[SkinCfg[arg_1_2.skinID].hero]

	if not HeroPosAndRotCfg[SkinCfg[arg_1_2.skinID].hero] then
		return 1
	end

	if var_1_0.hero_view_height == 0 then
		return 1
	else
		return var_1_0.hero_view_height
	end
end

return ReserveHeroCameraTemplate
