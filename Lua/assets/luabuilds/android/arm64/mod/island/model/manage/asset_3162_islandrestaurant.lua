local IslandRestaurant = class("IslandRestaurant", import("model.vo.BaseVO"))

IslandRestaurant.STATUS = {
	PREPARE = "prepare",
	END = "end",
	OPENING = "opening",
	CLOSE = "close"
}

function IslandRestaurant:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.level = arg_1_1.lv or 1
	self.rankCfg = pg.island_manage_rank[self.level] or 1
	self.sales = arg_1_1.total_sell or 0

	self:SetCommodities(arg_1_1.sell_list or {}, arg_1_1.rest_list or {})
	self:SetAssistants(arg_1_1.post_list)
	self:SetEndTime(arg_1_1.end_time or 0, arg_1_1.speed_time or 0)

	return
end

function IslandRestaurant:bindConfigTable()
	return pg.island_manage_restaurant
end

function IslandRestaurant:SetCommodities(arg_3_1, arg_3_2)
	self.commodities = {}
	self.sellCommodities = {}
	self.remainCommodities = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(self.sellCommodities, {
			id = iter_3_1.food_id,
			num = iter_3_1.num,
			price = iter_3_1.sell_money
		})

		self.commodities[iter_3_1.food_id] = {
			id = iter_3_1.food_id,
			num = iter_3_1.num
		}
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		local var_3_0 = iter_3_3.food_id
		local var_3_1 = iter_3_3.num

		table.insert(self.remainCommodities, {
			id = iter_3_3.food_id,
			num = iter_3_3.num
		})

		self.commodities[var_3_0] = {
			id = var_3_0,
			num = var_3_1 + ((self.commodities[var_3_0] or nil) and (self.commodities[var_3_0].num or 0))
		}
	end

	return
end

function IslandRestaurant:GetCommondities()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.commodities) do
		table.insert(var_4_0, iter_4_1)
	end

	return var_4_0
end

function IslandRestaurant:GetSellCommondities()
	return self.sellCommodities
end

function IslandRestaurant:GetRemainCommodities()
	return self.remainCommodities
end

function IslandRestaurant:SetAssistants(arg_7_1)
	self.assistants = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			table.insert(self.assistants, {
				id = iter_7_1.post_id,
				shipId = iter_7_1.ship_id
			})
		end
	else
		local var_7_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

		for iter_7_2, iter_7_3 in ipairs(self:getConfig("assistant_slot")) do
			if var_7_0:HasAbility(pg.island_manage_assistant[iter_7_3].unlock_type) then
				table.insert(self.assistants, {
					shipId = 0,
					id = iter_7_3
				})
			end
		end
	end

	return
end

function IslandRestaurant:GetAssistants()
	return self.assistants
end

function IslandRestaurant:ClearAssistantShips()
	for iter_9_0, iter_9_1 in ipairs(self.assistants) do
		iter_9_1.shipId = 0
	end

	return
end

function IslandRestaurant:SetEndTime(arg_10_1, arg_10_2)
	self.endTime = arg_10_1 - (arg_10_2 or 0)

	return
end

function IslandRestaurant:UpdateEndTime(arg_11_1)
	self.endTime = self.endTime - arg_11_1

	return
end

function IslandRestaurant:GetEndTime()
	return self.endTime
end

function IslandRestaurant:InitRemainCnt(arg_13_1)
	self.remainCnt = self:getConfig("opening_number") - arg_13_1

	return
end

function IslandRestaurant:ReduceRemainCnt()
	self.remainCnt = self.remainCnt - 1

	return
end

function IslandRestaurant:GetRemainCnt()
	return self.remainCnt
end

function IslandRestaurant:InitEstimateData(arg_16_1)
	local var_16_0 = {}

	var_16_0.cntMin = arg_16_1.sell_num_min or 0
	var_16_0.cntMax = arg_16_1.sell_num_max or 0
	var_16_0.salesMin = arg_16_1.sell_money_min or 0
	var_16_0.salesMax = arg_16_1.sell_money_max or 0
	self.estimateData = var_16_0

	return
end

