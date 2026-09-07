local IslandRoleDelegationData = class("IslandRoleDelegationData")

function IslandRoleDelegationData:Ctor(arg_1_1)
	self:UpdateData(arg_1_1)

	return
end

function IslandRoleDelegationData:UpdateData(arg_2_1)
	self.ship_id = arg_2_1.ship_id
	self.formula_id = arg_2_1.formula_id
	self.start_time = arg_2_1.start_time

	self:SetCostList(arg_2_1.cost_time_list)

	self.extraList = arg_2_1.times_extra or {}
	self.once_cost_power = arg_2_1.once_cost_power
	self.speed_time = arg_2_1.speed_time or 0

	self:SetIsSend(false)

	return
end

function IslandRoleDelegationData:AddExtraList(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(self.extraList, iter_3_1)
	end

	return
end

function IslandRoleDelegationData:GetExtraMainProduct(arg_4_1)
	return (self.extraList[arg_4_1] or nil) and (self.extraList[arg_4_1].main_extra or 0)
end

function IslandRoleDelegationData:GetExtraExtraProduct(arg_5_1)
	return (self.extraList[arg_5_1] or nil) and (self.extraList[arg_5_1].other_extra or 0)
end

function IslandRoleDelegationData:GetExtraExtraCost(arg_6_1)
	return (self.extraList[arg_6_1] or nil) and (self.extraList[arg_6_1].cost_extra or 0)
end

function IslandRoleDelegationData:AddCostList(arg_7_1)
	local var_7_0 = #self.cost_time_list
	local var_7_1 = #self.cost_time_list == 0 and 0 or self.cost_time_list[var_7_0]
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(self.cost_time_list, iter_7_1)

		self.cost_Alltime_list[var_7_0 + iter_7_0] = iter_7_1 + var_7_1 + var_7_2
		var_7_2 = iter_7_1 + var_7_2
	end

	self.end_time = self.end_time + var_7_2
	self.allTime = self.allTime + var_7_2

	return
end

function IslandRoleDelegationData:SetCostList(arg_8_1)
	self.cost_time_list = arg_8_1
	self.cost_Alltime_list = {}

	for iter_8_0, iter_8_1 in ipairs(self.cost_time_list) do
		self.cost_Alltime_list[iter_8_0] = iter_8_1 + 0
	end

	self.end_time = self.start_time

	for iter_8_2, iter_8_3 in ipairs(self.cost_time_list) do
		self.end_time = self.end_time + iter_8_3
	end

	self.allTime = self.end_time - self.start_time

	return
end

function IslandRoleDelegationData:AddSpeedTime(arg_9_1)
	self.speed_time = self.speed_time + arg_9_1

	return
end

function IslandRoleDelegationData:isEnd()
	local var_10_0

	if self.end_time > 0 then
		if pg.TimeMgr.GetInstance():GetServerTime() < self.end_time + 1 then
			var_10_0 = false

			goto label_10_0
		end
	end

	::label_10_0::

	return true
end

function IslandRoleDelegationData:GetFinishTime()
	return self.end_time
end

function IslandRoleDelegationData:GetAllTime()
	return self.allTime
end

function IslandRoleDelegationData:isSend()
	return self.issend
end

function IslandRoleDelegationData:SetIsSend(arg_14_1)
	self.issend = arg_14_1

	return
end

function IslandRoleDelegationData:InCurrentTime()
	local var_15_0 = pg.TimeMgr.GetInstance():GetServerTime() - self.start_time

	for iter_15_0, iter_15_1 in ipairs(self.cost_Alltime_list) do
		if var_15_0 <= iter_15_1 then
			return iter_15_0
		end
	end

	return #self.cost_Alltime_list
end

function IslandRoleDelegationData:GetCountByTimestamp(arg_16_1)
	for iter_16_0 = #self.cost_Alltime_list, 1, -1 do
		if arg_16_1 - self.start_time >= self.cost_Alltime_list[iter_16_0] then
			return iter_16_0
		end
	end

	return 0
end

function IslandRoleDelegationData:InCurrentTimeStart(arg_17_1)
	local var_17_0 = 0

	for iter_17_0 = 1, arg_17_1 - 1 do
		var_17_0 = var_17_0 + self.cost_time_list[iter_17_0]
	end

	return var_17_0 + self.start_time
end

function IslandRoleDelegationData:CurrentTimeNeed(arg_18_1)
	return self.cost_time_list[arg_18_1]
end

function IslandRoleDelegationData:CheckDelegationIsEnd()
	if not self:isSend() and self:isEnd() then
		return true
	end

	return
end

function IslandRoleDelegationData:CanRewardTimes()
	if pg.TimeMgr.GetInstance():GetServerTime() >= self.end_time then
		return #self.cost_time_list
	end

	return self:InCurrentTime() - 1
end

function IslandRoleDelegationData:GetCurrentCanRewardExtraMainNum()
	local var_21_0 = 0

	for iter_21_0 = 1, self:InCurrentTime() - 1 do
		var_21_0 = var_21_0 + self:GetExtraMainProduct(iter_21_0)
	end

	return var_21_0
end

function IslandRoleDelegationData:GetReturnExtraNum(arg_22_1)
	local var_22_0 = 0

	for iter_22_0 = #self.cost_time_list, #self.cost_time_list - arg_22_1 + 1, -1 do
		var_22_0 = var_22_0 + self:GetExtraExtraCost(iter_22_0)
	end

	return var_22_0
end

function IslandRoleDelegationData:LastTimes()
	return #self.cost_time_list - (self:InCurrentTime() - 1)
end

function IslandRoleDelegationData:OnGetAwardMidway(arg_24_1, arg_24_2, arg_24_3)
	self.start_time = arg_24_1

	self:SetCostList(arg_24_2)

	for iter_24_0 = 1, arg_24_3 do
		table.remove(self.extraList, 1)
	end

	return
end

return IslandRoleDelegationData
