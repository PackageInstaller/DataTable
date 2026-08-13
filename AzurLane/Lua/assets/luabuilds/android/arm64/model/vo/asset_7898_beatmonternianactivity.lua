class = var_0_10000

local var_0_0 = "BeatMonterNianActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Activity"))

function var_0_1.GetDataConfig(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.getConfig(var_1_0, "config_id")

	pg = var_1_10003

	local var_1_2 = var_1_10003.activity_event_nianshou

	tonumber = var_1_0

	local var_1_3

	var_1_3 = var_1_2[var_1_0(var_1_1)] and var_3[arg_1_1]

	return var_1_3
end

function var_0_1.GetCountForHitMonster(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getStartTime(var_2_0)

	pg = var_1_10002

	local var_2_2 = var_1_10002.TimeMgr.GetInstance()
	local var_2_3 = var_2.GetServerTime(var_2_2)

	pg = var_2_0

	local var_2_4 = var_2_0.TimeMgr.GetInstance()
	local var_2_5 = var_3.parseTimeFrom(var_2_4, var_2_3 - var_2_1)
	local var_2_6 = arg_2_0:GetDataConfig("daily_count")
	local var_2_7 = arg_2_0:GetDataConfig("first_extra_count")

	return (var_2_5 + 1) * var_2_6 + var_2_7 - arg_2_0.data2
end

return var_0_1
