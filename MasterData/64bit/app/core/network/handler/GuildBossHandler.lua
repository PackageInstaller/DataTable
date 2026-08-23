local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GuildBoss_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.guildBossData:updateServerInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildBoss_ChallengeBossBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_CHALLENGEBOSSBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildBoss_ChallengeBossFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.guildBossData:updateChallengeBoss(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_CHALLENGEBOSSFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GuildBoss_RobUserBegin = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_ROBUSERBEGIN, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GuildBoss_RobUserFinish = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.guildBossData:updateRobUser(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_ROBUSERFINISH, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_GuildBoss_GetRobUserList = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_GETROBUSERLIST, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_GuildBoss_UserJoin = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_USERJOIN, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_GuildBoss_Broadcast = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.guildBossData:updateBroadcase(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_BROADCAST, false, arg_8_1, arg_8_2)
		end
	end
}
