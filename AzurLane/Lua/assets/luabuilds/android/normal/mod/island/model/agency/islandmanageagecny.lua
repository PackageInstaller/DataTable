class = var_0_10000

local var_0_0 = "IslandManageAgecny"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.UPDATE_RESTAURANT = "IslandManageAgecny.UPDATE_RESTAURANT"
var_0_1.ADD_RESTAURANT = "IslandManageAgecny.ADD_RESTAURANT"
var_0_1.ADD_ASSISTANT = "IslandManageAgecny.ADD_ASSISTANT"
var_0_1.ON_DAILY_REFRESH = "IslandManageAgecny.ON_DAILY_REFRESH"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.trade_sys then
		var_1_0 = {}
	end

	arg_1_0.restaurants = {}
	ipairs = var_3

	local var_1_1

	if not var_1_0.trade_list then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_1) do
		IslandRestaurant = var_1_10008
		var_1_10008 = var_1_10008.New(iter_1_1)
		arg_1_0.restaurants[iter_1_1.id] = var_1_10008
	end

	arg_1_0:InitEventData(var_1_0)
	arg_1_0:InitRemainCnt(var_1_0.today_num)
	arg_1_0:InitEstimateData(var_1_0.presell_list)

	return
end

function var_0_1.InitEventData(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.today_event then
		var_2_0 = 0
	end

	local var_2_1

	if not arg_2_1.today_trade then
		var_2_1 = 0
	end

	local var_2_2 = {}

	ipairs = var_1_10005

	local var_2_3

	if not arg_2_1.effect then
		var_2_3 = {}
	end

	for iter_2_0, iter_2_1 in var_1_10005(var_2_3) do
		var_2_2[iter_2_1.food_id] = iter_2_1.add_per / 100
	end

	pairs = var_5

	for iter_2_2, iter_2_3 in var_5(arg_2_0.restaurants) do
		if iter_2_3.id == var_2_1 then
			iter_2_3:InitEventData(var_2_0, var_2_2)
		else
			iter_2_3:InitEventData(0, {})
		end
	end

	return
end

function var_0_1.InitRemainCnt(arg_3_0, arg_3_1)
	local var_3_0 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_1 or {}) do
		var_3_0[iter_3_1.trade_id] = iter_3_1.num
	end

	pairs = var_3

	for iter_3_2, iter_3_3 in var_3(arg_3_0.restaurants) do
		local var_3_1 = iter_3_3
		local var_3_2 = iter_3_3.InitRemainCnt
		local var_3_3

		if not var_3_0[iter_3_3.id] then
			var_3_3 = 0
		end

		var_3_2(var_3_1, var_3_3)
	end

	return
end

function var_0_1.InitEstimateData(arg_4_0, arg_4_1)
	local var_4_0 = {}

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_1 or {}) do
		var_4_0[iter_4_1.trade_id] = iter_4_1
	end

	pairs = var_3

	for iter_4_2, iter_4_3 in var_3(arg_4_0.restaurants) do
		local var_4_1 = iter_4_3
		local var_4_2 = iter_4_3.InitEstimateData
		local var_4_3

		if not var_4_0[iter_4_3.id] then
			var_4_3 = {}
		end

		var_4_2(var_4_1, var_4_3)
	end

	return
end

function var_0_1.GetRestaurants(arg_5_0)
	return arg_5_0.restaurants
end

function var_0_1.GetRestaurantList(arg_6_0)
	underscore = var_1_10001

	return var_1_10001.values(arg_6_0.restaurants)
end

function var_0_1.GetRestaurant(arg_7_0, arg_7_1)
	return arg_7_0.restaurants[arg_7_1]
end

function var_0_1.GetCntByRestLevel(arg_8_0, arg_8_1)
	local var_8_0 = 0

	pairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.restaurants) do
		if arg_8_1 <= iter_8_1:GetRankLevel() then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_1.UpdataRestaurant(arg_9_0, arg_9_1)
	arg_9_0.restaurants[arg_9_1.id] = arg_9_1

	arg_9_0:DispatchEvent(var_0_1.UPDATE_RESTAURANT)

	return
end

function var_0_1.UnlockNewRestaurant(arg_10_0, arg_10_1)
	IslandRestaurant = var_1_10002

	local var_10_0 = var_1_10002.New({
		id = arg_10_1
	})

	var_2.InitEventData(var_10_0, 0, {})
	var_2:InitRemainCnt(0)

	arg_10_0.restaurants[var_2.id] = var_2

	arg_10_0:DispatchEvent(var_0_1.ADD_RESTAURANT)

	return
end

function var_0_1.UnlockNewAssistant(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.island_manage_assistant[arg_11_1].restaurant

	assert = var_1_10003

	local var_11_1 = arg_11_0.restaurants[var_11_0]

	string = var_1_10005

	var_1_10003(var_11_1, var_1_10005.format("未解锁%d餐厅,提前解锁了%d餐厅岗位", var_11_0, arg_11_1))

	local var_11_2 = arg_11_0.restaurants[var_11_0]

	var_3.UnlockNewAssistant(var_11_2, arg_11_1)
	arg_11_0:DispatchEvent(var_0_1.ADD_ASSISTANT)

	return
end

function var_0_1.DailyRefresh(arg_12_0, arg_12_1)
	arg_12_0:InitEventData(arg_12_1)
	arg_12_0:InitRemainCnt({})
	arg_12_0:DispatchEvent(var_0_1.ON_DAILY_REFRESH)

	return
end

function var_0_1.UnlockDailyEvent(arg_13_0, arg_13_1)
	arg_13_0:InitEventData(arg_13_1)

	return
end

function var_0_1.GetTipInfos(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = {}

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10004(var_1_10005.island_set.post_manage_operate.key_value_varchar) do
		if arg_14_0.restaurants[iter_14_1] then
			local var_14_3 = var_9
			local var_14_4 = var_9.GetStatus(var_14_3)

			IslandRestaurant = var_14_3

			if var_14_4 == var_14_3.STATUS.CLOSE then
				var_14_0 = var_14_0 + 1
			else
				IslandRestaurant = var_11

				if var_14_4 == var_11.STATUS.PREPARE then
					var_14_1 = var_14_1 + #var_9:GetAssistants()
				else
					IslandRestaurant = var_11

					if var_14_4 == var_11.STATUS.OPENING then
						table = var_11

						var_11.insert(var_14_2, var_9:GetEndTime())
					end
				end
			end
		end
	end

	return {
		awardCnt = var_14_0,
		emptyCnt = var_14_1,
		timestamps = var_14_2
	}
end

return var_0_1
