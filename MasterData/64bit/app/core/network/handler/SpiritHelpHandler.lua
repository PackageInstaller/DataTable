local var_0_0 = g.core.model.User.spiritHelpData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_SpiritHelp_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRIT_HELP_GETINFO, false, arg_1_1, arg_1_2)
		end
	end
}
