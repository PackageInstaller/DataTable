local var_0_0 = class("IslandManageAgecny", import(".IslandBaseAgency"))

var_0_0.UPDATE_RESTAURANT = "IslandManageAgecny.UPDATE_RESTAURANT"
var_0_0.ADD_RESTAURANT = "IslandManageAgecny.ADD_RESTAURANT"
var_0_0.ADD_ASSISTANT = "IslandManageAgecny.ADD_ASSISTANT"
var_0_0.ON_DAILY_REFRESH = "IslandManageAgecny.ON_DAILY_REFRESH"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.trade_sys or {}

	arg_1_0.restaurants = {}

	local var_1_1 = var_1_0.trade_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		arg_1_0.restaurants[iter_1_1.id] = IslandRestaurant.New(iter_1_1)
	end

	arg_1_0:InitEventData(var_1_0)
	arg_1_0:InitRemainCnt(var_1_0.today_num)
	arg_1_0:InitEstimateData(var_1_0.presell_list)

	return
end

function var_0_0.InitEventData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.today_event or 0
	local var_2_1 = arg_2_1.today_trade or 0
	local var_2_2 = {}
	local var_2_3 = arg_2_1.effect or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_3) do
		var_2_2[iter_2_1.food_id] = iter_2_1.add_per / 100
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_0.restaurants) do
		if iter_2_3.id == var_2_1 then
			iter_2_3:InitEventData(var_2_0, var_2_2)
		else
			iter_2_3:InitEventData(0, {})
		end
	end

	return
end

function var_0_0.InitRemainCnt(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1 or {}) do
		({})[iter_3_1.trade_id] = iter_3_1.num
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0.restaurants) do
		local var_3_1 = ({})[iter_3_3.id]

		if not ({})[iter_3_3.id] then
			var_3_1 = 0
		end

		iter_3_3:InitRemainCnt(var_3_1)
	end

	return
end

function var_0_0.InitEstimateData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		({})[iter_4_1.trade_id] = iter_4_1
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.restaurants) do
		local var_4_1 = ({})[iter_4_3.id]

		if not ({})[iter_4_3.id] then
			var_4_1 = {}
		end

		iter_4_3:InitEstimateData(var_4_1)
	end

	return
end

function var_0_0.GetRestaurants(arg_5_0)
	return arg_5_0.restaurants
end

function var_0_0.GetRestaurantList(arg_6_0)
	return underscore.values(arg_6_0.restaurants)
end

function var_0_0.GetRestaurant(arg_7_0, arg_7_1)
	return arg_7_0.restaurants[arg_7_1]
end

function var_0_0.GetCntByRestLevel(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0.restaurants) do
		if arg_8_1 <= iter_8_1:GetRankLevel() then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.UpdataRestaurant(arg_9_0, arg_9_1)
	arg_9_0.restaurants[arg_9_1.id] = arg_9_1

	arg_9_0:DispatchEvent(var_0_0.UPDATE_RESTAURANT)

	return
end

function var_0_0.UnlockNewRestaurant(arg_10_0, arg_10_1)
	local var_10_0 = IslandRestaurant.New({
		id = arg_10_1
	})

	var_10_0:InitEventData(0, {})
	var_10_0:InitRemainCnt(0)

	arg_10_0.restaurants[var_10_0.id] = var_10_0

	arg_10_0:DispatchEvent(var_0_0.ADD_RESTAURANT)

	return
end

function var_0_0.UnlockNewAssistant(arg_11_0, arg_11_1)
	assert(arg_11_0.restaurants[pg.island_manage_assistant[arg_11_1].restaurant], string.format("未解锁%d餐厅,提前解锁了%d餐厅岗位", pg.island_manage_assistant[arg_11_1].restaurant, arg_11_1))
	arg_11_0.restaurants[pg.island_manage_assistant[arg_11_1].restaurant]:UnlockNewAssistant(arg_11_1)
	arg_11_0:DispatchEvent(var_0_0.ADD_ASSISTANT)

	return
end

function var_0_0.DailyRefresh(arg_12_0, arg_12_1)
	arg_12_0:InitEventData(arg_12_1)
	arg_12_0:InitRemainCnt({})
	arg_12_0:DispatchEvent(var_0_0.ON_DAILY_REFRESH)

	return
end

function var_0_0.UnlockDailyEvent(arg_13_0, arg_13_1)
	arg_13_0:InitEventData(arg_13_1)

	return
end

function var_0_0.GetTipInfos(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in ipairs(pg.island_set.post_manage_operate.key_value_varchar) do
		if arg_14_0.restaurants[iter_14_1] then
			local var_14_2 = arg_14_0.restaurants[iter_14_1]:GetStatus()

			if var_14_2 == IslandRestaurant.STATUS.CLOSE then
				var_14_0 = var_14_0 + 1
			elseif var_14_2 == IslandRestaurant.STATUS.PREPARE then
				var_14_1 = var_14_1 + #arg_14_0.restaurants[iter_14_1]:GetAssistants()
			elseif var_14_2 == IslandRestaurant.STATUS.OPENING then
				table.insert({}, arg_14_0.restaurants[iter_14_1]:GetEndTime())
			end
		end
	end

	return {
		awardCnt = var_14_0,
		emptyCnt = var_14_1,
		timestamps = {}
	}
end

return var_0_0
