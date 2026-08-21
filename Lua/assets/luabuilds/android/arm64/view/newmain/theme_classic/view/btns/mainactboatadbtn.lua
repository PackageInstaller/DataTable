local var_0_0 = class("MainActBoatAdBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_boat_ad_game"
end

function var_0_0.OnInit(arg_2_0)
	setActive(arg_2_0.tipTr.gameObject, (arg_2_0:IsShowTip()))

	return
end

function var_0_0.GetActivityID(arg_3_0)
	return arg_3_0:GetLinkConfig().time[2]
end

function var_0_0.IsShowTip(arg_4_0)
	local var_4_0 = getProxy(MiniGameProxy):GetHubByHubId(pg.mini_game[arg_4_0.config.param[1]].hub_id)

	if var_4_0 and var_4_0.count > 0 then
		return true
	end

	return false
end

return var_0_0
