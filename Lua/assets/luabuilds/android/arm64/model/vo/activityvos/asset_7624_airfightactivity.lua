local AirFightActivity = class("AirFightActivity", import("model.vo.Activity"))

function AirFightActivity:GetMaxProgress()
	return self:getConfig("config_data")[1]
end

function AirFightActivity:GetPerDayCount()
	return self:getConfig("config_data")[2]
end

function AirFightActivity:GetPerLevelProgress()
	return self:getConfig("config_data")[3]
end

function AirFightActivity:GetLevelCount()
	return self:GetMaxProgress() / self:GetPerLevelProgress()
end

function AirFightActivity:readyToAchieve()
	if self:IsTip() then
		return false
	end

	local var_5_0 = self:GetMaxProgress()
	local var_5_1 = self:GetPerDayCount()
	local var_5_2 = 0

	for iter_5_0 = 1, self:GetLevelCount() do
		var_5_2 = var_5_2 + (self:getKVPList(1, iter_5_0) or 0)
	end

	local var_5_3 = pg.TimeMgr.GetInstance()

	return var_5_2 < math.min((var_5_3:DiffDay(self.data1, var_5_3:GetServerTime()) + 1) * var_5_1, var_5_0)
end

function AirFightActivity:IsTip()
	local var_6_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt("airfight_tip_" .. self.id .. "_" .. var_6_0:getRawData().id, 0) > pg.TimeMgr.GetInstance().GetServerTime(var_6_0)
end

function AirFightActivity:RecordTip()
	if self:IsTip() then
		return
	end

	PlayerPrefs.SetInt("airfight_tip_" .. self.id .. "_" .. getProxy(PlayerProxy):getRawData().id, (pg.TimeMgr.GetInstance():GetTimeToNextTime()))

	return
end

return AirFightActivity
