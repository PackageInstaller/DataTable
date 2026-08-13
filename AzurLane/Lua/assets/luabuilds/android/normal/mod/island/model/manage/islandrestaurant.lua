class = var_0_10000

local var_0_0 = "IslandRestaurant"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.STATUS = {
	PREPARE = "prepare",
	END = "end",
	OPENING = "opening",
	CLOSE = "close"
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.lv then
		var_1_0 = 1
	end

	arg_1_0.level = var_1_0
	pg = var_1_0

	local var_1_1

	if not var_1_0.island_manage_rank[arg_1_0.level] then
		var_1_1 = 1
	end

	arg_1_0.rankCfg = var_1_1

	local var_1_2

	if not arg_1_1.total_sell then
		var_1_2 = 0
	end

	arg_1_0.sales = var_1_2

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.SetCommodities
	local var_1_5

	if not arg_1_1.sell_list then
		var_1_5 = {}
	end

	local var_1_6

	if not arg_1_1.rest_list then
		var_1_6 = {}
	end

	var_1_4(var_1_3, var_1_5, var_1_6)
	arg_1_0:SetAssistants(arg_1_1.post_list)

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.SetEndTime
	local var_1_9

	if not arg_1_1.end_time then
		var_1_9 = 0
	end

	local var_1_10

	if not arg_1_1.speed_time then
		var_1_10 = 0
	end

	var_1_8(var_1_7, var_1_9, var_1_10)

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_manage_restaurant
end

function var_0_1.SetCommodities(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.commodities = {}
	arg_3_0.sellCommodities = {}
	arg_3_0.remainCommodities = {}
	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(arg_3_1) do
		local var_3_0 = iter_3_1.food_id
		local var_3_1 = iter_3_1.num

		var_1_10010 = iter_3_1.sell_money
		table = var_1_10011

		var_1_10011.insert(arg_3_0.sellCommodities, {
			id = var_3_0,
			num = var_3_1,
			price = var_1_10010
		})

		var_1_10011 = arg_3_0.commodities
		var_1_10011[var_3_0] = {
			id = var_3_0,
			num = var_3_1
		}
	end

	ipairs = var_3

	for iter_3_2, iter_3_3 in var_3(arg_3_2) do
		local var_3_2 = iter_3_3.food_id
		local var_3_3 = iter_3_3.num

		table = var_1_10010

		var_1_10010.insert(arg_3_0.remainCommodities, {
			id = var_3_2,
			num = var_3_3
		})

		if not arg_3_0.commodities[var_3_2] or not arg_3_0.commodities[var_3_2].num then
			var_1_10010 = 0
		end

		arg_3_0.commodities[var_3_2] = {
			id = var_3_2,
			num = var_3_3 + var_1_10010
		}
	end

	return
end

function var_0_1.GetCommondities(arg_4_0)
	local var_4_0 = {}

	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.commodities) do
		table = var_1_10007

		var_1_10007.insert(var_4_0, iter_4_1)
	end

	return var_4_0
end

function var_0_1.GetSellCommondities(arg_5_0)
	return arg_5_0.sellCommodities
end

function var_0_1.GetRemainCommodities(arg_6_0)
	return arg_6_0.remainCommodities
end

function var_0_1.SetAssistants(arg_7_0, arg_7_1)
	arg_7_0.assistants = {}

	if arg_7_1 then
		ipairs = var_2

		for iter_7_0, iter_7_1 in var_2(arg_7_1) do
			table = var_1_10007

			var_1_10007.insert(arg_7_0.assistants, {
				id = iter_7_1.post_id,
				shipId = iter_7_1.ship_id
			})
		end
	else
		getProxy = var_2
		IslandProxy = var_1_10003

		local var_7_0 = var_2(var_1_10003)
		local var_7_1 = var_2.GetIsland(var_7_0)
		local var_7_2 = var_2.GetAblityAgency(var_7_1)

		ipairs = var_7_1

		for iter_7_2, iter_7_3 in var_7_1(arg_7_0:getConfig("assistant_slot")) do
			pg = var_1_10008
			var_1_10008 = var_1_10008.island_manage_assistant[iter_7_3].unlock_type

			if var_7_2:HasAbility(var_1_10008) then
				table = var_9

				var_9.insert(arg_7_0.assistants, {
					shipId = 0,
					id = iter_7_3
				})
			end
		end
	end

	return
end

function var_0_1.GetAssistants(arg_8_0)
	return arg_8_0.assistants
end

function var_0_1.ClearAssistantShips(arg_9_0)
	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.assistants) do
		iter_9_1.shipId = 0
	end

	return