function IslandRestaurant:GetEstimateData()
	return self.estimateData
end

function IslandRestaurant:InitEventData(arg_18_1, arg_18_2)
	self.eventId = arg_18_1
	self.eventEffects = arg_18_2
	self.eventInfluence = 0

	if self.eventId ~= 0 then
		self.eventInfluence = pg.island_manage_event[self.eventId].influence_bonus / 100
	end

	return
end

function IslandRestaurant:GetEventInfo()
	return self.eventId, self.eventEffects, self.eventInfluence
end

function IslandRestaurant:GetStatus()
	if self.endTime ~= 0 then
		return (pg.TimeMgr.GetInstance():GetServerTime() > self.endTime or nil) and (IslandRestaurant.STATUS.CLOSE or IslandRestaurant.STATUS.OPENING)
	else
		return (self.remainCnt > 0 or nil) and (IslandRestaurant.STATUS.PREPARE or IslandRestaurant.STATUS.END)
	end

	return
end

function IslandRestaurant:AddSales()
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(self.sellCommodities) do
		var_21_0 = var_21_0 + iter_21_1.price
	end

	IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.RESTAURANT_SALES, self.id, var_21_0)

	self.sales = self.sales + var_21_0

	return self:CheckUpgrade()
end

function IslandRestaurant:GetSales()
	return self.sales
end

function IslandRestaurant:CheckUpgrade()
	local var_23_0 = self:GetCanUpgradeExp()

	if var_23_0 ~= 0 and var_23_0 <= self.sales then
		self.level = self.level + 1
		self.rankCfg = pg.island_manage_rank[self.level]

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandRestUpgrade(self.id, self.level))
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.RESTAURANT_RANK)

		return true
	end

	return false
end

function IslandRestaurant:UnlockNewAssistant(arg_24_1)
	table.insert(self.assistants, {
		shipId = 0,
		id = arg_24_1
	})

	return
end

function IslandRestaurant:GetRankLevel()
	return self.level
end

function IslandRestaurant:GetShelfCnt()
	return self.rankCfg.slot_num[1]
end

function IslandRestaurant:GetBaseShelfCapacity()
	return self.rankCfg.slot_num[2]
end

function IslandRestaurant:GetRandomSaleCntBound()
	local var_28_0 = math.huge
	local var_28_1 = -math.huge

	for iter_28_0, iter_28_1 in ipairs(self.rankCfg.random_range) do
		if iter_28_1 < var_28_0 then
			var_28_0 = iter_28_1
		end

		if var_28_1 < iter_28_1 then
			var_28_1 = iter_28_1
		end
	end

	return var_28_0, var_28_1
end

function IslandRestaurant:GetCanUpgradeExp()
	return underscore.detect(self.rankCfg.level_up_exp, function(arg_30_0)
		return arg_30_0[1] == self.id
	end)[2]
end

function IslandRestaurant:GetRankFactor()
	return self.rankCfg.bonus_coefficient / 100
end

function IslandRestaurant:GetRankIcon()
	return self.rankCfg.icon
end

function IslandRestaurant:UpdateData(arg_33_1)
	self.level = arg_33_1.lv or 1
	self.rankCfg = pg.island_manage_rank[self.level] or 1
	self.sales = arg_33_1.total_sell or 0

	self:SetCommodities(arg_33_1.sell_list or {}, arg_33_1.rest_list or {})
	self:SetAssistants(arg_33_1.post_list or {})
	self:SetEndTime(arg_33_1.end_time or 0)

	return
end

function IslandRestaurant:IsPostTip()
	local var_34_0 = self:GetStatus()

	return var_34_0 == IslandRestaurant.STATUS.PREPARE or var_34_0 == IslandRestaurant.STATUS.CLOSE
end

function IslandRestaurant:GET_RNAK_EXPS()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(pg.island_manage_rank.all) do
		var_35_0[iter_35_1] = underscore.detect(pg.island_manage_rank[iter_35_1].level_up_exp, function(arg_36_0)
			return arg_36_0[1] == self
		end)[2]
	end

	return var_35_0
end

return IslandRestaurant
