local var_0_0 = {}

var_0_0.FULL_SCREEN = 1
var_0_0.POPUP = 2

local var_0_1 = g.core.const.ConstMgr
local Provider = require("app.core.common.Provider")

var_0_0.HOME = {
	package = "home",
	modType = var_0_0.FULL_SCREEN,
	BGM = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MAIN_MENU,
	create = function(arg_1_0)
		return require("app.view.module.home.view.HomeLayer").new(...)
	end
}
var_0_0.TXT_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_2_0)
		return require("app.view.base.component.BaseTxtPopComp").new(...)
	end
}
var_0_0.CONFIRM_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_3_0)
		return require("app.view.base.pop.BaseConfirmPop").new(...)
	end
}
var_0_0.PV_LAYER = {
	package = "login",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_4_0)
		return require("app.view.module.login.view.PvPlayLayer").new(...)
	end
}
var_0_0.LOGIN = {
	BGM_DELAY = 0.8,
	package = "login",
	modType = var_0_0.FULL_SCREEN,
	BGM = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_LOGIN,
	create = function(arg_5_0)
		return require("app.view.module.login.view.LoginLayer").new(...)
	end
}
var_0_0.UPGRADE = {
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0,
		withoutAni = true
	},
	create = function(arg_6_0)
		return require("upgrade.UpgradeLayer").new(...)
	end
}
var_0_0.SILENT_UPGRADE = {
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0,
		withoutAni = true
	},
	create = function(arg_7_0)
		return require("upgrade.SilentLayer").new(...)
	end
}
var_0_0.CREATE_MOVIE = {
	package = "create",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_8_0)
		return require("app.view.module.create.CreateFrontMovieLayer").new(...)
	end
}
var_0_0.CREATE = {
	package = "create",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_9_0)
		return require("app.view.module.create.CreateLayer").new(...)
	end
}
var_0_0.UNZIP_OBB = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_10_0)
		return require("upgrade.UnzipObbLayer").new(...)
	end
}
var_0_0.DUNGEON = {
	package = "dungeon",
	modType = var_0_0.FULL_SCREEN,
	routeType = {
		101,
		114
	},
	previous = var_0_0.HOME,
	create = function(arg_11_0)
		return require("app.view.module.dungeon.view.DungeonMainLayer").new(...)
	end
}
var_0_0.BIO_MAIN = {
	package = "biography",
	modType = var_0_0.FULL_SCREEN,
	routeType = {
		103,
		105,
		113
	},
	create = function(arg_12_0)
		return require("app.view.module.biography.view.BioMainLayer").new(...)
	end
}
var_0_0.BIO_STAGE = {
	routeType = 104,
	package = "biography",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.BIO_MAIN,
	create = function(arg_13_0)
		return require("app.view.module.biography.stage.BioGameStage").new(...)
	end
}
var_0_0.BIO_TEAM = {
	package = "biography",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.BIO_MAIN,
	create = function(arg_14_0)
		return require("app.view.module.biography.view.team.BioTeamLayer").new(...)
	end
}
var_0_0.REBEL = {
	routeType = 111,
	package = "rebel",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_15_0)
		return require("app.view.module.rebel.view.RebelMainLayer").new(...)
	end
}
var_0_0.HOME_LAND = {
	package = "homeLand",
	routeType = 25001,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	BGM = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MAP_HOME,
	create = function(arg_16_0)
		return require("app.view.module.homeLand.view.HomeLandLayer").new(...)
	end
}
var_0_0.HOME_LAND_TRAIN = {
	routeType = 107,
	package = "homeLandTrain",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME_LAND,
	create = function(arg_17_0)
		return require("app.view.module.homeLandTrain.view.HomeLandTrainLayer").new(...)
	end
}
var_0_0.HOME_LAND_FRIEND_TRAIN = {
	package = "homeLandTrain",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME_LAND_TRAIN,
	create = function(arg_18_0)
		return require("app.view.module.homeLandTrain.view.HomeLandFriendTrainLayer").new(...)
	end
}
var_0_0.MAIL = {
	routeType = 1005,
	package = "mail",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME_LAND,
	create = function(arg_19_0)
		return require("app.view.module.mail.view.MailLayer").new(...)
	end
}
var_0_0.KNIGHT_FAVO_MAIN = {
	routeType = 2041,
	package = "knightFavorability",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME_LAND,
	create = function(arg_20_0)
		return require("app.view.module.knightFavorability.view.FavoMainLayer").new(...)
	end
}
var_0_0.KNIGHT_FAVO = {
	package = "knightFavorability",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.KNIGHT_FAVORABILITY_MAIN,
	create = function(arg_21_0)
		return require("app.view.module.knightFavorability.view.FavoLayer").new(...)
	end
}
var_0_0.SHOW_ROOM = {
	package = "showRoom",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME_LAND,
	create = function(arg_22_0)
		return require("app.view.module.showRoom.view.ShowRoomMainLayer").new(...)
	end
}
var_0_0.ACHIEVEMENT = {
	isHungry = true,
	package = "achievement",
	routeType = 2035,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SHOW_ROOM,
	create = function(arg_23_0)
		return require("app.view.module.achievement.view.AchievementLayer").new(...)
	end,
	provider = Provider.reqAchievementGetInfo
}
var_0_0.PLOT_REPLAY_MAIN = {
	package = "plotReplay",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SHOW_ROOM,
	create = function(arg_24_0)
		return require("app.view.module.plotReplay.view.PlotReplayMainLayer").new(...)
	end
}
var_0_0.PLOT_REPLAY_REPLAY = {
	package = "plotReplay",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.PLOT_REPLAY_MAIN,
	create = function(arg_25_0)
		return require("app.view.module.plotReplay.view.PlotReplayReviewLayer").new(...)
	end
}
var_0_0.HAND_BOOK_MAIN = {
	routeType = 1014,
	package = "handBook",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SHOW_ROOM,
	create = function(arg_26_0)
		return require("app.view.module.handbook.view.HandBookMainLayer").new(...)
	end
}
var_0_0.ILLUSTRATION_MAIN = {
	package = "illustration",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SHOW_ROOM,
	create = function(arg_27_0)
		return require("app.view.module.illustration.view.IllustrationMainLayer").new(...)
	end
}
var_0_0.KNIGHT_TISSUE = {
	routeType = 2039,
	package = "knightTissue",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_28_0)
		return require("app.view.module.knightTissue.view.KnightTissueMainLayer").new(...)
	end
}
var_0_0.FURNITURE = {
	routeType = 2033,
	package = "furniture",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_29_0)
		return require("app.view.module.furniture.view.FurnitureMainLayer").new(...)
	end,
	needCloud = function()
		return true
	end
}
var_0_0.FRIEND_FURNITURE = {
	package = "furniture",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_31_0)
		return require("app.view.module.furniture.view.FurnitureFriendLayer").new(...)
	end
}
var_0_0.FURNITURE_CHARM_RANK = {
	package = "furniture",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_32_0)
		return require("app.view.module.furniture.view.FurnitureCharmRankLayer").new(...)
	end
}
var_0_0.FURNITURE_HAND_BOOK = {
	package = "furnitureHandBook",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_33_0)
		return require("app.view.module.furnitureHandBook.view.FurnitureHandBookLayer").new(...)
	end
}
var_0_0.DUNGEON_STAGE = {
	routeType = 102,
	package = "dungeon",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.DUNGEON,
	create = function(arg_34_0)
		return require("app.view.module.dungeon.view.stage.DungeonStageLayer").new(...)
	end,
	needCloud = function(arg_35_0)
		return true
	end
}
var_0_0.DUNGEON_BATTLE_POP = {
	package = "dungeon",
	modType = var_0_0.POPUP,
	previous = var_0_0.DUNGEON_STAGE,
	create = function(arg_36_0)
		return require("app.view.module.dungeon.view.stage.DungeonBattleInfoPop").new(...)
	end
}
var_0_0.DUNGEON_STAR_RANK = {
	package = "dungeon",
	modType = var_0_0.POPUP,
	previous = var_0_0.DUNGEON_STAGE,
	create = function(arg_37_0)
		return require("app.view.module.dungeon.view.DungeonStarRankLayer").new(...)
	end
}
var_0_0.BATTLE_SUMMARY = {
	package = "battleResult",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true,
		hideContinue = false
	},
	create = function(arg_38_0)
		return require("app.view.module.battleResult.view.BattleSummaryLayer").new(...)
	end
}
var_0_0.BATTLE_SELCARD = {
	package = "battleResult",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_39_0)
		return require("app.view.module.battleResult.view.BattleSelectCardLayer").new(...)
	end
}
var_0_0.BATTLE_ARENA_SELCARD = {
	package = "battleResult",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_40_0)
		return require("app.view.module.battleResult.view.BattleResultArenaSelectCardLayer").new(...)
	end
}
var_0_0.BATTLE_BIO_TEAM_SEL_CARD = {
	package = "battleResult",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_41_0)
		return require("app.view.module.battleResult.view.BattleResultBioTeamSelectCardLayer").new(...)
	end
}
var_0_0.LINE_UP_CHOOSE = {
	package = "lineUp",
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0
	},
	create = function(arg_42_0)
		return require("app.view.module.lineUp.view.lineUpPop.LineUpKnightPop").new(...)
	end
}
var_0_0.LINE_UP_CHOOSE_PET = {
	package = "lineUp",
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0
	},
	create = function(arg_43_0)
		return require("app.view.module.lineUp.view.lineUpPop.LineUpPetPop").new(...)
	end
}
var_0_0.KNIGHT = {
	routeType = 11,
	package = "knightBag",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_44_0)
		return require("app.view.module.knightBag.view.KnightBagLayer").new()
	end
}
var_0_0.KNIGHT_RECOMMEND = {
	package = "knightBag",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_45_0)
		return require("app.view.module.knightBag.view.KnightRecommendLayer").new()
	end
}
var_0_0.MAIN_BAG = {
	routeType = 2037,
	package = "bagNew",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_46_0)
		return require("app.view.module.bagNew.view.BagNewLayer").new()
	end
}
var_0_0.EQUIP_BAG = {
	routeType = 12,
	package = "bagNew",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_47_0)
		return require("app.view.module.bagNew.view.BagNewLayer").new({
			tab = require("app.view.module.bagNew.const.BagNewFuncCfg").FUNC_TYPE.EQUIPMENT - 1
		})
	end
}
var_0_0.TREASURE_BAG = {
	routeType = 34,
	package = "bagNew",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_48_0)
		return require("app.view.module.bagNew.view.BagNewLayer").new({
			tab = require("app.view.module.bagNew.const.BagNewFuncCfg").FUNC_TYPE.TREASURE - 1
		})
	end
}
var_0_0.ARTIFACT_BAG = {
	routeType = 26,
	package = "bagNew",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_49_0)
		return require("app.view.module.bagNew.view.BagNewLayer").new({
			tab = require("app.view.module.bagNew.const.BagNewFuncCfg").FUNC_TYPE.ARTIFACT - 1
		})
	end
}
var_0_0.PET_BAG = {
	routeType = 2075,
	package = "bagNew",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_50_0)
		return require("app.view.module.petBag.view.PetBagLayer").new()
	end
}
var_0_0.SKIN_BOOK = {
	package = "petBag",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_51_0)
		return require("app.view.module.knightSkinBook.view.KnightSkinBookLayer").new(...)
	end
}
var_0_0.PET_BOOK = {
	routeType = 2077,
	package = "petHandBook",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SHOW_ROOM,
	create = function(arg_52_0)
		return require("app.view.module.petHandbook.view.PetHandBookMainLayer").new(...)
	end
}
var_0_0.LINE_UP = {
	package = "lineUp",
	modType = var_0_0.FULL_SCREEN,
	routeType = {
		4,
		10
	},
	previous = var_0_0.HOME,
	create = function(arg_53_0)
		return require("app.view.module.lineUp.view.LineUpMainLayer").new(...)
	end
}
var_0_0.LINE_UP_PET = {
	routeType = 2078,
	package = "lineUp",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_54_0)
		return require("app.view.module.lineUp.view.LineUpPetMainLayer").new(...)
	end
}
var_0_0.KNIGHT_DEVELOP = {
	routeType = 21,
	package = "knight",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.KNIGHT,
	create = function(arg_55_0)
		return require("app.view.module.knight.view.KnightMainLayer").new(...)
	end
}
var_0_0.PET_DEVELOP = {
	routeType = 2076,
	package = "knight",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_56_0)
		return require("app.view.module.pet.view.PetMainLayer").new(...)
	end
}
var_0_0.FORMATION = {
	package = "formation",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_57_0)
		return require("app.view.module.formation.pre.FormationPreLayer").new(...)
	end
}
var_0_0.FORMATION_OTHER = {
	package = "formation",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_58_0)
		return require("app.view.module.formation.view.FormationOtherLayer").new(...)
	end
}
var_0_0.GUILD_MAIN = {
	package = "guild",
	routeType = 2001,
	modType = var_0_0.FULL_SCREEN,
	BGM = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ARMY,
	previous = var_0_0.HOME,
	create = function(arg_59_0)
		return require("app.view.module.guild.view.GuildMainLayer").new(...)
	end
}
var_0_0.GUILD_HALL = {
	package = "guild",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_MAIN,
	create = function(arg_60_0)
		return require("app.view.module.guild.view.GuildHallMainLayer").new({
			child = fgui.UIPackage:createObject("guild", "GuildInfoLeftComp")
		})
	end
}
var_0_0.GUILD_STATUE = {
	routeType = 2032,
	package = "guildStatue",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_MAIN,
	create = function(arg_61_0)
		return require("app.view.module.guildStatue.view.GuildStatueMainLayer").new()
	end
}
var_0_0.GUILD_RANK = {
	package = "guild",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_MAIN,
	create = function(arg_62_0)
		return require("app.view.module.guild.view.GuildRankLayer").new()
	end
}
var_0_0.GUILD_JOIN = {
	package = "guild",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_63_0)
		return require("app.view.module.guild.view.GuildJoinLayer").new(...)
	end
}
var_0_0.GUILD_JOIN_HALL = {
	package = "guild",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_JOIN,
	create = function(arg_64_0)
		return require("app.view.module.guild.view.GuildHallMainLayer").new(...)
	end
}
var_0_0.GUILD_RED_PACKET = {
	package = "guild",
	routeType = 2004,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_MAIN,
	create = function(arg_65_0)
		return require("app.view.module.guild.view.redPacket.GuildRedPacketLayer").new(...)
	end
}
var_0_0.GUILD_CAMPAIGN = {
	package = "guildCampaign",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_MAIN,
	create = function(arg_66_0)
		return require("app.view.module.guildCampaign.view.GuildCampaignLayer").new(...)
	end
}
var_0_0.GUILD_TASK = {
	routeType = 2003,
	package = "guild",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_MAIN,
	create = function(arg_67_0)
		return require("app.view.module.guild.view.task.GuildTaskMainLayer").new(...)
	end
}
var_0_0.GUILD_DUNGEON = {
	routeType = 2002,
	package = "guildDungeon",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD,
	create = function(arg_68_0)
		return require("app.view.module.guildDungeon.view.GuildDungeonMainLayer").new(...)
	end,
	provider = Provider.reqGuildDungeonProto
}
var_0_0.GUILD_BOSS = {
	package = "guildBoss",
	routeType = 2007,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD,
	BGM = g.core.const.ConstMgr.SoundConst.BGM.WUSH,
	create = function(arg_69_0)
		return require("app.view.module.guildBoss.view.GuildBossMainLayer").new(...)
	end
}
var_0_0.GUILD_CHAPTER = {
	package = "guildDungeon",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD,
	create = function(arg_70_0)
		return require("app.view.module.guildDungeon.view.GuildDungeonChapterLayer").new(...)
	end
}
var_0_0.STORM_MAIN = {
	routeType = 118,
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_71_0)
		return require("app.view.module.storm.view.StormMainLayer").new(...)
	end
}
var_0_0.STORM_BIG_WORLD = {
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_72_0)
		return require("app.view.module.storm.view.StormBigWorldLayer").new(...)
	end
}
var_0_0.STORM_SMALL_CITY = {
	package = "storm",
	routeType = 115,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_73_0)
		return require("app.view.module.storm.view.smallCity.StormSmallCityStage").new(...)
	end
}
var_0_0.STORM_MIDDLE_CITY = {
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_74_0)
		return require("app.view.module.storm.view.middleCity.StormMiddleCityStage").new(...)
	end
}
var_0_0.STORM_CITY_MAIN = {
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_75_0)
		return require("app.view.module.storm.view.StormMainLayer").new(...)
	end
}
var_0_0.STORM_CITY_MAIN_LAYER = {
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_76_0)
		return require("app.view.module.storm.view.StormStationMainLayer").new(...)
	end
}
var_0_0.STORM_STATION_OVERLORD = {
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_77_0)
		return require("app.view.module.storm.view.StormStationOverlordLayer").new(...)
	end
}
var_0_0.STORM_ALL_OVERLORD = {
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_78_0)
		return require("app.view.module.storm.view.StormAllOverlordLayer").new(...)
	end
}
var_0_0.STORM_STATION_RANK = {
	package = "storm",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_79_0)
		return require("app.view.module.storm.view.StormStationRankLayer").new(...)
	end
}
var_0_0.STORM_SMALL_CITY_FINISH = {
	package = "battleResult",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.STORM_MAIN,
	create = function(arg_80_0)
		return require("app.view.module.battleResult.view.storm.BattleResultStormSmallCompleteLayer").new(...)
	end
}
var_0_0.STORM_SKILL_LAYER = {
	package = "storm",
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0.1,
		withoutAni = true
	},
	previous = var_0_0.STORM_MAIN,
	create = function(arg_81_0)
		return require("app.view.module.storm.view.StormSkillTreeLayer").new(...)
	end
}
var_0_0.STORY_DIALOG = {
	package = "story",
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0,
		withoutAni = true
	},
	create = function(arg_82_0)
		return require("app.view.module.story.view.StoryDialogLayer").new(...)
	end
}
var_0_0.STORY_ANIMATION = {
	package = "story",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_83_0)
		return require("app.view.module.story.view.StoryAnimationLayer").new(...)
	end
}
var_0_0.STORY_ROLE_SHOW = {
	package = "story",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_84_0)
		return require("app.view.module.story.view.StoryRoleShowLayer").new(...)
	end
}
var_0_0.STORY_DARK_CURTAIN = {
	package = "story",
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0,
		withoutAni = true
	},
	create = function(arg_85_0)
		return require("app.view.module.story.view.StoryDarkCurtainLayer").new(...)
	end
}
var_0_0.STORY_ILLUSTRATION = {
	package = "story",
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0,
		withoutAni = true
	},
	create = function(arg_86_0)
		return require("app.view.module.story.view.StoryIllustrationLayer").new(...)
	end
}
var_0_0.STORY_MOVIE = {
	package = "story",
	BGM_OFF = true,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_87_0)
		return require("app.view.module.story.view.StoryMovieLayer").new(...)
	end
}
var_0_0.SHOW = {
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0.7,
		withoutAni = true
	},
	create = function(arg_88_0)
		return require("app.view.module.show.ShowFactory"):createShowRes(...)
	end
}
var_0_0.BATTLE = {
	package = "battle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_89_0)
		return require("app.view.battle.BattleScene").new(...)
	end
}
var_0_0.ASSISTANT = {
	package = "assistant",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_90_0)
		return require("app.view.module.assistant.view.AssistantMainLayer").new(...)
	end
}
var_0_0.ASSISTANT_ADV = {
	package = "assistant",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_91_0)
		return require("app.view.module.assistant.view.AssistantAdvMainLayer").new(...)
	end
}
var_0_0.SHOP = {
	routeType = 1002,
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_92_0)
		return require("app.view.module.shop.view.ShopLayer").new(...)
	end
}
var_0_0.SHOP_POPUP = {
	routeType = 1002,
	package = "shop",
	modType = var_0_0.POPUP,
	create = function(arg_93_0)
		return require("app.view.module.shop.view.ShopLayer").new(...)
	end
}
var_0_0.UNITE_TOKEN_SHOP = {
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_94_0)
		return require("app.view.module.shop.view.ShopLayer").new({
			shopType = var_0_1.ShopConst.SHOP_TYPE.UNITE_TOKEN_NORMAL
		})
	end
}
var_0_0.UNITE_TOKEN_LIMIT_SHOP = {
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_95_0)
		return require("app.view.module.shop.view.ShopLayer").new({
			shopType = var_0_1.ShopConst.SHOP_TYPE.UNITE_TOKEN_LIMIT
		})
	end
}
var_0_0.UNITE_TOKEN_OPENSVR_SHOP = {
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_96_0)
		return require("app.view.module.shop.view.ShopLayer").new({
			shopType = var_0_1.ShopConst.SHOP_TYPE.UNITE_TOKEN_OPENSERVER
		})
	end
}
var_0_0.GUILE_WAR_SHOP = {
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_97_0)
		return require("app.view.module.shop.view.ShopLayer").new({
			shopType = var_0_1.ShopConst.SHOP_TYPE.GUILD_WAR
		})
	end
}
var_0_0.ADD_ITEM_LAYER = {
	modType = var_0_0.POPUP,
	create = function(arg_98_0)
		return require("app.view.module.debug.AddItemLayer").new(...)
	end
}
var_0_0.EQUIP_AND_TREASURE = {
	routeType = 2044,
	package = "equipAndTreasure",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_99_0)
		return require("app.view.module.equipAndTreasure.view.ETMainLayer").new(...)
	end
}
var_0_0.OTHER_EQUIP_AND_TREASURE = {
	package = "equipAndTreasure",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_100_0)
		return require("app.view.module.equipAndTreasure.view.ETOtherMainLayer").new(...)
	end
}
var_0_0.EQUIP_DEVELOP = {
	routeType = 23,
	package = "equipAndTreasure",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_101_0)
		return require("app.view.module.equipAndTreasure.view.equip.EquipDevelopLayer").new(...)
	end
}
var_0_0.EQUIP_SUIT_INFO = {
	package = "equipAndTreasure",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true,
		hideContinue = true
	},
	create = function(arg_102_0)
		return require("app.view.module.equipAndTreasure.view.equip.EquipSuitInfoPop").new(...)
	end
}
var_0_0.TREASURE_DEVELOP = {
	routeType = 13,
	package = "equipAndTreasure",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.EQUIP_AND_TREASURE,
	create = function(arg_103_0)
		return require("app.view.module.equipAndTreasure.view.treasure.TreasureDevelopLayer").new(...)
	end
}
var_0_0.UNITE_TOKEN = {
	routeType = 14,
	package = "uniteToken",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_104_0)
		return require("app.view.module.uniteToken.view.UniteTokenBagLayer").new(...)
	end
}
var_0_0.UNITE_TOKEN_DEVELOP = {
	routeType = 22,
	package = "uniteToken",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.UNITE_TOKEN,
	create = function(arg_105_0)
		return require("app.view.module.uniteToken.view.UniteTokenDevMainLayer").new(...)
	end
}
var_0_0.UNITE_TOKEN_ATTRIBUTE = {
	package = "bagNew",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true
	},
	create = function(arg_106_0)
		return require("app.view.module.bagNew.view.popup.BagNewMorePop").new(...)
	end
}
var_0_0.RECRUIT = {
	routeType = 1001,
	package = "recruit",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_107_0)
		return require("app.view.module.recruit.view.RecruitLayer").new(...)
	end
}
var_0_0.PRIMARY_RECRUIT = {
	routeType = 2045,
	package = "recruit",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_108_0)
		return require("app.view.module.recruit.view.RecruitLayer").new({
			route1 = var_0_1.RecruitConst.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_RECRUIT_TYPE,
			route2 = var_0_1.RecruitConst.RECRUIT_TYPE.PRIMARY
		})
	end,
	provider = Provider.reqPrimaryRecruitProto
}
var_0_0.RECRUIT_ACT_UNITE_TOKEN = {
	routeType = 2045,
	package = "recruitActUniteToken",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_109_0)
		return require("app.view.module.recruit.view.recruitAct.uniteToken.RecruitActUniteTokenLayer").new(...)
	end
}
var_0_0.RECRUIT_SPRING = {
	routeType = 2300,
	package = "recruitKnightSpring",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_110_0)
		return require("app.view.module.recruit.view.recruitKnightSpring.RecruitKnightSpringLayer").new(...)
	end
}
var_0_0.BIOTEAMAKEY_POP = {
	package = "biography",
	modType = var_0_0.POPUP,
	create = function(arg_111_0)
		return require("app.view.module.biography.view.BioFastDropPop").new(...)
	end
}
var_0_0.UNITE_TOKEN_SUCCESS = {
	package = "uniteToken",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_112_0)
		return require("app.view.module.uniteToken.view.UniteTokenSuccessPop").new(...)
	end
}
var_0_0.RECRUIT_REWARD = {
	package = "recruitKnight",
	modType = var_0_0.POPUP,
	create = function(arg_113_0)
		return require("app.view.module.recruit.view.RecruitRewardLayer").new(...)
	end
}
var_0_0.RECRUIT_ARTIFACT_REWARD = {
	package = "recruitArtifact",
	modType = var_0_0.POPUP,
	create = function(arg_114_0)
		return require("app.view.module.recruit.view.artifact.ArtifactRewardLayer").new(...)
	end
}
var_0_0.RECRUIT_KNIGHT_SOUL_REWARD = {
	package = "recruitKnightSoul",
	modType = var_0_0.POPUP,
	create = function(arg_115_0)
		return require("app.view.module.recruit.view.knightSoul.KnightSoulRewardLayer").new(...)
	end
}
var_0_0.RECRUIT_PET_REWARD = {
	package = "recruitPet",
	modType = var_0_0.POPUP,
	create = function(arg_116_0)
		return require("app.view.module.recruit.view.pet.PetRewardLayer").new(...)
	end
}
var_0_0.RECRUIT_REWARD_SPRING = {
	package = "recruitKnightSpring",
	modType = var_0_0.POPUP,
	create = function(arg_117_0)
		return require("app.view.module.recruit.view.recruitKnightSpring.RecruitRewardSpringLayer").new(...)
	end
}
var_0_0.DAILY_DUNGEON = {
	routeType = 108,
	package = "dailyDungeon",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_118_0)
		return require("app.view.module.dailyDungeon.view.DailyDungeonMainLayer").new(...)
	end
}
var_0_0.DAILY_DUNGEON_DETAIL = {
	package = "dailyDungeon",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_119_0)
		return require("app.view.module.dailyDungeon.view.DailyDungeonLayer").new(...)
	end
}
var_0_0.SETTING = {
	package = "setting",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_120_0)
		return require("app.view.module.setting.view.SettingMainLayer").new(...)
	end
}
var_0_0.CHAT = {
	routeType = 1013,
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0,
		withoutAni = true
	},
	create = function(arg_121_0)
		return require("app.view.module.chat.view.ChatMainPop").new(...)
	end
}
var_0_0.ACTIVITY = {
	routeType = 1012,
	package = "activity",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_122_0)
		return require("app.view.module.activity.view.activityBase.ActivityMainLayer").new(...)
	end
}
var_0_0.SEVEN_DAYS_ACTIVITY = {
	routeType = 1017,
	package = "sevenDaysActivity",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_123_0)
		return require("app.view.module.sevenDays.view.SevenDaysMainLayer").new(var_0_1.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY, ...)
	end
}
var_0_0.SEVEN_DAYS_ACTIVITY_2 = {
	routeType = 1018,
	package = "sevenDaysActivity",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_124_0)
		return require("app.view.module.sevenDays.view.SevenDaysMainLayer").new(var_0_1.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY_2, ...)
	end
}
var_0_0.NEW_FIRST_RECHARGE = {
	package = "firstRecharge",
	modType = var_0_0.POPUP,
	previous = var_0_0.HOME,
	create = function(arg_125_0)
		return require("app.view.module.firstRecharge.view.FirstRechargePop").new(...)
	end
}
var_0_0.WUSH = {
	routeType = 110,
	package = "wush",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_126_0)
		return require("app.view.module.wush.view.WushMainLayer").new(...)
	end
}
var_0_0.WUSH_BLITZ = {
	package = "wush",
	modType = var_0_0.POPUP,
	create = function(arg_127_0)
		return require("app.view.module.wush.view.wushPop.WushBlitzPop").new(...)
	end
}
var_0_0.ARENA = {
	routeType = 109,
	package = "arena",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_128_0)
		return require("app.view.module.arena.view.ArenaMainLayer").new(...)
	end,
	provider = Provider.reqArenaProto
}
var_0_0.ARENA_FIRST = {
	package = "arena",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_129_0)
		return require("app.view.module.arena.view.ArenaMainLayer").new(...)
	end
}
var_0_0.SNATCH_TREASURE = {
	routeType = 112,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_130_0)
		return require("app.view.module.robTreasure.view.RobTreasureMainLayer").new(...)
	end
}
var_0_0.FRIEND = {
	routeType = 1004,
	package = "friend",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_131_0)
		return require("app.view.module.friend.view.FriendMainLayer").new(...)
	end
}
var_0_0.WARRIOR = {
	routeType = 18,
	package = "warriorsOfFate",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_132_0)
		return require("app.view.module.warriorsOfFate.view.WarriorsMainLayer").new(...)
	end
}
var_0_0.CAMPAIGN = {
	package = "campaign",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_133_0)
		return require("app.view.module.campaign.view.CampaignLayer").new(...)
	end
}
var_0_0.REBORN = {
	package = "reborn",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.MAIN_BAG,
	create = function(arg_134_0)
		return require("app.view.module.reborn.view.RebornMainLayer").new(...)
	end
}
var_0_0.PUZZLE_GAME = {
	package = "puzzle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_135_0)
		g.core.layer.LayerManager:setPhysicsWorldAutoStep(true)

		return require("app.view.module.puzzle.game.view.PuzzleGameMainLayer").new(...)
	end,
	needCloud = function()
		return true
	end
}
var_0_0.RECHARGE = {
	routeType = 1015,
	package = "recharge",
	modType = var_0_0.FULL_SCREEN,
	params = {
		blackOpacity = 0.6,
		withoutAni = true
	},
	create = function(arg_137_0)
		return require("app.view.module.recharge.view.RechargeLayer").new(...)
	end
}
var_0_0.USER_MAIN = {
	routeType = 2048,
	package = "recharge",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_138_0)
		return require("app.view.module.user.view.UserMainLayer").new(...)
	end
}
var_0_0.GUILD_FIGHT = {
	package = "guildFight",
	routeType = 2030,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_CAMPAIGN,
	create = function(arg_139_0)
		return require("app.view.module.guildFight.view.GuildFightMainLayer").new(...)
	end
}
var_0_0.GUILD_FIGHT_NORMAL_CHOOSE = {
	package = "guildFight",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_FIGHT,
	create = function(arg_140_0)
		return require("app.view.module.guildFight.view.GuildFightNormalChooseLayer").new(...)
	end
}
var_0_0.GUILD_FIGHT_CHARIOT_BATTLE = {
	package = "guildFight",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_FIGHT,
	create = function(arg_141_0)
		return require("app.view.module.guildFight.view.GuildFightChariotBattleLayer").new(...)
	end
}
var_0_0.DAILY_TASK = {
	routeType = 1006,
	package = "dailyTask",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_142_0)
		return require("app.view.module.dailyTask.view.DailyTaskMainLayer").new(...)
	end
}
var_0_0.SIGNIN_ACTIVITY = {
	package = "signIn",
	modType = var_0_0.POPUP,
	previous = var_0_0.HOME,
	create = function(arg_143_0)
		return require("app.view.module.signIn.view.SignInActivityPop").new(...)
	end
}
var_0_0.SEVEN_DAYS_SIGN_IN = {
	package = "sevenDaysSignIn",
	routeType = 2046,
	modType = var_0_0.POPUP,
	previous = var_0_0.HOME,
	params = {
		touchDisappear = false,
		hideContinue = true
	},
	create = function(arg_144_0)
		return require("app.view.module.sevenDaysSignIn.view.SevenDaysSignInPop").new(...)
	end
}
var_0_0.HALLOWEEN_SIGN_ACTIVITY = {
	routeType = 520006,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_145_0)
		return require("app.view.module.signActivity.view.HalloweenCustomActivityPop").new(...)
	end
}
var_0_0.LINDELL_SIGN_ACTIVITY = {
	routeType = 5200007,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_146_0)
		return require("app.view.module.signActivity.view.LindellCustomActivityPop").new(...)
	end
}
var_0_0.BEAUTY_SIGN_ACTIVITY = {
	routeType = 520010,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_147_0)
		return require("app.view.module.signActivity.view.BeautyCustomActivityPop").new(...)
	end
}
var_0_0.BEACH_SIGN_ACTIVITY = {
	routeType = 5005,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_148_0)
		return require("app.view.module.signActivity.view.BeachCustomActivityPop").new(...)
	end
}
var_0_0.MAGPIE_SIGN_ACTIVITY = {
	routeType = 5006,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_149_0)
		return require("app.view.module.signActivity.view.MagpieCustomActivityPop").new(...)
	end
}
var_0_0.MIDAUTUMN_SIGN_ACTIVITY = {
	routeType = 5007,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_150_0)
		return require("app.view.module.signActivity.view.MidAutumnCustomActivityPop").new(...)
	end
}
var_0_0.POTPOURRI_SIGN_ACTIVITY = {
	routeType = 5008,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_151_0)
		return require("app.view.module.signActivity.view.PotpourriCustomActivityPop").new(...)
	end
}
var_0_0.HERA_SIGN_ACTIVITY = {
	routeType = 5009,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_152_0)
		return require("app.view.module.signActivity.view.HeraCustomActivityPop").new(...)
	end
}
var_0_0.CHRIS_GIFT_SIGN_ACTIVITY = {
	routeType = 5010,
	modType = var_0_0.POPUP,
	create = function(arg_153_0)
		return require("app.view.module.signActivity.view.ChristmasGiftCustomActivityPop").new(...)
	end
}
var_0_0.LINK_SIGN_ACTIVITY = {
	routeType = 5011,
	modType = var_0_0.POPUP,
	create = function(arg_154_0)
		return require("app.view.module.signActivity.view.LinkCustomActivityPop").new(...)
	end
}
var_0_0.LOVER_SIGN_ACTIVITY = {
	routeType = 5012,
	modType = var_0_0.POPUP,
	create = function(arg_155_0)
		return require("app.view.module.signActivity.view.LoverCustomActivityPop").new(...)
	end
}
var_0_0.ROSE_NIGHT_SIGN_ACTIVITY = {
	routeType = 5014,
	modType = var_0_0.POPUP,
	create = function(arg_156_0)
		return require("app.view.module.signActivity.view.RoseNightCustomActivityPop").new(...)
	end
}
var_0_0.CHILDRENDAY_SIGN_ACTIVITY = {
	routeType = 5015,
	modType = var_0_0.POPUP,
	create = function(arg_157_0)
		return require("app.view.module.signActivity.view.ChildrenDayCustomActivityPop").new(...)
	end
}
var_0_0.PUREWHITE_SIGN_ACTIVITY = {
	routeType = 5018,
	modType = var_0_0.POPUP,
	create = function(arg_158_0)
		return require("app.view.module.signActivity.view.PureWhiteCustomActivityPop").new(...)
	end
}
var_0_0.CROWNBLUE_SIGN_ACTIVITY = {
	routeType = 5019,
	modType = var_0_0.POPUP,
	create = function(arg_159_0)
		return require("app.view.module.signActivity.view.CrownBlueCustomActivityPop").new(...)
	end
}
var_0_0.SILENT_SIGN_ACTIVITY = {
	routeType = 5020,
	modType = var_0_0.POPUP,
	create = function(arg_160_0)
		return require("app.view.module.signActivity.view.comp.SilentGuardianCustomActivityPop").new(...)
	end
}
var_0_0.FLOWLIGHT_SIGN_ACTIVITY = {
	routeType = 5021,
	modType = var_0_0.POPUP,
	create = function(arg_161_0)
		return require("app.view.module.signActivity.view.comp.FlowingLightCustomActivityPop").new(...)
	end
}
var_0_0.BUILD_SIGN_ACTIVITY = {
	routeType = 5022,
	modType = var_0_0.POPUP,
	create = function(arg_162_0)
		return require("app.view.module.signActivity.view.comp.BuildCustomActivityPop").new(...)
	end
}
var_0_0.TEASOUND_SIGN_ACTIVITY = {
	routeType = 5024,
	modType = var_0_0.POPUP,
	create = function(arg_163_0)
		return require("app.view.module.signActivity.view.TeaSoundCustomActivityPop").new(...)
	end
}
var_0_0.FANTASYDREAM_SIGN_ACTIVITY = {
	routeType = 5025,
	modType = var_0_0.POPUP,
	create = function(arg_164_0)
		return require("app.view.module.signActivity.view.FantasyDreamCustomActivityPop").new(...)
	end
}
var_0_0.GRANDCURTAIN_SIGN_ACTIVITY = {
	routeType = 5026,
	modType = var_0_0.POPUP,
	create = function(arg_165_0)
		return require("app.view.module.signActivity.view.GrandCurtainCustomActivityPop").new(...)
	end
}
var_0_0.NURTURING_SIGN_ACTIVITY = {
	routeType = 5027,
	modType = var_0_0.POPUP,
	create = function(arg_166_0)
		return require("app.view.module.signActivity.view.NurturingCustomActivityPop").new(...)
	end
}
var_0_0.SERGEANT_SIGN_ACTIVITY = {
	routeType = 5029,
	modType = var_0_0.POPUP,
	create = function(arg_167_0)
		return require("app.view.module.signActivity.view.SergeantCustomActivityPop").new(...)
	end
}
var_0_0.DOCTORVOLENCE_SIGN_ACTIVITY = {
	routeType = 5031,
	modType = var_0_0.POPUP,
	create = function(arg_168_0)
		return require("app.view.module.signActivity.view.DoctorVolenceCustomActivityPop").new(...)
	end
}
var_0_0.SEATRAVEL_SIGN_ACTIVITY = {
	routeType = 5200008,
	modType = var_0_0.POPUP,
	create = function(arg_169_0)
		return require("app.view.module.signActivity.view.SeaTravelCustomActivityPop").new(...)
	end
}
var_0_0.AUCTION = {
	routeType = 1028,
	package = "auction",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_170_0)
		return require("app.view.module.auction.view.AuctionMainLayer").new(...)
	end,
	provider = Provider.reqAuctionGetInfo
}
var_0_0.PUSH_GIFT = {
	routeType = 2043,
	package = "pushGift",
	modType = var_0_0.POPUP,
	params = {
		blackOpacity = 0.6,
		withoutAni = false
	},
	create = function(arg_171_0)
		return require("app.view.module.pushGift.view.PushGiftPop").new(...)
	end,
	provider = Provider.reqPushGiftMap
}
var_0_0.SIGN_CUSTOM_ACTIVITY = {
	routeType = 2058,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_172_0)
		return require("app.view.module.signActivity.view.SignCustomActivityPop").new(...)
	end
}
var_0_0.CHRISTMAS_SIGN_ACTIVITY = {
	routeType = 2063,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_173_0)
		return require("app.view.module.signActivity.view.ChristmasSignActivityPop").new(...)
	end
}
var_0_0.LEVIA_SIGN_ACTIVITY = {
	routeType = 2071,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_174_0)
		return require("app.view.module.signActivity.view.LeviaCustomActivityPop").new(...)
	end
}
var_0_0.LEVIA_SIGN_ACTIVITY_EU = {
	routeType = 5001,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_175_0)
		return require("app.view.module.signActivity.view.LeviaCustomActivityEUPop").new(...)
	end
}
var_0_0.VALENTINE_SIGN_ACTIVITY = {
	routeType = 2072,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_176_0)
		return require("app.view.module.signActivity.view.ValentineCustomActivityPop").new(...)
	end
}
var_0_0.SAKURA_SIGN_ACTIVITY = {
	routeType = 2081,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_177_0)
		return require("app.view.module.signActivity.view.SakuraCustomActivityPop").new(...)
	end
}
var_0_0.RAIN_SIGN_ACTIVITY = {
	routeType = 5002,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_178_0)
		return require("app.view.module.signActivity.view.RainCustomActivityPop").new(...)
	end
}
var_0_0.LOVE_SIGN_ACTIVITY = {
	routeType = 5003,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_179_0)
		return require("app.view.module.signActivity.view.LoveCustomActivityPop").new(...)
	end
}
var_0_0.SIGN_616 = {
	routeType = 5004,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_180_0)
		return require("app.view.module.signActivity.view.ListenWithSwearActivityPop").new(...)
	end
}
var_0_0.WHITEDANCE_SIGN_ACTIVITY = {
	routeType = 2087,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_181_0)
		return require("app.view.module.signActivity.view.WhiteDanceCustomActivityPop").new(...)
	end
}
var_0_0.GM_SIGN_ACTIVITY = {
	routeType = 2083,
	package = "signActivity",
	modType = var_0_0.POPUP,
	create = function(arg_182_0)
		return require("app.view.module.signActivity.view.GMSignActivityPop").new(...)
	end
}
var_0_0.OPEN_SCREEN_AD = {
	package = "openscreen",
	modType = var_0_0.POPUP,
	create = function(arg_183_0)
		return require("app.view.module.openscreen.view.OpenScreenAdvPop").new(...)
	end
}
var_0_0.DAILY_REPORT = {
	package = "dailyReport",
	modType = var_0_0.POPUP,
	create = function(arg_184_0)
		return require("app.view.module.dailyReport.view.DailyReportPop").new(...)
	end
}
var_0_0.SUMMON_OLD_PLAYER = {
	package = "summonOldPlayer",
	modType = var_0_0.POPUP,
	create = function(arg_185_0)
		return require("app.view.module.summonOldPlayer.view.SummonOldPlayerPop").new(...)
	end
}
var_0_0.BIRTHDAY_CARD = {
	package = "birthdayCard",
	modType = var_0_0.POPUP,
	create = function(arg_186_0)
		return require("app.view.module.birthdayCard.view.BirthdayCardPop").new(...)
	end
}
var_0_0.GUIDE_TASK = {
	package = "guideTask",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_187_0)
		return require("app.view.module.guideTask.view.GuideTaskMainLayer").new(...)
	end
}
var_0_0.BIO_TEAM_CHOOSE_CAMPAIGN = {
	package = "biography",
	routeType = 2040,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_188_0)
		return require("app.view.module.biography.view.team.BioTeamChooseCampaignLayer").new(...)
	end
}
var_0_0.BIO_TEAM__CAMPAIGN_INFO = {
	package = "biography",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.BIO_TEAM_CHOOSE_CAMPAIGN,
	create = function(arg_189_0)
		return require("app.view.module.biography.view.team.BioTeamCampaignInfoLayer").new(...)
	end
}
var_0_0.PEAK_ARENA = {
	routeType = 2042,
	package = "peakArena",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_190_0)
		return require("app.view.module.peakArena.view.PeakArenaLayer").new(...)
	end
}
var_0_0.PEAK_FORMATION = {
	package = "peakArena",
	modType = var_0_0.POPUP,
	previous = var_0_0.PEAK_ARENA,
	params = {
		fullSceneUseBlurBg = true,
		hideContinue = true,
		touchDisappear = false,
		ignoreTouch = true
	},
	create = function(arg_191_0)
		return require("app.view.module.peakArena.view.PeakFormationLayer").new(...)
	end
}
var_0_0.TOTAL_RECHARGE = {
	routeType = 2050,
	package = "totalRecharge",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_192_0)
		return require("app.view.module.totalRecharge.view.TotalRechargeLayer").new(...)
	end
}
var_0_0.GM_TOTAL_RECHARGE = {
	routeType = 2062,
	package = "gmTotalRecharge",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_193_0)
		return require("app.view.module.gmTotalRecharge.view.GmTotalRechargeLayer").new(...)
	end
}
var_0_0.PASS_CARD_MAIN = {
	package = "passCard",
	routeType = 2051,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_194_0)
		return require("app.view.module.passCard.view.PassCardMainLayer").new(...)
	end
}
var_0_0.PASS_CARD_TASK = {
	package = "passCard",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.PASS_CARD_MAIN,
	create = function(arg_195_0)
		return require("app.view.module.passCard.view.PassCardTaskLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_ACTIVITY = {
	routeType = 2052,
	package = "summerTheme",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_196_0)
		return require("app.view.module.summerTheme.SummerThemeActivityLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_BOSS_WAR = {
	routeType = 2054,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_197_0)
		local var_197_0 = {
			...
		}
		local var_197_1 = g.core.config.activity_theme_info.get(var_197_0[1] and var_197_0[1].themeValue)

		if var_197_1.version == g.core.const.ConstMgr.ThemeConst.THEME_ACTIVITY_BOSS_VERSION.SECOND then
			return require("app.view.module.summerThemeBoss.newBossView.ThemeBossWarLayer").new(...)
		elseif var_197_1.version == g.core.const.ConstMgr.ThemeConst.THEME_ACTIVITY_BOSS_VERSION.THIRD then
			return require("app.view.module.summerThemeThirdBoss.view.ThemeThirdBossMainLayer").new(...)
		else
			return require("app.view.module.summerThemeBoss.oldBossView.SummerThemeBossWarLayer").new(...)
		end
	end
}
var_0_0.SUMMER_THEME_TASK = {
	routeType = 2057,
	package = "summerTheme",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_198_0)
		return require("app.view.module.summerTheme.view.task.SummerThemeTaskLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_SHOP = {
	routeType = 2056,
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_199_0)
		return require("app.view.module.shop.view.ShopThemeLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_DUNGEON = {
	routeType = 2053,
	package = "summerTheme",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_200_0)
		return require("app.view.module.summerTheme.view.dungeon.SummerThemeDungeonLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_TURNCARD = {
	routeType = 2060,
	package = "summerThemeGame",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_201_0)
		return require("app.view.module.summerTheme.view.turncard.ThemeTurnCardMainLayer").new(...)
	end
}
var_0_0.THEME_TURNCARD_RANK = {
	package = "summerThemeGame",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_202_0)
		return require("app.view.module.summerTheme.view.turncard.ThemeTurnCardRankLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_TURNTABLE = {
	package = "summerThemeGame",
	routeType = 2061,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_203_0)
		return require("app.view.module.summerTheme.view.turnTable.ThemeTurnTableMainLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_EXPLORE = {
	routeType = 2055,
	package = "summerTheme",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_204_0)
		return require("app.view.module.summerTheme.view.explore.ThemeExploreMainLayer").new(...)
	end
}
var_0_0.SUMMER_THEME_EXPLORE_STAGE = {
	package = "summerTheme",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_EXPLORE,
	create = function(arg_205_0)
		return require("app.view.module.summerTheme.view.explore.ThemeExploreStage").new(...)
	end
}
var_0_0.THEME_GEM_ELIMINATE = {
	routeType = 2064,
	package = "summerThemeGame",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_206_0)
		return require("app.view.module.summerTheme.view.gemEliminate.GemEliminateMainLayer").new(...)
	end
}
var_0_0.THEME_GEM_ELIMINATE_RANK = {
	package = "summerThemeGame",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_207_0)
		return require("app.view.module.summerTheme.view.gemEliminate.GemEliminateRankLayer").new(...)
	end
}
var_0_0.THEME_GAME_PUZZLE_MAIN = {
	package = "summerThemeGame",
	routeType = 2074,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_208_0)
		return require("app.view.module.summerTheme.view.puzzle.ThemePuzzleMainLayer").new(...)
	end
}
var_0_0.THEME_PASS_CARD = {
	package = "themePasscard",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	provider = Provider.reqThemePassCard,
	create = function(arg_209_0)
		return require("app.view.module.summerTheme.view.passCard.ThemePassCardLayer").new(...)
	end
}
var_0_0.THEME_GAME_PUZZLE_PLAY = {
	package = "summerThemeGame",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.THEME_GAME_PUZZLE_MAIN,
	create = function(arg_210_0)
		return require("app.view.module.summerTheme.view.puzzle.ThemePuzzlePlayLayer").new(...)
	end
}
var_0_0.THEME_PUZZLE_RANK = {
	package = "summerThemeGame",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.THEME_GAME_PUZZLE_MAIN,
	create = function(arg_211_0)
		return require("app.view.module.summerTheme.view.puzzle.ThemePuzzleRankLayer").new(...)
	end
}
var_0_0.THEME_BIO_STAGE = {
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_212_0)
		local var_212_0 = {
			...
		}

		return require("app.view.module.themeBio.stage." .. (g.core.const.ConstMgr.ThemeConst.THEME_BIO_GAME_STAGE[var_212_0[1] and var_212_0[1].themeValue] or "ThemeBioGameCommonStage")).new(...)
	end
}
var_0_0.THEME_BIO_CHAPTER = {
	routeType = 2082,
	modType = var_0_0.POPUP,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_213_0)
		local var_213_0 = {
			...
		}
		local var_213_1 = var_213_0[1] and var_213_0[1].themeValue

		if var_213_1 == g.core.const.ConstMgr.ThemeConst.THEME_VALUE.GOLDENDANCE then
			return require("app.view.module.themeBio.view.vote.ThemeBioVoteChapterChooseLayer").new(...)
		elseif var_213_1 == g.core.const.ConstMgr.ThemeConst.THEME_VALUE.ANUBIS then
			return require("app.view.module.themeBio.view.vote.ThemeAnubisBioVoteChapterChooseLayer").new(...)
		elseif var_213_1 == g.core.const.ConstMgr.ThemeConst.THEME_VALUE.AKIRA then
			return require("app.view.module.themeBio.view.ThemeBioChapterChooseLayer").new(...)
		elseif var_213_1 == g.core.const.ConstMgr.ThemeConst.THEME_VALUE.LILITH then
			return require("app.view.module.themeBio.view.ThemeLilithBioChapterChooseLayer").new(...)
		else
			return require("app.view.module.themeBio.view.ThemeBrownBioChapterChooseLayer").new(...)
		end
	end
}
var_0_0.THEME_BIO_VOTE = {
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.THEME_BIO_CHAPTER,
	create = function(arg_214_0)
		local var_214_0 = {
			...
		}

		return require("app.view.module.themeBio.view.vote." .. g.core.const.ConstMgr.ThemeConst.THEME_BIO_VOTE_SELECTION_LAYER[var_214_0[1] and var_214_0[1].themeValue]).new(...)
	end
}
var_0_0.THEME_GAME_GUESS_MAIN = {
	package = "summerThemeGame",
	routeType = 2088,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.SUMMER_THEME_ACTIVITY,
	create = function(arg_215_0)
		return require("app.view.module.summerTheme.view.guess.ThemeGuessLayer").new(...)
	end
}
var_0_0.THEME_GUESS_RANK = {
	package = "summerThemeGame",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.THEME_GAME_PUZZLE_MAIN,
	create = function(arg_216_0)
		return require("app.view.module.summerTheme.view.guess.ThemeGuessRankLayer").new(...)
	end
}
var_0_0.MINE = {
	routeType = 2009,
	package = "mine",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_217_0)
		return require("app.view.module.mine.view.MineMainLayer").new(...)
	end
}
var_0_0.MINE_CITY = {
	package = "mine",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.MINE,
	create = function(arg_218_0)
		return require("app.view.module.mine.view.MineCityLayer").new(...)
	end
}
var_0_0.MINE_RESULT = {
	package = "mine",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_219_0)
		return require("app.view.module.mine.view.MineResultLayer").new(...)
	end
}
var_0_0.ARTIFACT_DEVELOP = {
	package = "artifact",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_220_0)
		return require("app.view.module.artifact.view.ArtifactDevelopLayer").new(...)
	end
}
var_0_0.ARTIFACT_LINE_UP = {
	routeType = 27,
	package = "artifact",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_221_0)
		return require("app.view.module.artifact.view.ArtifactLineUpLayer").new(...)
	end
}
var_0_0.ARTIFACT_HANDBOOK = {
	routeType = 35,
	package = "artifactHandbook",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_222_0)
		return require("app.view.module.artifactHandBook.view.ArtifactHandBookMainLayer").new(...)
	end
}
var_0_0.ARTIFACT_BAG = {
	routeType = 26,
	package = "artifact",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_223_0)
		return require("app.view.module.artifact.view.ArtifactBagLayer").new(...)
	end
}
var_0_0.TOWER = {
	routeType = 2047,
	package = "tower",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_224_0)
		return require("app.view.module.tower.view.TowerMainLayer").new(...)
	end
}
var_0_0.TOWER_CHOOSE = {
	package = "tower",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_225_0)
		return require("app.view.module.tower.view.TowerChooseMainLayer").new(...)
	end
}
var_0_0.TOWER_HARD = {
	routeType = 2086,
	package = "tower",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.TOWER_CHOOSE,
	create = function(arg_226_0)
		return require("app.view.module.tower.view.hard.TowerHardMainLayer").new(...)
	end
}
var_0_0.SHARE_LAYER = {
	package = "share",
	modType = var_0_0.POPUP,
	create = function(arg_227_0)
		return require("app.view.module.share.view.ShareLayer").new(...)
	end
}
var_0_0.SHARE_ACTIVITY_LAYER = {
	package = "share",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true
	},
	create = function(arg_228_0)
		return require("app.view.module.share.view.ShareActivityLayer").new(...)
	end
}
var_0_0.GAME_ENTERTAINMENT = {
	package = "gameEntertainment",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_229_0)
		return require("app.view.module.gameEntertainment.GameEntertainmentLayer").new(...)
	end
}
var_0_0.PLAYER_INFO = {
	package = "playerInfo",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_230_0)
		return require("app.view.module.playerInfo.view.PlayerInfoMainLayer").new(...)
	end
}
var_0_0.EASTEREGG_LAYER = {
	package = "easterEgg",
	modType = var_0_0.POPUP,
	create = function(arg_231_0)
		return require("app.view.module.easterEgg.view.EasterEggLayer").new(...)
	end
}
var_0_0.GUILD_WAR = {
	package = "guildWar",
	routeType = 2059,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_232_0)
		return require("app.view.module.guildWar.view.GuildWarMainLayer").new(...)
	end,
	needCloud = function()
		return true
	end
}
var_0_0.GUILD_WAR_SELF_CITY = {
	package = "guildWar",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GUILD_WAR,
	create = function(arg_234_0)
		return require("app.view.module.guildWar.view.GuildWarFightMineCityLayer").new(...)
	end
}
var_0_0.INVITE_FRIEND_SHARE = {
	package = "activity",
	modType = var_0_0.POPUP,
	create = function(arg_235_0)
		return require("app.view.module.activity.view.activityInviteFriend.ActivityShareLayer").new(...)
	end
}
var_0_0.GOLD_SAVING = {
	package = "goldSaving",
	modType = var_0_0.POPUP,
	create = function(arg_236_0)
		return require("app.view.module.goldSaving.view.GoldSavingPop").new(...)
	end
}
var_0_0.USER_BACK = {
	routeType = 2065,
	package = "userBack",
	modType = var_0_0.POPUP,
	create = function(arg_237_0)
		return require("app.view.module.userBack.view.UserBackLayer").new(...)
	end
}
var_0_0.NEW_YEAR_WISH = {
	package = "newYearWish",
	modType = var_0_0.POPUP,
	params = {
		ignoreTouch = true,
		hideContinue = true,
		touchDisappear = false
	},
	create = function(arg_238_0)
		return require("app.view.module.newYearWish.view.NewYearWishMainPop").new(...)
	end
}
var_0_0.NEW_YEAR_WISH_RESULT = {
	package = "newYearWish",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true
	},
	create = function(arg_239_0)
		local var_239_0 = ...

		if var_239_0 and var_239_0.activity_type == 999 then
			return require("app.view.module.newYearWish.view.GMWishResultPop").new(...)
		else
			return require("app.view.module.newYearWish.view.WishResultPop").new(...)
		end
	end
}
var_0_0.FOG_NIGHTMARE_MAIN = {
	routeType = 2070,
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_240_0)
		return require("app.view.module.fogNightmare.view.FogNightmareMainLayer").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_IDLE = {
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.FOG_NIGHTMARE_MAIN,
	create = function(arg_241_0)
		return require("app.view.module.fogNightmare.view.idle.FogNightmareIdleMainLayer").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_EXPLORE_ENTER = {
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.FOG_NIGHTMARE_MAIN,
	create = function(arg_242_0)
		return require("app.view.module.fogNightmare.view.explore.FogNightmareExploreEnterLayer").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_EXPLORE = {
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.FOG_NIGHTMARE_MAIN,
	create = function(arg_243_0)
		return require("app.view.module.fogNightmare.view.explore.FogNightmareExploreLayer").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_EXPLORE_STAGE = {
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.FOG_NIGHTMARE_MAIN,
	create = function(arg_244_0)
		return require("app.view.module.fogNightmare.view.explore.FogNightmareExploreLayer").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_TALENT = {
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.FOG_NIGHTMARE_MAIN,
	create = function(arg_245_0)
		return require("app.view.module.fogNightmare.view.talent.FogNightmareTalentLayer").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_KEEPSAKE_BOOK = {
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.FOG_NIGHTMARE_MAIN,
	create = function(arg_246_0)
		return require("app.view.module.fogNightmare.view.keepsake.FogNightmareKeepsakeBookLayer").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_KEEPSAKE_UNLOCK = {
	package = "fogNightmare",
	modType = var_0_0.POPUP,
	previous = var_0_0.FOG_NIGHTMARE_MAIN,
	params = {
		touchDisappear = true,
		hideContinue = false
	},
	create = function(arg_247_0)
		return require("app.view.module.fogNightmare.view.keepsake.FogNightmareKeepsakeUnlockPop").new(...)
	end
}
var_0_0.FOG_NIGHTMARE_RESULT_LAYER = {
	package = "fogNightmare",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_248_0)
		return require("app.view.module.fogNightmare.view.seasonResult.FogNightmareSeasonResultPop").new(...)
	end
}
var_0_0.VALENTINES_DAY_VOTE_MAIN_LAYER = {
	routeType = 2073,
	package = "valentinesDayVote",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_249_0)
		return require("app.view.module.valentinesDayVote.view.ValentinesDayVoteMainLayer").new(...)
	end
}
var_0_0.VALENTINES_DAY_VOTE_TASK_LAYER = {
	package = "valentinesDayVote",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_250_0)
		return require("app.view.module.valentinesDayVote.view.ValentinesDayVoteTaskLayer").new(...)
	end
}
var_0_0.GVE_SIGNUP_LAYER = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_251_0)
		return require("app.view.module.gve.view.GveApplyPeriodLayer").new(...)
	end
}
var_0_0.GVE_RESULT_LAYER = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_252_0)
		return require("app.view.module.gve.view.GveResultPeriodLayer").new(...)
	end
}
var_0_0.GVE_SEASON_RANK = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_RESULT_LAYER,
	create = function(arg_253_0)
		return require("app.view.module.gve.view.gvePioneer.GveSeasonRankLayer").new(...)
	end
}
var_0_0.GVE_GAME_STAGE = {
	isHungry = true,
	routeType = 2080,
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_254_0)
		return require("app.view.module.gve.view.gveStage.GveGameStage").new(...)
	end,
	provider = Provider.reqGveEnterMap
}
var_0_0.GVE_MINI_MAP = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_255_0)
		return require("app.view.module.gve.view.gveStage.GveMiniMapLayer").new(...)
	end
}
var_0_0.GVE_TASK = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_256_0)
		return require("app.view.module.gve.view.gveTask.GveTaskLayer").new(...)
	end
}
var_0_0.GVE_FORMATION_LAYER = {
	package = "gve",
	modType = var_0_0.POPUP,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_257_0)
		return require("app.view.module.gve.view.gveFormation.GveFormationMainLayer").new(...)
	end
}
var_0_0.GVE_FORMATION_PRESET_LAYER = {
	package = "gve",
	modType = var_0_0.POPUP,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_258_0)
		return require("app.view.module.gve.view.gveFormation.GveFormationPresetLayer").new(...)
	end
}
var_0_0.GVE_HALIDOM_LAYER = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_259_0)
		return require("app.view.module.gve.view.gveBag.GveHalidomDevelopLayer").new(...)
	end
}
var_0_0.GVE_FORMATION_SELECT_KNIGHT = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_260_0)
		return require("app.view.module.gve.view.gveFormation.GveFormationSelectKnightLayer").new(...)
	end
}
var_0_0.GVE_SHOP = {
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_261_0)
		return require("app.view.module.shop.view.ShopGveLayer").new(...)
	end
}
var_0_0.GVE_RESEARCH = {
	package = "gve",
	modType = var_0_0.POPUP,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_262_0)
		return require("app.view.module.gve.view.gveStage.GveInstitutePop").new(...)
	end
}
var_0_0.GVE_BOSS_LAYER = {
	package = "gve",
	modType = var_0_0.POPUP,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_263_0)
		return require("app.view.module.gve.view.gveStage.GveBossLayer").new(...)
	end
}
var_0_0.GVE_BRANCH = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_HALIDOM_LAYER,
	create = function(arg_264_0)
		return require("app.view.module.gve.view.gveBag.GveBranchSelectLayer").new(...)
	end
}
var_0_0.GVE_BRANCH_DES = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_HALIDOM_LAYER,
	create = function(arg_265_0)
		return require("app.view.module.gve.view.gveBag.GveBranchDesLayer").new(...)
	end
}
var_0_0.GVE_PIONEER_LAYER = {
	package = "gve",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GVE_GAME_STAGE,
	create = function(arg_266_0)
		return require("app.view.module.gve.view.gvePioneer.GvePioneerTeamLayer").new(...)
	end
}
var_0_0.HALF_ANNIVERSARY = {
	routeType = 2085,
	package = "halfAnniversary",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_267_0)
		return require("app.view.module.halfAnniversary.view.HalfAnniversaryLayer").new(...)
	end
}
var_0_0.HALF_ANNIVERSARY_TASK = {
	package = "halfAnniversary",
	modType = var_0_0.POPUP,
	previous = var_0_0.HALF_ANNIVERSARY,
	create = function(arg_268_0)
		return require("app.view.module.halfAnniversary.view.HalfAnniversaryTaskPop").new(...)
	end
}
var_0_0.HALF_ANNIVERSARY_SHOP = {
	package = "halfAnniversary",
	modType = var_0_0.POPUP,
	previous = var_0_0.HALF_ANNIVERSARY,
	create = function(arg_269_0)
		return require("app.view.module.halfAnniversary.view.HalfAnniversaryBuyScorePop").new(...)
	end
}
var_0_0.WUSH_TOWER_CHOOSE = {
	package = "wushTower",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_270_0)
		return require("app.view.module.wushTower.view.WushChooseLayer").new(...)
	end
}
var_0_0.WUSH_TOWER = {
	routeType = 2089,
	package = "wushTower",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.WUSH_TOWER_CHOOSE,
	create = function(arg_271_0)
		return require("app.view.module.wushTower.view.WushTowerMainLayer").new(...)
	end,
	provider = Provider.reqWushTowerMap
}
var_0_0.WUSH_TOWER_MONSTER = {
	package = "wushTower",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.WUSH_TOWER,
	create = function(arg_272_0)
		return require("app.view.module.wushTower.view.WushTowerMonsterLayer").new(...)
	end
}
var_0_0.WUSH_TOWER_CARD = {
	package = "wushTower",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.WUSH_TOWER,
	create = function(arg_273_0)
		return require("app.view.module.wushTower.view.WushTowerGoGetCardLayer").new(...)
	end
}
var_0_0.MULTI_TEAM_LAYER = {
	package = "mulTeam",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_274_0)
		return require("app.view.module.mulTeam.view.MulTeamMainLayer").new(...)
	end
}
var_0_0.PEI_ZI = {
	package = "home",
	modType = var_0_0.POPUP,
	previous = var_0_0.HOME,
	create = function(arg_275_0)
		return require("app.view.module.home.view.HomeEmbryoPop").new(...)
	end
}
var_0_0.CULTIVATION = {
	package = "home",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_276_0)
		return require("app.view.module.home.view.HomeCultivationLayer").new(...)
	end
}
var_0_0.ECHO_LAB = {
	routeType = 2090,
	package = "echoLab",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_277_0)
		return require("app.view.module.echoLab.view.main.EchoLabMainLayer").new(...)
	end
}
var_0_0.ECHOLAB_TERMINAL = {
	package = "echoLab",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ECHO_LAB,
	create = function(arg_278_0)
		return require("app.view.module.echoLab.view.terminal.EchoLabTerminalLayer").new(...)
	end
}
var_0_0.ECHOLAB_DEPLOY = {
	package = "echoLab",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ECHOLAB_TERMINAL,
	create = function(arg_279_0)
		return require("app.view.module.echoLab.view.terminal.EchoLabCommonDeployLayer").new(...)
	end
}
var_0_0.ECHOLAB_LINEUP = {
	package = "echoLab",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ECHOLAB_DEPLOY,
	create = function(arg_280_0)
		return require("app.view.module.echoLab.view.terminal.EchoLabCommonLineUpLayer").new(...)
	end
}
var_0_0.ECHOLAB_TREE_LAYER = {
	package = "echoLab",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ECHO_LAB,
	create = function(arg_281_0)
		return require("app.view.module.echoLab.view.dataTree.EchoLabTreeMainLayer").new(...)
	end
}
var_0_0.ECHO_LAB_COLLECT = {
	package = "echoLab",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ECHO_LAB,
	create = function(arg_282_0)
		return require("app.view.module.echoLab.view.collect.EchoLabCollectLayer").new(...)
	end
}
var_0_0.SPIRIT_HELP_LAYER = {
	package = "spiritHelp",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_283_0)
		return require("app.view.module.spiritHelp.view.SpiritHelpMainLayer").new(...)
	end
}
var_0_0.BATTLE_SPEED2 = {
	package = "spiritHelp",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true
	},
	create = function(arg_284_0)
		return require("app.view.module.spiritHelp.view.SpiritHelpBattleSpeedPop").new(...)
	end
}
var_0_0.HANDBOOK_COMPETITION_LAYER = {
	routeType = 2091,
	package = "competition",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_285_0)
		return require("app.view.module.competition.view.CompetitionActivityMainLayer").new(...)
	end,
	provider = Provider.reqCompetitionMap
}
var_0_0.COMMON_COMPETITION_LAYER = {
	routeType = 2092,
	package = "competition",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_286_0)
		local var_286_0 = {
			...
		}

		return require("app.view.module.competition.common.view.CompetitionCommonActivityMainLayer").new((var_286_0[1] and var_286_0[1].goods).activity_value)
	end
}
var_0_0.PAID_DIAMOND_EXCHANGE = {
	package = "diamondExchange",
	modType = var_0_0.POPUP,
	create = function(arg_287_0)
		return require("app.view.module.diamondExchange.DiamondExchangePop").new(...)
	end
}
var_0_0.DAILY_RECRUIT = {
	routeType = 2079,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_288_0)
		return require("app.view.module.dailyRecruit.view.DailyRecruitMainLayer").new(...)
	end
}
var_0_0.CROSS_SERVER_ARENA = {
	routeType = 5200004,
	package = "crossServerArena",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ARENA_CHOOSE_LAYER,
	create = function(arg_289_0)
		return require("app.view.module.crossServerArena.CrossServerArenaMainLayer").new(...)
	end
}
var_0_0.CROSS_SERVER_FORMATION = {
	package = "crossServerArena",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_290_0)
		return require("app.view.module.crossServerArena.CrossServerArenaFormationLayer").new(...)
	end
}
var_0_0.ARENA_CHOOSE_LAYER = {
	package = "crossServerArena",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CAMPAIGN,
	create = function(arg_291_0)
		return require("app.view.module.crossServerArena.ArenaChooseLayer").new(...)
	end
}
var_0_0.ARENA_BATTLE_PREPARATION = {
	package = "crossServerArena",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CROSS_SERVER_ARENA,
	create = function(arg_292_0)
		return require("app.view.module.crossServerArena.CrossServerArenaBattlePrepareLayer").new(...)
	end
}
var_0_0.GENE = {
	routeType = 5200002,
	package = "gene",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.CULTIVATION,
	create = function(arg_293_0)
		return require("app.view.module.gene.view.GeneChooseFigureLayer").new(...)
	end
}
var_0_0.GENE_FIGURE = {
	package = "gene",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.GENE,
	create = function(arg_294_0)
		return require("app.view.module.gene.view.GeneFigureMainLayer").new(...)
	end
}
var_0_0.GENE_FIGURE_INFO = {
	package = "gene",
	modType = var_0_0.POPUP,
	previous = var_0_0.GENE_FIGURE,
	create = function(arg_295_0)
		return require("app.view.module.gene.view.GeneWaferDetailsPop").new(...)
	end
}
var_0_0.GOLD_SAVING_TURN_CARD = {
	package = "goldSaving",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_296_0)
		return require("app.view.module.goldSaving.game.goldSavingTurnCardGame.GoldSavingTurnCardGameLayer").new(...)
	end
}
var_0_0.RED_PACKET_RAIN = {
	package = "goldSaving",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_297_0)
		return require("app.view.module.goldSaving.game.redPacketRain.RedPacketRainLayer").new(...)
	end
}
var_0_0.GOLD_SAVING_TURN_GAME = {
	package = "goldSaving",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_298_0)
		return require("app.view.module.goldSaving.view.GoldSavingTurnGameLayer").new(...)
	end
}
var_0_0.DOUBLE_ELEVEN = {
	package = "doubleEleven",
	modType = var_0_0.POPUP,
	previous = var_0_0.HOME,
	create = function(arg_299_0)
		return require("app.view.module.doubleEleven.view.DoubleElevenPop").new(...)
	end
}
var_0_0.COMMANDER_WORLD = {
	routeType = 2099,
	package = "commanderWorld",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_300_0)
		return require("app.view.module.commanderWorld.view.CommanderWorldMainLayer").new(...)
	end
}
var_0_0.COMMANDER_TASK = {
	package = "commanderWorld",
	modType = var_0_0.POPUP,
	previous = var_0_0.COMMANDER_WORLD,
	create = function(arg_301_0)
		return require("app.view.module.commanderWorld.view.CommanderWorldTaskPop").new(...)
	end
}
var_0_0.COMMANDER_SHOP = {
	package = "commanderWorld",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.COMMANDER_WORLD,
	create = function(arg_302_0)
		return require("app.view.module.commanderWorld.view.CommanderWorldShopLayer").new(...)
	end
}
var_0_0.COMMANDER_RANK = {
	package = "commanderWorld",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.COMMANDER_WORLD,
	create = function(arg_303_0)
		return require("app.view.module.commanderWorld.view.CommanderRankLayer").new(...)
	end
}
var_0_0.COMMANDER_GIFT = {
	package = "commanderWorld",
	modType = var_0_0.POPUP,
	previous = var_0_0.COMMANDER_WORLD,
	create = function(arg_304_0)
		return require("app.view.module.commanderWorld.view.CommanderRechargeGiftPop").new(...)
	end
}
var_0_0.COMMANDER_MARS_RANK = {
	package = "commanderWorld",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.COMMANDER_WORLD,
	create = function(arg_305_0)
		return require("app.view.module.commanderWorld.view.CommanderWorldAllLordLayer").new(...)
	end
}
var_0_0.PHOENIX_GIFT = {
	package = "phoenixGift",
	modType = var_0_0.POPUP,
	previous = var_0_0.HOME,
	create = function(arg_306_0)
		return require("app.view.module.phoenixGift.view.PhoenixGiftPop").new(...)
	end
}
var_0_0.WISH_POOL = {
	package = "activity",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_307_0)
		return require("app.view.module.activity.view.activityWishpool.ActivityWishpoolLayer").new(...)
	end,
	provider = Provider.reqWishPool
}
var_0_0.KNIGHT_SOUL_MAIN_LAYER = {
	routeType = 2400,
	package = "knightSoul",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_308_0)
		return require("app.view.module.knightSoul.view.KnightSoulMainLayer").new(...)
	end
}
var_0_0.KNIGHT_SOUL_BOOK_LAYER = {
	package = "knightSoul",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.KNIGHT_SOUL_MAIN_LAYER,
	create = function(arg_309_0)
		return require("app.view.module.knightSoul.view.KnightSoulBookLayer").new(...)
	end
}
var_0_0.KNIGHT_SOUL_BAG_LAYER = {
	routeType = 2403,
	package = "knightSoul",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.KNIGHT_SOUL_MAIN_LAYER,
	create = function(arg_310_0)
		return require("app.view.module.knightSoul.view.KnightSoulBagLayer").new(...)
	end
}
var_0_0.KNIGHT_SOUL_SELL = {
	package = "knightSoul",
	modType = var_0_0.POPUP,
	previous = var_0_0.KNIGHT_SOUL_BAG_LAYER,
	create = function(arg_311_0)
		return require("app.view.module.knightSoul.view.KnightSoulSellPop").new(...)
	end
}
var_0_0.KNIGHT_SOUL_RANK_LAYER = {
	package = "knightSoul",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.KNIGHT_SOUL_MAIN_LAYER,
	create = function(arg_312_0)
		return require("app.view.module.knightSoul.view.KnightSoulRankLayer").new(...)
	end
}
var_0_0.LOTTERY = {
	package = "lottery",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_313_0)
		return require("app.view.module.lottery.view.LotteryMainLayer").new(...)
	end,
	provider = Provider.reqLottery
}
var_0_0.WEEKLY_COMPETITION = {
	package = "weeklyCompetition",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_314_0)
		return require("app.view.module.weeklyCompetition.view.WeeklyCompetitionMainLayer").new(...)
	end,
	provider = Provider.reqWeeklyCompetition
}
var_0_0.TEAM_PVP_MAIN_LAYER = {
	routeType = 2501,
	package = "teamPVP",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_315_0)
		if g.core.model.User.teamPvpData:isActivityInExpire() then
			return require("app.view.module.teamPVP.view.TeamPVPActiveResultLayer").new(...)
		else
			return require("app.view.module.teamPVP.view.TeamPVPMainLayer").new(true)
		end
	end,
	provider = Provider.teamPvp
}
var_0_0.TEAM_PVP_TEAM_LAYER = {
	package = "teamPVP",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.TEAM_PVP_MAIN_LAYER,
	create = function(arg_316_0)
		return require("app.view.module.teamPVP.view.TeamPVPTeamLayer").new(...)
	end
}
var_0_0.TEAM_PVP_MATCHING = {
	package = "teamPVP",
	modType = var_0_0.POPUP,
	previous = var_0_0.TEAM_PVP_MAIN_LAYER,
	params = {
		touchDisappear = false,
		ignoreTouch = true
	},
	create = function(arg_317_0)
		return require("app.view.module.teamPVP.view.TeamPVPMatchPop").new(...)
	end
}
var_0_0.TEAM_PVP_RESULT_DETAIL_LAYER = {
	package = "teamPVP",
	modType = var_0_0.POPUP,
	params = {
		ignoreTouch = true,
		hideContinue = true,
		touchDisappear = false
	},
	create = function(arg_318_0)
		return require("app.view.module.teamPVP.view.TeamPVPResultPop").new(...)
	end
}
var_0_0.TEAMPVP_BATTLE_LAYER = {
	package = "teamPVP",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.TEAM_PVP_TEAM_LAYER,
	create = function(arg_319_0)
		return require("app.view.module.teamPVP.view.battle.TeamPVPBattleLayer").new(...)
	end
}
var_0_0.TEAM_PVP_RANK_LAYER = {
	package = "teamPVP",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_320_0)
		return require("app.view.module.teamPVP.view.TeamPVPRankLayer").new(...)
	end
}
var_0_0.TEAM_PVP_ACTIVE_RESULT_POP = {
	package = "teamPVP",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true
	},
	create = function(arg_321_0)
		return require("app.view.module.teamPVP.view.TeamPVPActiveResultPop").new(...)
	end
}
var_0_0.EXPLORATION = {
	routeType = 2601,
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_322_0)
		local var_322_0 = g.core.model.User.explorationData:getCurStage()

		if var_322_0 == 1 then
			return require("app.view.module.exploration.view.ExplorationMainLayer").new(...)
		elseif var_322_0 == 2 then
			return require("app.view.module.exploration.view.rank.ExplorationExhibitLayer").new(...)
		end
	end,
	provider = Provider.exploration
}
var_0_0.EXPLORATION_FORMATION = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_323_0)
		return require("app.view.module.exploration.view.formation.ExplorationFormationMainLayer").new(...)
	end
}
var_0_0.EXPLORATION_BAG = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_324_0)
		return require("app.view.module.exploration.view.bag.ExplorationBagMainLayer").new(...)
	end
}
var_0_0.EXPLORATION_PLAY_SHOP = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_325_0)
		return require("app.view.module.shop.view.exploration.ShopExplorationLayer").new(...)
	end
}
var_0_0.EXPLORATION_REDPACKAGE = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_326_0)
		return require("app.view.module.exploration.view.game.ExplorationRedPacketRainLayer").new(...)
	end
}
var_0_0.EXPLORATION_WISHTREE = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_327_0)
		return require("app.view.module.exploration.view.game.ExplorationWishTreeLayer").new(...)
	end
}
var_0_0.EXPLORATION_TURNCARD = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_328_0)
		return require("app.view.module.exploration.view.game.ExplorationTurnCardGameLayer").new(...)
	end
}
var_0_0.EXPLORATION_RANK_LAYER = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_329_0)
		return require("app.view.module.exploration.view.rank.ExplorationRankLayer").new(...)
	end
}
var_0_0.EXPLORATION_RESULT_LAYER = {
	package = "exploration",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_330_0)
		return require("app.view.module.exploration.view.rank.ExplorationExhibitLayer").new(...)
	end
}
var_0_0.RED_CLIFF_MAIN_LAYER = {
	routeType = 2801,
	package = "redCliff",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_331_0)
		if g.core.model.User.redCliffData:getGameStage() ~= g.core.const.ConstMgr.RedCliffConst.GAME_STAGE.RESULT then
			return require("app.view.module.redCliff.view.mainView.RedCliffMainLayer").new(...)
		else
			return require("app.view.module.redCliff.view.rank.RedCliffExhibitionLayer").new(...)
		end
	end,
	provider = Provider.redCliff
}
var_0_0.RED_CLIFF_STAGE = {
	package = "redCliff",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_332_0)
		return require("app.view.module.redCliff.stage.RedCliffGameStage").new(...)
	end
}
var_0_0.RED_CLIFF_RANK_LAYER = {
	package = "redCliff",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_333_0)
		return require("app.view.module.redCliff.view.rank.RedCliffRankLayer").new(...)
	end
}
var_0_0.RED_CLIFF_EXHIBITION_LAYER = {
	package = "redCliff",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_334_0)
		return require("app.view.module.redCliff.view.rank.RedCliffExhibitionLayer").new(...)
	end
}
var_0_0.PRECIOUS = {
	routeType = 2701,
	package = "precious",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_335_0)
		return require("app.view.module.precious.view.PreciousMainLayer").new(...)
	end,
	provider = Provider.reqPreciousGetInfo
}
var_0_0.PRECIOUS_DEV = {
	package = "precious",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_336_0)
		return require("app.view.module.precious.view.PreciousDevelopLayer").new(...)
	end
}
var_0_0.PRECIOUS_SUIT_DEV = {
	package = "precious",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_337_0)
		return require("app.view.module.precious.view.PreciousSuitDevLayer").new(...)
	end
}
var_0_0.PRECIOUS_SUIT_SUCCESS = {
	package = "precious",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_338_0)
		return require("app.view.module.precious.view.PreciousSuitDevSuccessLayer").new(...)
	end
}
var_0_0.PRECIOUS_STARUP_SUCCESS = {
	package = "precious",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_339_0)
		return require("app.view.module.precious.view.PreciousStarUpPop").new(...)
	end
}
var_0_0.CULTIVATE_MAIN = {
	routeType = 3001,
	package = "cultivate",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_340_0)
		return require("app.view.module.cultivate.view.CultivateMainLayer").new(...)
	end
}
var_0_0.CULTIVATE_SHOP = {
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_341_0)
		return require("app.view.module.shop.view.ShopCultivateLayer").new(...)
	end
}
var_0_0.CULTIVATE_WITCH_SHOP = {
	package = "shop",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_342_0)
		return require("app.view.module.shop.view.ShopWitchCultivateLayer").new(...)
	end
}
var_0_0.CULTIVATE_TASK = {
	package = "cultivate",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_343_0)
		return require("app.view.module.cultivate.view.CultivateTaskLayer").new(...)
	end
}
var_0_0.CULTIVATE_WITCH_TASK = {
	package = "cultivate",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_344_0)
		return require("app.view.module.cultivate.view.witch.CultivateWitchTaskLayer").new(...)
	end
}
var_0_0.CULTIVATE_PASSCARD_PREVIEW = {
	package = "cultivate",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_345_0)
		return require("app.view.module.cultivate.view.CultivatePassCardPreviewLayer").new(...)
	end
}
var_0_0.CULTIVATE_WITCH_PASSCARD_PREVIEW = {
	package = "cultivate",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_346_0)
		return require("app.view.module.cultivate.view.witch.CultivateWitchPassCardPreviewLayer").new(...)
	end
}
var_0_0.CULTIVATE_PASSCARD = {
	package = "cultivate",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_347_0)
		return require("app.view.module.cultivate.view.CultivatePassCardLayer").new(...)
	end
}
var_0_0.CULTIVATE_WITCH_PASSCARD = {
	package = "cultivate",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_348_0)
		return require("app.view.module.cultivate.view.witch.CultivateWitchPassCardLayer").new(...)
	end
}
var_0_0.CULTIVATE_GIFT = {
	package = "shop",
	modType = var_0_0.POPUP,
	create = function(arg_349_0)
		return require("app.view.module.shop.view.ShopCultivatePop.ShopCultivateGiftPop").new(...)
	end
}
var_0_0.BOUNTY_MAIN = {
	routeType = 2901,
	package = "bounty",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_350_0)
		return require("app.view.module.bounty.view.BountyMainLayer").new(...)
	end,
	provider = Provider.reqBountyInfo
}
var_0_0.BOUNTY_PERIOD = {
	routeType = 2902,
	package = "bounty",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_351_0)
		return require("app.view.module.bounty.view.BountyResultPeriodLayer").new(...)
	end,
	provider = Provider.reqBountyRankInfo
}
var_0_0.BOUNTY_SHARE = {
	package = "bounty",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_352_0)
		return require("app.view.module.bounty.view.BountyShareLayer").new(...)
	end
}
var_0_0.NEW_PASS_CARD = {
	package = "newPassCard",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_353_0)
		return require("app.view.module.newPassCard.view.PassCardNewLayer").new(...)
	end
}
var_0_0.WEDDING_MAIN_POP = {
	package = "wedding",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true
	},
	create = function(arg_354_0, arg_354_1, arg_354_2, arg_354_3)
		if g.core.model.User.weddingData:isWeddingVowByKnightId((arg_354_1.knightStruct and arg_354_1.knightStruct or g.core.model.User.knightsData:getKnight(arg_354_1)):getAdvanceId()) then
			return require("app.view.module.wedding.view.WeddingFinishPop").new(arg_354_1, arg_354_2, arg_354_3)
		else
			return require("app.view.module.wedding.view.WeddingMainPop").new(arg_354_1)
		end
	end
}
var_0_0.MYSTERY_MAIN_LAYER = {
	routeType = 3101,
	package = "mystery",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_355_0)
		return require("app.view.module.mystery.view.MysteryMainLayer").new(...)
	end,
	needCloud = function()
		return true
	end
}
var_0_0.MYSTERY_CHOOSE_CHAPTER = {
	package = "mystery",
	modType = var_0_0.POPUP,
	create = function(arg_357_0)
		return require("app.view.module.mystery.view.MysteryChooseChapterLayer").new(...)
	end
}
var_0_0.THEME_THIRD_TALENT_LAYER = {
	package = "mystery",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_358_0)
		return require("app.view.module.summerThemeThirdBoss.view.ThemeThirdBossTalentLayer").new(...)
	end
}
var_0_0.MYSTERY_BOSS_MAIN_LAYER = {
	package = "mystery",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_359_0)
		return require("app.view.module.mystery.view.mysteryBoss.MysteryBossMainLayer").new(...)
	end
}
var_0_0.MYSTERY_BOSS_CHOOSE = {
	package = "mystery",
	modType = var_0_0.POPUP,
	params = {
		withoutAni = true
	},
	create = function(arg_360_0)
		if g.core.model.User.mysteryBossData:getCurBossId() > 0 then
			return require("app.view.module.mystery.view.mysteryBoss.MysteryBossMainLayer").new({
				boss = g.core.model.User.mysteryBossData:getBossDataById((g.core.model.User.mysteryBossData:getCurBossId()))
			})
		else
			return require("app.view.module.mystery.view.mysteryBoss.MysteryBossChoosePop").new(...)
		end
	end
}
var_0_0.ACTIVITY_RETURN = {
	routeType = 2100,
	package = "activityReturn",
	modType = var_0_0.FULL_SCREEN,
	provider = Provider.reqReturnActivity,
	create = function(arg_361_0)
		return require("app.view.module.activityReturn.view.ActivityReturnLayer").new(...)
	end
}
var_0_0.RICHMAN_MAIN = {
	routeType = 3201,
	package = "richman",
	modType = var_0_0.FULL_SCREEN,
	provider = Provider.reqRichmanInfo,
	create = function(arg_362_0)
		return require("app.view.module.richman.view.RichmanMainStage").new(...)
	end
}
var_0_0.RICHMAN_TURN_CARD = {
	package = "richman",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_363_0)
		return require("app.view.module.richman.view.game.RichmanTurnCardGameLayer").new(...)
	end
}
var_0_0.RICHMAN_RED_PACKET_RAIN = {
	package = "richman",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_364_0)
		return require("app.view.module.richman.view.game.RichmanRedPacketRainLayer").new(...)
	end
}
var_0_0.RICHMAN_TURN_GAME = {
	package = "richman",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_365_0)
		return require("app.view.module.richman.view.game.RichmanWishTreeLayer").new(...)
	end
}
var_0_0.TREE_MAIN = {
	routeType = 2101,
	package = "tree",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_366_0)
		return require("app.view.module.tree.view.TreeMainLayer").new(...)
	end,
	provider = Provider.reqTreeGetInfo
}
var_0_0.TEAM_BATTLE_READY_LAYER = {
	routeType = 3301,
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_367_0)
		if g.core.model.User.teamBattleData:getCurStage() == 3 then
			return require("app.view.module.teamBattle.view.TeamBattleAllLordLayer").new(...)
		else
			return require("app.view.module.teamBattle.view.TeamBattleReadyPeriodLayer").new(...)
		end
	end
}
var_0_0.TEAM_BATTLE_RESULT_LAYER = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_368_0)
		return require("app.view.module.teamBattle.view.TeamBattleAllLordLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_TEAM_UP_LAYER = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_369_0)
		return require("app.view.module.teamBattle.view.teamUp.TeamBattleTeamLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_MAP_LAYER = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	provider = Provider.reqTeamBattleMap,
	create = function(arg_370_0)
		return require("app.view.module.teamBattle.view.map.TeamBattleMapLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_FORMATION_LAYER = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_371_0)
		return require("app.view.module.teamBattle.view.formation.TeamBattleFormationLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_RANK_LAYER = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_372_0)
		return require("app.view.module.teamBattle.view.rank.TeamBattleRankLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_BUFF_BAG_POP = {
	package = "teamBattle",
	modType = var_0_0.POPUP,
	create = function(arg_373_0)
		return require("app.view.module.teamBattle.view.bag.TeamBattleBuffBagPop").new(...)
	end
}
var_0_0.TEAM_BATTLE_RESULT_POP = {
	package = "teamBattle",
	modType = var_0_0.POPUP,
	create = function(arg_374_0)
		return require("app.view.module.teamBattle.view.TeamBattleActiveResultPop").new(...)
	end
}
var_0_0.TEAM_BATTLE_KNIGHT_BAG_LAYER = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_375_0)
		return require("app.view.module.teamBattle.view.bag.TeamBattleKnightBagLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_METEOR_SHOWER = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_376_0)
		return require("app.view.module.teamBattle.view.game.TeamBattleRedPacketRainLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_TURN_CARD = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_377_0)
		return require("app.view.module.teamBattle.view.game.TeamBattleTurnCardGameLayer").new(...)
	end
}
var_0_0.TEAM_BATTLE_DART = {
	package = "teamBattle",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_378_0)
		return require("app.view.module.teamBattle.view.game.TeamBattleDartGamePop").new(...)
	end
}
var_0_0.CELEBRATION_LOGIN_POP = {
	package = "activity",
	modType = var_0_0.POPUP,
	params = {
		hideContinue = true,
		ignoreTouch = true,
		touchDisappear = false
	},
	create = function(arg_379_0)
		return require("app.view.module.activity.view.activityCelebrationLogin.CelebrationLoginPopup").new(...)
	end
}
var_0_0.WAKE_LOGIN_LAYER = {
	package = "activity",
	routeType = 2112,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_380_0)
		return require("app.view.module.activity.view.activityCelebrationLogin.wake.ActivityWakeLoginLayer").new(...)
	end
}
var_0_0.ABVERT_AWARD_1 = {
	package = "activity",
	modType = var_0_0.POPUP,
	params = {
		hideContinue = true,
		ignoreTouch = true,
		touchDisappear = false
	},
	create = function(arg_381_0)
		return require("app.view.module.abvertPageAward.view.AbvertPageAwardPop").new(...)
	end
}
var_0_0.ALLIANCE = {
	routeType = 2200,
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_382_0)
		if g.core.model.User.allianceData:isInAlliance() then
			return require("app.view.module.alliance.view.AllianceMainLayer").new(...)
		else
			return require("app.view.module.alliance.view.AllianceCreateLayer").new(...)
		end
	end,
	provider = Provider.reqGuildGetInfo
}
var_0_0.ALLIANCE_HALL = {
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ALLIANCE,
	create = function(arg_383_0)
		return require("app.view.module.alliance.view.hall.AllianceHallLayer").new(...)
	end
}
var_0_0.ALLIANCE_SEND_BOX = {
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ALLIANCE,
	create = function(arg_384_0)
		return require("app.view.module.alliance.view.box.AllianceSendBoxLayer").new(...)
	end
}
var_0_0.ALLIANCE_OPEN_BOX = {
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ALLIANCE,
	create = function(arg_385_0)
		return require("app.view.module.alliance.view.box.AllianceOpenBoxLayer").new(...)
	end
}
var_0_0.ALLIANCE_TASK = {
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ALLIANCE,
	create = function(arg_386_0)
		return require("app.view.module.alliance.view.task.AllianceTaskLayer").new(...)
	end
}
var_0_0.ALLIANCE_RANK = {
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ALLIANCE,
	create = function(arg_387_0)
		return require("app.view.module.alliance.view.task.AllianceRankLayer").new(...)
	end
}
var_0_0.ALLIANCE_HONOR = {
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ALLIANCE,
	create = function(arg_388_0)
		return require("app.view.module.alliance.view.honor.AllianceHonourMainLayer").new(...)
	end
}
var_0_0.ALLIANCE_TRIAL = {
	package = "alliance",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ALLIANCE,
	create = function(arg_389_0)
		return require("app.view.module.allianceTrial.view.AllianceTrialMainLayer").new(...)
	end,
	needCloud = function()
		return g.core.model.User.allianceTrialData:isNeedCloud()
	end
}
var_0_0.NEW_SLG_MAIN = {
	routeType = 3401,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_391_0)
		return require("app.view.module.slg.view.NewSlgMainLayer").new(...)
	end,
	cloudEvents = {
		g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER
	},
	needCloud = function(arg_392_0)
		return true
	end
}
var_0_0.NEW_SLG_DEVELOP_MAIN_LAYER = {
	routeType = 3402,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_393_0)
		if g.core.model.User.newSlgData:isForecasting() then
			return require("app.view.module.slg.view.NewSlgPreviewLayer").new(...)
		elseif g.core.model.User.newSlgData:isEnding() then
			return require("app.view.module.slg.view.NewSlgResultLayer").new(...)
		else
			return require("app.view.module.slg.view.develop.NewSlgDevelopMainLayer").new(...)
		end
	end
}
var_0_0.NEW_SLG_MAIN_CITY_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_394_0)
		return require("app.view.module.slg.view.develop.NewSlgUpgradePop").new({
			buildType = 1
		})
	end
}
var_0_0.NEW_SLG_EMBRYO_LINEUP_POP = {
	routeType = 3405,
	modType = var_0_0.POPUP,
	previous = var_0_0.NEW_SLG_DEVELOP_MAIN_LAYER,
	create = function(arg_395_0)
		return require("app.view.module.slg.view.develop.NewSlgEmbryoLineUpPop").new(...)
	end
}
var_0_0.NEW_SLG_EMBRYO_DEPLOY_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_396_0)
		return require("app.view.module.slg.view.develop.NewSlgEmbryoDeployPop").new(...)
	end
}
var_0_0.NEW_SLG_SUPPLY_POP = {
	routeType = 3405,
	modType = var_0_0.POPUP,
	create = function(arg_397_0)
		return require("app.view.module.slg.view.develop.NewSlgSupplyPop").new(...)
	end
}
var_0_0.New_SLG_BARRACK_POP = {
	routeType = 3405,
	modType = var_0_0.POPUP,
	create = function(arg_398_0)
		return require("app.view.module.slg.view.develop.NewSlgUpgradePop").new(...)
	end
}
var_0_0.NEW_SLG_PREVIEW_LAYER = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_399_0)
		return require("app.view.module.slg.view.NewSlgPreviewLayer").new(...)
	end
}
var_0_0.NEW_SLG_END_SHOW_LAYER = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_400_0)
		return require("app.view.module.slg.view.NewSlgResultLayer").new(...)
	end
}
var_0_0.NEW_SLG_PVC_DEFENDER_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_401_0)
		return require("app.view.module.slg.view.pvc.NewSlgPvcDefenderInfoPop").new(...)
	end
}
var_0_0.NEW_SLG_S2_DEFENDER_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_402_0)
		return require("app.view.module.slg.view.s2.NewSlgS2DefenderInfoPop").new(...)
	end
}
var_0_0.NEW_SLG_PVC_CHARIOT_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_403_0)
		return require("app.view.module.slg.view.pvc.NewSlgPvcChariotInfoPop").new(...)
	end
}
var_0_0.NEW_SLG_PVC_QUEST_POP = {
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = true,
		hideContinue = false
	},
	create = function(arg_404_0)
		if g.core.model.User.newSlgData:getSName() == "S1" then
			return require("app.view.module.slg.view.pvc.NewSlgPvcQuestPop").new(...)
		else
			return require("app.view.module.slg.view.s2.achievement.NewSlgAchievementPop").new(...)
		end
	end
}
var_0_0.NEW_SLG_PVC_FLOAT_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_405_0)
		return require("app.view.module.slg.view.pvc.NewSlgPvcFloatPop").new(...)
	end
}
var_0_0.NEW_SLG_RANK = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_406_0)
		return require("app.view.module.slg.view.pvc.NewSlgPvcRankLayer").new(...)
	end
}
var_0_0.NEW_SLG_MOVE_ALLIANCE_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_407_0)
		return require("app.view.module.slg.view.NewSlgMoveAlliancePop").new(...)
	end
}
var_0_0.NEW_SLG_BOSS_TEAM_LIST_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_408_0)
		return require("app.view.module.slg.view.boss.NewSlgBossTeamRoomPop").new(...)
	end
}
var_0_0.NEW_SLG_BOSS_TEAM_DETAIL_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_409_0)
		return require("app.view.module.slg.view.boss.NewSlgBossTeamDetailPop").new(...)
	end
}
var_0_0.NEW_SLG_BOSS_TEAM_INVITE_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_410_0)
		return require("app.view.module.slg.view.boss.NewSlgBossInvitePop").new(...)
	end
}
var_0_0.NEW_SLG_BOSS_TEAM_INVITED_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_411_0)
		return require("app.view.module.slg.view.boss.NewSlgBossTeamInvitedPop").new(...)
	end
}
var_0_0.NEW_SLG_BOSS_TOTAL_TEAM = {
	modType = var_0_0.POPUP,
	create = function(arg_412_0)
		return require("app.view.module.slg.view.boss.NewSlgBossTotalTeamPop").new(...)
	end
}
var_0_0.NEW_SLG_POINT_QUEST_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_413_0)
		return require("app.view.module.slg.view.NewSlgPointQuestPop").new(...)
	end
}
var_0_0.NEW_SLG_ELEM_TIP_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_414_0)
		return require("app.view.module.slg.view.team.NewSlgTeamTipPop").new(...)
	end
}
var_0_0.NEW_SLG_BAG_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_415_0)
		return require("app.view.module.slg.view.bag.NewSlgBagPop").new(...)
	end
}
var_0_0.NEW_SLG_BP = {
	routeType = 3404,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_416_0)
		return require("app.view.module.commonPassCard.view.CommonPassCardLayer").new(...)
	end
}
var_0_0.NEW_SLG_BP_BUY_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_417_0)
		return require("app.view.module.slg.view.bp.NewSlgBpBuyPop").new(...)
	end
}
var_0_0.NEW_SLG_PLAYER_INFO = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_418_0)
		return require("app.view.module.slg.view.team.NewSlgTeamPlayerInfoLayer").new(...)
	end
}
var_0_0.NEW_SLG_S2_BUILD = {
	modType = var_0_0.POPUP,
	create = function(arg_419_0)
		return require("app.view.module.slg.view.s2.NewSlgS2BuildPop").new(...)
	end
}
var_0_0.NEW_SLG_S2_CITY_RESULT = {
	modType = var_0_0.POPUP,
	create = function(arg_420_0)
		if g.core.model.User.newSlgData:getSName() == "S2" then
			return require("app.view.module.slg.view.s2.NewSlgS2CityResultPop").new(...)
		else
			return require("app.view.module.slg.view.pvc.NewSlgPvcLastDayRankPop").new(...)
		end
	end,
	params = {
		tag = "NewSlgMainLayer_exeQueue"
	}
}
var_0_0.NEW_SLG_S2_CITY_RESULT_DETAIL = {
	modType = var_0_0.POPUP,
	create = function(arg_421_0)
		return require("app.view.module.slg.view.s2.NewSlgS2CityResultDetailPop").new(...)
	end
}
var_0_0.NEW_SLG_S2_CITY_RESULT_USER = {
	modType = var_0_0.POPUP,
	create = function(arg_422_0)
		return require("app.view.module.slg.view.s2.NewSlgS2CityResultUserPop").new(...)
	end
}
var_0_0.NEW_SLG_FARM_TEAM_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_423_0)
		return require("app.view.module.slg.view.farm.NewSlgFarmTeamPop").new(...)
	end
}
var_0_0.NEW_SLG_S3_EVENT_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_424_0)
		return require("app.view.module.slg.view.event.NewSlgEventPop").new(...)
	end
}
var_0_0.NEW_SLG_SKILL_TREE_MAIN = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_425_0)
		return require("app.view.module.slg.view.skillTree.NewSlgSkillTalentSelectLayer").new(...)
	end
}
var_0_0.NEW_SLG_SKILL_TREE = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_426_0)
		return require("app.view.module.slg.view.skillTree.NewSlgSkillTreeTalentLayer").new(...)
	end
}
var_0_0.NEW_SLG_SEASON_TASK = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_427_0)
		return require("app.view.module.slg.view.seasonTask.NewSlgSeasonTaskLayer").new(...)
	end
}
var_0_0.NEW_SLG_STRATEGY_POP = {
	params = {
		touchDisappear = true
	},
	modType = var_0_0.POPUP,
	create = function(arg_428_0)
		return require("app.view.module.slg.view.strategy.NewSlgStrategyPop").new(...)
	end
}
var_0_0.HOME_REMIND_POP = {
	modType = var_0_0.POPUP,
	provider = Provider.reqCrossPoint,
	create = function(arg_429_0)
		return require("app.view.module.home.view.HomeInfoRemindPop").new(...)
	end
}
var_0_0.RETRO = {
	routeType = 2102,
	package = "retro",
	modType = var_0_0.FULL_SCREEN,
	provider = Provider.reqRetroActivity,
	previous = var_0_0.HOME,
	create = function(arg_430_0)
		return require("app.view.module.retro.view.RetroMainLayer").new(...)
	end
}
var_0_0.RETRO_SHOP = {
	package = "retro",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_431_0)
		return require("app.view.module.shop.view.shopRetro.ShopRetroLayer").new(...)
	end
}
var_0_0.ROLE_SKIN_LAYER = {
	package = "roleSkin",
	routeType = 2103,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_432_0)
		return require("app.view.module.roleSkin.view.RoleSkinLayer").new(...)
	end
}
var_0_0.RECYCLE_CULTIVATE_LAYER = {
	package = "recycleCultivate",
	routeType = 2104,
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_433_0)
		return require("app.view.module.recycleCultivate.view.RecycleCultivateLayer").new(...)
	end
}
var_0_0.WEDDING_ACTIVITY_POP = {
	package = "weddingActivity",
	modType = var_0_0.POPUP,
	provider = Provider.reqPrimaryWedActivity,
	params = {
		touchDisappear = true
	},
	create = function(arg_434_0)
		return require("app.view.module.weddingActivity.view.WeddingActivityPop").new(...)
	end
}
var_0_0.PUBG_MAIN_LAYER = {
	routeType = 3611,
	package = "pubg",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_435_0)
		return require("app.view.module.pubg.view.PubgMainLayer").new(...)
	end
}
var_0_0.PUBG_MAP_LAYER = {
	isHungry = true,
	package = "pubg",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_436_0)
		return require("app.view.module.pubg.view.pubgMap.PubgMapLayer").new(...)
	end,
	provider = Provider.reqPubgMapEnter
}
var_0_0.PUBG2_MAP_LAYER = {
	package = "pubg",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_437_0)
		return require("app.view.module.pubg2Map.view.Pubg2MapLayer").new(...)
	end
}
var_0_0.PUBG2_SETTING_MAP_LAYER = {
	package = "pubg",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_438_0)
		return require("app.view.module.pubg2Map.view.Pubg2SettingMapLayer").new(...)
	end
}
var_0_0.PUBG_RANK_LAYER = {
	package = "pubg",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_439_0)
		return require("app.view.module.pubg.view.PubgRankLayer").new(...)
	end
}
var_0_0.SUCUBA_DEV_LAYER = {
	package = "succuba",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_440_0)
		return require("app.view.module.succuba.view.SuccubaDevLayer").new(...)
	end
}
var_0_0.SUCUBA_MAIN_LAYER = {
	routeType = 2105,
	package = "succuba",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	provider = Provider.reqSuccubaInfo,
	create = function(arg_441_0)
		return require("app.view.module.succuba.view.SuccubaMainLayer").new(...)
	end
}
var_0_0.SUCUBA_HANDBOOK_LAYER = {
	package = "succuba",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_442_0)
		return require("app.view.module.succuba.view.SuccubaChatHandbookLayer").new(...)
	end
}
var_0_0.MONOPOLY_STAGE = {
	package = "monopoly",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_443_0)
		return require("app.view.module.monopoly.view.MonopolyMainStage").new(...)
	end,
	provider = Provider.reqMonopolyMapEnter
}
var_0_0.BLAZING_ARENA = {
	routeType = 3105,
	package = "blazingArena",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_444_0)
		return require("app.view.module.blazingArena.view.BlazingArenaMainLayer").new(...)
	end
}
var_0_0.BLAZING_ARENA_FORMATION = {
	package = "blazingArena",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_445_0)
		return require("app.view.module.blazingArena.view.BlazingArenaFormationLayer").new(...)
	end
}
var_0_0.BLAZING_ARENA_BATTLE_PREPARATION = {
	package = "blazingArena",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_446_0)
		return require("app.view.module.blazingArena.view.BlazingArenaBattlePrepareLayer").new(...)
	end
}
var_0_0.SUCCUBA_LAUNCH = {
	package = "succubaLaunch",
	routeType = 3501,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_447_0)
		return require("app.view.module.succubaLaunch.SuccubaLaunchLayer").new(...)
	end
}
var_0_0.ANNIVERSARY_MAIN_LAYER = {
	routeType = 3801,
	package = "anniversary",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_448_0)
		return require("app.view.module.anniversary.view.AnniversaryMainLayer").new(...)
	end
}
var_0_0.ANNIVERSARY_SHOP_LAYER = {
	package = "anniversary",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_449_0)
		return require("app.view.module.anniversary.view.AnniversaryShopLayer").new(...)
	end
}
var_0_0.ANNIVERSARY_FLOOR_LAYER = {
	package = "anniversary",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_450_0)
		return require("app.view.module.anniversary.view.AnniversaryFloorLayer").new(...)
	end
}
var_0_0.ANNIVERSARY_JIGSAW_LAYER = {
	package = "anniversary",
	previous = var_0_0.ANNIVERSARY_MAIN_LAYER,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_451_0)
		return require("app.view.module.anniversary.view.jigsaw.AnniversaryJigsawLayer").new(...)
	end
}
var_0_0.SPIRE_MAIN_LAYER = {
	routeType = 3701,
	package = "spire",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_452_0)
		return require("app.view.module.spire.view.SpireMainLayer").new(...)
	end
}
var_0_0.SPIRE_DETAIL_LAYER = {
	package = "spire",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_453_0)
		return require("app.view.module.spire.view.SpireDetailLayer").new(...)
	end
}
var_0_0.SPIRE_COLLECT_LAYER = {
	package = "spire",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_454_0)
		return require("app.view.module.spire.view.SpireCollectLayer").new(...)
	end
}
var_0_0.SPIRE_RANK_LAYER = {
	package = "spire",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_455_0)
		return require("app.view.module.spire.view.SpireRankLayer").new(...)
	end
}
var_0_0.SPIRE_FORMATION_LAYER = {
	package = "spire",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_456_0)
		return require("app.view.module.spire.view.SpireFormationLayer").new(...)
	end
}
var_0_0.SPIRE_CHALLENGE_LAYER = {
	package = "spire",
	previous = var_0_0.SPIRE_MAIN_LAYER,
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_457_0)
		return require("app.view.module.spire.view.SpireChallengeLayer").new(...)
	end
}
var_0_0.SPIRE_BOSS_DETAIL_POP = {
	modType = var_0_0.POPUP,
	create = function(arg_458_0)
		return require("app.view.module.spire.view.pop.SpireBossDetailPop").new(...)
	end
}
var_0_0.ELDERBOSS_CHOOSE_BUFF_LAYER = {
	package = "elderBoss",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_459_0)
		return require("app.view.module.elderBoss.view.ElderBossChooseBuffLayer").new(...)
	end
}
var_0_0.ELDERBOSS_MAIN_LAYER = {
	routeType = 3901,
	package = "elderBoss",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_460_0)
		return require("app.view.module.elderBoss.view.ElderBossMainLayer").new(...)
	end
}
var_0_0.ELDERBOSS_RESULT_LAYER = {
	package = "elderBoss",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_461_0)
		return require("app.view.module.elderBoss.view.ElderBossResultLayer").new(...)
	end
}
var_0_0.ELDERBOSS_RANK_LAYER = {
	package = "elderBoss",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_462_0)
		return require("app.view.module.elderBoss.view.ElderRankLayer").new(...)
	end
}
var_0_0.OUT_POST_STAGE = {
	package = "outpost",
	routeType = 6605,
	modType = var_0_0.FULL_SCREEN,
	provider = Provider.reqOutpostInfo,
	create = function(arg_463_0)
		return require("app.view.module.outpost.view.stage.OutpostGameStage").new(...)
	end
}
var_0_0.OUT_POST_EQUIP_LAYER = {
	package = "outpost",
	previous = var_0_0.OUT_POST_STAGE,
	modType = var_0_0.POPUP,
	create = function(arg_464_0)
		return require("app.view.module.outpost.view.build.OutpostEquipBuildLayer").new(...)
	end
}
var_0_0.OUT_POST_EXCHANGE_LAYER = {
	package = "outpost",
	previous = var_0_0.OUT_POST_STAGE,
	modType = var_0_0.POPUP,
	create = function(arg_465_0)
		return require("app.view.module.outpost.view.build.OutpostExchangeBuildLayer").new(...)
	end
}
var_0_0.OUT_POST_FORMATION_LAYER = {
	package = "outpost",
	previous = var_0_0.OUT_POST_STAGE,
	modType = var_0_0.POPUP,
	create = function(arg_466_0)
		return require("app.view.module.outpost.view.formation.OutpostChangeFormationLayer").new(...)
	end
}
var_0_0.OUT_POST_RECOVER_LAYER = {
	package = "outpost",
	previous = var_0_0.OUT_POST_STAGE,
	modType = var_0_0.POPUP,
	create = function(arg_467_0)
		return require("app.view.module.outpost.view.build.OutpostRecoverBuildLayer").new(...)
	end
}
var_0_0.OUT_POST_MAIN_CITY = {
	package = "outpost",
	previous = var_0_0.OUT_POST_STAGE,
	modType = var_0_0.POPUP,
	create = function(arg_468_0)
		return require("app.view.module.outpost.view.build.OutpostMainCityLayer").new(...)
	end
}
var_0_0.OUT_POST_BOSS_BUILD = {
	package = "outpost",
	previous = var_0_0.OUT_POST_STAGE,
	modType = var_0_0.POPUP,
	create = function(arg_469_0)
		return require("app.view.module.outpost.view.build.OutpostBossBuildLayer").new(...)
	end
}
var_0_0.OUT_POST_KNIGHT_DETAIL = {
	package = "outpost",
	previous = var_0_0.OUT_POST_STAGE,
	modType = var_0_0.POPUP,
	create = function(arg_470_0)
		return require("app.view.module.outpost.view.knight.OutpostKnightDetailLayer").new(...)
	end
}
var_0_0.RELEASE_ACTIVITY_MAIN_LAYER = {
	routeType = 2110,
	package = "release",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_471_0)
		return require("app.view.module.release.view.ReleaseActivityMainLayer").new(...)
	end
}
var_0_0.RELEASE_ACTIVITY_GIFT_POP = {
	routeType = 2111,
	package = "release",
	modType = var_0_0.POPUP,
	create = function(arg_472_0)
		return require("app.view.module.shop.view.shopRelease.ShopReleaseGiftPop").new(...)
	end
}
var_0_0.DOMAIN_DUNGEON_CHOOSE = {
	routeType = 6606,
	package = "domainDungeon",
	modType = var_0_0.FULL_SCREEN,
	provider = Provider.reqDomainGetInfo,
	create = function(arg_473_0)
		return require("app.view.module.domain.view.DomainChooseDungeonLayer").new(...)
	end
}
var_0_0.DOMAIN_DUNGEON_MAINLAYER = {
	package = "domainDungeon",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_474_0)
		return require("app.view.module.domain.view.DomainDungeonMainLayer").new(...)
	end
}
var_0_0.DOMAIN_FORMATION_LAYER = {
	package = "domainDungeon",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_475_0)
		return require("app.view.module.domain.view.DomainFormationLayer").new(...)
	end
}
var_0_0.DOMAIN_SLOT_MACHINE = {
	package = "domainDungeon",
	modType = var_0_0.POPUP,
	create = function(arg_476_0)
		return require("app.view.module.domain.view.DomainSlotMachinePop").new(...)
	end
}
var_0_0.DOMAIN_TURN_GAME = {
	package = "domainDungeon",
	modType = var_0_0.POPUP,
	create = function(arg_477_0)
		return require("app.view.module.domain.view.DomainTurnGamePop").new(...)
	end
}
var_0_0.DOMAIN_AWARD_POP = {
	package = "domainDungeon",
	modType = var_0_0.POPUP,
	create = function(arg_478_0)
		return require("app.view.module.domain.view.DomainDungeonAwardPop").new(...)
	end
}
var_0_0.SERVER_PASS_MAIN_LAYER = {
	package = "serverPassActivity",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_479_0)
		return require("app.view.module.serverPassActivity.view.ServerPassMainLayer").new(...)
	end
}
var_0_0.SERVER_PASS_BUY_LAYER = {
	package = "serverPassActivity",
	modType = var_0_0.POPUP,
	create = function(arg_480_0)
		return require("app.view.module.serverPassActivity.view.ServerPassBuyLayer").new(...)
	end
}
var_0_0.ANCIENTS_MAIN_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_481_0)
		return require("app.view.module.ancients.view.AncientsMainLayer").new(...)
	end
}
var_0_0.ANCIENTS_COOP_MAIN_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_482_0)
		return require("app.view.module.ancients.view.coop.AncientsCoopMainLayer").new(...)
	end
}
var_0_0.ANCIENTS_POINTS_RANK_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.HOME,
	create = function(arg_483_0)
		return require("app.view.module.ancients.view.AncientsPointsRankingLayer").new(...)
	end
}
var_0_0.ANCIENTS_BATTLE_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ANCIENTS_MAIN_LAYER,
	create = function(arg_484_0)
		return require("app.view.module.ancients.view.AncientsBattleLayer").new(...)
	end
}
var_0_0.ANCIENTS_LINEUP_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ANCIENTS_MAIN_LAYER,
	create = function(arg_485_0)
		return require("app.view.module.ancients.view.AncientsLineupLayer").new(...)
	end
}
var_0_0.ANCIENTS_FINAL_RANK_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	previous = var_0_0.ANCIENTS_AGAINST_LAYER,
	create = function(arg_486_0)
		return require("app.view.module.ancients.view.AncientsFinalRankLayer").new(...)
	end
}
var_0_0.ANCIENTS_AGAINST_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_487_0)
		return require("app.view.module.ancients.view.AncientsAgainstLayer").new(...)
	end
}
var_0_0.ANCIENTS_REVIEW_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_488_0)
		return require("app.view.module.ancients.view.AncientsReviewLayer").new(...)
	end
}
var_0_0.ANCIENTS_BATTLE_RESULT_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_489_0)
		return require("app.view.module.ancients.view.AncientsBattleResultPop").new(...)
	end
}
var_0_0.ANCIENTS_BATTLE_REPORT_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_490_0)
		return require("app.view.module.ancients.view.AncientsBattleReportPop").new(...)
	end
}
var_0_0.ANCIENTS_FINAL_BATTLE_REPORT_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_491_0)
		return require("app.view.module.ancients.view.AncientsFinalBattleReportPop").new(...)
	end
}
var_0_0.ANCIENTS_BATTLE_DETAIL_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_492_0)
		return require("app.view.module.ancients.view.AncientsBattleDetailPop").new(...)
	end
}
var_0_0.ANCIENTS_LINEUP_MATCH_SUCC_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	params = {
		touchDisappear = false
	},
	create = function(arg_493_0)
		return require("app.view.module.ancients.view.AncientsLineupMatchSuccPop").new(...)
	end
}
var_0_0.ANCIENTS_GUESS_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_494_0)
		return require("app.view.module.ancients.view.AncientsGuessPop").new(...)
	end
}
var_0_0.ANCIENTS_MESSAGE_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_495_0)
		return require("app.view.module.ancients.view.AncientsMessagePop").new(...)
	end
}
var_0_0.ANCIENTS_BUY_FIGHT_COUNT_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_496_0)
		return require("app.view.module.ancients.view.AncientsBuyFightCountPop").new(...)
	end
}
var_0_0.ANCIENTS_SELECT_KNIGHT_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_497_0)
		return require("app.view.module.ancients.view.AncientsSelectKnightPop").new(...)
	end
}
var_0_0.ANCIENTS_TEAM_INVITE_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_498_0)
		return require("app.view.module.ancients.view.AncientsTeamInvitePop").new(...)
	end
}
var_0_0.ANCIENTS_TEAM_APPLY_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_499_0)
		return require("app.view.module.ancients.view.AncientsTeamApplyPop").new(...)
	end
}
var_0_0.ANCIENTS_TEAM_SPOILS_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_500_0)
		return require("app.view.module.ancients.view.AncientsTeamSpoilsPop").new(...)
	end
}
var_0_0.ANCIENTS_TEAM_SPOILS_PREVIEW_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_501_0)
		return require("app.view.module.ancients.view.AncientsTeamSpoilsPreviewPop").new(...)
	end
}
var_0_0.ANCIENTS_TEAM_SPOILS_DETAIL_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_502_0)
		return require("app.view.module.ancients.view.AncientsTeamSpoilsDetailPop").new(...)
	end
}
var_0_0.ANCIENTS_SOUL_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_503_0)
		return require("app.view.module.ancients.view.soul.AncientsSoulPop").new(...)
	end
}
var_0_0.ANCIENTS_COOP_TEAM_RANK_POP = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_504_0)
		return require("app.view.module.ancients.view.coop.AncientsCoopTeamRankPop").new(...)
	end
}
var_0_0.ANCIENTS_COOP_TEAM_INFO_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_505_0)
		return require("app.view.module.ancients.view.coop.AncientsCoopTeamInfoPop").new(...)
	end
}
var_0_0.ANCIENTS_COOP_TEAM_INVITE_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_506_0)
		return require("app.view.module.ancients.view.coop.AncientsCoopTeamInvitePop").new(...)
	end
}
var_0_0.ANCIENTS_COOP_CREATE_TEAM_POP = {
	package = "ancients",
	modType = var_0_0.POPUP,
	create = function(arg_507_0)
		return require("app.view.module.ancients.view.coop.AncientsCoopCreateTeamPop").new(...)
	end
}
var_0_0.ANCIENTS_FORMATION_LAYER = {
	package = "ancients",
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_508_0)
		return require("app.view.module.ancients.view.AncientsFormationLayer").new(...)
	end
}
var_0_0.VIP_LINK_POP = {
	package = "vipLink",
	modType = var_0_0.POPUP,
	create = function(arg_509_0)
		return require("app.view.module.vipLink.view.VipLinkPop").new(...)
	end
}
var_0_0.DEBUG = {
	modType = var_0_0.FULL_SCREEN,
	create = function(arg_510_0)
		return require("app.view.module.debug.DebugMainLayer").new(...)
	end
}

local var_0_3 = {}

for iter_0_0, iter_0_1 in pairs(var_0_0) do
	if iter_0_0 ~= "FULL_SCREEN" and iter_0_0 ~= "POPUP" then
		var_0_3[iter_0_1] = iter_0_0
	end
end

var_0_0.MODULE_NAME = var_0_3

return var_0_0
