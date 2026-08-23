local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_DailyDungeon_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.dailyDungeonData:initInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_DailyDungeon_ChallengeBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_DailyDungeon_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.dailyDungeonData:onRecvChallenge(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_DailyDungeon_Fast = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_FAST, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_DailyDungeon_Fast_Spirit_Help = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_FAST_SPIRIT_HELP, false, arg_5_1, arg_5_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_5_1, arg_5_2)
		end
	end
}
