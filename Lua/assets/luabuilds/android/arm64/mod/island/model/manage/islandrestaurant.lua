local var_0_0 = class("IslandRestaurant", import("model.vo.BaseVO"))

var_0_0.STATUS = {
	PREPARE = "prepare",
	END = "end",
	OPENING = "opening",
	CLOSE = "close"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.level = arg_1_1.lv or 1
	arg_1_0.rankCfg = pg.island_manage_rank[arg_1_0.level] or 1
	arg_1_0.sales = arg_1_1.total_sell or 0

	local var_1_0 = arg_1_1.sell_list or {}
	local var_1_1 = arg_1_1.rest_list or {}

	arg_1_0:SetCommodities(var_1_0, var_1_1)
	arg_1_0:SetAssistants(arg_1_1.post_list)

	local var_1_2 = arg_1_1.end_time or 0
	local var_1_3 = arg_1_1.speed_time or 0

	arg_1_0:SetEndTime(var_1_2, var_1_3)

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_manage_restaurant
end

function var_0_0.SetCommodities(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.commodities = {}
	arg_3_0.sellCommodities = {}
	arg_3_0.remainCommodities = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(arg_3_0.sellCommodities, {
			id = iter_3_1.food_id,
			num = iter_3_1.num,
			price = iter_3_1.sell_money
		})

		arg_3_0.commodities[iter_3_1.food_id] = {
			id = iter_3_1.food_id,
			num = iter_3_1.num
		}
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		local var_3_0 = iter_3_3.food_id
		local var_3_1 = iter_3_3.num

		table.insert(arg_3_0.remainCommodities, {
			id = iter_3_3.food_id,
			num = iter_3_3.num
		})

		if arg_3_0.commodities[var_3_0] then
			local var_3_2 = arg_3_0.commodities[var_3_0].num or 0

			arg_3_0.commodities[var_3_0] = {
				id = var_3_0,
				num = var_3_1 + var_3_2
			}
		end
	end

	return
end

function var_0_0.GetCommondities(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.commodities) do
		table.insert({}, iter_4_1)
	end

	return {}
end

function var_0_0.GetSellCommondities(arg_5_0)
	return arg_5_0.sellCommodities
end

function var_0_0.GetRemainCommodities(arg_6_0)
	return arg_6_0.remainCommodities
end

function var_0_0.SetAssistants(arg_7_0, arg_7_1)
	arg_7_0.assistants = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			table.insert(arg_7_0.assistants, {
				id = iter_7_1.post_id,
				shipId = iter_7_1.ship_id
			})
		end
	else
		local var_7_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

		for iter_7_2, iter_7_3 in ipairs(arg_7_0:getConfig("assistant_slot")) do
			if var_7_0:HasAbility(pg.island_manage_assistant[iter_7_3].unlock_type) then
				table.insert(arg_7_0.assistants, {
					shipId = 0,
					id = iter_7_3
				})
			end
		end
	end

	return
end

function var_0_0.GetAssistants(arg_8_0)
	return arg_8_0.assistants
end

function var_0_0.ClearAssistantShips(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.assistants) do
		iter_9_1.shipId = 0
	end

	return
end

function var_0_0.SetEndTime(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.endTime = arg_10_1 - (arg_10_2 or 0)

	return
end

function var_0_0.UpdateEndTime(arg_11_0, arg_11_1)
	arg_11_0.endTime = arg_11_0.endTime - arg_11_1

	return
end

function var_0_0.GetEndTime(arg_12_0)
	return arg_12_0.endTime
end

function var_0_0.InitRemainCnt(arg_13_0, arg_13_1)
	arg_13_0.remainCnt = arg_13_0:getConfig("opening_number") - arg_13_1

	return
end

function var_0_0.ReduceRemainCnt(arg_14_0)
	arg_14_0.remainCnt = arg_14_0.remainCnt - 1

	return
end

function var_0_0.GetRemainCnt(arg_15_0)
	return arg_15_0.remainCnt
end

function var_0_0.InitEstimateData(arg_16_0, arg_16_1)
	({}).cntMin = arg_16_1.sell_num_min or 0
	;({}).cntMax = arg_16_1.sell_num_max or 0
	;({}).salesMin = arg_16_1.sell_money_min or 0
	;({}).salesMax = arg_16_1.sell_money_max or 0
	arg_16_0.estimateData = {}

	return
end

function var_0_0.GetEstimateData(arg_17_0)
	return arg_17_0.estimateData
end

function var_0_0.InitEventData(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.eventId = arg_18_1
	arg_18_0.eventEffects = arg_18_2
	arg_18_0.eventInfluence = 0

	if arg_18_0.eventId ~= 0 then
		arg_18_0.eventInfluence = pg.island_manage_event[arg_18_0.eventId].influence_bonus / 100
	end

	return
end

function var_0_0.GetEventInfo(arg_19_0)
	return arg_19_0.eventId, arg_19_0.eventEffects, arg_19_0.eventInfluence
end

function var_0_0.GetStatus(arg_20_0)
	if arg_20_0.endTime ~= 0 then
		if pg.TimeMgr.GetInstance():GetServerTime() > arg_20_0.endTime then
			do return var_0_0.STATUS.CLOSE or var_0_0.STATUS.OPENING end

			goto label_20_0

			::label_20_0::

			if arg_20_0.remainCnt > 0 then
				do
					return var_0_0.STATUS.PREPARE or var_0_0.STATUS.END
				end

				return
			end
		end
	end
end

function var_0_0.AddSales(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_0.sellCommodities) do
		var_21_0 = var_21_0 + iter_21_1.price
	end

	IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.RESTAURANT_SALES, arg_21_0.id, var_21_0)

	arg_21_0.sales = arg_21_0.sales + var_21_0

	return arg_21_0:CheckUpgrade()
end

function var_0_0.GetSales(arg_22_0)
	return arg_22_0.sales
end

function var_0_0.CheckUpgrade(arg_23_0)
	local var_23_0 = arg_23_0:GetCanUpgradeExp()

	if var_23_0 ~= 0 and var_23_0 <= arg_23_0.sales then
		arg_23_0.level = arg_23_0.level + 1
		arg_23_0.rankCfg = pg.island_manage_rank[arg_23_0.level]

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandRestUpgrade(arg_23_0.id, arg_23_0.level))
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.RESTAURANT_RANK)

		return true
	end

	return false
end

function var_0_0.UnlockNewAssistant(arg_24_0, arg_24_1)
	table.insert(arg_24_0.assistants, {
		shipId = 0,
		id = arg_24_1
	})

	return
end

function var_0_0.GetRankLevel(arg_25_0)
	return arg_25_0.level
end

function var_0_0.GetShelfCnt(arg_26_0)
	return arg_26_0.rankCfg.slot_num[1]
end

function var_0_0.GetBaseShelfCapacity(arg_27_0)
	return arg_27_0.rankCfg.slot_num[2]
end

function var_0_0.GetRandomSaleCntBound(arg_28_0)
	local var_28_0 = math.huge
	local var_28_1 = -math.huge

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.rankCfg.random_range) do
		if iter_28_1 < var_28_0 then
			var_28_0 = iter_28_1
		end

		if var_28_1 < iter_28_1 then
			var_28_1 = iter_28_1
		end
	end

	return var_28_0, var_28_1
