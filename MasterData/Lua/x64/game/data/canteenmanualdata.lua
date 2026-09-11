local var_0_0 = singletonClass("CanteenManualData")
local var_0_1
local var_0_2

function var_0_0.EnterManualState(arg_1_0)
	var_0_1 = {
		manualSerCusNum = 0,
		hightPopularityNum = 0,
		manualPopNum = 0,
		manualGenCusNum = 0,
		manualTotalIncome = 0,
		manualSettlementList = {}
	}
	var_0_2 = {}
end

function var_0_0.ExitManualState(arg_2_0)
	var_0_1 = nil
	var_0_2 = nil
end

function var_0_0.GetManualPopNum(arg_3_0)
	if var_0_1 then
		return var_0_1.manualPopNum
	end

	return 0
end

function var_0_0.CookFoodComplete(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	CanteenAIFunction:GetEntityData(arg_4_3).curCooking = {
		cfgID = arg_4_4,
		taste = arg_4_5,
		quality = arg_4_2
	}
	var_0_2 = var_0_2 or {}
	var_0_2[arg_4_4] = var_0_2[arg_4_4] or 0
	var_0_2[arg_4_4] = var_0_2[arg_4_4] + 1

	CanteenFoodData:RefreshCanOrderFoodList()
end

var_0_0.COOK_FOOD_CANCELED = false

function var_0_0:CookFoodCanceled(arg_5_1, arg_5_2)
	CanteenAIFunction:GetEntityData(arg_5_2).curCooking = self.COOK_FOOD_CANCELED
end

function var_0_0.RecordCookFood(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = CanteenAIFunction:GetEntityData(arg_6_2)

	if var_0_1.manualSettlementList[arg_6_1] == nil then
		var_0_1.manualSettlementList[arg_6_1] = {}
	end

	var_0_1.manualSettlementList[arg_6_1].food_id = var_6_0.cfgID
	var_0_1.manualSettlementList[arg_6_1].quality = var_6_0.quality
	var_0_1.manualSettlementList[arg_6_1].guest_uid = 0
	var_0_1.manualSettlementList[arg_6_1].guest_id = 0
	var_0_1.manualSettlementList[arg_6_1].special_event = 0
	var_0_1.manualSettlementList[arg_6_1].evaluate = 0
end

function var_0_0.RecordFoodDelivery(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if var_0_1.manualSettlementList[arg_7_1] == nil then
		var_0_1.manualSettlementList[arg_7_1] = {}
	end

	var_0_1.manualSettlementList[arg_7_1].guest_uid = arg_7_2
	var_0_1.manualSettlementList[arg_7_1].guest_id = arg_7_3
end

function var_0_0.RecordFoodQuality(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		var_0_1.manualSettlementList[CanteenAIFunction:GetFoodManualIndex(iter_8_1)].evaluate = arg_8_2
	end
end

function var_0_0.RecordManualGenCustomerNum(arg_9_0, arg_9_1)
	var_0_1.manualGenCusNum = var_0_1.manualGenCusNum + arg_9_1
end

function var_0_0.RecordManualSerCustomerNum(arg_10_0, arg_10_1)
	var_0_1.manualSerCusNum = var_0_1.manualSerCusNum + arg_10_1
end

function var_0_0.GetManualInfo(arg_11_0)
	return var_0_1
end

function var_0_0.GetTotalIncome(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(var_0_1.manualSettlementList) do
		var_12_0[BackHomeCanteenFoodCfg[iter_12_1.food_id].cook_type] = var_12_0[BackHomeCanteenFoodCfg[iter_12_1.food_id].cook_type] or 0
		var_12_0[BackHomeCanteenFoodCfg[iter_12_1.food_id].cook_type] = var_12_0[BackHomeCanteenFoodCfg[iter_12_1.food_id].cook_type] + BackHomeCanteenFoodCfg[iter_12_1.food_id].sell * GameSetting.canteen_customer_evaluation.value[iter_12_1.quality][2] / 100
	end

	local var_12_1 = 0

	for iter_12_2, iter_12_3 in pairs(var_12_0) do
		var_12_1 = var_12_1 + (DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostRise, nil, nil, iter_12_2) + 100) / 100 * iter_12_3
	end

	var_0_1.ManualTotalIncome = math.floor(var_12_1)

	return var_0_1.ManualTotalIncome
end

function var_0_0.ManualConsumeMaterial(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(var_0_1.manualSettlementList) do
		if iter_13_1 then
			for iter_13_2, iter_13_3 in ipairs(BackHomeCanteenFoodCfg[iter_13_1.food_id].ingredient_list) do
				var_13_0[iter_13_3[1]] = var_13_0[iter_13_3[1]] or 0
				var_13_0[iter_13_3[1]] = var_13_0[iter_13_3[1]] + iter_13_3[2]
			end
		end
	end

	local var_13_1 = {}

	for iter_13_4, iter_13_5 in pairs(var_13_0) do
		table.insert(var_13_1, {
			iter_13_4,
			iter_13_5
		})
	end

	return var_13_1
end

function var_0_0.CalculateRemainPopularity(arg_14_0)
	return (math.floor(var_0_1.manualPopNum * GameSetting.canteen_hot_hold.value[1] / 100))
end

function var_0_0.MostPopFoodIdAndNum(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(var_0_1.manualSettlementList) do
		var_15_0[iter_15_1.food_id] = var_15_0[iter_15_1.food_id] or 0
		var_15_0[iter_15_1.food_id] = var_15_0[iter_15_1.food_id] + 1
	end

	local var_15_1 = {
		num = -1,
		name = ""
	}
	local var_15_2 = 0
	local var_15_3

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		if var_15_2 < iter_15_3 then
			var_15_3 = iter_15_2
			var_15_2 = iter_15_3
		end
	end

	if var_15_3 then
		var_15_1.name = BackHomeCanteenFoodCfg[var_15_3].name
		var_15_1.num = var_15_2

		return var_15_1
	end

	return var_15_1
end

function var_0_0.GetManualCookFoodInfo(arg_16_0)
	return var_0_2
end

function var_0_0.AddPopularityNum(arg_17_0, arg_17_1)
	var_0_1.manualPopNum = var_0_1.manualPopNum + GameSetting.canteen_hot_increase.value[arg_17_1][2]

	manager.notify:Invoke(DORM_REFRESH_POPULAR_EVENT)
end

function var_0_0:GetManualAward(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1.oper_list) do
		CanteenFoodData:AddFoodProficiency(iter_18_1.food_id, iter_18_1.quality)
	end

	CanteenData:ReceiveCurPenEarSuccess(self:GetTotalIncome(), DormEnum.RestaurantMode.RestaurantManual)

	local var_18_0 = CanteenData:GetPopularInfo()

	var_18_0.dynamicNum = var_18_0.dynamicNum + CanteenManualData:CalculateRemainPopularity()

	if var_18_0.dynamicNum < 0 then
		var_18_0.dynamicNum = 0
	end

	if var_0_2 then
		local var_18_1 = CanteenFoodData:GetFoodToSignList()

		for iter_18_2, iter_18_3 in pairs(var_0_2) do
			var_18_1[iter_18_2].soldNum = var_18_1[iter_18_2].soldNum + iter_18_3
			var_18_1[iter_18_2].soldIncome = var_18_1[iter_18_2].soldIncome + CanteenFoodData:GetFoodUnitCost(iter_18_2) * iter_18_3
		end
	end
end

return var_0_0
