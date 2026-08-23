local var_0_0 = g.core.event.enum
local ProtoHandler = import(".ProtoHandler")
local var_0_2 = g.core.event.EventManager

return {
	on_S2C_H5Activity_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.h5ActivityData:onH5ActivityGetInfo(arg_1_2)
			var_0_2:dispatchEvent(var_0_0.EVENT_NET_S2C_H5_ACTIVITY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_H5Activity_UpdateInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.h5ActivityData:onH5ActivityUpdate(arg_2_2)
			var_0_2:dispatchEvent(var_0_0.EVENT_NET_S2C_H5_ACTIVITY_GETINFO, false, arg_2_1, arg_2_2)
		end
	end
}
