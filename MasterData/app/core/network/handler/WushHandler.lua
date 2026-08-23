local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_DeadBattle_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.wushData:updateWushData(arg_1_2, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_DeadBattle_ChallengeBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_CHALLENGEBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_DeadBattle_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.wushData:updateChallengeResult(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_DeadBattle_PickBuff = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.wushData:updateWushInfo(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_PICKBUFF, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_DeadBattle_FastChallenge = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.wushData:recordBlitzStageIndex()
			g.core.model.User.wushData:updateWushInfo(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_FASTCHALLENGE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_DeadBattle_AllChallenge = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.wushData:updateWushInfo(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_ALLCHALLENGE, false, arg_6_1, arg_6_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_DeadBattle_Shopping = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.wushData:updateShopInfo(clone(arg_7_2.shop))
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_SHOPPING, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_DeadBattle_BoxAward = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.wushData:updateWushData(arg_8_2)
			g.core.model.User.wushData:updateBoxState()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_BOXAWARD, false, arg_8_1, arg_8_2)
		end
	end
}
