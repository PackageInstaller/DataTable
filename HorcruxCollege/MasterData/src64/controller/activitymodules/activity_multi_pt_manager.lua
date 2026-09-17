local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:getMultiPTLayerName(arg_1_1)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:getMultiPTLayerName()
end

function activity_base_manager:getActivityMultiPtTask(arg_2_1)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:getActivityMultiPtTask()
end

function activity_base_manager:getActivityMultiPtTaskData(arg_3_1)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:getActivityMultiPtTaskData()
end

function activity_base_manager:isHasCanCompleteMultiPtTask(arg_4_1)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:isHasCanCompleteMultiPtTask()
end

function activity_base_manager:getMultiPtTaskReward(arg_5_1, arg_5_2)
	local var_5_0 = self:getActivityObj(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:getMultiPtTaskReward(arg_5_2)
end

function activity_base_manager:getMultiPtTaskRewardOneKey(arg_6_1)
	local var_6_0 = self:getActivityObj(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:getMultiPtTaskRewardOneKey()
end

function activity_base_manager:getMultiPTnum(arg_7_1)
	local var_7_0 = self:getActivityObj(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:getMultiPTnum()
end

function activity_base_manager:getBMultiPtLevelData(arg_8_1)
	local var_8_0 = self:getActivityObj(arg_8_1)

	if not var_8_0 then
		return
	end

	return var_8_0:getBMultiPtLevelData()
end

function activity_base_manager:isMuiltPtHasRewardCanGet(arg_9_1)
	local var_9_0 = self:getActivityObj(arg_9_1)

	if not var_9_0 then
		return
	end

	return var_9_0:isMuiltPtHasRewardCanGet()
end

function activity_base_manager:get_multi_pt_reward(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = self:getActivityObj(arg_10_1)

	if not var_10_0 then
		return
	end

	return var_10_0:get_multi_pt_reward(arg_10_2, arg_10_3)
end
