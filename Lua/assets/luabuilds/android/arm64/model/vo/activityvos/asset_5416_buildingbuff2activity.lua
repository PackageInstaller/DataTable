local BuildingBuff2Activity = class("BuildingBuff2Activity", import("model.vo.Activity"))

function BuildingBuff2Activity:GetBuildingConfigTable(arg_1_1)
	return pg.activity_event_building[arg_1_1]
end

function BuildingBuff2Activity:GetBuildingLevel(arg_2_1)
	return self.data1KeyValueList[2][arg_2_1] or 1
end

function BuildingBuff2Activity:SetBuildingLevel(arg_3_1, arg_3_2)
	self.data1KeyValueList[2][arg_3_1] = arg_3_2

	return
end

function BuildingBuff2Activity:GetBuildingIds()
	return self:getConfig("config_data")[1]
end

function BuildingBuff2Activity:GetTotalBuildingLevel()
	local var_5_0 = self:GetBuildingIds()
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		var_5_1 = var_5_1 + self:GetBuildingLevel(iter_5_1)
	end

	return math.floor(var_5_1 / #var_5_0)
end

function BuildingBuff2Activity:GetBuildingLevelSum()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs((self:GetBuildingIds())) do
		var_6_0 = var_6_0 + (self:GetBuildingLevel(iter_6_1) - 1)
	end

	return var_6_0
end

function BuildingBuff2Activity:GetSceneBuildingId()
	return self:getConfig("config_id")
end

function BuildingBuff2Activity:GetLastRequestTime()
	return self.data1
end

function BuildingBuff2Activity:RecordLastRequestTime()
	self.data1 = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function BuildingBuff2Activity:CanRequest()
	return pg.TimeMgr.GetInstance():GetNextTime(0, 0, 0) - 0 > self:GetLastRequestTime()
end

return BuildingBuff2Activity
