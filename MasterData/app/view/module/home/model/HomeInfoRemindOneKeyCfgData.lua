local var_0_0 = g.core.model.User

return {
	oneKeyNetFunc = {
		[1000 + 1] = {
			function()
				require("app.view.module.guild.view.task.GuildTaskMainLayer"):oneKeyGetProgressAward()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETPROGRESSAWARD_ONEKEY,
			function()
				return var_0_0.guildWorshipData:canReceiveAward()
			end
		},
		[1000 + 2] = {
			function()
				require("app.view.module.guild.view.task.GuildTaskMainLayer"):oneKeyGetTaskAward()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION_ONEKEY,
			function()
				return var_0_0.guildWorshipData:canContribute()
			end
		},
		[1000 + 3] = {
			function()
				require("app.view.module.guildDungeon.view.GuildDungeonMainLayer"):getClearAwardOneKey()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETFINISHAWARD_ONEKEY,
			function()
				return var_0_0.guildDungeonData:canGetClearAward()
			end
		},
		[1000 + 4] = {
			function()
				require("app.view.module.guildDungeon.view.GuildDungeonMainLayer"):getChapterAwardOneKey()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYGETFINISHAWARD,
			function()
				return var_0_0.guildDungeonData:canReceiveTreasure()
			end
		},
		[1000 + 5] = {
			function()
				require("app.view.module.guildFight.view.GuildFightMainLayer"):getOenKeyBoxRewards()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_AWARD_ONEKEY,
			function()
				return #var_0_0.GuildFightData:getGuildFightCanGetAwardId() > 0
			end
		},
		[1000 + 6] = {
			function()
				require("app.view.module.guild.view.redPacket.GuildRedPacketLayer"):getOneKeyReward()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_PICK_ONEKEY,
			function()
				return var_0_0.redPacketData:isHasGuildRedPacket()
			end
		},
		[1000 + 7] = {
			function()
				require("app.view.module.guildStatue.view.GuildStatueMainLayer"):getStageAwardCanGet()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_ONEKEYSTAGEAWARD,
			function()
				return var_0_0.guildStatueData:hasStageAwardCanGet()
			end
		},
		[1000 + 8] = {
			function()
				require("app.view.module.guildStatue.view.GuildStatueMainLayer"):getFinalReward()
			end,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETFINALAWARD,
			function()
				return var_0_0.guildStatueData:hasFinalAwardCanGet()
			end
		},
		[1000 + 9] = {
			function()
				require("app.view.module.biography.view.BioMainLayer"):getOneKeyGetBioTeamAward()
			end,
			g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETCHAPTERAWARD_ONEKEY,
			function()
				return #var_0_0.bioData:getCanGetBioTeamAwardIds() > 0
			end
		},
		[1000 + 10] = {
			function()
				require("app.view.module.dungeon.view.DungeonMainLayer"):onClickOneKey()
			end,
			g.core.event.enum.EVENT_NET_S2C_DUNGEON_ONEKEY_GETCHAPTERCHESTAWARD,
			function()
				return var_0_0.dungeonData:checkBoxAward()
			end
		},
		[1000 + 11] = {
			function()
				require("app.view.module.arena.view.ArenaTaskPop"):getOneKeyTaskAward()
			end,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD,
			function()
				return var_0_0.arenaData:isOneKeyGetEnable()
			end
		},
		[1000 + 12] = {
			function()
				require("app.view.module.rebel.view.RebelDailyRewardPop"):getOneKeyDailyReward()
			end,
			g.core.event.enum.EVENT_NET_S2C_REBEL_ONE_BUTTON_AWARD,
			function()
				return var_0_0.rebelData:isOneKeyGetEnable()
			end
		},
		[1000 + 13] = {
			function()
				require("app.view.module.robTreasure.view.RobTreasureTaskPop"):getTaskAwardOneKey()
			end,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD,
			function()
				return false
			end
		},
		[1000 + 14] = {
			function()
				require("app.view.module.storm.view.StormMainLayer"):getOneKeyReward()
			end,
			g.core.event.enum.EVENT_NET_S2C_STORM_FINISH_AWARD_ONEKEY,
			function()
				return var_0_0.stormData:isCanGetFreeReward()
			end
		},
		[1000 + 15] = {
			function()
				var_0_0.achievementData:reqGetAchieveRewardOneKey()
			end,
			g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_FINISH_ONEKEY,
			function()
				return var_0_0.achievementData:isExistOneKeyGeAchieveReward()
			end
		},
		[1000 + 16] = {
			function()
				var_0_0.achievementData:reqGetProgressAwardOneKey()
			end,
			g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_REWARD_ONEKEY,
			function()
				return var_0_0.achievementData:isExistOneKeyGetProgressReward()
			end
		},
		[1000 + 20] = {
			function()
				var_0_0.hlTrainData:reqGetAllRoomsAward()
			end,
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCHAWARD,
			function()
				return var_0_0.hlTrainData:isThereRoomProduct40PercentWithCustomData()
			end
		}
	}
}
