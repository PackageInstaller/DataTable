local var_0_0 = singletonClass("CanteenFoodData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4 = CanteenConst.CanteenMapID

function var_0_0.InitSimpleCanteenFoodData(arg_1_0, arg_1_1)
	var_0_0:InitSignFoodList(arg_1_1.canteens[1])
	var_0_0:InitCanteenIngredient(arg_1_1.ingredients)
end

function var_0_0.InitDetailCanteenFoodData(arg_2_0, arg_2_1)
	var_0_0:InitSignFoodList(arg_2_1.canteens[1])
	var_0_0:InitCanteenIngredient(arg_2_1.ingredients)
	var_0_0:InitFoodProficiency(arg_2_1.food)
end

function var_0_0.InitFoodProficiency(arg_3_0, arg_3_1)
	var_0_2 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_0_2[iter_3_1.id] = arg_3_0:InitFoodProficiencyData(iter_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(BackHomeCanteenFoodCfg.all) do
		if not var_0_2[iter_3_3] then
			local var_3_0 = {
				id = iter_3_3
			}

			var_0_2[iter_3_3] = arg_3_0:InitFoodProficiencyData(var_3_0)
		end
	end
end

function var_0_0.InitSignFoodList(arg_4_0, arg_4_1)
	var_0_4 = CanteenConst.CanteenMapID
	var_0_3 = {}

	local var_4_0 = arg_4_1.id

	var_0_3[var_4_0] = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.signature_dish) do
		var_0_3[var_4_0][iter_4_1.food_id] = {
			sellNum = iter_4_1.sell_num,
			soldNum = iter_4_1.sold_num,
			soldIncome = iter_4_1.sell_earnings
		}
	end

	arg_4_0:RefreshCanOrderFoodList()
end

function var_0_0.GetFoodToSignList(arg_5_0)
	return var_0_3
end

function var_0_0.GetChooseFoodList(arg_6_0)
	local var_6_0 = {}

	if var_0_3[var_0_4] then
		for iter_6_0, iter_6_1 in pairs(var_0_3[var_0_4]) do
			table.insert(var_6_0, iter_6_0)
		end
	end

	return var_6_0
end

function var_0_0.GetSignFoodInfo(arg_7_0, arg_7_1)
	if var_0_3[var_0_4][arg_7_1] then
		return var_0_3[var_0_4][arg_7_1]
	end

	print("未找到对应招牌菜信息")
end

function var_0_0.CheckIsSignFood(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(var_0_3[var_0_4]) do
		if arg_8_1 == iter_8_0 then
			return true
		end
	end

	return false
end

function var_0_0.PushFoodToSignList(arg_9_0, arg_9_1, arg_9_2)
	if var_0_3[var_0_4] then
		if arg_9_2 then
			var_0_3[var_0_4][arg_9_1] = {}
			var_0_3[var_0_4][arg_9_1] = {
				soldIncome = 0,
				soldNum = 0,
				sellNum = arg_9_2
			}
		elseif var_0_3[var_0_4][arg_9_1] then
			var_0_3[var_0_4][arg_9_1] = nil
		end
	end

	arg_9_0:RefreshCanOrderFoodList()
end

local var_0_5

function var_0_0.GetCanOrderFoodList(arg_10_0)
	return var_0_5
end

local var_0_6 = 100000

function var_0_0.CalculateFoodCanCookNum(arg_11_0, arg_11_1)
	local var_11_0 = CanteenFoodData:CheckIsSignFood(arg_11_1)
	local var_11_1 = 0

	if not var_11_0 then
		local var_11_2 = BackHomeCanteenFoodCfg[arg_11_1].ingredient_list
		local var_11_3 = var_0_6

		for iter_11_0, iter_11_1 in pairs(var_11_2) do
			local var_11_4 = iter_11_1[1]
			local var_11_5 = iter_11_1[2]
			local var_11_6 = arg_11_0:GetCateenIngredientNum(var_11_4) or 0
			local var_11_7 = math.floor(var_11_6 / var_11_5)

			var_11_3 = math.min(var_11_7, var_11_3)
		end

		var_11_1 = var_11_3
	end

	return var_11_1
end

function var_0_0.GetSignFoodTime(arg_12_0, arg_12_1)
	local var_12_0 = var_0_3[var_0_4][arg_12_1].sellNum - var_0_3[var_0_4][arg_12_1].soldNum

	return arg_12_0:CalSignFoodTime(arg_12_1, var_12_0)
end

function var_0_0.CalSignFoodTime(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = BackHomeCanteenFoodCfg[arg_13_1].cook_type
	local var_13_1 = BackHomeCanteenFoodCfg[arg_13_1].cost_time
	local var_13_2 = CanteenConst.HeroSkillType.FoodCostQucik
	local var_13_3 = (100 - DormSkillData:GetSkillEffect(var_13_2, nil, nil, var_13_0)) / 100

	return math.ceil(var_13_1 * arg_13_2 * var_13_3)
end

function var_0_0.GetSignFoodCanCookNum(arg_14_0, arg_14_1)
	local var_14_0 = CanteenManualData:GetManualCookFoodInfo()
	local var_14_1 = 0

	if var_14_0 then
		var_14_1 = var_14_0[arg_14_1] or 0
	end

	local var_14_2 = var_0_3[var_0_4][arg_14_1].sellNum - var_0_3[var_0_4][arg_14_1].soldNum - var_14_1

	if var_14_2 < 0 then
		print("计算数量错误")

		var_14_2 = 0
	end

	return var_14_2
end

function var_0_0.RefreshCanOrderFoodList(arg_15_0)
	local var_15_0 = CanteenManualData:GetManualCookFoodInfo()
	local var_15_1 = arg_15_0:GetChooseFoodList()

	var_0_5 = {}

	if var_15_1 then
		for iter_15_0, iter_15_1 in pairs(var_15_1) do
			local var_15_2 = arg_15_0:GetSignFoodInfo(iter_15_1)
			local var_15_3 = 0
			local var_15_4 = not var_15_0 and 0 or var_15_0[iter_15_1] or 0

			if var_15_2.sellNum - var_15_2.soldNum - var_15_4 > 0 then
				table.insert(var_0_5, iter_15_1)
			end
		end
	end

	manager.notify:Invoke(CANTEEN_SIGN_FOOD_NUM_CHANGE)
	var_0_0:OnIngredientChange()
end

function var_0_0.GetCateenIngredient(arg_16_0)
	if var_0_1 then
		return var_0_1
	end
end

function var_0_0.GetHadIngredientNum(arg_17_0, arg_17_1)
	return var_0_1[arg_17_1] or 0
end

function var_0_0.AddFoodIngredients(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 then
		if not var_0_1 then
			var_0_1 = {}
		end

		if not var_0_1[arg_18_1] then
			var_0_1[arg_18_1] = 0
		end

		if arg_18_2 then
			var_0_1[arg_18_1] = arg_18_2
		end

		if var_0_1[arg_18_1] < 0 then
			var_0_1[arg_18_1] = 0

			print("食材减少数量不正确")
		end
	end
end

function var_0_0.GetCateenIngredientNum(arg_19_0, arg_19_1)
	local var_19_0 = 0

	if var_0_1[arg_19_1] then
		var_19_0 = var_0_1[arg_19_1]

		for iter_19_0, iter_19_1 in pairs(var_0_3[var_0_4]) do
			local var_19_1 = BackHomeCanteenFoodCfg[iter_19_0].ingredient_list

			for iter_19_2, iter_19_3 in ipairs(var_19_1) do
				if iter_19_3[1] == arg_19_1 then
					var_19_0 = var_19_0 - (iter_19_1.sellNum - iter_19_1.soldNum) * iter_19_3[2]
				end
			end
		end
	end

	if var_19_0 < 0 then
		var_19_0 = 0
	end

	return var_19_0
end

function var_0_0.UpdataFoodProficiency(arg_20_0, arg_20_1)
	if not var_0_2 then
		var_0_2 = {}
	end

	var_0_2[arg_20_1.id] = arg_20_0:InitFoodProficiencyData(arg_20_1)
end

function var_0_0.GetFoodProficiency(arg_21_0, arg_21_1)
	return var_0_2[arg_21_1].proficiency
end

function var_0_0.GetFoodCookNum(arg_22_0, arg_22_1)
	return var_0_2[arg_22_1].hasCookNum
end

function var_0_0.InitFoodProficiencyData(arg_23_0, arg_23_1)
	return {
		foodCfgID = arg_23_1.id,
		proficiency = arg_23_1.proficiency or 0,
		hasCookNum = arg_23_1.num or 0,
		foodType = BackHomeCanteenFoodCfg[arg_23_1.id].cook_type
	}
end

function var_0_0.GetFoodTypeCookNum(arg_24_0, arg_24_1)
	local var_24_0 = 0

	if var_0_2 then
		for iter_24_0, iter_24_1 in pairs(var_0_2) do
			if BackHomeCanteenFoodCfg[iter_24_0].cook_type == arg_24_1 then
				var_24_0 = var_24_0 + iter_24_1.hasCookNum
			end
		end
	end

	return var_24_0
end

function var_0_0.AddFoodProficiency(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = GameSetting.canteen_cook_mastery.value
	local var_25_1 = 0

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1[1] == arg_25_2 then
			var_25_1 = iter_25_1[2]

			break
		end
	end

	var_0_2[arg_25_1].proficiency = math.min(var_0_2[arg_25_1].proficiency + var_25_1, GameSetting.canteen_cook_mastery_max.value[1])
end

function var_0_0.GetFoodUnitCost(arg_26_0, arg_26_1)
	local var_26_0 = BackHomeCanteenFoodCfg[arg_26_1].sell
	local var_26_1 = CanteenConst.HeroSkillType.FoodCostRise
	local var_26_2 = BackHomeCanteenFoodCfg[arg_26_1].cook_type
	local var_26_3 = (100 + DormSkillData:GetSkillEffect(var_26_1, nil, nil, var_26_2)) / 100

	return math.floor(var_26_0 * var_26_3)
end

function var_0_0.ReviseSignFoodInfo(arg_27_0, arg_27_1)
	if not var_0_3 then
		var_0_3 = {}
		var_0_3[var_0_4] = {}
	end

	if not var_0_3[var_0_4][arg_27_1.food_id] then
		var_0_3[var_0_4][arg_27_1.food_id] = {}
	end

	var_0_3[var_0_4][arg_27_1.food_id].sellNum = arg_27_1.sell_num
	var_0_3[var_0_4][arg_27_1.food_id].soldNum = arg_27_1.sold_num
	var_0_3[var_0_4][arg_27_1.food_id].soldIncome = arg_27_1.sell_earnings

	if arg_27_1.sell_num == arg_27_1.sold_num then
		arg_27_0:RefreshCanOrderFoodList()
		manager.notify:Invoke(CANTEEN_UPDATE_STATE)
	end

	manager.notify:Invoke(CANTEEN_SIGN_FOOD_INFO_CHANGE)
end

function var_0_0.InitCanteenIngredient(arg_28_0, arg_28_1)
	var_0_1 = {}

	if arg_28_1 then
		for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
			var_0_1[iter_28_1.id] = iter_28_1.num
		end
	end
end

function var_0_0.OnIngredientChange(arg_29_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		DormRedPointTools:Notify(RedPointConst.CANTEEN_BUSINESS_STOPPED, #arg_29_0:GetCanOrderFoodList() < DormConst.ORDER_FOOD_NUM)
	end
end

function var_0_0.DisposeDetailData(arg_30_0)
	var_0_2 = nil
end

return var_0_0
