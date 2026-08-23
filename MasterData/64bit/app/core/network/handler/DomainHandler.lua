local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Domain_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.domainData:onS2CDomainGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DOMAIN_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Domain_ChallengeBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DOMAIN_CHALLENGEBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Domain_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.domainData:onS2CDomainChallengeFinish(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DOMAIN_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Domain_Sweep = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.domainData:onS2CDomainSweep(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DOMAIN_SWEEP, false, arg_4_1, arg_4_2)
		end
	end
}
