local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.activityWishpoolData

return {
	on_S2C_Wishpool_Flush = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:on_S2C_Wishpool_Flush(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FLUSH, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Wishpool_DailyPresents = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:on_S2C_Wishpool_DailyPresents(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_DAILYPRESENTS, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Wishpool_Fishing = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:on_S2C_Wishpool_Fishing(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FISHING, false, arg_3_1, arg_3_2)
		end
	end
}
