local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}
local var_0_2

function var_0_1.on_S2C_Support_GetInfo(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		var_0_2 = g.core.model.User.valentinesDayVoteData

		var_0_2:onGetInfo(arg_1_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SUPPORT_GETINFO, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_Support_Vote(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		var_0_2 = g.core.model.User.valentinesDayVoteData

		var_0_2:onVote(arg_2_2)
		g.core.network.GameNetProxy:send_C2S_Support_GetInfo({})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTE, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_Support_VoteAward(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		var_0_2 = g.core.model.User.valentinesDayVoteData

		var_0_2:onVoteAward(arg_3_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTEAWARD, false, arg_3_1, arg_3_2)
	end
end

function var_0_1.on_S2C_Support_VoteAllAward(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		var_0_2 = g.core.model.User.valentinesDayVoteData

		var_0_2:onVoteAwardAll(arg_4_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTEALLAWARD, false, arg_4_1, arg_4_2)
	end
end

function var_0_1.on_S2C_Support_TaskAward(arg_5_0, arg_5_1, arg_5_2)
	if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
		var_0_2 = g.core.model.User.valentinesDayVoteData

		var_0_2:onTaskAward(arg_5_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SUPPORT_TASKAWARD, false, arg_5_1, arg_5_2)
	end
end

function var_0_1.on_S2C_Support_TaskAllAward(arg_6_0, arg_6_1, arg_6_2)
	if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
		var_0_2 = g.core.model.User.valentinesDayVoteData

		var_0_2:onTaskAwardAll(arg_6_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SUPPORT_TASKALLAWARD, false, arg_6_1, arg_6_2)
	end
end

return var_0_1
