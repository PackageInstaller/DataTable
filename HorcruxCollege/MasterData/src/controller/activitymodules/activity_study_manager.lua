local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_activity_study_info(arg_1_1, arg_1_2)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:get_activity_study_info(arg_1_2)
end

function activity_base_manager:get_activity_study_servant_info(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:get_activity_study_servant_info(arg_2_2, arg_2_3)
end

function activity_base_manager:do_activity_study(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:do_activity_study(arg_3_2, arg_3_3)
end

function activity_base_manager:change_activity_study(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:change_activity_study(arg_4_2, arg_4_3)
end

function activity_base_manager:finish_activity_study(arg_5_1, arg_5_2)
	local var_5_0 = self:getActivityObj(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:finish_activity_study(arg_5_2)
end

function activity_base_manager:getStakePlayerConf(arg_6_1, arg_6_2)
	local var_6_0 = self:getActivityObj(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:getStakePlayerConf(arg_6_2)
end

function activity_base_manager:getStudyPlayerSync(arg_7_1, arg_7_2)
	local var_7_0 = self:getActivityObj(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:getStudyPlayerSync(arg_7_2)
end

function activity_base_manager:getStudyEnemySync(arg_8_1, arg_8_2)
	local var_8_0 = self:getActivityObj(arg_8_1)

	if not var_8_0 then
		return
	end

	return var_8_0:getStudyEnemySync(arg_8_2)
end

function activity_base_manager:getFightRresultEmenyData(arg_9_1, arg_9_2)
	local var_9_0 = self:getActivityObj(arg_9_1)

	if not var_9_0 then
		return
	end

	return var_9_0:getFightRresultEmenyData(arg_9_2)
end

function activity_base_manager:getServantUnlockjump(arg_10_1, arg_10_2)
	local var_10_0 = self:getActivityObj(arg_10_1)

	if not var_10_0 then
		return
	end

	return var_10_0:getServantUnlockjump(arg_10_2)
end

function activity_base_manager:getServantUnlockDes(arg_11_1, arg_11_2)
	local var_11_0 = self:getActivityObj(arg_11_1)

	if not var_11_0 then
		return
	end

	return var_11_0:getServantUnlockDes(arg_11_2)
end
