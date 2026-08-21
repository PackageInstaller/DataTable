local var_0_0 = class("BeatMonterNianActivity", import(".Activity"))

function var_0_0.GetDataConfig(arg_1_0, arg_1_1)
	local var_1_0 = pg.activity_event_nianshou[tonumber((arg_1_0:getConfig("config_id")))]

	return var_1_0 and var_1_0[arg_1_1]
end

function var_0_0.GetCountForHitMonster(arg_2_0)
	return (pg.TimeMgr.GetInstance():parseTimeFrom(pg.TimeMgr.GetInstance():GetServerTime() - arg_2_0:getStartTime()) + 1) * arg_2_0:GetDataConfig("daily_count") + arg_2_0:GetDataConfig("first_extra_count") - arg_2_0.data2
end

return var_0_0