end

function var_0_1.SetEndTime(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.endTime = arg_10_1 - (arg_10_2 or 0)

	return
end

function var_0_1.UpdateEndTime(arg_11_0, arg_11_1)
	arg_11_0.endTime = arg_11_0.endTime - arg_11_1

	return
end

function var_0_1.GetEndTime(arg_12_0)
	return arg_12_0.endTime
end

function var_0_1.InitRemainCnt(arg_13_0, arg_13_1)
	arg_13_0.remainCnt = arg_13_0:getConfig("opening_number") - arg_13_1

	return
end

function var_0_1.ReduceRemainCnt(arg_14_0)
	arg_14_0.remainCnt = arg_14_0.remainCnt - 1

	return
end

function var_0_1.GetRemainCnt(arg_15_0)
	return arg_15_0.remainCnt
end

function var_0_1.InitEstimateData(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1

	if not arg_16_1.sell_num_min then
		var_16_1 = 0
	end

	var_16_0.cntMin = var_16_1

	local var_16_2

	if not arg_16_1.sell_num_max then
		var_16_2 = 0
	end

	var_16_0.cntMax = var_16_2

	local var_16_3

	if not arg_16_1.sell_money_min then
		var_16_3 = 0
	end

	var_16_0.salesMin = var_16_3

	local var_16_4

	if not arg_16_1.sell_money_max then
		var_16_4 = 0
	end

	var_16_0.salesMax = var_16_4
	arg_16_0.estimateData = var_16_0

	return
end

function var_0_1.GetEstimateData(arg_17_0)
	return arg_17_0.estimateData
end

function var_0_1.InitEventData(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.eventId = arg_18_1
	arg_18_0.eventEffects = arg_18_2
	arg_18_0.eventInfluence = 0

	if arg_18_0.eventId ~= 0 then
		pg = var_3
		arg_18_0.eventInfluence = var_3.island_manage_event[arg_18_0.eventId].influence_bonus / 100
	end

	return
end

function var_0_1.GetEventInfo(arg_19_0)
	return arg_19_0.eventId, arg_19_0.eventEffects, arg_19_0.eventInfluence
end

function var_0_1.GetStatus(arg_20_0)
	if arg_20_0.endTime ~= 0 then
		pg = var_1

		local var_20_0 = var_1.TimeMgr.GetInstance()
		local var_20_1

		if not (var_1.GetServerTime(var_20_0) > arg_20_0.endTime) or not var_0_1.STATUS.CLOSE then
			var_20_1 = var_0_1.STATUS.OPENING
		end

		return var_20_1
	else
		local var_20_2

		if not (arg_20_0.remainCnt > 0) or not var_0_1.STATUS.PREPARE then
			var_20_2 = var_0_1.STATUS.END
		end

		return var_20_2
	end

	return
end

function var_0_1.AddSales(arg_21_0)
	local var_21_0 = 0

	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.sellCommodities) do
		var_21_0 = var_21_0 + iter_21_1.price
	end

	IslandAchievementHelper = var_2

	local var_21_1 = var_2.UpdateRecordWithAdd

	IslandAchievementType = var_3

	var_21_1(var_3.RESTAURANT_SALES, arg_21_0.id, var_21_0)

	arg_21_0.sales = arg_21_0.sales + var_21_0

	return arg_21_0:CheckUpgrade()
end

function var_0_1.GetSales(arg_22_0)
	return arg_22_0.sales
end

function var_0_1.CheckUpgrade(arg_23_0)
	if arg_23_0:GetCanUpgradeExp() ~= 0 and var_1 <= arg_23_0.sales then
		arg_23_0.level = arg_23_0.level + 1
		pg = var_2
		arg_23_0.rankCfg = var_2.island_manage_rank[arg_23_0.level]
		pg = var_2

		local var_23_0 = var_2.GameTrackerMgr.GetInstance()
		local var_23_1 = var_2.Record

		GameTrackerBuilder = var_1_10004

		var_23_1(var_23_0, var_1_10004.BuildIslandRestUpgrade(arg_23_0.id, arg_23_0.level))

		IslandTaskHelper = var_23_1

		local var_23_2 = var_23_1.UpdateRuntimeTaskByTargetType

		IslandTaskTargetType = var_23_0

		var_23_2(var_23_0.RESTAURANT_RANK)

		return true
	end

	return false
end

function var_0_1.UnlockNewAssistant(arg_24_0, arg_24_1)
	table = var_1_10002

	var_1_10002.insert(arg_24_0.assistants, {
		shipId = 0,
		id = arg_24_1
	})

	return
end

function var_0_1.GetRankLevel(arg_25_0)
	return arg_25_0.level
end

function var_0_1.GetShelfCnt(arg_26_0)
	return arg_26_0.rankCfg.slot_num[1]
end

function var_0_1.GetBaseShelfCapacity(arg_27_0)
	return arg_27_0.rankCfg.slot_num[2]
end

function var_0_1.GetRandomSaleCntBound(arg_28_0)
	math = var_1_10001

	local var_28_0 = var_1_10001.huge

	math = var_1_10002

	local var_28_1 = -var_1_10002.huge

	ipairs = var_1_10003

	for iter_28_0, iter_28_1 in var_1_10003(arg_28_0.rankCfg.random_range) do
		if iter_28_1 < var_28_0 then
			var_28_0 = iter_28_1
		end

		if var_28_1 < iter_28_1 then
			var_28_1 = iter_28_1
		end
	end

	return var_28_0, var_28_1
end

function var_0_1.GetCanUpgradeExp(arg_29_0)
	underscore = var_1_10001

	return var_1_10001.detect(arg_29_0.rankCfg.level_up_exp, function(arg_30_0)
		return arg_30_0[1] == arg_29_0.id
	end)[2]
end

function var_0_1.GetRankFactor(arg_31_0)
	return arg_31_0.rankCfg.bonus_coefficient / 100
end

function var_0_1.GetRankIcon(arg_32_0)
	return arg_32_0.rankCfg.icon
end

function var_0_1.UpdateData(arg_33_0, arg_33_1)
	local var_33_0

	if not arg_33_1.lv then
		var_33_0 = 1
	end

	arg_33_0.level = var_33_0
	pg = var_33_0

	local var_33_1

	if not var_33_0.island_manage_rank[arg_33_0.level] then
		var_33_1 = 1
	end

	arg_33_0.rankCfg = var_33_1

	local var_33_2

	if not arg_33_1.total_sell then
		var_33_2 = 0
	end

	arg_33_0.sales = var_33_2

	local var_33_3 = arg_33_0
	local var_33_4 = arg_33_0.SetCommodities
	local var_33_5

	if not arg_33_1.sell_list then
		var_33_5 = {}
	end

	local var_33_6

	if not arg_33_1.rest_list then
		var_33_6 = {}
	end

	var_33_4(var_33_3, var_33_5, var_33_6)

	local var_33_7 = arg_33_0
	local var_33_8 = arg_33_0.SetAssistants
	local var_33_9

	if not arg_33_1.post_list then
		var_33_9 = {}
	end

	var_33_8(var_33_7, var_33_9)

	local var_33_10 = arg_33_0
	local var_33_11 = arg_33_0.SetEndTime
	local var_33_12

	if not arg_33_1.end_time then
		var_33_12 = 0
	end

	var_33_11(var_33_10, var_33_12)

	return
end

function var_0_1.IsPostTip(arg_34_0)
	return arg_34_0:GetStatus() == var_0_1.STATUS.PREPARE or var_1 == var_0_1.STATUS.CLOSE
end

function var_0_1.GET_RNAK_EXPS(arg_35_0)
	local var_35_0 = {}

	pg = var_1_10002

	local var_35_1 = var_1_10002.island_manage_rank

	ipairs = var_1_10003

	for iter_35_0, iter_35_1 in var_1_10003(var_35_1.all) do
		underscore = var_1_10008
		var_35_0[iter_35_1] = var_1_10008.detect(var_35_1[iter_35_1].level_up_exp, function(arg_36_0)
			return arg_36_0[1] == arg_35_0
		end)[2]
	end

	return var_35_0
end

return var_0_1
