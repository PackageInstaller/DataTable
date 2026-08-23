local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GuildBattle_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.GuildFightData:resGuildFightInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildBattle_BeginChallenge = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.GuildFightData:resBattleReport(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_BEGINCHALLENGE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildBattle_FinishChallenge = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.GuildFightData:resBattleResult(arg_3_2)

			if g.core.model.User.GuildFightData:isNormal() then
				arg_3_2.battlePlayType = arg_3_2.battlePlayType or 1

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_FINISHCHALLENGE, false, arg_3_1, arg_3_2)
			else
				arg_3_2.battlePlayType = arg_3_2.battlePlayType or 2

				g.core.model.User.GuildFightData:setChariotFightFinishServiceInfo({
					event = g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_FINISHCHALLENGE,
					msgId = arg_3_1,
					content = arg_3_2
				})
			end
		end
	end,
	on_S2C_GuildBattle_Award = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.GuildFightData:resAwardsInfo(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_AWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GuildBattle_NoticeNewChariot = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.GuildFightData:resNoticeNewUsers(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_NOTICENEWCHARIOT, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_GuildBattle_GetRecords = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.GuildFightData:resHistoryInfo(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_GETRECORDS, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_GuildBattle_NoticeScore = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.GuildFightData:resUpdateScore(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_NOTICESCORE, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_GuildBattle_NoticeUser = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.GuildFightData:resNoticeUser(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_NOTICEUSER, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_GuildBattle_Award_OneKey = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_AWARD_ONEKEY, false, arg_9_1, arg_9_2)
		end
	end
}
