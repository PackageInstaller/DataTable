local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_RpRain_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.redPacketRainData:initData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RP_RAIN_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_RpRain_AwardRedpacket = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.redPacketRainData:receiveAward(arg_2_2)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RP_RAIN_AWARDREDPACKET, false, arg_2_1, arg_2_2)
	end,
	on_S2C_RpRain_AwardFish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.redPacketRainData:receiveFishAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RP_RAIN_AWARDFISH, false, arg_3_1, arg_3_2)
		end
	end
}
