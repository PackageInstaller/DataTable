local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}
local var_0_2 = g.core.model.User

function var_0_1.on_S2C_KnightFavorability_Info(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		var_0_2.knightFavoData:onFavoPlotInfo(arg_1_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITY_INFO, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_KnightFavorability_Award(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		var_0_2.knightFavoData:onFavoAward(arg_2_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITY_AWARD, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_FlushFavorabilityItem(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_FAVORABILITY_ITEM, false, arg_3_1, arg_3_2)
	end
end

return var_0_1
