local IslandManageAgecny = class("IslandManageAgecny", import(".IslandBaseAgency"))

IslandManageAgecny.UPDATE_RESTAURANT = "IslandManageAgecny.UPDATE_RESTAURANT"
IslandManageAgecny.ADD_RESTAURANT = "IslandManageAgecny.ADD_RESTAURANT"
IslandManageAgecny.ADD_ASSISTANT = "IslandManageAgecny.ADD_ASSISTANT"
IslandManageAgecny.ON_DAILY_REFRESH = "IslandManageAgecny.ON_DAILY_REFRESH"

function IslandManageAgecny:OnInit(arg_1_1)
	local var_1_0 = arg_1_1.trade_sys or {}

	self.restaurants = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.trade_list or {}) do
		self.restaurants[iter_1_1.id] = IslandRestaurant.New(iter_1_1)
	end

	self:InitEventData(var_1_0)
	self:InitRemainCnt(var_1_0.today_num)
	self:InitEstimateData(var_1_0.presell_list)

	return
end

function IslandManageAgecny:InitEventData(arg_2_1)
	local var_2_0 = arg_2_1.today_event or 0
	local var_2_1 = arg_2_1.today_trade or 0
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.effect or {}) do
		var_2_2[iter_2_1.food_id] = iter_2_1.add_per / 100
	end

	for iter_2_2, iter_2_3 in pairs(self.restaurants) do
		if iter_2_3.id == var_2_1 then
			iter_2_3:InitEventData(var_2_0, var_2_2)
		else
			iter_2_3:InitEventData(0, {})
		end
	end

	return
end

function IslandManageAgecny:InitRemainCnt(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1 or {}) do
		var_3_0[iter_3_1.trade_id] = iter_3_1.num
	end

	for iter_3_2, iter_3_3 in pairs(self.restaurants) do
		iter_3_3:InitRemainCnt(var_3_0[iter_3_3.id] or 0)
	end

	return
end

function IslandManageAgecny:InitEstimateData(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		var_4_0[iter_4_1.trade_id] = iter_4_1
	end

	for iter_4_2, iter_4_3 in pairs(self.restaurants) do
		iter_4_3:InitEstimateData(var_4_0[iter_4_3.id] or {})
	end

	return
end

function IslandManageAgecny:GetRestaurants()
	return self.restaurants
end

function IslandManageAgecny:GetRestaurantList()
	return underscore.values(self.restaurants)
end

function IslandManageAgecny:GetRestaurant(arg_7_1)
	return self.restaurants[arg_7_1]
end

function IslandManageAgecny:GetCntByRestLevel(arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(self.restaurants) do
		if arg_8_1 <= iter_8_1:GetRankLevel() then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function IslandManageAgecny:UpdataRestaurant(arg_9_1)
	self.restaurants[arg_9_1.id] = arg_9_1

	self:DispatchEvent(IslandManageAgecny.UPDATE_RESTAURANT)

	return
end

function IslandManageAgecny:UnlockNewRestaurant(arg_10_1)
	local var_10_0 = IslandRestaurant.New({
		id = arg_10_1
	})

	var_10_0:InitEventData(0, {})
	var_10_0:InitRemainCnt(0)

	self.restaurants[var_10_0.id] = var_10_0

	self:DispatchEvent(IslandManageAgecny.ADD_RESTAURANT)

	return
end

function IslandManageAgecny:UnlockNewAssistant(arg_11_1)
	assert(self.restaurants[pg.island_manage_assistant[arg_11_1].restaurant], string.format("未解锁%d餐厅,提前解锁了%d餐厅岗位", pg.island_manage_assistant[arg_11_1].restaurant, arg_11_1))
	self.restaurants[pg.island_manage_assistant[arg_11_1].restaurant]:UnlockNewAssistant(arg_11_1)
	self:DispatchEvent(IslandManageAgecny.ADD_ASSISTANT)

	return
end

function IslandManageAgecny:DailyRefresh(arg_12_1)
	self:InitEventData(arg_12_1)
	self:InitRemainCnt({})
	self:DispatchEvent(IslandManageAgecny.ON_DAILY_REFRESH)

	return
end

function IslandManageAgecny:UnlockDailyEvent(arg_13_1)
	self:InitEventData(arg_13_1)

	return
end

function IslandManageAgecny:GetTipInfos()
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(pg.island_set.post_manage_operate.key_value_varchar) do
		if self.restaurants[iter_14_1] then
			local var_14_3 = self.restaurants[iter_14_1]:GetStatus()

			if var_14_3 == IslandRestaurant.STATUS.CLOSE then
				var_14_0 = var_14_0 + 1
			elseif var_14_3 == IslandRestaurant.STATUS.PREPARE then
				var_14_1 = var_14_1 + #self.restaurants[iter_14_1]:GetAssistants()
			elseif var_14_3 == IslandRestaurant.STATUS.OPENING then
				table.insert(var_14_2, self.restaurants[iter_14_1]:GetEndTime())
			end
		end
	end

	return {
		awardCnt = var_14_0,
		emptyCnt = var_14_1,
		timestamps = var_14_2
	}
end

return IslandManageAgecny
