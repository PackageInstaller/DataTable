class = var_0_10000

local var_0_0 = "MainActBoatAdBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_boat_ad_game"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0:IsShowTip()

	setActive = var_1_10002

	var_1_10002(arg_2_0.tipTr.gameObject, var_2_0)

	return
end

function var_0_1.GetActivityID(arg_3_0)
	return arg_3_0:GetLinkConfig().time[2]
end

function var_0_1.IsShowTip(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.mini_game[arg_4_0.config.param[1]].hub_id

	getProxy = var_2
	MiniGameProxy = var_1_10004

	local var_4_1 = var_2(var_1_10004)

	if var_2.GetHubByHubId(var_4_1, var_4_0) and var_2.count > 0 then
		return true
	end

	return false
end

return var_0_1
