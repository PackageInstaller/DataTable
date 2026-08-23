local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GuildStatue_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.guildStatueData:updateStatueInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildStatue_DoCast = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.guildStatueData:updateStatueData(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_DOCAST, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildStatue_GetStageAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.guildStatueData:updateAwardState(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETSTAGEAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GuildStatue_GetFinalAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.guildStatueData:updateFinalAwardBySelf(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETFINALAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GuildStatue_Push = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.guildStatueData:updateStatueByPush(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_PUSH, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_GuildStatue_OneKeyStageAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.guildStatueData:updateOneKeyAward(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_ONEKEYSTAGEAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_GuildStatue_FastFinish = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.guildStatueData:updateOneKeySprite(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_FASTFINISH, false, arg_7_1, arg_7_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_7_1, arg_7_2)
		end
	end
}
