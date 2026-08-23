local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GuildCompetition_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.guildActivityData:updateTaskData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_COMPETITION_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildCompetition_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.guildActivityData:updateReceiveId(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_COMPETITION_GETAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildCompetition_SyncTask = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.guildActivityData:syncTaskData(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_COMPETITION_SYNCTASK, false, arg_3_1, arg_3_2)
		end
	end
}
