local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local activity_bachelor_envelope_data = require("data.activity_envelope.activity_bachelor_envelope_data")

function ACTIVITY_OBJ_NEW.initModuleRedPacket(arg_1_0, arg_1_1)
	arg_1_0._artstarttime = arg_1_1.starttime
	arg_1_0._artfinishtime = arg_1_1.finishtime
end

function ACTIVITY_OBJ_NEW:check_red_packet(arg_2_1)
	network:rpc("can_get_red_envelope", {
		id = self._id
	}, function(arg_3_0)
		if arg_2_1 then
			arg_2_1(arg_3_0.result, arg_3_0.stat)
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_red_envelope_info(arg_4_1)
	network:rpc("get_red_envelope_info", {
		id = self._id
	}, function(arg_5_0)
		if arg_4_1 then
			arg_4_1(arg_5_0.result, arg_5_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getRedPacketInfo(arg_6_1, arg_6_2)
	self:get_red_envelope_info(function(arg_7_0, arg_7_1)
		if arg_7_0 ~= 1 then
			global_ShowBlockWords(L_GET_REDBAG_FAIL)
		else
			if arg_7_1.stat == 1 then
				global_get({
					gold = arg_7_1.gold,
					diamond = arg_7_1.diamond,
					items = arg_7_1.items
				})
			end

			local var_7_0 = arg_6_1 and arg_6_2 and {
				arg_7_1.dropinfos[arg_6_2 + 1]
			} or arg_7_1.dropinfos

			activity_manager:fireEvent(activity_manager.activityEventId.OPEN_RED_PACK_SUCCESS, {
				list = var_7_0,
				stat = arg_7_1.stat,
				id = arg_6_1
			})
		end
	end)
end

function ACTIVITY_OBJ_NEW:getRedPacketMaxPackNum()
	return activity_bachelor_envelope_data[self._id].maxopencount
end
