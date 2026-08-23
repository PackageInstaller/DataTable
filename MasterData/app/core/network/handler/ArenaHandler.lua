local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User

return {
	on_S2C_Arena_GetMainInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1.arenaData:updateArenaData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_GETMAININFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Arena_ChallengeBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGEBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Arena_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1.arenaData:updateRank(arg_3_2.rank, arg_3_2.cur_rank)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Arena_FastChallenge = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1.arenaData:updateChallengeCount(arg_4_2.challenge_count)
			var_0_1.arenaData:updateHasChallengeCount(arg_4_2.already_challenge_count)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_FASTCHALLENGE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Arena_GetTaskInfo = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_GETTASKINFO, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Arena_GetTaskAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_GETTASKAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Arena_GetRanklist = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_GETRANKLIST, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Arena_ChallengeRecord = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGERECORD, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Arena_OneKeyChallenge = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARENA_ONEKEYCHALLENGE, false, arg_9_1, arg_9_2)
		end
	end
}