end

function var_0_0.GetCanUpgradeExp(arg_29_0)
	return underscore.detect(arg_29_0.rankCfg.level_up_exp, function(arg_30_0)
		return arg_30_0[1] == arg_29_0.id
	end)[2]
end

function var_0_0.GetRankFactor(arg_31_0)
	return arg_31_0.rankCfg.bonus_coefficient / 100
end

function var_0_0.GetRankIcon(arg_32_0)
	return arg_32_0.rankCfg.icon
end

function var_0_0.UpdateData(arg_33_0, arg_33_1)
	arg_33_0.level = arg_33_1.lv or 1
	arg_33_0.rankCfg = pg.island_manage_rank[arg_33_0.level] or 1
	arg_33_0.sales = arg_33_1.total_sell or 0

	local var_33_0 = arg_33_1.sell_list or {}
	local var_33_1 = arg_33_1.rest_list or {}

	arg_33_0:SetCommodities(var_33_0, var_33_1)

	local var_33_2 = arg_33_1.post_list or {}

	arg_33_0:SetAssistants(var_33_2)

	local var_33_3 = arg_33_1.end_time or 0

	arg_33_0:SetEndTime(var_33_3)

	return
end

function var_0_0.IsPostTip(arg_34_0)
	local var_34_0 = arg_34_0:GetStatus()

	return var_34_0 == var_0_0.STATUS.PREPARE or var_34_0 == var_0_0.STATUS.CLOSE
end

function var_0_0.GET_RNAK_EXPS(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(pg.island_manage_rank.all) do
		({})[iter_35_1] = underscore.detect(pg.island_manage_rank[iter_35_1].level_up_exp, function(arg_36_0)
			return arg_36_0[1] == arg_35_0
		end)[2]
	end

	return {}
end

return var_0_0
