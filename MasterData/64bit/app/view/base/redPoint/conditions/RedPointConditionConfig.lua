local var_0_0 = g.core.model.User

return {
	{
		func = function(arg_1_0)
			return g.core.common.ModuleUnlock:isModuleUnlockWithCustomData(arg_1_0)
		end,
		events = {
			g.core.event.enum.EVENT_THE_NEW_FUNC_SAVED
		}
	},
	{
		func = function(arg_2_0)
			return var_0_0.knightsData:canKnightLevelUpFive(arg_2_0)
		end,
		events = {
			g.core.event.enum.EVENT_GUIDE_CHECK,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	{
		func = function(arg_3_0)
			return var_0_0.knightsData:canKnightAdvance(arg_3_0)
		end,
		events = {
			g.core.event.enum.EVENT_GUIDE_CHECK,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	{
		func = function(arg_4_0)
			return var_0_0.mailData:isExistMailCheck(arg_4_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MAIL_INFO,
			g.core.event.enum.EVENT_NET_S2C_MAIL_AWARD,
			g.core.event.enum.MAIL_CLICK_REFRESH_RED_POINT
		}
	},
	{
		func = function(arg_5_0)
			return var_0_0.GuildFightData:isHasGuildFightCanGetAward(arg_5_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_AWARD
		}
	},
	{
		func = function(arg_6_0)
			return var_0_0.warriorsOfFateData:checkWarriors(arg_6_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SCROLL_ACTIVATE
		}
	},
	[8] = {
		func = function(arg_7_0)
			return var_0_0.knightFavoData:isCanLevelUp(arg_7_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	[9] = {
		func = function(arg_8_0)
			return var_0_0.knightFavoData:isNewDossier(arg_8_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYUPGRADE
		}
	},
	[10] = {
		func = function(arg_9_0)
			return var_0_0.redPacketData:isHasRedPacketCanSend(arg_9_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_USE,
			g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_INFO,
			g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_FLUSH
		}
	},
	[11] = {
		func = function(arg_10_0)
			return var_0_0.guildStatueData:isHasRewardCanGet(arg_10_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_PUSH,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_DOCAST,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETSTAGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_ONEKEYSTAGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETINFO
		}
	},
	[12] = {
		func = function(arg_11_0)
			return var_0_0.guildStatueData:isCanOneKeyReward(arg_11_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_PUSH,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_DOCAST,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETSTAGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_ONEKEYSTAGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETINFO
		}
	},
	[13] = {
		func = function(arg_12_0)
			return var_0_0.dailyDungeonData:hasNewDungeon(arg_12_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEFINISH,
			g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_FAST,
			g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_INFO
		}
	},
	[14] = {
		func = function(arg_13_0)
			return var_0_0.friendData:isCanRecvGiftOrGiven(arg_13_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRIEND_FRIENDLIST,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_CONFIRMFRIEND,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYGIFT,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_INFO,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIENDREQUEST,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIEND,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYDELFRIEND,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDBLACKLIST,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_DELBLACKLIST,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_SENDGIFT,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_RECEIVEGIFT
		}
	},
	[15] = {
		func = function(arg_14_0)
			return var_0_0.friendData:isHasRequestNum(arg_14_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRIEND_REQUESTLIST,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_CONFIRMFRIEND,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIENDREQUEST,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIEND,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDBLACKLIST
		}
	},
	[16] = {
		func = function(arg_15_0)
			return var_0_0.userAvatarFrameData:isHasNewAvatar(arg_15_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRAME_INFO
		}
	},
	[17] = {
		func = function(arg_16_0)
			return var_0_0.userAvatarFrameData:isHasNewFrame(arg_16_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRAME_INFO
		}
	},
	[18] = {
		func = function(arg_17_0)
			return var_0_0.UserTitleData:isHasGetTitleNew(arg_17_0)
		end
	},
	[19] = {
		func = function(arg_18_0)
			return var_0_0.accountAutheData:isShowRed(arg_18_0)
		end,
		events = {}
	},
	[20] = {
		func = function(arg_19_0)
			return var_0_0.chatData:hasNewPrivateChat(arg_19_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.EVENT_NET_S2C_MAIL_INFO,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[21] = {
		func = function(arg_20_0)
			return var_0_0.chatData:hasNewWorldChat(arg_20_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[22] = {
		func = function(arg_21_0)
			return var_0_0.chatData:hasNewFaceGroup(arg_21_0)
		end,
		events = {
			g.core.event.enum.EVENT_GUIDE_CHECK,
			g.core.event.enum.EVENT_NET_S2C_TALK_SHOW_ACTIVE,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[23] = {
		func = function(arg_22_0)
			return var_0_0.SignInData:isCanGetCumulateAwards(arg_22_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SIGN_IN_AWARD
		}
	},
	[24] = {
		func = function(arg_23_0)
			return var_0_0.SignInData:isCanGetSignAwards(arg_23_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SIGN_IN_SIGN
		}
	},
	[25] = {
		func = function(arg_24_0)
			return var_0_0.uniteTokenData:isUniteTokenCanBreakUp(arg_24_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_STARINCREASE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[26] = {
		func = function(arg_25_0)
			return var_0_0.uniteTokenData:isUniteTokenCanLvUp(arg_25_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_ONEKEY_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_UPGRADE
		}
	},
	[27] = {
		func = function(arg_26_0)
			return var_0_0.uniteTokenData:hasNotLineUpToken(arg_26_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[28] = {
		func = function(arg_27_0)
			return var_0_0.formationData:isPositionCanLineupUniteToken(arg_27_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[29] = {
		func = function(arg_28_0)
			return var_0_0.uniteTokenData:isHasNewUniteToken(arg_28_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_AWAKEN
		}
	},
	[30] = {
		func = function(arg_29_0)
			return var_0_0.uniteTokenData:hasUniteTokenCanCompose(arg_29_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[31] = {
		func = function(arg_30_0)
			return var_0_0.recruitData:isHasFreeGenerialRecruit(arg_30_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO
		}
	},
	[32] = {
		func = function(arg_31_0)
			return var_0_0.sevenDaysData:isNewUnlockedDay(arg_31_0)
		end
	},
	[33] = {
		func = function(arg_32_0)
			return var_0_0.sevenDaysData:isExistAwardWithCustomData(arg_32_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SEVENDAYS_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_SEVENDAYS_AWARD
		}
	},
	[34] = {
		func = function(arg_33_0)
			return var_0_0.rebelData:isExistDailyReward(arg_33_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_REBEL_INFO,
			g.core.event.enum.EVENT_NET_S2C_REBEL_AWARD,
			g.core.event.enum.EVENT_NET_S2C_REBEL_ONE_BUTTON_AWARD
		}
	},
	[35] = {
		func = function(arg_34_0)
			return var_0_0.bioData:isBioTeamCampaignNew(arg_34_0)
		end
	},
	[36] = {
		func = function(arg_35_0)
			return var_0_0.bioData:isCanGetBioTeamAward(arg_35_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETCAMPAIGNFIRSTAWARD
		}
	},
	[37] = {
		func = function(arg_36_0)
			return var_0_0.guildDungeonData:isThereCanRcvBoxWithCustomData(arg_36_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYGETFINISHAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETTREASUREBOX,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH
		}
	},
	[38] = {
		func = function(arg_37_0)
			return var_0_0.guildDungeonData:canGetClearAward(arg_37_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETFINISHAWARD_ONEKEY,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETFINISHAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH
		}
	},
	[39] = {
		func = function(arg_38_0)
			return var_0_0.guildDungeonData:isSkillCalLvUp(arg_38_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_SKILLLEVELUP,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETSKILLINFO,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH
		}
	},
	[40] = {
		func = function(arg_39_0)
			return var_0_0.stormData:isCanGetFreeReward(arg_39_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORM_FINISH_AWARD,
			g.core.event.enum.EVENT_NET_S2C_STORM_INFO
		}
	},
	[41] = {
		func = function(arg_40_0)
			return var_0_0.stormData:isCanStormSkillLvUp(arg_40_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORM_GETSKILLINFO,
			g.core.event.enum.EVENT_NET_S2C_STORM_INFO,
			g.core.event.enum.EVENT_NET_S2C_STORM_SKILLRESET,
			g.core.event.enum.EVENT_NET_S2C_STORM_SKILLLVUP
		}
	},
	[42] = {
		func = function(arg_41_0)
			return var_0_0.bioData:isBioChapterNew(arg_41_0)
		end
	},
	[43] = {
		func = function(arg_42_0)
			return var_0_0.dungeonData:isShowGetStarChestRedPoint(arg_42_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DUNGEON_GETCHAPTERCHESTAWARD
		}
	},
	[44] = {
		func = function(arg_43_0)
			return var_0_0.dungeonData:checkBoxAward(arg_43_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DUNGEON_ONEKEY_GETCHAPTERCHESTAWARD
		}
	},
	[45] = {
		func = function(arg_44_0)
			return var_0_0.furnitureData:checkIsNewFurniture(arg_44_0)
		end,
		events = {}
	},
	[47] = {
		func = function(arg_45_0)
			return var_0_0.hlTrainData:isCanLevelUpWithCustomData(arg_45_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_UPLEVEL
		}
	},
	[53] = {
		func = function(arg_46_0)
			return var_0_0.robTreasureData:isTaskAwardCanGet(arg_46_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO
		}
	},
	[54] = {
		func = function(arg_47_0)
			return var_0_0.bagData:checkIsRandOpenBox(arg_47_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[55] = {
		func = function(arg_48_0)
			return var_0_0.bagData:checkIsNewItem(arg_48_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[56] = {
		func = function(arg_49_0)
			return var_0_0.bagData:hasEquipCanCompose(arg_49_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE,
			g.core.event.enum.EVENT_NET_S2C_SELL
		}
	},
	[57] = {
		func = function(arg_50_0)
			return var_0_0.bagData:hasTreasureCanCompose(arg_50_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE,
			g.core.event.enum.EVENT_NET_S2C_SELL
		}
	},
	[58] = {
		func = function(arg_51_0)
			return var_0_0.handBookData:isHandBookCanUpgrade(arg_51_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE
		}
	},
	[59] = {
		func = function(arg_52_0)
			return var_0_0.achievementData:isExistAchieveReward(arg_52_0)
		end
	},
	[60] = {
		func = function(arg_53_0)
			return var_0_0.achievementData:isExistProgressReward(arg_53_0)
		end
	},
	[61] = {
		func = function(arg_54_0)
			return var_0_0.knightsData:hasCanComposeKnight(arg_54_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_KNIGHT,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[62] = {
		func = function(arg_55_0)
			return var_0_0.knightsData:isNewKnight(arg_55_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	[63] = {
		func = function(arg_56_0)
			return var_0_0.skinData:isNewSkin(arg_56_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[64] = {
		func = function(arg_57_0)
			return var_0_0.knightsData:canKnightStarUp(arg_57_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE
		}
	},
	[65] = {
		func = function(arg_58_0)
			return var_0_0.formationData:isPositionCanLineupKnight(arg_58_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[67] = {
		func = function(arg_59_0)
			return var_0_0.activityLevelUpData:isHasAwardCanGet(arg_59_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_LEVEL_UP_AWARD
		}
	},
	[68] = {
		func = function(arg_60_0)
			return var_0_0.activityGetStaminaData:isExistStaminaGet(arg_60_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GET_STAMINA_INFO,
			g.core.event.enum.EVENT_NET_S2C_GET_STAMINA_GET
		}
	},
	[71] = {
		func = function(arg_61_0)
			return var_0_0.warriorsOfFateData:checkWarriors(arg_61_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SCROLL_ACTIVATE
		}
	},
	[72] = {
		func = function(arg_62_0)
			return var_0_0.arenaData:isExistTaskAward(arg_62_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO,
			g.core.event.enum.EVENT_NET_S2C_ARENA_ONEKEYCHALLENGE,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD
		}
	},
	[73] = {
		func = function(arg_63_0)
			return var_0_0.knightTissueData:isTissueCanActiveOrLevelUp(arg_63_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_TISSUE_ACTIVE,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_TISSUE_UPLV,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE
		}
	},
	[74] = {
		func = function(arg_64_0)
			return var_0_0.equipmentData:checkEquipStrength(arg_64_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[75] = {
		func = function(arg_65_0)
			return var_0_0.equipmentData:checkEquipRefine(arg_65_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[76] = {
		func = function(arg_66_0)
			return var_0_0.knightFavoData:isNewSound(arg_66_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYUPGRADE
		}
	},
	[77] = {
		func = function(arg_67_0)
			return var_0_0.knightFavoData:isNewStory(arg_67_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYUPGRADE
		}
	},
	[80] = {
		func = function(arg_68_0)
			return var_0_0.equipmentData:checkWearEquipByType(arg_68_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[82] = {
		func = function(arg_69_0)
			return var_0_0.equipmentData:checkChangeEquipByType(arg_69_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[83] = {
		func = function(arg_70_0)
			return var_0_0.equipmentData:checkEquipGlyph(arg_70_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[84] = {
		func = function(arg_71_0)
			return var_0_0.treasureData:getIsTreasureCanStrength(arg_71_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TREASURE_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_TREASURE_UPGRADE_ONELEVEL
		}
	},
	[85] = {
		func = function(arg_72_0)
			return var_0_0.treasureData:getIsTreasureCanRefine(arg_72_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TREASURE_REFINING
		}
	},
	[86] = {
		func = function(arg_73_0)
			return var_0_0.treasureData:getIsHasTreasureCanOperation(arg_73_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[88] = {
		func = function(arg_74_0)
			return var_0_0.treasureData:getIsHasBetterTreasureToWear(arg_74_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION
		}
	},
	[89] = {
		func = function(arg_75_0)
			return var_0_0.treasureData:isTreasureCanGlyUp(arg_75_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TREASURE_GLYPH
		}
	},
	[90] = {
		func = function(arg_76_0)
			return var_0_0.onlineGiftData:isCanGetCurAward(arg_76_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ONLINE_GIFT_GETAWARD,
			g.core.event.enum.EVENT_ACTIVITY_ONLINE_GIFT_REFRESH_POINT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[91] = {
		func = function(arg_77_0)
			return var_0_0.dailyTaskData:checkHasAwardCanGet(arg_77_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_FINISHAWARD,
			g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_DEGREEAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_GETINFO
		}
	},
	[92] = {
		func = function(arg_78_0)
			return var_0_0.dailyTaskData:checkAllProfileHasNew(arg_78_0)
		end
	},
	[93] = {
		func = function(arg_79_0)
			return var_0_0.dailyTaskData:checkAllProfileHasAward(arg_79_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_PROFILEAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[99] = {
		func = function(arg_80_0)
			return var_0_0.sevenDaysSignInData:isThereRewardToGet(arg_80_0)
		end
	},
	[100] = {
		func = function(arg_81_0)
			return var_0_0.knightsData:hasKnightCanStarUp(arg_81_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[101] = {
		func = function(arg_82_0)
			return var_0_0.knightsData:hasKnightCanStarUpInOwner(arg_82_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[102] = {
		func = function(arg_83_0)
			return var_0_0.sevenDaysData:isExistIntegralAwardWithCustomData(arg_83_0)
		end
	},
	[103] = {
		func = function(arg_84_0)
			return var_0_0.hlTrainData:isRoomCanUnlockWithCustomData(arg_84_0)
		end
	},
	[104] = {
		func = function(arg_85_0)
			return var_0_0.hlTrainData:isThereCanWorkRoomWithCustomData(arg_85_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_UPLEVEL,
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_PRODUCT,
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH
		}
	},
	[105] = {
		func = function(arg_86_0)
			return var_0_0.hlTrainData:isThereRoomProduct40PercentWithCustomData(arg_86_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCHAWARD,
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_PRODUCT,
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH
		}
	},
	[106] = {
		func = function(arg_87_0)
			return var_0_0.furnitureData:isCanLevelUpWithCustomData(arg_87_0)
		end
	},
	[107] = {
		func = function(arg_88_0)
			return var_0_0.hlTrainData:isCanLevelUpWithCustomData(arg_88_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_UPLEVEL
		}
	},
	[108] = {
		func = function(arg_89_0)
			return var_0_0.furnitureData:isCheckInBtnNotClicked(arg_89_0)
		end
	},
	[110] = {
		func = function(arg_90_0)
			return var_0_0.questionnaireData:hasNewQuestionnaire(arg_90_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_QUESTIONNAIRE_GETINFO
		}
	},
	[111] = {
		func = function(arg_91_0)
			return var_0_0.activityDailyBoxData:isHasFreeGift(arg_91_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[112] = {
		func = function(arg_92_0)
			return var_0_0.totalRechargeData:isHasRewardCanGet(arg_92_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETTOTALRECHARGEAWARD
		}
	},
	[113] = {
		func = function(arg_93_0)
			return var_0_0.giftData:isCanReceiveFreeGift(arg_93_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[114] = {
		func = function(arg_94_0)
			return var_0_0.firstRechargeData:hasGanGetAward(arg_94_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFIRSTRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD
		}
	},
	[115] = {
		func = function(arg_95_0)
			return var_0_0.pushGiftData:getHasNew(arg_95_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD
		}
	},
	[116] = {
		func = function(arg_96_0)
			return var_0_0:isJoinGuild(arg_96_0)
		end
	},
	[117] = {
		func = function(arg_97_0)
			return var_0_0.passCardData:getIsHasPassCardRewardCanGet(arg_97_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PASS_CARD_INFO
		}
	},
	[118] = {
		func = function(arg_98_0)
			return var_0_0.passCardData:getIsHasDailyTaskAward(arg_98_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PASS_CARD_TASKCOMPLETE
		}
	},
	[119] = {
		func = function(arg_99_0)
			return var_0_0.passCardData:getIsHasWeekTaskAward(arg_99_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PASS_CARD_TASKCOMPLETE
		}
	},
	[120] = {
		func = function(arg_100_0)
			return var_0_0.passCardData:getIsHasRecycleTaskAward(arg_100_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PASS_CARD_TASKCOMPLETE
		}
	},
	[121] = {
		func = function(arg_101_0)
			return var_0_0.activityMonthCardData:checkMonthCardCanGet(arg_101_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_USEMONTHCARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[122] = {
		func = function(arg_102_0)
			return var_0_0.recruitData:canNoviceRecruit(arg_102_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENRECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENAWARD
		}
	},
	[123] = {
		func = function(arg_103_0)
			return var_0_0.recruitData:canNoviceReward(arg_103_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENRECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENAWARD
		}
	},
	[124] = {
		func = function(arg_104_0)
			return var_0_0.giftData:isCanReceiveLimitFreeGift(arg_104_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[126] = {
		func = function(arg_105_0)
			return var_0_0.pushGiftData:isHaveAwardGet(arg_105_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD
		}
	},
	[127] = {
		func = function(arg_106_0)
			return var_0_0.shopData:_isGuildShopHasFreeItem(arg_106_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[128] = {
		func = function(arg_107_0)
			return var_0_0.shopData:_isArenaShopHasFreeItem(arg_107_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[129] = {
		func = function(arg_108_0)
			return var_0_0.shopData:_isRebelShopHasFreeItem(arg_108_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[130] = {
		func = function(arg_109_0)
			return var_0_0.shopData:_isWushShopHasFreeItem(arg_109_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[131] = {
		func = function(arg_110_0)
			return var_0_0.shopData:_isWushTowerShopHasFreeItem(arg_110_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[132] = {
		func = function(arg_111_0)
			return var_0_0.activityMonthCardData:checkMonthCardCanGet(arg_111_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_USEMONTHCARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[133] = {
		func = function(arg_112_0)
			return var_0_0.giftData:isCanReceiveHotFreeGift(arg_112_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[134] = {
		func = function(arg_113_0)
			return var_0_0.guideTaskData:checkGuideTaskCompleted(arg_113_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUIDE_TASK_AWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[135] = {
		func = function(arg_114_0)
			return var_0_0.guideTaskData:checkGuideTaskNewById(arg_114_0)
		end,
		events = {}
	},
	[136] = {
		func = function(arg_115_0)
			return var_0_0.AuctionData:getIsHaveNew(arg_115_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_AUCTION_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_AUCTION_GOODSNOTIFY
		}
	},
	[137] = {
		func = function(arg_116_0)
			return var_0_0.themeData:hasNewBossPhaseOpen(arg_116_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[138] = {
		func = function(arg_117_0)
			return var_0_0.stormCityData:canRevHegemonyReward(arg_117_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO
		}
	},
	[139] = {
		func = function(arg_118_0)
			return var_0_0.stormCityData:checkOverLordAwardRed(arg_118_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETMAXLORDAWARD,
			g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORDACHIVEAWARD
		}
	},
	[140] = {
		func = function(arg_119_0)
			return var_0_0.stormCityData:isHasDailyReward(arg_119_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORDAWARD
		}
	},
	[141] = {
		func = function(arg_120_0)
			return var_0_0.UserTitleData:isNotOneAccountBind(arg_120_0)
		end,
		events = {
			g.core.event.enum.EVENT_BIND_ACCOUNT_SUCCESS,
			g.core.event.enum.EVENT_ACCOUNT_INFO_CALLBACK
		}
	},
	[142] = {
		func = function(arg_121_0)
			return var_0_0.UserTitleData:isCanBindAccountAward(arg_121_0)
		end,
		events = {
			g.core.event.enum.EVENT_BIND_ACCOUNT_SUCCESS,
			g.core.event.enum.EVENT_ACCOUNT_INFO_CALLBACK
		}
	},
	[143] = {
		func = function(arg_122_0)
			return var_0_0.activityMonthCardData:isCanGetSubAward(arg_122_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[145] = {
		func = function(arg_123_0)
			return var_0_0.peakArenaData:isExistDailyTaskAward(arg_123_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD
		}
	},
	[146] = {
		func = function(arg_124_0)
			return var_0_0.artifactHandBookData:groupHasItemCanActive(arg_124_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_HANDBOOKACTIVATE,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_INFO,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_HANDBOOKUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_STAR
		}
	},
	[147] = {
		func = function(arg_125_0)
			return var_0_0.artifactData:isHasArtifactCanCompose(arg_125_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE
		}
	},
	[148] = {
		func = function(arg_126_0)
			return var_0_0.artifactData:isHasArtifactCanStarUp(arg_126_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_STAR,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_INHERITFORMATION
		}
	},
	[149] = {
		func = function(arg_127_0)
			return var_0_0.artifactData:isHasArtifactCanStrength(arg_127_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_LEVELUP,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_INHERITFORMATION
		}
	},
	[150] = {
		func = function(arg_128_0)
			return var_0_0.artifactData:isHasNewArtifact(arg_128_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE
		}
	},
	[151] = {
		func = function(arg_129_0)
			return var_0_0.artifactData:isHasArtifactCanWear(arg_129_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE
		}
	},
	[153] = {
		func = function(arg_130_0)
			return var_0_0.activityFundData:canRewardLevelFund(arg_130_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[154] = {
		func = function(arg_131_0)
			return var_0_0.activityFundData:canRewardDungeonFund(arg_131_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[155] = {
		func = function(arg_132_0)
			return var_0_0.activityFundData:canRewardWushFund(arg_132_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[156] = {
		func = function(arg_133_0)
			return var_0_0.activityFundData:canRewardDungeonWelfare(arg_133_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_FUNDBUYNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[157] = {
		func = function(arg_134_0)
			return var_0_0.activityFundData:canRewardWushWelfare(arg_134_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_FUNDBUYNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[159] = {
		func = function(arg_135_0)
			return var_0_0.chatData:hasNewWorldChat(arg_135_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[160] = {
		func = function(arg_136_0)
			return var_0_0.chatData:hasNewArmyChat(arg_136_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[161] = {
		func = function(arg_137_0)
			return var_0_0.chatData:hasNewTroopsChat(arg_137_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[162] = {
		func = function(arg_138_0)
			return var_0_0.themeData:hasNewBoxCanGet(arg_138_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_GETCHAPTERBOX,
			g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_CHALLENGEFINISH
		}
	},
	[163] = {
		func = function(arg_139_0)
			return var_0_0.themeData:hasNewTaskDayCanGet(arg_139_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_THEME_ACTION_GETAWARDS,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[164] = {
		func = function(arg_140_0)
			return var_0_0.themeData:hasNewTaskHonourCanGet(arg_140_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_THEME_ACTION_GETAWARDS,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[165] = {
		func = function(arg_141_0)
			return var_0_0.themeData:hasNewShopCanBuy(arg_141_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[166] = {
		func = function(arg_142_0)
			return var_0_0.themeData:hasNewChapterOpen(arg_142_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[152] = {
		func = function(arg_143_0)
			return var_0_0.towerData:hasHangupRewardRed(arg_143_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPAWARD
		}
	},
	[158] = {
		func = function(arg_144_0)
			return var_0_0.towerData:hasFirstPassRewardRed(arg_144_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TOWER_FIRSTPASSAWARD,
			g.core.event.enum.EVENT_NET_S2C_TOWER_ONEKEYFIRSTPASSAWARD
		}
	},
	[167] = {
		func = function(arg_145_0)
			return var_0_0.guildData:hasPlayerWaitApply(arg_145_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_GETAPPLYLIST,
			g.core.event.enum.EVENT_NET_S2C_GUILD_CONFIRM
		}
	},
	[168] = {
		func = function(arg_146_0)
			return var_0_0.guildStatueData:canGetStartAward(arg_146_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_GUILD_STATUE_GETFINALAWARD
		}
	},
	[169] = {
		func = function(arg_147_0)
			return var_0_0.redPacketData:canGetRedPackage(arg_147_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_INFO,
			g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_PICK,
			g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_FLUSH
		}
	},
	[170] = {
		func = function(arg_148_0)
			return var_0_0.mineData:canRecTaskFullReward(arg_148_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_MINE_GETMISSION,
			g.core.event.enum.EVENT_NET_S2C_MINE_GETMISSIONREWARD,
			g.core.event.enum.EVENT_NET_S2C_MINE_GETACHIEVEREWARD
		}
	},
	[171] = {
		func = function(arg_149_0)
			return var_0_0.mineData:gatherRedPoint(arg_149_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_MINE_GETMASSINFO,
			g.core.event.enum.EVENT_NET_S2C_MINE_MASS,
			g.core.event.enum.EVENT_NET_S2C_MINE_MASSNOTIFY,
			g.core.event.enum.EVENT_MINE_GATHER_RED_POINT
		}
	},
	[172] = {
		func = function(arg_150_0)
			return var_0_0.mineData:isHintDead(arg_150_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO,
			g.core.event.enum.EVENT_MINE_PLAYER_DEAD,
			g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERDIENOTIFY
		}
	},
	[173] = {
		func = function(arg_151_0)
			return var_0_0.artifactData:isHasBagNewOwnArtifactCanStarUp(arg_151_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_STAR,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_INHERITFORMATION
		}
	},
	[174] = {
		func = function(arg_152_0)
			return var_0_0.rebelData:isRebelCntEnough(arg_152_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE,
			g.core.event.enum.EVENT_RECOVER_NOTIFY
		}
	},
	[175] = {
		func = function(arg_153_0)
			return var_0_0.bioData:isBioCntEnough(arg_153_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE,
			g.core.event.enum.EVENT_RECOVER_NOTIFY
		}
	},
	[176] = {
		func = function(arg_154_0)
			return var_0_0.stormData:isStormCntEnough(arg_154_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[177] = {
		func = function(arg_155_0)
			return var_0_0.guildDungeonData:getDunCntEnough(arg_155_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE
		}
	},
	[178] = {
		func = function(arg_156_0)
			return var_0_0.skinGoodsData:isNewSkin(arg_156_0)
		end,
		events = {
			g.core.event.enum.EVENT_RECHARGE_SKIN_REFRESH_POINT
		}
	},
	[179] = {
		func = function(arg_157_0)
			return var_0_0.guildWorshipData:isShowRedPoint(arg_157_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_GETWORSHIPINFO,
			g.core.event.enum.EVENT_NET_S2C_GUILD_DOWORSHIP,
			g.core.event.enum.EVENT_NET_S2C_GUILD_GETWORSHIPAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETPROGRESSAWARD_ONEKEY
		}
	},
	[180] = {
		func = function(arg_158_0)
			return var_0_0.bagData:checkIsTimeLimitItem(arg_158_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[181] = {
		func = function(arg_159_0)
			return var_0_0.bagData:checkIsTimeFullItem(arg_159_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[182] = {
		func = function(arg_160_0)
			return var_0_0.furnitureData:checkHaveCleanRoomFriends(arg_160_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_SWEEP
		}
	},
	[183] = {
		func = function(arg_161_0)
			return var_0_0.themeData:hasNewThemeShopOpen(arg_161_0)
		end,
		events = {}
	},
	[184] = {
		func = function(arg_162_0)
			return var_0_0.peakArenaData:isShowEntrance(arg_162_0)
		end,
		events = {}
	},
	[185] = {
		func = function(arg_163_0)
			return var_0_0.mineData:isInOpenTime(arg_163_0)
		end,
		events = {}
	},
	[186] = {
		func = function(arg_164_0)
			return var_0_0.towerData:hasRedPointByFreeCount(arg_164_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPQUICKAWARD,
			g.core.event.enum.EVENT_TOWER_CAPACITY_UP_REFRESH_RED_POINT
		}
	},
	[188] = {
		func = function(arg_165_0)
			return var_0_0.userActiveSceneData:isNewScene(arg_165_0)
		end,
		events = {}
	},
	[189] = {
		func = function(arg_166_0)
			return var_0_0.stormData:isStormCenterEnough(arg_166_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[190] = {
		func = function(arg_167_0)
			return var_0_0.themeData:hasNewExploreChapter(arg_167_0)
		end,
		events = {}
	},
	[191] = {
		func = function(arg_168_0)
			return var_0_0.plotReplayReviewData:isProfileHasAward(arg_168_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORY_COMPLETION_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_STORY_COMPLETION_AWARD
		}
	},
	[192] = {
		func = function(arg_169_0)
			return var_0_0.guildBossData:isShowRedPointByChallengeCount(arg_169_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_CHALLENGEBOSSFINISH,
			g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_ROBUSERFINISH,
			g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_GETINFO
		}
	},
	[193] = {
		func = function(arg_170_0)
			return var_0_0.recruitData:checkHasNewArtifactWishMember(arg_170_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO
		}
	},
	[194] = {
		func = function(arg_171_0)
			return var_0_0.furnitureHandBookData:checkIsHaveActivateHandBook(arg_171_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[196] = {
		func = function(arg_172_0)
			return var_0_0.stormData:isCanResetAndPass(arg_172_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORM_CLEAR,
			g.core.event.enum.EVENT_NET_S2C_STORM_RESET,
			g.core.event.enum.EVENT_NET_S2C_STORM_STORMINFO
		}
	},
	[197] = {
		func = function(arg_173_0)
			return var_0_0.stormCityData:isShowStationRedPoint(arg_173_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORM_CITY_CHALLENGEFINISH,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[198] = {
		func = function(arg_174_0)
			return var_0_0.giftData:isCanReceiveThemeFreeGift(arg_174_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[199] = {
		func = function(arg_175_0)
			return var_0_0.giftData:isHaveNewThemeGift(arg_175_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[200] = {
		func = function(arg_176_0)
			return var_0_0.guildWarData:isExistTaskAward(arg_176_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_ACHIEVES_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_ACHIEVES_AWARD
		}
	},
	[201] = {
		func = function(arg_177_0)
			return var_0_0.guildWarData:isNeedDispatchGuildMember(arg_177_0)
		end,
		events = {}
	},
	[202] = {
		func = function(arg_178_0)
			return var_0_0.chatData:hasNewGuildWarChat(arg_178_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[204] = {
		func = function(arg_179_0)
			return var_0_0.themeData:hasTurnCardNewPhase(arg_179_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[205] = {
		func = function(arg_180_0)
			return var_0_0.themeData:hasTurnCardAwardCanGet(arg_180_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TURN_CARD_RESULT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[206] = {
		func = function(arg_181_0)
			return var_0_0.giftData:isCanReceiveMonthFreeGift(arg_181_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[207] = {
		func = function(arg_182_0)
			return var_0_0.themeData:isHaveFiveTurnRes(arg_182_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TURNTABLE_ONCE,
			g.core.event.enum.EVENT_NET_S2C_TURNTABLE_FIVE
		}
	},
	[208] = {
		func = function(arg_183_0)
			return var_0_0.themeData:isHaveProgAwardCanGet(arg_183_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TURNTABLE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_TURNTABLE_REWARD
		}
	},
	[209] = {
		func = function(arg_184_0)
			return var_0_0.recruitData:checkHasNewLimitRecruit(arg_184_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO
		}
	},
	[214] = {
		func = function(arg_185_0)
			return var_0_0.activityInviteFriendData:isHaveAwardGet(arg_185_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_INVITED_AWARD,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_INVITE_AWARD,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_AWARDSTATUSFLUSH
		}
	},
	[215] = {
		func = function(arg_186_0)
			return var_0_0.guildWarData:isOpen(arg_186_0)
		end
	},
	[216] = {
		func = function(arg_187_0)
			return var_0_0.giftData:isHaveNewLevelGift(arg_187_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE,
			g.core.event.enum.EVENT_LEVEL_GIFT_SHOW_NEW
		}
	},
	[217] = {
		func = function(arg_188_0)
			return var_0_0.giftData:isCanReceiveLevelFreeGift(arg_188_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[218] = {
		func = function(arg_189_0)
			return var_0_0.activityInviteFriendData:isHaveNew(arg_189_0)
		end
	},
	[219] = {
		func = function(arg_190_0)
			return var_0_0.guildWarData:isLeaderNotGoInMineCityLayerThisSeason(arg_190_0)
		end
	},
	[220] = {
		func = function(arg_191_0)
			return var_0_0.guildWarData:isHaveDrillNumOnDrillStage(arg_191_0)
		end
	},
	[221] = {
		func = function(arg_192_0)
			return var_0_0.guildWarData:isHaveFightNumOnFighting(arg_192_0)
		end
	},
	[222] = {
		func = function(arg_193_0)
			return var_0_0.activityMonthCardData:isCanGetMonthTurnAwards(arg_193_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_MONTHCARDTURNAWARD
		}
	},
	[223] = {
		func = function(arg_194_0)
			return var_0_0.gmTotalRechargeData:isExistTotalRechargeAwardCanGet(arg_194_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGEAWARD
		}
	},
	[224] = {
		func = function(arg_195_0)
			return var_0_0.gmTotalRechargeData:isNewGmTotalRechargeActivity(arg_195_0)
		end
	},
	[225] = {
		func = function(arg_196_0)
			return var_0_0.goldSavingData:showNewFlag(arg_196_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_FLUSH,
			g.core.event.enum.EVENT_GOLD_SAVING_SHOW_NEW
		}
	},
	[227] = {
		func = function(arg_197_0)
			return var_0_0.themeData:hasGemEliminateNewPhase(arg_197_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ELIMINATE_GETINFO
		}
	},
	[228] = {
		func = function(arg_198_0)
			return var_0_0.themeData:hasGemEliminateAwardCanGet(arg_198_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ELIMINATE_RESULT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ELIMINATE_GETINFO
		}
	},
	[229] = {
		func = function(arg_199_0)
			return var_0_0.h5ActivityData:checkIconRedPoint(arg_199_0)
		end,
		events = {}
	},
	[230] = {
		func = function(arg_200_0)
			return var_0_0.userBackData:showOpenScreen(arg_200_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[231] = {
		func = function(arg_201_0)
			return var_0_0.userBackData:hasRedPoint(arg_201_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETSIGNREWARD
		}
	},
	[232] = {
		func = function(arg_202_0)
			return var_0_0.fogNightmareData:hasChallengeCount(arg_202_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FOG_NEXTFLOOR,
			g.core.event.enum.EVENT_NET_S2C_RFRESH_RESOURCE,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[233] = {
		func = function(arg_203_0)
			return var_0_0.fogNightmareData:hasIdleAward(arg_203_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FOG_IDLEAWARD
		}
	},
	[234] = {
		func = function(arg_204_0)
			return var_0_0.fogNightmareData:hasTalentPoint(arg_204_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FOG_TALENT_UPGRADENODE,
			g.core.event.enum.EVENT_NET_S2C_FOG_TALENT_RESET,
			g.core.event.enum.EVENT_NET_S2C_FOG_GETINFO
		}
	},
	[235] = {
		func = function(arg_205_0)
			return var_0_0.fogNightmareData:hasStageAward(arg_205_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FOG_PHASEAWARD,
			g.core.event.enum.EVENT_NET_S2C_FOG_NEXTFLOOR
		}
	},
	[236] = {
		func = function(arg_206_0)
			return var_0_0.fogNightmareData:hasNewFloor(arg_206_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FOG_UPGRADELEVEL
		}
	},
	[237] = {
		func = function(arg_207_0)
			return var_0_0.fogNightmareData:hasPlaceFormation(arg_207_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FOG_ADDKNIGHT,
			g.core.event.enum.EVENT_NET_S2C_FOG_UPGRADELEVEL
		}
	},
	[238] = {
		func = function(arg_208_0)
			return var_0_0.fogNightmareData:isOpen(arg_208_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FOG_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_FOG_NOTICEACTIVITY
		}
	},
	[239] = {
		func = function(arg_209_0)
			return var_0_0.knightsData:hasAssistRedPoint(arg_209_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_ONEKEY_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_UPGRADE
		}
	},
	[240] = {
		func = function(arg_210_0)
			return var_0_0.fogNightmareData:isKeepsakeNew(arg_210_0)
		end
	},
	[241] = {
		func = function(arg_211_0)
			return var_0_0.activityDailyBoxData:isProgCanAward(arg_211_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_DAILYBOXTURNAWARD
		}
	},
	[242] = {
		func = function(arg_212_0)
			return var_0_0.gmTotalRechargeData:isExistTaskAwardCanGet(arg_212_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[243] = {
		func = function(arg_213_0)
			return var_0_0.valentinesDayVoteData:hasTaskAwardCanGet(arg_213_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUPPORT_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_SUPPORT_TASKALLAWARD
		}
	},
	[244] = {
		func = function(arg_214_0)
			return var_0_0.valentinesDayVoteData:hasTicketCanVote(arg_214_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTE
		}
	},
	[245] = {
		func = function(arg_215_0)
			return var_0_0.valentinesDayVoteData:hasLevelAwardCanGet(arg_215_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTEAWARD,
			g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTEALLAWARD
		}
	},
	[246] = {
		func = function(arg_216_0)
			return var_0_0.themeData:hasPuzzleNewPhase(arg_216_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_PUZZLE_GETINFO
		}
	},
	[247] = {
		func = function(arg_217_0)
			return var_0_0.themeData:hasPuzzleAwardCanGet(arg_217_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PUZZLE_RESULT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_PUZZLE_GETINFO
		}
	},
	[248] = {
		func = function(arg_218_0)
			return var_0_0.petHandBookData:hasPetCanActivateOrStarUpWithCustomData(arg_218_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKACTIVATE,
			g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKINFO,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_PET_STARUP
		}
	},
	[249] = {
		func = function(arg_219_0)
			return var_0_0.petsData:hasPetCanComposeWithCustomData(arg_219_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_PET
		}
	},
	[250] = {
		func = function(arg_220_0)
			return var_0_0.petsData:hasPetCanStarUpWithCustomData(arg_220_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_PET
		}
	},
	[251] = {
		func = function(arg_221_0)
			return var_0_0.petsData:hasPetCanLevelUpWithCustomData(arg_221_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_PET
		}
	},
	[252] = {
		func = function(arg_222_0)
			return var_0_0.petsData:isNewPetWithCustomData(arg_222_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_PET
		}
	},
	[253] = {
		func = function(arg_223_0)
			return var_0_0.petsData:isPositionCanLineUpPetWithCustomData(arg_223_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_PET,
			g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_INHERIT
		}
	},
	[254] = {
		func = function(arg_224_0)
			return var_0_0.petsData:hasPetCanAdvanceWithCustomData(arg_224_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_PET
		}
	},
	[255] = {
		func = function(arg_225_0)
			return var_0_0.gveDataMgr:hasEquipNormalHalidom(arg_225_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_MERGE,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_LEVELUP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_DECOMPOSITION,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_FASTDECOMPOSITION,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[256] = {
		func = function(arg_226_0)
			return var_0_0.gveDataMgr:isCanLevelUpCoreHalidom(arg_226_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_MERGE,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_LEVELUP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_DECOMPOSITION,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_FASTDECOMPOSITION
		}
	},
	[257] = {
		func = function(arg_227_0)
			return var_0_0.gveDataMgr:isComposeAnylHalidom(arg_227_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_MERGE,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_LEVELUP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_DECOMPOSITION,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_FASTDECOMPOSITION,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[258] = {
		func = function(arg_228_0)
			return var_0_0.gveDataMgr:isComposeAllHalidom(arg_228_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_MERGE,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_LEVELUP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_DECOMPOSITION,
			g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_FASTDECOMPOSITION,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[259] = {
		func = function(arg_229_0)
			return var_0_0.gveDataMgr:isSiteHasKnightAdd(arg_229_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDGIVEUPCELL,
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH,
			g.core.event.enum.EVENT_GVE_MY_GRID_CHANGE,
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSETCELLKNIGHT
		}
	},
	[260] = {
		func = function(arg_230_0)
			return var_0_0.gveDataMgr:hasIdleTimeAward(arg_230_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDTIMEAWARD,
			g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY
		}
	},
	[261] = {
		func = function(arg_231_0)
			return var_0_0.gveDataMgr:hasKnightPoolSpace(arg_231_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSELECTKNIGHT,
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH
		}
	},
	[262] = {
		func = function(arg_232_0)
			return var_0_0.gveDataMgr:isTaskHaveAward(arg_232_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_TASKGETINFO,
			g.core.event.enum.EVENT_NET_S2C_G_VE_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_G_VE_CHAPTERAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[263] = {
		func = function(arg_233_0)
			return var_0_0.gveDataMgr:hasUniteCanLineUp(arg_233_0)
		end,
		events = {}
	},
	[264] = {
		func = function(arg_234_0)
			return var_0_0.gveDataMgr:hasPetCanLineUp(arg_234_0)
		end,
		events = {}
	},
	[265] = {
		func = function(arg_235_0)
			return var_0_0.gveDataMgr:hasKnightActionFull(arg_235_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH,
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCHALLENGEBEGIN,
			g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDACTIONNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_G_VE_CHALLENGEBOSSBEGIN
		}
	},
	[266] = {
		func = function(arg_236_0)
			return var_0_0.petsData:hasLineupPetCanStarUpWithCustomData(arg_236_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_PET
		}
	},
	[267] = {
		func = function(arg_237_0)
			return var_0_0.themeData:hasNewThemeBioChapter(arg_237_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_EXECUTEMISSION
		}
	},
	[268] = {
		func = function(arg_238_0)
			return var_0_0.activityMonthGachaData:isHasCanUseDraw(arg_238_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_DRAW
		}
	},
	[269] = {
		func = function(arg_239_0)
			return var_0_0.activityMonthGachaData:isCanRewardTask(arg_239_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKINFO,
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKAWARD
		}
	},
	[270] = {
		func = function(arg_240_0)
			return var_0_0.activityMonthGachaData:isActOpen(arg_240_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKINFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[271] = {
		func = function(arg_241_0)
			return var_0_0.towerHardData:hasFirstPassRewardRed(arg_241_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TOWER_FIRSTPASSAWARD,
			g.core.event.enum.EVENT_NET_S2C_TOWER_ONEKEYFIRSTPASSAWARD
		}
	},
	[272] = {
		func = function(arg_242_0)
			return var_0_0.recruitData:hasFreeTime(arg_242_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[273] = {
		func = function(arg_243_0)
			return var_0_0.towerHardData:hasHangupRewardRed(arg_243_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPAWARD
		}
	},
	[274] = {
		func = function(arg_244_0)
			return var_0_0.halfAnniversaryData:isHaveTaskAwards(arg_244_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_NOTIFYTASK,
			g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETAWARD
		}
	},
	[275] = {
		func = function(arg_245_0)
			return var_0_0.halfAnniversaryData:isHaveScoreAwards(arg_245_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETSCOREAWARD
		}
	},
	[276] = {
		func = function(self)
			return var_0_0.activityPermanentRechargeData:hasAwardCanReceive(self.index)
		end,
		events = {}
	},
	[277] = {
		func = function(arg_247_0)
			return false
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGEREBATEINFO,
			g.core.event.enum.EVENT_PERMANENT_RECHARGE_REFRESH_TAB
		}
	},
	[278] = {
		func = function(arg_248_0)
			return var_0_0.activityPermanentRechargeData:hasNewStageWithCustomData(arg_248_0)
		end,
		events = {
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	[279] = {
		func = function(arg_249_0)
			return var_0_0.activityPermanentRechargeData:hasNewGiftCanBuy(arg_249_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGEREBATEAWARD,
			g.core.event.enum.EVENT_PERMANENT_RECHARGE_REFRESH_TAB
		}
	},
	[280] = {
		func = function(arg_250_0)
			return var_0_0.mineData:hasFreeShieldCanGet(arg_250_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINE_GETSHIELD,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[281] = {
		func = function(arg_251_0)
			return var_0_0.wushTowerData:isCanGetTaskAward(arg_251_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ENTERINFO,
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_TASKUPDATE,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ONEKEYSWEEP
		}
	},
	[282] = {
		func = function(arg_252_0)
			return var_0_0.wushTowerData:isUnFinishCanChallenge(arg_252_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_NEXTGRIDS,
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_BATTLEFINISH,
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_CHOOSEGRID,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ONEKEYSWEEP
		}
	},
	[283] = {
		func = function(arg_253_0)
			return var_0_0.shopData:_isWushTowerShopHasFreeItem(arg_253_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[284] = {
		func = function(arg_254_0)
			return var_0_0.competitionData:isHaveCanGetAwardTask(arg_254_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_SYNCTASK,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_GETAWARD
		}
	},
	[285] = {
		func = function(arg_255_0)
			return var_0_0.competitionData:isHaveCanGetAwardScore(arg_255_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_SYNCTASK,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_GETAWARD
		}
	},
	[286] = {
		func = function(arg_256_0)
			return var_0_0.competitionData:isOpenCompetitonRank(arg_256_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_SYNCTASK,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_GETAWARD
		}
	},
	[287] = {
		func = function(arg_257_0)
			return var_0_0.commonCompetitionDataManager:hasTaskAwardCanGet(arg_257_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_COMPETITION_TASKAWARD
		}
	},
	[288] = {
		func = function(arg_258_0)
			return var_0_0.commonCompetitionDataManager:hasScoreAwardCanGet(arg_258_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_COMPETITION_SCOREAWARD
		}
	},
	[289] = {
		func = function(arg_259_0)
			return var_0_0.commonCompetitionDataManager:isNewOpenRank(arg_259_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[290] = {
		func = function(arg_260_0)
			return var_0_0.commonCompetitionDataManager:isNewOpenActivity(arg_260_0)
		end
	},
	[291] = {
		func = function(arg_261_0)
			return var_0_0.gveDataMgr:isHasHonorAward(arg_261_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSFIRSTKILL,
			g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSAWARD,
			g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSNOTIFYDEAD
		}
	},
	[292] = {
		func = function(arg_262_0)
			return var_0_0.lotteryData:canReceiveTaskReward(arg_262_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_LOTTERY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_LOTTERY_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[293] = {
		func = function(arg_263_0)
			return var_0_0.lotteryData:canDraw(arg_263_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_LOTTERY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_LOTTERY_NEXT_POOL,
			g.core.event.enum.EVENT_NET_S2C_LOTTERY_DRAW
		}
	},
	[294] = {
		func = function(arg_264_0)
			return var_0_0.treasureData:isEnoughPurifyAndIsEmpty(arg_264_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY,
			g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_REPLACE,
			g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_LOCK
		}
	},
	[295] = {
		func = function(arg_265_0)
			return var_0_0.treasureData:isEnoughTenPurify(arg_265_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY,
			g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_REPLACE,
			g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_LOCK
		}
	},
	[296] = {
		func = function(arg_266_0)
			return var_0_0.lotteryData:isNewActivity(arg_266_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_LOTTERY_GETINFO
		}
	},
	[297] = {
		func = function(arg_267_0)
			return var_0_0.weeklyCompetitionMgrData:isNewActivity(arg_267_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_INFO
		}
	},
	[298] = {
		func = function(arg_268_0)
			return var_0_0.weeklyCompetitionMgrData:canGetBoxReward(arg_268_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_INFO,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[300] = {
		func = function(arg_269_0)
			return var_0_0.peakArenaData:isShowMulTeamEditBtnNewPoint(arg_269_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_GET,
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_PLAYBETS,
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_GETACTIVITYINFO,
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_GETUSERINFO
		}
	},
	[301] = {
		func = function(arg_270_0)
			return var_0_0.peakArenaData:isThereNoEditMulTeam(arg_270_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_GET,
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_PLAYBETS,
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_GETACTIVITYINFO,
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_GETUSERINFO
		}
	},
	[302] = {
		func = function(arg_271_0)
			return var_0_0.gveDataMgr:isHasCanResearchKnight(arg_271_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_RESEARCHMISSION,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	[303] = {
		func = function(arg_272_0)
			return var_0_0.themeData:hasNewThemeBioItem(arg_272_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_THEME_BIO_ITEM
		}
	},
	[304] = {
		func = function(arg_273_0)
			return var_0_0.gveDataMgr:isKillResearchOpenAndNotIn(arg_273_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_G_VE_GETALLRANDOMBOSSINFO,
			g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSNOTIFYDEAD,
			g.core.event.enum.EVENT_NET_S2C_G_VE_GETALLBOSSISDEAD
		}
	},
	[305] = {
		func = function(arg_274_0)
			return var_0_0.giftData:isCanReceiveGachaFreeGift(arg_274_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[306] = {
		func = function(arg_275_0)
			return var_0_0.towerHardData:hasRedPointByFreeCount(arg_275_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPQUICKAWARD,
			g.core.event.enum.EVENT_NET_S2C_TOWER_FASTROLLING
		}
	},
	[307] = {
		func = function(arg_276_0)
			return not var_0_0.userFestivalData:isBirthdaySet(arg_276_0)
		end,
		events = {}
	},
	[308] = {
		func = function(arg_277_0)
			return var_0_0.userFestivalData:hasBirthdayGiftCanReceive(arg_277_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FESTIVAL_GET_BIRTHDAY_AWARD
		}
	},
	[310] = {
		func = function(arg_278_0)
			return var_0_0.themeData:hasNewGuessPhase(arg_278_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[311] = {
		func = function(arg_279_0)
			return var_0_0.themeData:hasGuessPhaseDailyReward(arg_279_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINI_GAME_GUESS_RESULT,
			g.core.event.enum.EVENT_NET_S2C_MINI_GAME_GUESS_GETINFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[312] = {
		func = function(arg_280_0)
			return var_0_0.equipmentData:checkRealEquipResonance(arg_280_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_RESONANCE_UP
		}
	},
	[313] = {
		func = function(arg_281_0)
			return var_0_0.echoLabData:getCollectData():isCardCanActive(arg_281_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PALACE_GETHANGUPAWARD,
			g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVEALTARNODE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[314] = {
		func = function(arg_282_0)
			return var_0_0.echoLabData:getCollectData():isCardCanUpgrade(arg_282_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PALACE_GETHANGUPAWARD,
			g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVEALTARNODE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[315] = {
		func = function(arg_283_0)
			return var_0_0.echoLabData:getCollectData():isReachHangupLimitTime(arg_283_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PALACE_GETHANGUPAWARD,
			g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVEALTARNODE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[316] = {
		func = function(arg_284_0)
			return var_0_0.echoLabData:getTreeData():hasCanActiveTalent(arg_284_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PALACE_GETHANGUPAWARD,
			g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVEALTARNODE
		}
	},
	[317] = {
		func = function(arg_285_0)
			return var_0_0.echoLabData:isHaveCanLineUpCards(arg_285_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PALACE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_PALACE_USECOMPOSE
		}
	},
	[318] = {
		func = function(arg_286_0)
			return not var_0_0.activityWishpoolData:isGetDailyReward(arg_286_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_WISHPOOL_DAILYPRESENTS,
			g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FLUSH
		}
	},
	[319] = {
		func = function(arg_287_0)
			return var_0_0.activityWishpoolData:isCanFishing(arg_287_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FISHING,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[320] = {
		func = function()
			return var_0_0.recruitData:isArtifactHasFreeTime()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[321] = {
		func = function()
			return var_0_0.activityDailyBoxData:hasGiftCanDraw()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[322] = {
		func = function()
			return var_0_0.recruitData:hasDailyRecruitRed()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT
		}
	},
	[323] = {
		func = function(arg_291_0)
			return var_0_0.arenaData:isArenaHasLeftCount(arg_291_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[324] = {
		func = function(arg_292_0)
			return var_0_0.wushData:isUnRestOrHasLeftCount(arg_292_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[325] = {
		func = function(arg_293_0)
			return var_0_0.dailyDungeonData:isChapterHasLeftCount(arg_293_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_INFO,
			g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEFINISH,
			g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_FAST,
			g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_FAST_SPIRIT_HELP,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[326] = {
		func = function(arg_294_0)
			return var_0_0.bioData:isHaveBioTeamLeftCount(arg_294_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[327] = {
		func = function(arg_295_0)
			return var_0_0.GuildFightData:hasRedInChallengeCount()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_FINISHCHALLENGE
		}
	},
	[328] = {
		func = function(arg_296_0)
			return false
		end,
		events = {}
	},
	[329] = {
		func = function(arg_297_0)
			return var_0_0.mulFormationData:hasHigherKnightQualityByParam(arg_297_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_KNIGHT,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[330] = {
		func = function(arg_298_0)
			return var_0_0.mulFormationData:hasHigherArtifactQualityByParam(arg_298_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_ARTIFACT,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[331] = {
		func = function(arg_299_0)
			return var_0_0.mulFormationData:hasHigherUniteQualityByParam(arg_299_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_UNITE,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[332] = {
		func = function(arg_300_0)
			return var_0_0.mulFormationData:hasHigherPetQualityByParam(arg_300_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_PET,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[333] = {
		func = function(arg_301_0)
			return var_0_0.activityWishpoolData:isNewActivity()
		end,
		events = {}
	},
	[334] = {
		func = function(arg_302_0)
			return var_0_0.shopData:isTowerShopHasFreeItem(arg_302_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[335] = {
		func = function(arg_303_0)
			return var_0_0.shopData:isTowerHardShopHasFreeItem(arg_303_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[336] = {
		func = function()
			return var_0_0.teamPvpData:hasChallengeNum()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[337] = {
		func = function()
			return var_0_0.teamPvpData:hasTaskCanReceive()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_ENTER
		}
	},
	[338] = {
		func = function(arg_306_0)
			return var_0_0.knightSoulData:isHaveNewGMChapter(arg_306_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SCREEN_ITEMS_INFOS,
			g.core.event.enum.EVENT_NET_S2C_SCREEN_ITEMS_NOTIFY
		}
	},
	[339] = {
		func = function(arg_307_0)
			return var_0_0.recruitData:checkHasNewLimitKnightSoulRecruit(arg_307_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO
		}
	},
	[340] = {
		func = function(arg_308_0)
			return var_0_0.teamPvpData:isActivityOpen()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[341] = {
		func = function(arg_309_0)
			return var_0_0.explorationData:hasStepsCanMove()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT
		}
	},
	[342] = {
		func = function(arg_310_0)
			return var_0_0.explorationData:hasGameCanPlay(arg_310_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_INFO,
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_UNLOCKCELL
		}
	},
	[343] = {
		func = function(arg_311_0)
			return var_0_0.explorationData:canReceiveOrChallenge()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_GETBOSSBATTLETEAM,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[344] = {
		func = function(arg_312_0)
			return var_0_0.explorationData:hasBossChallengeNum()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT
		}
	},
	[345] = {
		func = function(arg_313_0)
			return var_0_0.explorationData:canAssist()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_SHOWSETKNIGHTS,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_SETKNIGHTS,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_GETKNIGHTS,
			g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_USEKNIGHTS
		}
	},
	[346] = {
		func = function(arg_314_0)
			return var_0_0.explorationData:getFormationData():hasHigherKnightQualityByParam(arg_314_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_KNIGHT,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[347] = {
		func = function(arg_315_0)
			return var_0_0.explorationData:getFormationData():hasHigherArtifactQualityByParam(arg_315_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_ARTIFACT,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[348] = {
		func = function(arg_316_0)
			return var_0_0.explorationData:getFormationData():hasHigherUniteQualityByParam(arg_316_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_UNITE,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[349] = {
		func = function(arg_317_0)
			return var_0_0.explorationData:getFormationData():hasHigherPetQualityByParam(arg_317_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_PET,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[350] = {
		func = function(arg_318_0)
			return var_0_0.explorationData:isActivityOpen()
		end,
		events = {}
	},
	[351] = {
		func = function(arg_319_0)
			return var_0_0.explorationData:isNewKnight(arg_319_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS
		}
	},
	[352] = {
		func = function(arg_320_0)
			return var_0_0.explorationData:canRecycleLineUpKnight(arg_320_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_KNIGHT,
			g.core.event.enum.MUL_CHANGE_ALL,
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS,
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_SELL
		}
	},
	[353] = {
		func = function(arg_321_0)
			return var_0_0.explorationData:canReplaceLineUpKnight(arg_321_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_KNIGHT,
			g.core.event.enum.MUL_CHANGE_ALL
		}
	},
	[354] = {
		func = function(arg_322_0)
			return var_0_0.explorationData:taskCanGetAwards(arg_322_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_INFO,
			g.core.event.enum.EVENT_NET_S2C_EXPLORATION_FINISHTASK,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[355] = {
		func = function(arg_323_0)
			return var_0_0.redCliffData:hasTaskCanReceive()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_CHI_BI_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CHI_BI_APPLY,
			g.core.event.enum.EVENT_NET_S2C_CHI_BI_ACHIEVEMENTAWARD
		}
	},
	[356] = {
		func = function(arg_324_0)
			return var_0_0.redCliffData:hasMatchCanFight()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT
		}
	},
	[357] = {
		func = function(arg_325_0)
			return var_0_0.redCliffData:isCanApply()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_CHI_BI_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CHI_BI_APPLY
		}
	},
	[358] = {
		func = function(arg_326_0)
			return var_0_0.preciousData:isPreciousCanUpgradeStage(arg_326_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_UPGRADE
		}
	},
	[359] = {
		func = function(arg_327_0)
			return var_0_0.preciousData:isPreciousCanComposeOrStarUp(arg_327_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_STARUP
		}
	},
	[360] = {
		func = function(arg_328_0)
			return var_0_0.preciousData:isPreciousSuitActivateOrStarUp(arg_328_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_SUITACTIVATE,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_SUITSTARUP
		}
	},
	[361] = {
		func = function(arg_329_0)
			return var_0_0.recruitData:isPreciousHasFreeTime(arg_329_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[362] = {
		func = function(arg_330_0)
			return var_0_0.recruitData:checkHasNewLimitPreciousRecruit(arg_330_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO
		}
	},
	[363] = {
		func = function(arg_331_0)
			return var_0_0.formationData:hasPreciousSuitCanLineUp(arg_331_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_PRECIOUS_SUITACTIVATE
		}
	},
	[364] = {
		func = function(arg_332_0)
			return var_0_0.redCliffData:isActivityOpen()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[365] = {
		func = function(arg_333_0)
			return var_0_0.cultivateDataMgr:hasDailyTaskReward(arg_333_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATETASK,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_NOTICE,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[366] = {
		func = function(arg_334_0)
			return var_0_0.cultivateDataMgr:hasAchievementTaskReward(arg_334_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATETASK,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_NOTICE,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[367] = {
		func = function(arg_335_0)
			return false
		end,
		events = {}
	},
	[368] = {
		func = function(arg_336_0)
			return var_0_0.cultivateDataMgr:canUnlockPassCard(arg_336_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATEPASSCARD,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_PASSCARDGIFT,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_NOTICE,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_GETINFO
		}
	},
	[369] = {
		func = function(arg_337_0)
			return var_0_0.cultivateDataMgr:canGetPassCardReward(arg_337_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATEPASSCARD,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_PASSCARDGIFT,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_NOTICE,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_GETINFO
		}
	},
	[370] = {
		func = function(arg_338_0)
			return var_0_0.cultivateDataMgr:isNewActivityShop(arg_338_0)
		end,
		events = {}
	},
	[371] = {
		func = function(arg_339_0)
			return var_0_0.bountyData:canSummon(arg_339_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_FINDMONSTER,
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[372] = {
		func = function(arg_340_0)
			return var_0_0.bountyData:canBattleMonster(arg_340_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERINFO,
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_CHALLENGEFINISH
		}
	},
	[373] = {
		func = function(arg_341_0)
			return var_0_0.bountyData:canGetTaskReward(arg_341_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERINFO,
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[374] = {
		func = function(arg_342_0)
			return var_0_0.bountyData:canGetShareReward(arg_342_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERINFO,
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_MONSTERSHAREAWARD
		}
	},
	[375] = {
		func = function(arg_343_0)
			return var_0_0.bountyData:isHaveFreeGift(arg_343_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_BUYRECHARGEREBATEGIFT,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[376] = {
		func = function(arg_344_0)
			return var_0_0.bountyData:isNewActivityBounty(arg_344_0)
		end,
		events = {}
	},
	[383] = {
		func = function(arg_345_0)
			return var_0_0.bountyData:canGetDailyReward(arg_345_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETMONSTERINFO,
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETUSERDAILYSCORE,
			g.core.event.enum.EVENT_NET_S2C_BOUNTY_DAILYSCOREAWARD
		}
	},
	[384] = {
		func = function(arg_346_0)
			return var_0_0.chatData:hasNewBountyChat(arg_346_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[385] = {
		func = function(arg_347_0)
			return var_0_0.weddingData:hasWeddingRedPoint(arg_347_0, false)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_UPGRADE
		}
	},
	[386] = {
		func = function(arg_348_0)
			return var_0_0.weddingData:hasWeddingRedPoint(arg_348_0, false)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_UPGRADE
		}
	},
	[387] = {
		func = function(arg_349_0)
			return var_0_0.weddingData:hasWeddingSpecialRing(arg_349_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_ACTIVE
		}
	},
	[377] = {
		func = function(arg_350_0)
			return var_0_0.giftData:isCanReceivePreciousFreeGift(arg_350_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[378] = {
		func = function(arg_351_0)
			return var_0_0.gmFundData:hasFogFundReward(arg_351_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_LEVELAWARD,
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_UPDATEACTION
		}
	},
	[379] = {
		func = function(arg_352_0)
			return var_0_0.gmFundData:hasGveFundReward(arg_352_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_LEVELAWARD,
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_UPDATEACTION
		}
	},
	[380] = {
		func = function(arg_353_0)
			return var_0_0.gmFundData:hasForestFundReward(arg_353_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_LEVELAWARD,
			g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_UPDATEACTION
		}
	},
	[381] = {
		func = function(arg_354_0)
			return var_0_0.gmPassCardData:hasPassCardLevelReward(arg_354_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_LEVELAWARD,
			g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_BUYLEVEL
		}
	},
	[382] = {
		func = function(arg_355_0)
			return var_0_0.gmPassCardData:hasPassCardTaskReward(arg_355_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_UPDATE,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[388] = {
		func = function(arg_356_0)
			return var_0_0.activityFundData:canRewardMysteryFund(arg_356_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[389] = {
		func = function(arg_357_0)
			return var_0_0.activityFundData:canRewardMysteryWelfare(arg_357_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_FUNDBUYNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[390] = {
		func = function(arg_358_0)
			return var_0_0.mysteryData:isHaveChallengeTime(arg_358_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[391] = {
		func = function(arg_359_0)
			return var_0_0.mysteryData:isHaveTaskCanGetAwards(arg_359_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYTASK,
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_AWARD,
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_INFO
		}
	},
	[392] = {
		func = function(arg_360_0)
			return var_0_0.giftData:isCanReceiveWeddingFreeGift(arg_360_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD
		}
	},
	[393] = {
		func = function(arg_361_0)
			return var_0_0.shopData:isMysteryShopHasFreeItem(arg_361_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[394] = {
		func = function(arg_362_0)
			return var_0_0.mysteryData:isMysteryCanGetDailyTask(arg_362_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYTASK,
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_AWARD,
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[395] = {
		func = function(arg_363_0)
			return var_0_0.activityMonthGachaData:isCanRewardStageTask(arg_363_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKINFO,
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKAWARD
		}
	},
	[396] = {
		func = function(arg_364_0)
			return var_0_0.themeData:hasFreePassCardAward(arg_364_0)
		end,
		events = {}
	},
	[401] = {
		func = function(arg_365_0)
			return var_0_0.chatData:hasCrossChat(arg_365_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[402] = {
		func = function(arg_366_0)
			return var_0_0.activityReturnData:hasStageTaskAward(arg_366_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RERUN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RERUN_TASKAWARD
		}
	},
	[403] = {
		func = function(arg_367_0)
			return var_0_0.activityReturnData:hasNewActivity(arg_367_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RERUN_GETINFO
		}
	},
	[404] = {
		func = function(arg_368_0)
			return var_0_0.activityReturnData:hasNormalTaskAward(arg_368_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RERUN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RERUN_TASKAWARD
		}
	},
	[405] = {
		func = function(arg_369_0)
			return var_0_0.giftData:isCanReceiveActivityReturnFreeGift(arg_369_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[406] = {
		func = function(arg_370_0)
			return var_0_0.themeData:hasTalentNewRed(arg_370_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_ACTIVETALENT,
			g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_RESETTALENT,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[407] = {
		func = function(arg_371_0)
			return var_0_0.themeData:hasTalentRed(arg_371_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_ACTIVETALENT,
			g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_RESETTALENT,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[408] = {
		func = function(arg_372_0)
			return var_0_0.mysteryBossData:hasMysteryBossChallengeCount(arg_372_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[409] = {
		func = function(arg_373_0)
			return var_0_0.mysteryBossData:isCanReturnBossRoom(arg_373_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT
		}
	},
	[410] = {
		func = function(arg_374_0)
			return var_0_0.treeData:hasNodeCanUpgrade(arg_374_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TREE_NODE_UPSTAGE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[411] = {
		func = function(arg_375_0)
			return var_0_0.richmanData:isHasCanUseDice(arg_375_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROLLDICE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[412] = {
		func = function(arg_376_0)
			return var_0_0.richmanData:isCanRewardTask(arg_376_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[413] = {
		func = function(arg_377_0)
			return var_0_0.richmanData:isHasMiniGame(arg_377_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROLLDICE,
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_EVENTPROCESS,
			g.core.event.enum.EVENT_RICHMAN_EVENTPROCESS_FAILED,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[414] = {
		func = function(arg_378_0)
			return var_0_0.richmanData:isHangUpMax(arg_378_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_CONSTRUCTAWARD,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[415] = {
		func = function(arg_379_0)
			return var_0_0.richmanData:isBeSteal(arg_379_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETLOG,
			g.core.event.enum.EVENT_RICHMAN_LOG_REFRESH
		}
	},
	[416] = {
		func = function(arg_380_0)
			return var_0_0.richmanData:isHasMonsterCanAttack(arg_380_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROLLDICE,
			g.core.event.enum.EVENT_NET_S2C_RICH_MAN_EVENTPROCESS,
			g.core.event.enum.EVENT_RICHMAN_EVENTPROCESS_FAILED
		}
	},
	[417] = {
		func = function()
			return var_0_0.activityCelebrationLoginData:hasAwardCanReceive(g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_LOGIN)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_NOTICEACTIVITY,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_SIGNREWARD,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_DRAWGIFT
		}
	},
	[419] = {
		func = function()
			if g.core.model.User.teamBattleData:getCurStage() ~= g.core.const.ConstMgr.TeamBattleConst.ACTIVITY_STATE.OPEN then
				return false
			end

			return g.core.model.User.teamBattleData:isEnoughPoint()
		end,
		events = {}
	},
	[420] = {
		func = function()
			if g.core.model.User.teamBattleData:getCurStage() ~= g.core.const.ConstMgr.TeamBattleConst.ACTIVITY_STATE.OPEN then
				return false
			end

			return g.core.model.User.teamBattleData:hasGameCount()
		end,
		events = {}
	},
	[421] = {
		func = function()
			if g.core.model.User.teamBattleData:getCurStage() ~= g.core.const.ConstMgr.TeamBattleConst.ACTIVITY_STATE.PREPARE then
				return false
			end

			return not g.core.model.User.teamBattleData:getTeamUpData():hasMyTeam()
		end,
		events = {}
	},
	[422] = {
		func = function()
			if g.core.model.User.teamBattleData:getCurStage() ~= g.core.const.ConstMgr.TeamBattleConst.ACTIVITY_STATE.OPEN then
				return false
			end

			return not g.core.model.User.teamBattleData:isEnteredMap()
		end,
		events = {}
	},
	[423] = {
		func = function()
			return not g.core.model.User.teamBattleData:isRedLog()
		end,
		events = {}
	},
	[425] = {
		func = function()
			return var_0_0.chatData:hasNewTeamBattleChat()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST
		}
	},
	[426] = {
		func = function()
			return var_0_0.artifactHandBookData:isHasHandBookCanLvUp()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_URHANDBOOK_ACTIVE,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_URHANDBOOK_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_INFO,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_STAR
		}
	},
	[427] = {
		func = function(arg_389_0)
			return var_0_0.artifactData:isSpiritCanUpgrade(arg_389_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_SPIRITLEVELUP,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_SPIRITSTAGEUP,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE
		}
	},
	[428] = {
		func = function(arg_390_0)
			return var_0_0.petHandBookData:hasGroupCanPromoteWithCustomData(arg_390_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_INFO,
			g.core.event.enum.EVENT_NET_S2C_PET_UR_HANDBOOKACTIVE,
			g.core.event.enum.EVENT_NET_S2C_PET_UR_HANDBOOKUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_PET_STARUP,
			g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_PET_STARUP
		}
	},
	[429] = {
		func = function()
			return false
		end,
		events = {}
	},
	[430] = {
		func = function(arg_392_0)
			return var_0_0.equipmentData:checkEquipMagical(arg_392_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_MAGICALSTAGE_UP
		}
	},
	[431] = {
		func = function()
			return var_0_0.allianceData:hasAllianceInviteList()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPROVEINVITE
		}
	},
	[432] = {
		func = function()
			return var_0_0.guildData:isLeader()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE
		}
	},
	[433] = {
		func = function()
			return var_0_0.allianceData:hasAlliance()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE
		}
	},
	[434] = {
		func = function()
			return var_0_0.allianceData:canSendBoxInDayTime()
		end
	},
	[435] = {
		func = function()
			return var_0_0.allianceData:canGetBoxInTime()
		end,
		events = {}
	},
	[436] = {
		func = function()
			return var_0_0.allianceData:hasGuildApply()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPROVEINVITE,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPLYLIST
		}
	},
	[437] = {
		func = function()
			return false
		end,
		events = {}
	},
	[438] = {
		func = function()
			return var_0_0.allianceData:hasRedTaskCanRewardDaily()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKLIST,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKAWARD
		}
	},
	[439] = {
		func = function()
			return var_0_0.allianceData:hasRedTaskCanRewardAchievement()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKLIST,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKAWARD
		}
	},
	[440] = {
		func = function()
			return var_0_0.chatData:hasNewAllianceChat()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[441] = {
		func = function()
			return var_0_0.newSlgData:isPlayingState() and var_0_0.newSlgDevelopData:checkMainCityCanUpgrade()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEMAINCITY,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEBARRACK,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADESUPPLY,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[442] = {
		func = function(arg_404_0)
			return var_0_0.newSlgData:isPlayingState() and (g.core.model.User.newSlgData:getSName() == "S1" or nil) and var_0_0.newSlgDevelopData:checkEmbryoLineUpWithCustomData(arg_404_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_STATIONMAINCITY,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEMAINCITY
		}
	},
	[443] = {
		func = function()
			return var_0_0.newSlgData:isPlayingState() and var_0_0.newSlgDevelopData:checkSupplyCanAwards()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINSUPPLYAWARD
		}
	},
	[444] = {
		func = function()
			return var_0_0.newSlgData:isPlayingState() and var_0_0.newSlgDevelopData:checkSupplyProductLimit()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINSUPPLYAWARD
		}
	},
	[445] = {
		func = function(arg_407_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.commonPassCardDataMgr:hasLevelAwardCanGet(arg_407_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_LEVELAWARD,
			g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_BUYLEVEL
		}
	},
	[446] = {
		func = function(arg_408_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.commonPassCardDataMgr:hasTaskAwardCanGet(arg_408_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_UPDATETASK,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[447] = {
		func = function(arg_409_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:canAchieveCityQuest()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYCHECKPOINTQUEST,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCCITYQUESTPROGRESS,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCMAINQUESTPROGRESS,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYQUESTAWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINQUESTREWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ONEKEYOBTAINREWARDS,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_USERACHIEVEMENTNTF,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MAINQUESTAWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER
		}
	},
	[448] = {
		func = function(arg_410_0)
			return var_0_0.newSlgData:checkNewSlgCityGatherOutMap(arg_410_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER,
			g.core.event.enum.EVENT_SCHEDULE_NOTIFY
		}
	},
	[449] = {
		func = function(arg_411_0)
			return var_0_0.newSlgData:checkNewSlgCityGather(arg_411_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYGATHER,
			g.core.event.enum.EVENT_SCHEDULE_NOTIFY
		}
	},
	[450] = {
		func = function(arg_412_0)
			if not var_0_0.newSlgData:isForecasting() then
				return false
			end

			return not var_0_0.newSlgData:getIsGotPreviewReward(arg_412_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINPREVIEWREWARDS
		}
	},
	[451] = {
		func = function(arg_413_0)
			return var_0_0.newSlgData:isSettle() and var_0_0.shopData:_isNewSlgShopHasFreeItem()
		end,
		events = {}
	},
	[453] = {
		func = function(arg_414_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:isHaveCheckPointPassed(arg_414_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYCHECKPOINTQUEST,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCCITYQUESTPROGRESS,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCMAINQUESTPROGRESS,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYQUESTAWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MAINQUESTAWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER
		}
	},
	[454] = {
		func = function()
			return var_0_0.newSlgData:isPlayingState() and var_0_0.newSlgDevelopData:checkSupplyCanUpgrade()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADESUPPLY,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEMAINCITY,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEBARRACK,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[455] = {
		func = function(arg_416_0)
			return var_0_0.newSlgData:isPlayingState() and var_0_0.newSlgDevelopData:checkHasBarrackCanUpgrade(arg_416_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEMAINCITY,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[456] = {
		func = function(arg_417_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:checkHasTeamInvite(arg_417_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_TIPS_SET,
			g.core.event.enum.EVENT_NET_S2C_TIPS_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_TIPS_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_TIPS_DEL,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[457] = {
		func = function(arg_418_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:hasNewBattleReport(arg_418_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLEFINISHNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MONSTERBATTLEREPORT,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETREPORT,
			g.core.event.enum.EVENT_NEW_SLG_REPORT_VIEW_CLOSED,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT
		}
	},
	[458] = {
		func = function(arg_419_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:getLeftMonsterFightCount(arg_419_0) > 0
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MONSTERMARCH,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MONSTERBATTLEREPORT,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYMONSTERBATTLERESULT
		}
	},
	[459] = {
		func = function()
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:hasBoxCanUse()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ITEM_USE
		}
	},
	[460] = {
		func = function()
			return var_0_0.guildData:hasApplyMergeDataRed()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_AGREE
		}
	},
	[461] = {
		func = function()
			return var_0_0.newSlgData:isCanDeclaredCity()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYDECLARE,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYDECLARENTF,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYBEDECLAREDNTF,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER
		}
	},
	[462] = {
		func = function(arg_423_0)
			return g.core.model.User.recruitData:springRecruitProAwardCanRecv(arg_423_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_PROGRESSAWARD
		}
	},
	[463] = {
		func = function(self)
			return g.core.model.User.recruitData:isClickOpenSpring(self.id)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[464] = {
		func = function(arg_425_0)
			return var_0_0.giftData:isCanReceiveRecruitSpringFreeGift(arg_425_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD
		}
	},
	[465] = {
		func = function(arg_426_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:hasAchievementRed(arg_426_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_USERACHIEVEMENTNTF,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ONEKEYOBTAINREWARDS,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINQUESTREWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCCITYQUESTPROGRESS
		}
	},
	[466] = {
		func = function(arg_427_0)
			return var_0_0.allianceData:hasRedHonourLike(arg_427_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_HONOURSENDLIKE
		}
	},
	[467] = {
		func = function(arg_428_0)
			return var_0_0.giftData:isCanReceiveRetroFreeGift(arg_428_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[468] = {
		func = function(arg_429_0)
			return var_0_0.retroData:isCanRewardTask(arg_429_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RETRO_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RETRO_TASKAWARD
		}
	},
	[469] = {
		func = function(arg_430_0)
			return var_0_0.retroData:isCanRewardStageTask(arg_430_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RETRO_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RETRO_TASKAWARD
		}
	},
	[470] = {
		func = function(arg_431_0)
			return var_0_0.peakArenaData:hasCanCheerCount(arg_431_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_CHEER
		}
	},
	[471] = {
		func = function(arg_432_0)
			return var_0_0.peakArenaData:hasRankAwardCanRecv(arg_432_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_ALLIANCERANKAWARD
		}
	},
	[472] = {
		func = function(arg_433_0)
			return var_0_0.allianceTrialData:hasRedChallengeCount(arg_433_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH,
			g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH_SWEEP
		}
	},
	[473] = {
		func = function(arg_434_0)
			return var_0_0.allianceTrialData:hasRedGiveCount(arg_434_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_GIVE,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_USERLIST
		}
	},
	[474] = {
		func = function(arg_435_0)
			return var_0_0.allianceTrialData:hasRedGetBoxAward(arg_435_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXAWARD,
			g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXINFO,
			g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_UPDATEMONSTER,
			g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYLEVEL
		}
	},
	[475] = {
		func = function(arg_436_0)
			return var_0_0.activityOtherReturnPayData:isShow()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OTHER_RETURN_PAY_GETAWARD
		}
	},
	[476] = {
		func = function(arg_437_0)
			return var_0_0.activityOtherReturnPayData:isShow()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OTHER_RETURN_PAY_GETAWARD
		}
	},
	[477] = {
		func = function(arg_438_0)
			return var_0_0.roleSkinData:hasSkinPartCanLevelUp(arg_438_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SKIN_PART_LEVELUP,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[478] = {
		func = function(arg_439_0)
			return var_0_0.roleSkinData:hasSkinPartCanStageUp(arg_439_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SKIN_PART_STAGEUP,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[479] = {
		func = function(arg_440_0)
			return var_0_0.weddingActivityData:isCanGetTaskAward(arg_440_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_TASKAWARD
		}
	},
	[481] = {
		func = function(arg_441_0)
			return var_0_0.pubgData:isHaveTaskReward(arg_441_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_PUBG_TASKINFO,
			g.core.event.enum.EVENT_NET_S2C_PUBG_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[482] = {
		func = function(arg_442_0)
			return var_0_0.pubgData:isHaveTime(arg_442_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[483] = {
		func = function(arg_443_0)
			return var_0_0.monopolyDataMgr:isHasDiceCanUse(arg_443_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_MONOPOLY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_MONOPOLY_ROLLDICE,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_NOTICE
		}
	},
	[484] = {
		func = function(arg_444_0)
			return var_0_0.monopolyDataMgr:isHasPointRewardCanGet(arg_444_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MONOPOLY_ROLLDICE,
			g.core.event.enum.EVENT_NET_S2C_MONOPOLY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_MONOPOLY_NODEAWARD
		}
	},
	[485] = {
		func = function(arg_445_0)
			return var_0_0.succubaData:hasLeftInteractionTimes(arg_445_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_INTERACTIVEGET,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_INTERACTIVEFINISH
		}
	},
	[486] = {
		func = function(arg_446_0)
			return var_0_0.succubaData:hasSuccubaCanLevelUp(arg_446_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_LEVELUP
		}
	},
	[487] = {
		func = function(arg_447_0)
			return var_0_0.succubaData:hasSuccubaCanStarUp(arg_447_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_STARUP
		}
	},
	[488] = {
		func = function(arg_448_0)
			return var_0_0.succubaData:hasLeftAITimes(arg_448_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_INTERACTIVEGET,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_INTERACTIVEFINISH
		}
	},
	[489] = {
		func = function(arg_449_0)
			return var_0_0.succubaData:canLineUpSuccuba(arg_449_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_GET,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE,
			g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[490] = {
		func = function()
			return var_0_0.activityCelebrationLoginData:hasAwardCanReceive(g.core.const.ConstMgr.FUNCTION_TYPE.CELEBRATION_WITCH)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_NOTICEACTIVITY,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_SIGNREWARD,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_DRAWGIFT
		}
	},
	[491] = {
		func = function(arg_451_0)
			return var_0_0.gveDataMgr:getGveFormationData():canLineUpSuccubaInEmptyPos(arg_451_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FORMATION_GET,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE,
			g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_SAVE,
			g.core.event.enum.GVE_CHANGE_SUCCUBA
		}
	},
	[492] = {
		func = function()
			return var_0_0.abvertPageAwardData:isCanGetAward()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ABVERT_PAGE_AWARD_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_ABVERT_PAGE_AWARD_AWARD,
			g.core.event.enum.EVENT_NET_S2C_ABVERT_PAGE_AWARD_NOTIFY
		}
	},
	[493] = {
		func = function(arg_453_0)
			return var_0_0.mulFormationData:hasHigherSuccubaQualityByParam(arg_453_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_ALL,
			g.core.event.enum.MUL_CHANGE_SUCCUBA
		}
	},
	[494] = {
		func = function(arg_454_0)
			return var_0_0.explorationData:getFormationData():hasHigherSuccubaQualityByParam(arg_454_0)
		end,
		events = {
			g.core.event.enum.MUL_CHANGE_KNIGHT,
			g.core.event.enum.MUL_CHANGE_ALL,
			g.core.event.enum.MUL_CHANGE_SUCCUBA
		}
	},
	[495] = {
		func = function(arg_455_0)
			return var_0_0.newSlgData:canGetBountyTaskAward(arg_455_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYINFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYREFRESHTASK,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYTASKAWARD
		}
	},
	[496] = {
		func = function(arg_456_0)
			return var_0_0.newSlgData:canGetFirstKillAward(arg_456_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLINFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLAWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLNOTIFY
		}
	},
	[497] = {
		func = function()
			return var_0_0.userBackData:hasSignAwardGet()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETSIGNREWARD,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[498] = {
		func = function()
			return var_0_0.userBackData:hasFreeGiftGet()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_BUYGIFT,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[499] = {
		func = function(arg_459_0)
			return var_0_0.recruitData:isCanDrawReturnKnight(arg_459_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[500] = {
		func = function(arg_460_0)
			return var_0_0.recruitData:isCanDrawReturnArtifact(arg_460_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[501] = {
		func = function(arg_461_0)
			return var_0_0.userBackData:hasCanGetResourceAward(arg_461_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETBACKRES,
			g.core.event.enum.EVENT_NET_S2C_USER_BACK_RESACTIONNOTIFY,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[502] = {
		func = function(arg_462_0)
			return var_0_0.succubaData:canAdvUpSuccuba(arg_462_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_STAGEUP
		}
	},
	[503] = {
		func = function(arg_463_0)
			return var_0_0.blazingArenaData:isPlayTimeFull(arg_463_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[504] = {
		func = function(arg_464_0)
			return var_0_0.blazingArenaData:isHaveTaskReward(arg_464_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[505] = {
		func = function(arg_465_0)
			return var_0_0.blazingArenaData:isHaveNewBorrowUnit(arg_465_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[506] = {
		func = function(arg_466_0)
			return var_0_0.giftData:isCanReceiveScuccubaLaunchFreeGift(arg_466_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD
		}
	},
	[507] = {
		func = function(arg_467_0)
			return var_0_0.succubaLaunchData:hasTaskReward(arg_467_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_ACTIVITY_FINISHTASK
		}
	},
	[508] = {
		func = function(arg_468_0)
			return var_0_0.succubaLaunchData:canBuyItem(arg_468_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING,
			g.core.event.enum.EVENT_NET_S2C_SUCCUBA_ACTIVITY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[509] = {
		func = function(arg_469_0)
			return var_0_0.shopData:isBlazingArenaShopHasFreeItem(arg_469_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[510] = {
		func = function(arg_470_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgData:isHasSeasonTaskAward(arg_470_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SEASONTASKSYNCPROGRESS,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SEASONTASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER
		}
	},
	[511] = {
		func = function(arg_471_0)
			if not var_0_0.newSlgData:isPlayingState() then
				return false
			end

			return var_0_0.newSlgSkillTreeData:hasTalentRed(arg_471_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYACTIVATE,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYUPDATE,
			g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH
		}
	},
	[512] = {
		func = function(arg_472_0)
			return var_0_0.anniversaryData:isHaveFloorReward(arg_472_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ITEM_USE,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETFLOORAWARD
		}
	},
	[513] = {
		func = function(arg_473_0)
			return var_0_0.anniversaryData:isHaveTaskReward(arg_473_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETTASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_TASKNOTIFY
		}
	},
	[514] = {
		func = function(arg_474_0)
			return var_0_0.anniversaryData:isHaveFireItem(arg_474_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ITEM_USE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT
		}
	},
	[515] = {
		func = function(arg_475_0)
			return var_0_0.anniversaryData:isHaveJigsawDrawCost(arg_475_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_DRAWJIGSAW,
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETTASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[516] = {
		func = function(arg_476_0)
			return var_0_0.anniversaryData:isHaveCumulativeAward(arg_476_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETINFO
		}
	},
	[517] = {
		func = function(arg_477_0)
			return var_0_0.spireData:haveHalfMaxTimeIdleReward(arg_477_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_IDLEINFO,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_IDLEAWARD,
			g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY
		}
	},
	[518] = {
		func = function(arg_478_0)
			return var_0_0.spireData:haveFreeFastIdleReward(arg_478_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_FASTIDLE,
			g.core.event.enum.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[519] = {
		func = function(arg_479_0)
			return var_0_0.spireData:isTowerNewUnlock(arg_479_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_GETINFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[520] = {
		func = function(arg_480_0)
			return var_0_0.spireData:isTowerCanChallenge(arg_480_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_STAGEFINISH,
			g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSFINISH
		}
	},
	[521] = {
		func = function(arg_481_0)
			return var_0_0.knightsData:isHasMrKnightSoulUp(arg_481_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTUP,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[522] = {
		func = function(arg_482_0)
			return var_0_0.knightsData:isHasMrKnightSupportActive(arg_482_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTACTIVE
		}
	},
	[523] = {
		func = function(arg_483_0)
			return var_0_0.knightsData:isHasMrKnightSupportSkillUp(arg_483_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTUP,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTSKILLUP
		}
	},
	[524] = {
		func = function()
			return var_0_0.chatData:hasNewAnniversaryChat()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST,
			g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT
		}
	},
	[525] = {
		func = function(arg_485_0)
			return var_0_0.mysteryData:isWaitAttackBoss(arg_485_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_ELITE_CHALLENGEBEGIN,
			g.core.event.enum.EVENT_NET_S2C_MYSTERY_ELITE_CHALLENGEFINISH,
			g.core.event.enum.EVENT_MYSTERY_CLICK_MAIN_BOSS_BTN
		}
	},
	[526] = {
		func = function(arg_486_0)
			return var_0_0.giftData:isCanReceiveMonthlyFreeGift(arg_486_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[527] = {
		func = function(arg_487_0)
			return var_0_0.giftData:isCanReceiveMonthlyFreeGift(arg_487_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[528] = {
		func = function(arg_488_0)
			return var_0_0.outpostData:isHasVit(arg_488_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO
		}
	},
	[529] = {
		func = function(arg_489_0)
			return var_0_0.outpostData:isCanLineUp(arg_489_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_UNLOCK,
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_ENTRANCE,
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_EXIT
		}
	},
	[530] = {
		func = function(arg_490_0)
			return var_0_0.outpostData:isHasBossChallengeTimes(arg_490_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_CALLBOSS
		}
	},
	[531] = {
		func = function(arg_491_0)
			return var_0_0.shopData:_isOutpostShopHasFreeItem(arg_491_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[532] = {
		func = function(arg_492_0)
			return var_0_0.outpostData:isHasLimitTaskAward(arg_492_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_SYNCTASK,
			g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETTASKAWARD
		}
	},
	[533] = {
		func = function(arg_493_0)
			return var_0_0.mineData:isShowOwnCoinRed(arg_493_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_MINE_MOVECITY,
			g.core.event.enum.EVENT_NET_S2C_MINE_GETGOLD,
			g.core.event.enum.EVENT_NET_S2C_MINE_LEAVE,
			g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERDIENOTIFY,
			g.core.event.enum.EVENT_MINE_PLAYER_DEAD,
			g.core.event.enum.EVENT_MINE_GOLD_TICK_END
		}
	},
	[534] = {
		func = function(arg_494_0)
			return var_0_0.outpostData:isLackConBuildCoin(arg_494_0)
		end,
		events = {
			g.core.event.enum.EVENT_OUTPOST_KNIGHT_NOT_COIN_REFRESH
		}
	},
	[535] = {
		func = function(arg_495_0)
			return var_0_0.giftData:isCanReceiveReleaseFreeDiamondGfit(arg_495_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE
		}
	},
	[536] = {
		func = function(arg_496_0)
			return var_0_0.mineData:hasRichCity(arg_496_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_MINE_MOVECITY,
			g.core.event.enum.EVENT_NET_S2C_MINE_LEAVE,
			g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERDIENOTIFY,
			g.core.event.enum.EVENT_MINE_PLAYER_DEAD,
			g.core.event.enum.EVENT_NET_S2C_MINE_BUYPOWER,
			g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERPOWERNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[537] = {
		func = function(arg_497_0)
			return var_0_0.mineData:hasMoreHalfPower(arg_497_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_MINE_MOVECITY,
			g.core.event.enum.EVENT_NET_S2C_MINE_LEAVE,
			g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERDIENOTIFY,
			g.core.event.enum.EVENT_MINE_PLAYER_DEAD
		}
	},
	[538] = {
		func = function(arg_498_0)
			return var_0_0.domainData:isDungeonHasLeftTime(arg_498_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[539] = {
		func = function(arg_499_0)
			return var_0_0.ancientsData:checkAncientsHasFightTimes()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_ENTER,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_QUITTEAM,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYTEAMCHANGE,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_BUYFIGHTTIMES,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_FIGHTTIMESNTF
		}
	},
	[540] = {
		func = function(arg_500_0)
			return var_0_0.ancientsData:checkAncientsTaskAward(2)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKNTF,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKAWARD
		}
	},
	[541] = {
		func = function(arg_501_0)
			return var_0_0.ancientsData:checkAncientsTaskAward(1)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKNTF,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKAWARD
		}
	},
	[542] = {
		func = function(arg_502_0)
			return var_0_0.ancientsData:checkAncientsHasSpoils()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_ENTER,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_QUITTEAM,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYBEKICK,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_LOOTINFO,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICEROLL
		}
	},
	[543] = {
		func = function(arg_503_0)
			return var_0_0.ancientsData:checkAncientsFinalSubCanGuess(arg_503_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSINFO,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSAWARD,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESS,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_ROUNDNOTIFY
		}
	},
	[544] = {
		func = function(arg_504_0)
			return var_0_0.ancientsData:hasNewTeamApply()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_ENTER,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETAPPLYLIST,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_CONFIRMAPPLY
		}
	},
	[545] = {
		func = function(arg_505_0)
			return var_0_0.ancientsData:checkAncientsInvited()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETINVITATIONLIST,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYINVITE
		}
	},
	[547] = {
		func = function(arg_506_0)
			return var_0_0.ancientsData:checkAncientsFinalHasSubGuessAward(arg_506_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSINFO,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSAWARD,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESS,
			g.core.event.enum.EVENT_NET_S2C_ANCIENT_ROUNDNOTIFY
		}
	},
	[999] = {
		func = function(arg_507_0)
			return var_0_0.knightsData:hasKnightCanLevelUpFive(arg_507_0)
		end,
		events = {
			g.core.event.enum.EVENT_GUIDE_CHECK,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	[1000] = {
		func = function(arg_508_0)
			return var_0_0.knightsData:hasKnightCanAdvance(arg_508_0)
		end,
		events = {
			g.core.event.enum.EVENT_GUIDE_CHECK,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_CHANGE_KNIGHT
		}
	},
	[1001] = {
		func = function(arg_509_0)
			return var_0_0.functionUnlockData:isNewFuncUnlockedWithCustomData(arg_509_0)
		end
	},
	[1002] = {
		func = function(arg_510_0)
			return var_0_0.formationData:hasPositionCanLineupUniteToken(arg_510_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_INHERIT
		}
	},
	[1003] = {
		func = function(arg_511_0)
			return var_0_0.skinData:hasNewSkinByAdvanceId(arg_511_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT
		}
	},
	[1004] = {
		func = function(arg_512_0)
			return var_0_0.rebornData:hasCanRebornKnight(arg_512_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE
		}
	},
	[1005] = {
		func = function(arg_513_0)
			return var_0_0.rebornData:hasCanRebornUniteToken(arg_513_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE
		}
	},
	[1006] = {
		func = function(arg_514_0)
			return var_0_0.rebornData:hasCanRebornTreasure(arg_514_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE
		}
	},
	[1007] = {
		func = function(arg_515_0)
			return var_0_0.rebornData:hasCanRebornEquip(arg_515_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE
		}
	},
	[1008] = {
		func = function(arg_516_0)
			return var_0_0.rebornData:hasCanRebornArtifact(arg_516_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE
		}
	},
	[1009] = {
		func = function(arg_517_0)
			return var_0_0.knightsData:hasAssistRedPoint(arg_517_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_ONEKEY_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_OP_OBJECT,
			g.core.event.enum.EVENT_NET_S2C_KNIGHT_UPGRADE,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_INHERIT
		}
	},
	[1010] = {
		func = function(arg_518_0)
			return var_0_0.rebornData:hasCanRebornPet(arg_518_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE
		}
	},
	[1011] = {
		func = function(arg_519_0)
			return not g.core.model.User.sevenDaysSignInData:isEnterSevenDayView()
		end
	},
	[1013] = {
		func = function(arg_520_0)
			return g.core.model.User.goldSavingData:isHasGameCanPlay()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_FLUSH,
			g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_NOTIFYGAMEINFO,
			g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMEOVER
		}
	},
	[1012] = {
		func = function()
			return var_0_0.dungeonData:canReceiveStarAward()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DUNGEON_FINISHACHIEVEMENT
		}
	},
	[1014] = {
		func = function()
			return var_0_0.activityLifeTimeCardData:hasAwardCanReceive()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_USESUBRECHARGE
		}
	},
	[1015] = {
		func = function()
			return var_0_0.rechargeData:isShowReturnPay()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RETURN_PAY_GETAWARD
		}
	},
	[1016] = {
		func = function(arg_524_0)
			return var_0_0.plotReplayReviewData:isProfileSubHasAward(arg_524_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_STORY_COMPLETION_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_STORY_COMPLETION_AWARD
		}
	},
	[1017] = {
		func = function(self)
			return var_0_0.activityPermanentRechargeData:leftHasGift(self.index)
		end,
		events = {}
	},
	[1018] = {
		func = function(self)
			return var_0_0.activityPermanentRechargeData:rightHasGift(self.index)
		end,
		events = {}
	},
	[1019] = {
		func = function()
			return var_0_0.commanderWorldData:getHasGuildLvUpReward()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO,
			g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_GUILDNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_GUILDALLAWARD
		}
	},
	[1020] = {
		func = function(arg_528_0)
			return var_0_0.commanderWorldData:hasMarsRankRewardCanReceive(arg_528_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO,
			g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_MARSAWARD,
			g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[1021] = {
		func = function(arg_529_0)
			return var_0_0.commanderWorldData:isExistItemCanDonate(arg_529_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_AWARD
		}
	},
	[1022] = {
		func = function(arg_530_0)
			return var_0_0.commanderWorldData:hasTaskFinished()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO,
			g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[1023] = {
		func = function(arg_531_0)
			return var_0_0.commanderWorldData:hasGiftCanReceive()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_BUYRECHARGEREBATEGIFT,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[1024] = {
		func = function(arg_532_0)
			return var_0_0.phoenixGiftData:checkIsNewGift()
		end,
		events = {}
	},
	[1025] = {
		func = function(arg_533_0)
			return var_0_0.activityDailyBoxData:hasGameCount()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMEOVER
		}
	},
	[1026] = {
		func = function(arg_534_0)
			return var_0_0.themeData:hasGiftCanReceive(arg_534_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD
		}
	},
	[1027] = {
		func = function(arg_535_0)
			return var_0_0.giftData:isCanReceiveNewPlayerFreeGift(arg_535_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD
		}
	},
	[1028] = {
		func = function(arg_536_0)
			return var_0_0.hotSaleGMGiftData:isHaveFreeGMGift(arg_536_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_BUY,
			g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD
		}
	},
	[1029] = {
		func = function(arg_537_0)
			return var_0_0.hotSaleGMGiftData:isHaveNewGMPushGift(arg_537_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[1030] = {
		func = function()
			return var_0_0.activityTapWelfareData:isFirstClick()
		end,
		events = {
			g.core.event.enum.TAP_WELFARE_RED_POINT
		}
	},
	[1031] = {
		func = function(arg_539_0)
			return var_0_0.resouceBackData:isTodayUnEnter(arg_539_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[1032] = {
		func = function(arg_540_0)
			return var_0_0.knightSoulData:isHaveBookCanActivate(arg_540_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_K_SOUL_BOOKACTIVATE,
			g.core.event.enum.EVENT_NET_S2C_K_SOUL_BOOKUPGRADE
		}
	},
	[1033] = {
		func = function(arg_541_0)
			return var_0_0.knightSoulData:isHaveBookCanStarUp(arg_541_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_K_SOUL_BOOKACTIVATE,
			g.core.event.enum.EVENT_NET_S2C_K_SOUL_BOOKUPGRADE
		}
	},
	[1034] = {
		func = function(arg_542_0)
			return var_0_0.knightSoulData:isHaveHonorCanActivate(arg_542_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_K_SOUL_CHAPTERINFO,
			g.core.event.enum.EVENT_NET_S2C_K_SOUL_BOOKACTIVATE,
			g.core.event.enum.EVENT_NET_S2C_K_SOUL_HONORADVANCE
		}
	},
	[1035] = {
		func = function(arg_543_0)
			return var_0_0.recruitData:isKnightSoulHasFreeTime(arg_543_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_INFO,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY
		}
	},
	[1036] = {
		func = function(arg_544_0)
			return var_0_0.crossServerArenaData:isGloryRewardCanReceive(arg_544_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_GUILDHONORRANK,
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_GUILDRANKAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE
		}
	},
	[1037] = {
		func = function(arg_545_0)
			return var_0_0.crossServerArenaData:isSkillCanLvUp(arg_545_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_GUILDSKILL,
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_SKILLLEVELUP,
			g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE
		}
	},
	[1038] = {
		func = function(arg_546_0)
			return var_0_0.giftData:isCanReceiveCultivateFreeGift(arg_546_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[1040] = {
		func = function(arg_547_0)
			return var_0_0.petHandBookData:hasGroupPut()
		end
	},
	[1041] = {
		func = function(arg_548_0)
			return var_0_0.artifactHandBookData:hasURArtifactPut()
		end
	},
	[1043] = {
		func = function(arg_549_0)
			return var_0_0.allianceData:hasRedSendBox(arg_549_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXOPEN,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXGET,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETINFO
		}
	},
	[1044] = {
		func = function(arg_550_0)
			return var_0_0.allianceData:hasRedOpenBox(arg_550_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXOPEN,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXGET,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETINFO
		}
	},
	[1045] = {
		func = function(arg_551_0)
			return var_0_0.allianceData:hasRedBoxScoreAward(arg_551_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_EXCHANGEBOXAWARD,
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETINFO
		}
	},
	[1046] = {
		func = function(arg_552_0)
			return var_0_0.allianceData:hasRedGetBox(arg_552_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXGRANDNOTIFY
		}
	},
	[1049] = {
		func = function(arg_553_0)
			return false
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SKIN_PART_LEVELUP,
			g.core.event.enum.EVENT_NET_S2C_SKIN_PART_STAGEUP
		}
	},
	[1050] = {
		func = function(arg_554_0)
			return var_0_0.recycleCultivateData:isCanIncrease()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT,
			g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_UPGRADE
		}
	},
	[1051] = {
		func = function(arg_555_0)
			return var_0_0.giftData:isCanReceiveWitchCultivateFreeGift(arg_555_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE
		}
	},
	[1052] = {
		func = function(arg_556_0)
			return var_0_0.elderBossData:isHaveElderBossChallengeCount(arg_556_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGEFINISH
		}
	},
	[1053] = {
		func = function(arg_557_0)
			return var_0_0.elderBossData:hasTaskAwardCanGet(arg_557_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_TASKAWARD,
			g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_ENTER,
			g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGENOTIFY
		}
	},
	[1054] = {
		func = function(arg_558_0)
			return var_0_0.releaseActivityData:isCanRewardTask(arg_558_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RELEASE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RELEASE_DRAW,
			g.core.event.enum.EVENT_NET_S2C_RELEASE_TASKAWARD
		}
	},
	[1055] = {
		func = function(arg_559_0)
			return var_0_0.releaseActivityData:isCanAccumulateAward(arg_559_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RELEASE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_RELEASE_DRAW,
			g.core.event.enum.EVENT_NET_S2C_RELEASE_GETREWARD
		}
	},
	[1056] = {
		func = function(arg_560_0)
			return var_0_0.activityCelebrationLoginData:hasDailyRewardCanReceive(nil, arg_560_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_SIGNREWARD
		}
	},
	[1057] = {
		func = function(arg_561_0)
			return var_0_0.activityCelebrationLoginData:hasCumulateRewardCanReceive(nil, arg_561_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_CELEBRATION_LOGIN_DRAWGIFT
		}
	},
	[1058] = {
		func = function(arg_562_0)
			return var_0_0.releaseActivityData:isNewActivityRelease(arg_562_0)
		end,
		events = {}
	},
	[1059] = {
		func = function(arg_563_0)
			return var_0_0.artifactData:isHasBagNewOwnArtifactCanSpiritStageUp(arg_563_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_SPIRITLEVELUP,
			g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION,
			g.core.event.enum.EVENT_NET_S2C_ARTIFACT_INHERITFORMATION
		}
	},
	[1060] = {
		func = function(arg_564_0)
			return not var_0_0.vipLinkData:isOpen()
		end,
		events = {}
	},
	[5000001] = {
		func = function(arg_565_0)
			return var_0_0.geneData:canActivateFrag(arg_565_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GENE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_GENE_ACTIVATESEGMENT,
			g.core.event.enum.EVENT_NET_S2C_GENE_CHANGEPOSITION
		}
	},
	[5000002] = {
		func = function(arg_566_0)
			return var_0_0.geneData:canActivateGene(arg_566_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GENE_GETINFO,
			g.core.event.enum.EVENT_NET_S2C_GENE_ACTIVATEMAP,
			g.core.event.enum.EVENT_NET_S2C_GENE_CHANGEPOSITION
		}
	},
	[5000003] = {
		func = function(arg_567_0)
			return var_0_0.themeData:bossChallengeCountIsFull(arg_567_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_CHALLENGEFINISH
		}
	},
	[5000004] = {
		func = function(arg_568_0)
			return var_0_0.themeData:hasBossScoreAward(arg_568_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_GETAWARD
		}
	},
	[5000005] = {
		func = function()
			return var_0_0.crossServerArenaData:isExistTaskAward()
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD,
			g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD,
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_ONEKEYCHALLENGE
		}
	},
	[5000006] = {
		func = function()
			return var_0_0.crossServerArenaData:isChallengeNumFull()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	},
	[5000007] = {
		func = function()
			return var_0_0.crossServerArenaData:isNewSeason()
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_NOTICEACTIVITY
		}
	},
	[5000008] = {
		func = function(arg_572_0)
			return var_0_0.shopData:_isCrossServerArenaShopHasFreeItem(arg_572_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING
		}
	},
	[5000009] = {
		func = function(arg_573_0)
			return var_0_0.activityFundData:canRewardLevelWelfare(arg_573_0)
		end,
		events = {
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_FUNDBUYNOTIFY,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE
		}
	},
	[6000001] = {
		func = function(arg_574_0)
			return var_0_0.recruitData:leaderRecruitProAwardCanRecv(arg_574_0)
		end,
		events = {
			g.core.event.enum.EVENT_CROSS_DAY_NOTIFY,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_PROGRESSAWARD,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO,
			g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_RECRUIT,
			g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_INFO
		}
	},
	[2000] = {
		func = function()
			return var_0_0.activityBlackFiveData:isFirstClick()
		end,
		events = {
			g.core.event.enum.BLACK_FIVE_RED_POINT
		}
	},
	[2001] = {
		func = function(arg_576_0)
			return var_0_0.UserTitleData:showWXPageRed(arg_576_0)
		end,
		events = {}
	}
}
