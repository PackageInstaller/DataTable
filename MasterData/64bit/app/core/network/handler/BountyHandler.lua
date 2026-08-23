local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Bounty_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.bountyData:onS2CBountyGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Bounty_FindMonster = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.bountyData:addMyMonster(arg_2_2.monster, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_FINDMONSTER, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Bounty_ShareMonster = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.bountyData:updateMyMonsterShareType(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_SHAREMONSTER, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Bounty_GetShareMonsterList = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.bountyData:updateShareMonsterList(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETSHAREMONSTERLIST, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Bounty_MonsterShareAward = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.bountyData:onGetShareMonsterAward(arg_5_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_MONSTERSHAREAWARD, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Bounty_GetUserDailyScore = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.bountyData:updateScoreData(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETUSERDAILYSCORE, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Bounty_DailyScoreAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.bountyData:addGetDailyAwardUserIdByList(arg_7_2.user_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_DAILYSCOREAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Bounty_ChallengeBegin = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_CHALLENGEBEGIN, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Bounty_ChallengeFinish = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.bountyData:updateMonsterAlive(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_CHALLENGEFINISH, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Bounty_GetGuildRank = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.bountyData:onS2CCommonRankList(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETGUILDRANK, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Bounty_TaskAward = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.bountyData:onGetTaskAward(arg_11_2.task_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_TASKAWARD, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Bounty_GetMonsterInfo = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERINFO, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Bounty_GetMonsterDetailInfo = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.bountyData:onS2CBountyGetMonsterDetailInfo(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERDETAILINFO, false, arg_13_1, arg_13_2)
		end
	end
}
