class = var_0_10000

local var_0_0 = "MainLanternFestivalBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_LanternFestival"
end

function var_0_1.GetActivityID(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	return var_2_1(var_2_0, var_1_10004.LANTERNFESTIVAL) and var_1.id
end

function var_0_1.OnInit(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_3_2 = var_3_1(var_3_0, var_1_10004.LANTERNFESTIVAL)
	local var_3_3 = false

	if var_3_2 then
		local var_3_4 = var_3_2

		if not var_3_2.isEnd(var_3_4) then
			getProxy = var_3_0
			MiniGameProxy = var_3_4

			local var_3_5 = var_3_0(var_3_4)

			var_3_3 = var_3_0.GetHubByHubId(var_3_5, var_3_2:getConfig("config_id")).count > 0 and var_4.usedtime < 7
		end
	end

	setActive = var_3_0

	local var_3_6 = arg_3_0._tf

	var_3_0(var_5.Find(var_3_6, "Tip"), var_3_3)

	return
end

function var_0_1.CustomOnClick(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	if var_4_1(var_4_0, var_1_10004.LANTERNFESTIVAL) then
		pg = var_1_10002

		local var_4_2 = var_1_10002.m02
		local var_4_3 = var_2.sendNotification

		GAME = var_1_10005

		var_4_3(var_4_2, var_1_10005.GO_MINI_GAME, var_1:getConfig("config_client").miniGame)
	end

	return
end

return var_0_1
