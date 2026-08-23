local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.crossServerArenaData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

return {
	on_S2C_ChiefArena_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:updateCrossServerArenaData(arg_1_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ChiefArena_GetRankList = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:updateRankList(arg_2_2.units)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_GETRANKLIST, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ChiefArena_ChallengeBegin = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CChiefArenaChallengeBegin(arg_3_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_CHALLENGEBEGIN, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_ChiefArena_ChallengeFinish = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CChiefArenaChallengeFinish(arg_4_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_CHALLENGEFINISH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_ChiefArena_GetServerInfos = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:updateServerInfo(arg_5_2)
		end
	end,
	on_S2C_ChiefArena_NoticeActivity = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:updateSeasonInfo(arg_6_2)
			g.core.model.User.shopData:setNeedUpdateInfo(true)
		end
	end,
	on_S2C_ChiefArena_GuildRankAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) and arg_7_2 and arg_7_2.index > 0 then
			var_0_1:updateGuildReceiveState(arg_7_2.index)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_GUILDRANKAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_ChiefArena_SkillLevelUp = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) and arg_8_2 and arg_8_2.skill then
			var_0_1:onS2CSkillLevelUp(arg_8_2.skill)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_SKILLLEVELUP, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_ChiefArena_GuildRank = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_1:updateGuildRankList(arg_9_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_GUILDRANK, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_ChiefArena_OtherGuildSkill = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_1:onS2COtherGuildSkill(arg_10_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_OTHERGUILDSKILL, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_ChiefArena_GuildHonorRank = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_1:onS2CGuildHonorRank(arg_11_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_GUILDHONORRANK, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_ChiefArena_GuildSkill = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_1:onS2CGuildSkill(arg_12_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_GUILDSKILL, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_ChiefArena_OneKeyChallenge = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_1:onS2CChiefArenaOneKeyChallenge(arg_13_2.guild_rate)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHIEF_ARENA_ONEKEYCHALLENGE, false, arg_13_1, arg_13_2)
		end
	end
}
