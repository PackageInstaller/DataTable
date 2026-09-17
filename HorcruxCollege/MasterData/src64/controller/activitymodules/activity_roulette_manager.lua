local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:getRouletteInfo(arg_1_1)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:getRouletteInfo()
end

function activity_base_manager:rouletteForOnce(arg_2_1)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:rouletteForOnce()
end

function activity_base_manager:rouletteForFive(arg_3_1)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:rouletteForFive()
end

function activity_base_manager:getRouletteEndTime(arg_4_1)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:getRouletteEndTime()
end

function activity_base_manager:getRouletteItemData(arg_5_1)
	local var_5_0 = self:getActivityObj(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:getRouletteItemData()
end

function activity_base_manager:getRouletteNeedItem(arg_6_1)
	local var_6_0 = self:getActivityObj(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:getRouletteNeedItem()
end

function activity_base_manager:getRouletteShowModel(arg_7_1)
	local var_7_0 = self:getActivityObj(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:getRouletteShowModel()
end

function activity_base_manager:getRouletteNums(arg_8_1)
	local var_8_0 = self:getActivityObj(arg_8_1)

	if not var_8_0 then
		return
	end

	return var_8_0:getRouletteNums()
end

function activity_base_manager:getCurphase(arg_9_1)
	local var_9_0 = self:getActivityObj(arg_9_1)

	if not var_9_0 then
		return
	end

	return var_9_0:getCurphase()
end

function activity_base_manager:isRouletteCanFree(arg_10_1)
	local var_10_0 = self:getActivityObj(arg_10_1)

	if not var_10_0 then
		return
	end

	return var_10_0:isRouletteCanFree()
end

function activity_base_manager:isHaveEnoughToRoulettes(arg_11_1, arg_11_2)
	local var_11_0 = self:getActivityObj(arg_11_1)

	if not var_11_0 then
		return
	end

	return var_11_0:isHaveEnoughToRoulettes(arg_11_2)
end

function activity_base_manager:getRouletteLimitData(arg_12_1)
	local var_12_0 = self:getActivityObj(arg_12_1)

	if not var_12_0 then
		return
	end

	return var_12_0:getRouletteLimitData()
end

function activity_base_manager:buyRouletteLimitBag(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = self:getActivityObj(arg_13_1)

	if not var_13_0 then
		return
	end

	return var_13_0:buyRouletteLimitBag(arg_13_2, arg_13_3, arg_13_4)
end

function activity_base_manager:isRouletteneedAlert(arg_14_1)
	local var_14_0 = self:getActivityObj(arg_14_1)

	if not var_14_0 then
		return
	end

	return var_14_0:isRouletteneedAlert()
end

function activity_base_manager:isSpItem(arg_15_1, arg_15_2)
	local var_15_0 = self:getActivityObj(arg_15_1)

	if not var_15_0 then
		return
	end

	return var_15_0:isSpItem(arg_15_2)
end

function activity_base_manager:getRouletteSize(arg_16_1, arg_16_2)
	local var_16_0 = self:getActivityObj(arg_16_1)

	if not var_16_0 then
		return
	end

	return var_16_0:getRouletteSize(arg_16_2)
end

function activity_base_manager:canBuyRouletteCurrency(arg_17_1, arg_17_2)
	local var_17_0 = self:getActivityObj(arg_17_1)

	if not var_17_0 then
		return
	end

	return var_17_0:canBuyRouletteCurrency(arg_17_2)
end

function activity_base_manager:ROULETTE_FOR_TEST(arg_18_1, arg_18_2)
	local var_18_0 = self:getActivityObj(arg_18_1)

	if not var_18_0 then
		return
	end

	return var_18_0:ROULETTE_FOR_TEST(arg_18_2)
end

function activity_base_manager:getRouletteTaskList(arg_19_1)
	return self.activities[arg_19_1]:getRouletteTaskList()
end

function activity_base_manager:getRouletteTaskReward(arg_20_1, arg_20_2)
	return self.activities[arg_20_1]:getRouletteTaskReward(arg_20_2)
end

function activity_base_manager:getCommonRouletteItemData(arg_21_1)
	return self.activities[arg_21_1]:getCommonRouletteItemData()
end

function activity_base_manager:get_commonroulette_special_drop(arg_22_1, arg_22_2)
	return self.activities[arg_22_1]:get_commonroulette_special_drop(arg_22_2)
end

function activity_base_manager:set_commonroulette_special_drop(arg_23_1, arg_23_2, arg_23_3)
	return self.activities[arg_23_1]:set_commonroulette_special_drop(arg_23_2, arg_23_3)
end

function activity_base_manager:getCommonDropById(arg_24_1, arg_24_2)
	return self.activities[arg_24_1]:getCommonDropById(arg_24_2)
end

function activity_base_manager:getCommonRouletteSpecailDrop(arg_25_1)
	return self.activities[arg_25_1]:getCommonRouletteSpecailDrop()
end

function activity_base_manager:getCommonSpecialDropids(arg_26_1)
	return self.activities[arg_26_1]:getCommonSpecialDropids()
end

function activity_base_manager:isCommonRoulette(arg_27_1)
	if not self.activities[arg_27_1] then
		return
	end

	return self.activities[arg_27_1]:isCommonRoulette()
end

function activity_base_manager:getRouletteShopJump(arg_28_1)
	if not self.activities[arg_28_1] then
		return
	end

	return self.activities[arg_28_1]:getRouletteShopJump()
end
