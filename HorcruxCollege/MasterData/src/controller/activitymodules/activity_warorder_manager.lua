local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:getWarOrderLayerName(arg_1_1)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:getWarOrderLayerName()
end

function activity_base_manager:getActivityWarOrderTask(arg_2_1)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:getActivityWarOrderTask()
end

function activity_base_manager:getActivityWarOrderTaskData(arg_3_1)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:getActivityWarOrderTaskData()
end

function activity_base_manager:isHasCanCompleteWarOrderTask(arg_4_1)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:isHasCanCompleteWarOrderTask()
end

function activity_base_manager:getWarOrderTaskReward(arg_5_1, arg_5_2)
	local var_5_0 = self:getActivityObj(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:getWarOrderTaskReward(arg_5_2)
end

function activity_base_manager:getWarOrderTaskRewardOneKey(arg_6_1)
	local var_6_0 = self:getActivityObj(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:getWarOrderTaskRewardOneKey()
end

function activity_base_manager:getWarOrdernum(arg_7_1)
	local var_7_0 = self:getActivityObj(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:getWarOrdernum()
end

function activity_base_manager:requestWarOrderLevelInfo(arg_8_1)
	local var_8_0 = self:getActivityObj(arg_8_1)

	if not var_8_0 then
		return
	end

	return var_8_0:requestWarOrderLevelInfo()
end

function activity_base_manager:getCurWarOrderLevel(arg_9_1)
	local var_9_0 = self:getActivityObj(arg_9_1)

	if not var_9_0 then
		return
	end

	return var_9_0:getCurWarOrderLevel()
end

function activity_base_manager:getCurWarOrderLevelProceed(arg_10_1, arg_10_2)
	local var_10_0 = self:getActivityObj(arg_10_1)

	if not var_10_0 then
		return
	end

	return var_10_0:getCurWarOrderLevelProceed(arg_10_2)
end

function activity_base_manager:requestWarOrderTaskInfo(arg_11_1)
	local var_11_0 = self:getActivityObj(arg_11_1)

	if not var_11_0 then
		return
	end

	return var_11_0:requestWarOrderTaskInfo()
end

function activity_base_manager:get_warorder_multi_pt_reward(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = self:getActivityObj(arg_12_1)

	if not var_12_0 then
		return
	end

	return var_12_0:get_warorder_multi_pt_reward(arg_12_2, arg_12_3)
end

function activity_base_manager:refresh_task_one_item(arg_13_1, arg_13_2)
	local var_13_0 = self:getActivityObj(arg_13_1)

	if not var_13_0 then
		return
	end

	return var_13_0:refresh_task_one_item(arg_13_2)
end

function activity_base_manager:getActivityWarOrderFreeCostNum(arg_14_1)
	local var_14_0 = self:getActivityObj(arg_14_1)

	if not var_14_0 then
		return
	end

	return var_14_0:getActivityWarOrderFreeCostNum()
end

function activity_base_manager:warorder_daily_update(arg_15_1)
	local var_15_0 = self:getActivityObj(arg_15_1)

	if not var_15_0 then
		return
	end

	return var_15_0.warorder_daily_update()
end

function activity_base_manager:init_activity_warorder_info(arg_16_1, arg_16_2)
	local var_16_0 = self:getActivityObj(arg_16_1)

	if not var_16_0 then
		return
	end

	return var_16_0:init_activity_warorder_info(arg_16_2)
end

function activity_base_manager:getWarOrderVipGiftList(arg_17_1)
	if not self.activities or not self.activities[arg_17_1] then
		return
	end

	return self.activities[arg_17_1]:getWarOrderVipGiftList()
end

function activity_base_manager:getCurShowType(arg_18_1)
	if not self.activities or not self.activities[arg_18_1] then
		return
	end

	return self.activities[arg_18_1]:getCurShowType()
end

function activity_base_manager:setCurShowType(arg_19_1, arg_19_2)
	if not self.activities or not self.activities[arg_19_1] then
		return
	end

	return self.activities[arg_19_1]:setCurShowType(arg_19_2)
end

function activity_base_manager:getWarOrderMaxLevel(arg_20_1)
	if not self.activities or not self.activities[arg_20_1] then
		return
	end

	return self.activities[arg_20_1]:getWarOrderMaxLevel()
end

function activity_base_manager:getWarOrderExp(arg_21_1)
	if not self.activities or not self.activities[arg_21_1] then
		return
	end

	return self.activities[arg_21_1]:getWarOrderExp()
end

function activity_base_manager:canWarOrderLevelUp(arg_22_1, arg_22_2)
	if not self.activities or not self.activities[arg_22_1] then
		return
	end

	return self.activities[arg_22_1]:canWarOrderLevelUp(arg_22_2)
end

function activity_base_manager:getWarOrderLevelUpCost(arg_23_1, arg_23_2)
	if not self.activities or not self.activities[arg_23_1] then
		return
	end

	return self.activities[arg_23_1]:getWarOrderLevelUpCost(arg_23_2)
end

function activity_base_manager:getWarOrderLevelupCanGetDrop(arg_24_1, arg_24_2)
	if not self.activities or not self.activities[arg_24_1] then
		return
	end

	return self.activities[arg_24_1]:getWarOrderLevelupCanGetDrop(arg_24_2)
end

function activity_base_manager:isWarOrderSVIP(arg_25_1)
	if not self.activities or not self.activities[arg_25_1] then
		return
	end

	return self.activities[arg_25_1]:isWarOrderSVIP()
end

function activity_base_manager:buyWarOrderActivityLevel(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	if not self.activities or not self.activities[arg_26_1] then
		return
	end

	return self.activities[arg_26_1]:buyWarOrderActivityLevel(arg_26_2, arg_26_3, arg_26_4, arg_26_5)
end

function activity_base_manager:getWarOrderTaskReward(arg_27_1, arg_27_2)
	if not self.activities or not self.activities[arg_27_1] then
		return
	end

	return self.activities[arg_27_1]:getWarOrderTaskReward(arg_27_2)
end

function activity_base_manager:getWarOrderLevelReward(arg_28_1, arg_28_2)
	if not self.activities or not self.activities[arg_28_1] then
		return
	end

	return self.activities[arg_28_1]:getWarOrderLevelReward(arg_28_2)
end

function activity_base_manager:isHasCanCompleteWarorderTask(arg_29_1)
	if not self.activities or not self.activities[arg_29_1] then
		return
	end

	return self.activities[arg_29_1]:isHasCanCompleteWarorderTask()
end

function activity_base_manager:isHasWarOrderRewardCanGet(arg_30_1)
	if not self.activities or not self.activities[arg_30_1] then
		return
	end

	return self.activities[arg_30_1]:isHasWarOrderRewardCanGet()
end

function activity_base_manager:isWarOrderVIP(arg_31_1)
	if not self.activities or not self.activities[arg_31_1] then
		return
	end

	return self.activities[arg_31_1]:isWarOrderVIP()
end

function activity_base_manager:isCanPlayWarOrder(arg_32_1)
	if not self.activities or not self.activities[arg_32_1] then
		return
	end

	return self.activities[arg_32_1]:isCanPlayWarOrder()
end

function activity_base_manager:isCanShowWarOrder(arg_33_1, arg_33_2)
	if not self.activities or not self.activities[arg_33_1] then
		return true
	end

	return self.activities[arg_33_1]:isCanShowWarOrder(arg_33_2)
end

function activity_base_manager:get_warorder_module_finishtime(arg_34_1)
	if not self.activities or not self.activities[arg_34_1] then
		return true
	end

	return self.activities[arg_34_1]:get_warorder_module_finishtime()
end

function activity_base_manager:get_warorder_id(arg_35_1)
	if not self.activities or not self.activities[arg_35_1] then
		return true
	end

	return self.activities[arg_35_1]:get_warorder_id()
end

function activity_base_manager:updateWarOrderEntranceAlert(arg_36_1)
	if not self.activities or not self.activities[arg_36_1] then
		return true
	end

	return self.activities[arg_36_1]:updateWarOrderEntranceAlert()
end
