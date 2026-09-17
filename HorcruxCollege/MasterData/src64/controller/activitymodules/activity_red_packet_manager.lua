local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:check_red_packet(arg_1_1, arg_1_2)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:check_red_packet(arg_1_2)
end

function activity_base_manager:get_red_envelope_info(arg_2_1, arg_2_2)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:get_red_envelope_info(arg_2_2)
end

function activity_base_manager:getRedPacketInfo(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:getRedPacketInfo(arg_3_2, arg_3_3)
end

function activity_base_manager:getRedPacketMaxPackNum(arg_4_1)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:getRedPacketMaxPackNum(index)
end
