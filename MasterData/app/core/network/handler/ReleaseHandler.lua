local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Release_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.releaseActivityData:onS2CReleaseGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RELEASE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Release_PrizeList = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.releaseActivityData:onS2CReleasePrizeList(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RELEASE_PRIZELIST, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Release_Draw = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.releaseActivityData:onS2CReleaseDraw(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RELEASE_DRAW, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Release_GetReward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.releaseActivityData:onS2CReleaseGetReward(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RELEASE_GETREWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Release_TaskAward = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.releaseActivityData:onS2CReleaseTaskAward(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RELEASE_TASKAWARD, false, arg_5_1, arg_5_2)
		end
	end
}
