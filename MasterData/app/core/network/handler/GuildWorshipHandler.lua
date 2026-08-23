local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GuildWorship_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.guildWorshipData:updateWorshipData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildWorship_FinishMission = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.guildWorshipData:updateFinishMission(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildWorship_GetProgressAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.guildWorshipData:updateWorshipAwardId(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETPROGRESSAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GuildWorship_PushMission = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.guildWorshipData:updateTaskProgress(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_PUSHMISSION, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GuildWorship_PushHistory = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.guildWorshipData:generateContributeRecord(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_PUSHHISTORY, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_GuildWorship_GetProgressAward_OneKey = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETPROGRESSAWARD_ONEKEY, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_GuildWorship_FinishMission_OneKey = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.guildWorshipData:updateFinishMissionOneKey(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION_ONEKEY, false, arg_7_1, arg_7_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_7_1, arg_7_2)
		end
	end
}
