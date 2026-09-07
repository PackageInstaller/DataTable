local BeatMonterNianActivity = class("BeatMonterNianActivity", import(".Activity"))

function BeatMonterNianActivity:GetDataConfig(arg_1_1)
	local var_1_0 = pg.activity_event_nianshou[tonumber((self:getConfig("config_id")))]

	return var_1_0 and var_1_0[arg_1_1]
end

function BeatMonterNianActivity:GetCountForHitMonster()
	return (pg.TimeMgr.GetInstance():parseTimeFrom(pg.TimeMgr.GetInstance():GetServerTime() - self:getStartTime()) + 1) * self:GetDataConfig("daily_count") + self:GetDataConfig("first_extra_count") - self.data2
end

return BeatMonterNianActivity
