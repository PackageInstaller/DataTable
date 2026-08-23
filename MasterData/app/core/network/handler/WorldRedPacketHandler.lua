local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_WorldRedPacket_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.worldRedPacketData:onS2CGetInfo(arg_1_2)
			g.core.model.User.chatData:addWorldRedPacketList(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_WorldRedPacket_Detail = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.worldRedPacketData:onS2CDetail(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_DETAIL, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_WorldRedPacket_Award = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.worldRedPacketData:onS2CAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_AWARD, false, arg_3_1, {
				errorAward = false,
				data = arg_3_2
			})
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_AWARD, false, arg_3_1, {
				errorAward = true
			})
		end
	end,
	on_S2C_WorldRedPacket_Notify = function(arg_4_0, arg_4_1, arg_4_2)
		g.core.model.User.worldRedPacketData:onS2CNotify(arg_4_2)
		g.core.model.User.chatData:addWorldRedNotify(arg_4_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_NOTIFY, false, arg_4_1, arg_4_2)
	end,
	on_S2C_WorldRedPacket_Add = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.worldRedPacketData:onS2CUseAdd(arg_5_2)
			g.core.model.User.chatData:addWorldRedByUse(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_ADD, false, arg_5_1, {
				errorText = false,
				data = arg_5_2
			})
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_ADD, false, arg_5_1, {
				errorText = true
			})
		end
	end
}
