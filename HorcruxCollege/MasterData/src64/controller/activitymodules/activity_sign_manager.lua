local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:getActivitySignData(arg_1_1, arg_1_2)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:getActivitySignData(arg_1_2)
end

function activity_base_manager:getSignType(arg_2_1)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:getSignType()
end

function activity_base_manager:getSignVersion(arg_3_1)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:getSignVersion()
end

function activity_base_manager:isSignVip(arg_4_1)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:isSignVip()
end

function activity_base_manager:getSignVipBuyReward(arg_5_1)
	local var_5_0 = self:getActivityObj(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:getSignVipBuyReward()
end

function activity_base_manager:buySignVip(arg_6_1)
	local var_6_0 = self:getActivityObj(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:buySignVip()
end

function activity_base_manager:getSignDropByIndex(arg_7_1, arg_7_2)
	local var_7_0 = self:getActivityObj(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:getSignDropByIndex(arg_7_2)
end

function activity_base_manager:getVipSignDropByIndex(arg_8_1, arg_8_2)
	local var_8_0 = self:getActivityObj(arg_8_1)

	if not var_8_0 then
		return
	end

	return var_8_0:getVipSignDropByIndex(arg_8_2)
end

function activity_base_manager:activityBpSign(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = self:getActivityObj(arg_9_1)

	if not var_9_0 then
		return
	end

	return var_9_0:activityBpSign(arg_9_2, arg_9_3)
end

function activity_base_manager.isLoginBpSign(arg_10_0, arg_10_1)
	return require("data.activity_modules.activity_sign_conf")[arg_10_1].signtype == 6
end
