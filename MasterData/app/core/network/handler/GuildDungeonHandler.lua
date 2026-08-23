local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.guildDungeonData

return {
	on_S2C_GuildDungeon_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:updateGuildDungeonInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildDungeon_GetChapter = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:updateCurChapterInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETCHAPTER, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildDungeon_AttackBegin = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKBEGIN, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GuildDungeon_AttackFinish = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:updateAttackFinish(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GuildDungeon_GetSkillInfo = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:updateSkillInfo(arg_5_2.skills)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETSKILLINFO, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_GuildDungeon_SkillLevelUp = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:updateSkillInfo(arg_6_2.skills)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_SKILLLEVELUP, false, arg_6_1, arg_6_2)
	end,
	on_S2C_GuildDungeon_GetFinishAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_1:updateClearAward(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETFINISHAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_GuildDungeon_GetTreasureBox = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1:updateStageTreasure(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETTREASUREBOX, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_GuildDungeon_GetStageMvpAward = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_1:updateMvpAwardState(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETSTAGEMVPAWARD, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_GuildDungeon_BroadcastDamage = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_1:updateStageHp(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_BROADCASTDAMAGE, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_GuildDungeon_GetMemberDamage = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETMEMBERDAMAGE, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_GuildDungeon_OneKeyGetFinishAward = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_1:updateStageTreasureArr(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYGETFINISHAWARD, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_GuildDungeon_GetFinishAward_OneKey = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_1:updateClearAwardList(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETFINISHAWARD_ONEKEY, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_GuildDungeon_OneKeyAttackBegin = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYATTACKBEGIN, false, arg_14_1, arg_14_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_GuildDungeon_OneKeyAttackFinish = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_1:updateAttackFinish(arg_15_2)
			var_0_1:updateAllBoxAwards(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYATTACKFINISH, false, arg_15_1, arg_15_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_15_1, arg_15_2)
		end
	end
}
