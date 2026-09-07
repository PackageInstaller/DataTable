local IslandTechnologyAgency = class("IslandTechnologyAgency", import(".IslandBaseAgency"))

IslandTechnologyAgency.PLACE_ID = 702

function IslandTechnologyAgency:OnInit(arg_1_1)
	local var_1_0 = arg_1_1.tech.finish_list
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.tech.repeat_finish_list) do
		var_1_1[iter_1_1.id] = iter_1_1.num
	end

	self.techData = {}
	self.formula2Id = {}

	for iter_1_2, iter_1_3 in ipairs(pg.island_technology_template.all) do
		local var_1_2 = IslandTechnology.New(iter_1_3)

		if var_1_2:IsOnceType() then
			var_1_2:SetFinishedCnt(table.contains(var_1_0, iter_1_3) and 1 or 0)
		else
			var_1_2:SetFinishedCnt(var_1_1[iter_1_3] or 0)
		end

		self.techData[var_1_2.id] = var_1_2
		self.formula2Id[var_1_2:GetFormulaId()] = var_1_2.id
	end

	return
end

function IslandTechnologyAgency:InitLockData()
	self.lockIds = {}

	for iter_2_0, iter_2_1 in pairs(self.techData) do
		if not iter_2_1:IsUnlock() then
			table.insert(self.lockIds, iter_2_1.id)
		end
	end

	return
end

function IslandTechnologyAgency:GetTechnology(arg_3_1)
	return self.techData[arg_3_1]
end

function IslandTechnologyAgency:GetTechnologys()
	return self.techData
end

function IslandTechnologyAgency:GetTechnologyByFormulaId(arg_5_1)
	return self.techData[self.formula2Id[arg_5_1]]
end

function IslandTechnologyAgency:AddFinishCntByFormulatId(arg_6_1)
	self:GetTechnologyByFormulaId(arg_6_1):AddFinishedCnt()

	return
end

function IslandTechnologyAgency:GetAutoFinishList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.techData) do
		if iter_7_1:CheckFinishImmd() then
			table.insert(var_7_0, iter_7_1.id)
		end
	end

	return var_7_0
end

function IslandTechnologyAgency:IsUnlockTech(arg_8_1)
	return self.techData[arg_8_1]:IsUnlock()
end

function IslandTechnologyAgency:IsFinishedTech(arg_9_1)
	if not self.techData[arg_9_1] then
		return false
	end

	return self.techData[arg_9_1]:GetFinishedCnt() > 0
end

function IslandTechnologyAgency:GetPctByType(arg_10_1)
	return math.floor(self:GetFinishCntByType(arg_10_1) / #pg.island_technology_template.get_id_list_by_tech_belong[arg_10_1] * 100)
end

function IslandTechnologyAgency:GetFinishCntByType(arg_11_1)
	return underscore.reduce(pg.island_technology_template.get_id_list_by_tech_belong[arg_11_1], 0, function(arg_12_0, arg_12_1)
		return arg_12_0 + (self:IsFinishedTech(arg_12_1) and 1 or 0)
	end)
end

function IslandTechnologyAgency:GetAllTypeFinishCnt()
	return underscore.reduce(pg.island_technology_template.all, 0, function(arg_14_0, arg_14_1)
		return arg_14_0 + (self:IsFinishedTech(arg_14_1) and 1 or 0)
	end)
end

function IslandTechnologyAgency:GetEmptySlotId()
	local var_15_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(IslandTechnologyAgency.PLACE_ID)

	for iter_15_0, iter_15_1 in ipairs(IslandTechnologyAgency.GetSlotIds()) do
		local var_15_1 = var_15_0:GetDelegationSlotData(iter_15_1)

		if var_15_1 and var_15_1:CanStartDelegation() then
			return iter_15_1
		end
	end

	return nil
end

function IslandTechnologyAgency:RemoveLockId(arg_16_1)
	table.removebyvalue(self.lockIds, arg_16_1)

	return
end

function IslandTechnologyAgency:TryAutoUnlock(arg_17_1)
	if self.isInPlan then
		return
	end

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self.lockIds) do
		table.insert(var_17_0, function(arg_18_0)
			if not self.techData[iter_17_1]:IsUnlock() and self.techData[iter_17_1]:CanUnlock() then
				pg.m02:sendNotification(GAME.ISLAND_UNLOCK_TECH, {
					techId = iter_17_1,
					callback = arg_18_0
				})
			else
				arg_18_0()
			end

			return
		end)
	end

	self.isInPlan = true

	seriesAsync(var_17_0, function()
		existCall(arg_17_1)

		self.isInPlan = false

		return
	end)

	return
end

function IslandTechnologyAgency:IsTip()
	local var_20_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(IslandTechnologyAgency.PLACE_ID)

	for iter_20_0, iter_20_1 in ipairs((IslandTechnologyAgency.GetSlotIds())) do
		local var_20_1 = var_20_0:GetDelegationSlotData(iter_20_1)

		if var_20_1 and var_20_1:GetSlotRewardData() then
			return true
		end
	end

	return false
end

function IslandTechnologyAgency.GetSlotIds()
	return pg.island_production_slot.get_id_list_by_place[IslandTechnologyAgency.PLACE_ID]
end

return IslandTechnologyAgency
