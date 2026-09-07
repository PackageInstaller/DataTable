local MiniGameData = class("MiniGameData", import(".BaseVO"))

function MiniGameData:Ctor(arg_1_1)
	MiniGameData.super.Ctor(self, arg_1_1)

	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.configCsv = self:getConfig("config_csv")
	self.configCsvKey = self:getConfig("config_csv_key")
	self.runtimeData = {}
	self.exData = nil
	self.rank = {}
	self._rankCd = 0

	return
end

function MiniGameData:bindConfigTable()
	return pg.mini_game
end

function MiniGameData:GetSimpleValue(arg_3_1)
	return self:getConfig("simple_config_data")[arg_3_1]
end

function MiniGameData:GetConfigCsvValue(arg_4_1)
	return pg[self.configCsv][self.configCsvKey][arg_4_1]
end

function MiniGameData:GetConfigCsvLine(arg_5_1)
	return pg[self.configCsv][arg_5_1]
end

function MiniGameData:SetRuntimeData(arg_6_1, arg_6_2)
	self.runtimeData[arg_6_1] = arg_6_2

	return
end

function MiniGameData:GetRuntimeData(arg_7_1)
	return self.runtimeData[arg_7_1]
end

function MiniGameData:CheckInTime()
	local var_8_0 = getProxy(MiniGameProxy)
	local var_8_1 = self:getConfig("hub_id")

	if var_8_0:CheckHasHub(var_8_1) then
		return var_8_0:GetHubByHubId(var_8_1):CheckInTime()
	else
		return false
	end

	return
end

function MiniGameData:GetRank()
	return self.rank
end

function MiniGameData:SetRank(arg_10_1)
	self._rankCd = GetHalfHour()
	self.rank = arg_10_1

	return
end

function MiniGameData:CanFetchRank()
	return pg.TimeMgr.GetInstance():GetServerTime() > self._rankCd
end

return MiniGameData
