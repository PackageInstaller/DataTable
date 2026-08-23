local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_BlazingArena_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_BlazingArena_RankList = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaRankList(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_RANKLIST, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_BlazingArena_ChallengeBegin = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaChallengeBegin(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_CHALLENGEBEGIN, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_BlazingArena_ChallengeFinish = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaChallengeFinish(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_CHALLENGEFINISH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_BlazingArena_ServerInfos = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaServerInfos(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_SERVERINFOS, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_BlazingArena_TaskAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaTaskAward(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_TASKAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_BlazingArena_EmbryoBorrow = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaEmbryoBorrow(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_EMBRYOBORROW, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_BlazingArena_EmbryoGiveBack = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaEmbryoGiveBack(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_EMBRYOBORROW, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_BlazingArena_Sweep = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.blazingArenaData:onS2CBlazingArenaSweep(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_SWEEP, false, arg_9_1, arg_9_2)
		end
	end
}
