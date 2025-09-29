-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/iconloader/IconType.lua

module("logic.common.iconloader.IconType", package.seeall)

local IconType = {}
local settings = {}

function IconType.getSetting(iconType)
	return settings[iconType]
end

local function getLanguagePath(resPath)
	return string.format("language/zh/%s", resPath)
end

IconType.Skinlib = 201
IconType.HeadIcon = 1
IconType.SkillIcon = 2
IconType.BuffIcon = 3
IconType.PlotFaceIcon = 4
IconType.ItemIcon = 5
IconType.PlotCamp = 7
IconType.CharaterBust = 8
IconType.CharaterCampCornerIcon = 9
IconType.CharaterIcon = 10
IconType.CharacterHeadLeft = 11
IconType.Background = 12
IconType.BattleHead = 13
IconType.Card = 14
IconType.Head = 15
IconType.BigCamp = 16
IconType.CharacterInfoCamp = 17
IconType.CampBg = 18
IconType.EquipIcon = 19
IconType.Silhouette = 20
IconType.CampBattle = 21
IconType.Thought = 22
IconType.EchoItemIcon = 23
IconType.CharaterCommercialIcon = 24
IconType.LotteryEntry = 25
IconType.RunGroup = 26
IconType.Emoji2 = 27
IconType.EchoItemBigIcon = 28
IconType.Room = 29
IconType.Monument = 30
IconType.Furniture = 31
IconType.RoomOrder = 32
IconType.ChatEmoji = 33
IconType.Portrait = 34
IconType.DisplayCard = 35
IconType.LotteryCamp = 36
IconType.CharacterDetailCamp = 37
IconType.HouseSkill = 38
IconType.HouseBuff = 39
IconType.SideIcon = 40
IconType.D6Icon = 41
IconType.MainlineDungeon = 42
IconType.PlayerCard = 43
IconType.CharacterSystem = 44
IconType.PlayerCardSpecial = 45
IconType.AchievementSkill = 46
IconType.PlayerCardMedium = 47
IconType.PlayerCardSpecial1 = 48
IconType.Survey = 49
IconType.HandbookCG = 50
IconType.StoryCharacter = 51
IconType.RoleCard = 52
IconType.HouseCompile = 53
IconType.HouseWorkShop = 54
IconType.MainlinePlotDungeon = 55
IconType.Mainline = 56
IconType.StoryHeadIcon = 57
IconType.CharaterDepotCampIcon = 58
IconType.SKillHeartAnchor = 59
IconType.RoleHeadIcon = 60
IconType.RoleCardIcon = 61
IconType.RunGroupRoleCamp = 62
IconType.CharacterHeartAnchorCarryItem = 63
IconType.ControlActionBig = 64
IconType.PlayerInfoMask = 65
IconType.ControlActionHead = 66
IconType.ControlActionMonitor = 67
IconType.activityTabIcon = 68
IconType.StoreIcon = 69
IconType.ControlActionManual = 70
IconType.AirWorkShopTheme = 71
IconType.SkillEffectLabel = 72
IconType.AirWorkShopTrophy = 73
IconType.EchoPuzzleItemIcon = 74
IconType.EquipDiceIcon = 75
IconType.RetrieveBanner = 76
IconType.PowerChallenge = 77
IconType.PlayerInfoCard = 78
IconType.PlayerInfoFrame = 79
IconType.EchoCardUnpack = 80
IconType.EnemyHint = 81
IconType.DynSpriteAtlas_Language = 101
IconType.DynSpriteAtlas_Battle = 102
IconType.DynSpriteAtlas_LoadingMain = 103
IconType.DynSpriteAtlas_Plot = 104
IconType.DynSpriteAtlas_DungeonEntrance = 105
IconType.DynSpriteAtlas_Team = 106
IconType.DynSpriteAtlas_CharacterDepot = 107
IconType.DynSpriteAtlas_CharacterSystem = 109
IconType.DynSpriteAtlas_Dungeon = 110
IconType.DynSpriteAtlas_Material = 111
IconType.DynSpriteAtlas_Dice = 112
IconType.DynSpriteAtlas_Room = 114
IconType.DynSpriteAtlas_ResourcesExplore = 115
IconType.DynSpriteAtlas_Backpack = 116
IconType.DynSpriteAtlas_Task = 117
IconType.DynSpriteAtlas_Store = 118
IconType.DynSpriteAtlas_Wekfare = 119
IconType.DynSpriteAtlas_Fight = 120
IconType.DynSpriteAtlas_Season = 121
IconType.DynSpriteAtlas_EquipExplore = 122
IconType.DynSpriteAtlas_CharacterSystem_Authority = 123
IconType.DynSpriteAtlas_CharacterSystem_Com = 124
IconType.DynSpriteAtlas_CharacterSystem_Detail = 125
IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor = 126
IconType.DynSpriteAtlas_SecretTime = 128
IconType.DynSpriteAtlas_AirWorkShop = 129
IconType.DynSpriteAtlas_TeachExplore = 130
IconType.DynSpriteAtlas_MainView = 131
IconType.DynSpriteAtlas_RetrieveMainView = 132
IconType.LoadType_DynIcon = 1
IconType.LoadType_SpriteAtlas = 2
IconType.LoadType_CutSprite = 3
settings[IconType.Skinlib] = {
	url = "ui/spriteatlas/skinlib_dynamic.spriteatlas",
	loadType = 2
}
settings[IconType.HeadIcon] = {
	url = "ui/dynicon/head/%s.png",
	loadType = 1
}
settings[IconType.SkillIcon] = {
	url = "ui/dynicon/skill/%s.png",
	loadType = 1
}
settings[IconType.BuffIcon] = {
	url = "ui/dynicon/buff/%s.png",
	loadType = 1
}
settings[IconType.ItemIcon] = {
	url = "ui/dynicon/normal/%s.png",
	loadType = 1
}
settings[IconType.Furniture] = {
	url = "ui/dynicon/furniture/%s.png",
	loadType = 1
}
settings[IconType.EquipIcon] = {
	url = "ui/dynicon/equip/%s.png",
	loadType = 1
}
settings[IconType.D6Icon] = {
	url = "ui/dynicon/equip/%s.png",
	loadType = 1
}
settings[IconType.CharaterCampCornerIcon] = {
	url = "ui/dynicon/camp/camp_3/%s.png",
	loadType = 1
}
settings[IconType.CharaterDepotCampIcon] = {
	url = "ui/dynicon/camp/camp_9/%s.png",
	loadType = 1
}
settings[IconType.PlotFaceIcon] = {
	url = "ui/dynicon/plot_face/100003/%s.png",
	loadType = 1
}
settings[IconType.PlotCamp] = {
	url = "ui/dynicon/camp/camp_2/%s.png",
	loadType = 1
}
settings[IconType.BigCamp] = {
	url = "ui/dynicon/camp/camp_3/%s.png",
	loadType = 1
}
settings[IconType.CharacterInfoCamp] = {
	url = "ui/dynicon/commercial/commercial_1/%s.png",
	loadType = 1
}
settings[IconType.Background] = {
	url = "ui/dynicon/background/%s.png",
	loadType = 1
}
settings[IconType.BattleHead] = {
	url = "ui/dynicon/battle_head/%s.png",
	loadType = 1
}
settings[IconType.CampBg] = {
	url = "ui/dynicon/camp/camp_5/%s.png",
	loadType = 1
}
settings[IconType.CampBattle] = {
	url = "ui/dynicon/camp/camp_1/%s.png",
	loadType = 1
}
settings[IconType.EchoItemIcon] = {
	url = "ui/dynicon/echo/%s.png",
	loadType = 1
}
settings[IconType.EchoItemBigIcon] = {
	url = "ui/dynicon/echo_big/%s.png",
	loadType = 1
}
settings[IconType.EchoPuzzleItemIcon] = {
	url = "ui/dynicon/echo_fragment/%s.png",
	loadType = 1
}
settings[IconType.CharaterCommercialIcon] = {
	url = "ui/dynicon/commercial/commercial_3/%s.png",
	loadType = 1
}
settings[IconType.LotteryCamp] = {
	url = "ui/dynicon/camp/camp_4/%s.png",
	loadType = 1
}
settings[IconType.CharacterDetailCamp] = {
	url = "ui/dynicon/camp/camp_6/%s.png",
	loadType = 1
}
settings[IconType.MainlineDungeon] = {
	url = "ui/dynicon/instance/instance_chapter/%s.png",
	loadType = 1
}
settings[IconType.MainlinePlotDungeon] = {
	url = "ui/dynicon/instance/instance_drama/%s.png",
	loadType = 1
}
settings[IconType.Mainline] = {
	url = "ui/dynicon/instance/%s.png",
	loadType = 1
}
settings[IconType.CharaterIcon] = {
	url = "ui/dynicon/character/%s.png",
	loadType = 3
}
settings[IconType.CharaterBust] = {
	url = "ui/dynicon/character/%s.png",
	loadType = 3
}
settings[IconType.Card] = {
	url = "ui/dynicon/card/card_%s.png",
	loadType = 1
}
settings[IconType.Head] = {
	url = "ui/dynicon/head/head_%s.png",
	loadType = 1
}
settings[IconType.Silhouette] = {
	url = "ui/dynicon/infomation_cucoloris/jy_%s.png",
	loadType = 1
}
settings[IconType.Thought] = {
	url = "ui/dynicon/thought/%s.png",
	loadType = 1
}
settings[IconType.LotteryEntry] = {
	url = "ui/dynicon/summoncard/%s.png",
	loadType = 1
}
settings[IconType.RunGroup] = {
	url = "ui/dynicon/rungroup/%s.png",
	loadType = 1
}
settings[IconType.Emoji2] = {
	url = "ui/dynicon/emoji/emoji_2/%s.png",
	loadType = 1
}
settings[IconType.Room] = {
	url = "ui/dynicon/room/%s.png",
	loadType = 1
}
settings[IconType.Monument] = {
	url = "ui/dynicon/playerinfo/symptom/%s.png",
	loadType = 1
}
settings[IconType.RoomOrder] = {
	url = "ui/dynicon/room/room_order/%s.png",
	loadType = 1
}
settings[IconType.ChatEmoji] = {
	url = "ui/dynicon/chat_emoji/%s.png",
	loadType = 1
}
settings[IconType.Portrait] = {
	url = "ui/dynicon/head/%s.png",
	loadType = 1
}
settings[IconType.DisplayCard] = {
	url = "ui/dynicon/background/%s.png",
	loadType = 1
}
settings[IconType.HouseSkill] = {
	url = "ui/dynicon/house_skill/%s.png",
	loadType = 1
}
settings[IconType.HouseBuff] = {
	url = "ui/dynicon/house_buff/%s.png",
	loadType = 1
}
settings[IconType.SideIcon] = {
	url = "ui/dynicon/float_sign/%s.png",
	loadType = 1
}
settings[IconType.PlayerCard] = {
	url = "ui/dynicon/decorate/decorate_card_small/%s.png",
	loadType = 1
}
settings[IconType.PlayerCardMedium] = {
	url = "ui/dynicon/decorate/decorate_card_medium/%s.png",
	loadType = 1
}
settings[IconType.PlayerCardSpecial] = {
	url = "ui/dynicon/decorate/decorate_card/%s.png",
	loadType = 1
}
settings[IconType.PlayerCardSpecial1] = {
	url = "ui/dynicon/decorate/decorate_card1/%s.png",
	loadType = 1
}
settings[IconType.AchievementSkill] = {
	url = "ui/dynicon/playerinfo/achievement_skill/%s.png",
	loadType = 1
}
settings[IconType.Survey] = {
	url = "ui/dynicon/wekfare/survey/survey_bg_scene/%s.png",
	loadType = 1
}
settings[IconType.HandbookCG] = {
	url = "ui/dynicon/handbook/handbook_cg/%s.png",
	loadType = 1
}
settings[IconType.RoleCard] = {
	url = "ui/dynicon/role_card/%s.png",
	loadType = 1
}
settings[IconType.HouseCompile] = {
	url = "ui/dynicon/room/room_compile/%s.png",
	loadType = 1
}
settings[IconType.HouseWorkShop] = {
	url = "ui/dynicon/room/room_workshop/%s.png",
	loadType = 1
}
settings[IconType.StoryHeadIcon] = {
	url = "ui/dynicon/plot_head/%s",
	loadType = 1
}
settings[IconType.SKillHeartAnchor] = {
	url = "ui/dynicon/skill_heartanchor/%s.png",
	loadType = 1
}
settings[IconType.RoleHeadIcon] = {
	url = "ui/dynicon/role_head/%s.png",
	loadType = 1
}
settings[IconType.RoleCardIcon] = {
	url = "ui/dynicon/role_card/%s.png",
	loadType = 1
}
settings[IconType.RunGroupRoleCamp] = {
	url = "ui/dynicon/camp/camp_10/%s.png",
	loadType = 1
}
settings[IconType.CharacterHeartAnchorCarryItem] = {
	url = "ui/dynicon/heart_anchor/carry/%s.png",
	loadType = 1
}
settings[IconType.ControlActionBig] = {
	url = "ui/dynicon/regulatory_action/main_building/%s.jpg",
	loadType = 1
}
settings[IconType.ControlActionHead] = {
	url = "ui/dynicon/regulatory_action/head/%s.png",
	loadType = 1
}
settings[IconType.ControlActionMonitor] = {
	url = "ui/dynicon/regulatory_action/monitor/%s.png",
	loadType = 1
}
settings[IconType.ControlActionManual] = {
	url = "ui/dynicon/regulatory_action/manual/%s.png",
	loadType = 1
}
settings[IconType.PlayerInfoMask] = {
	url = "ui/dynicon/playerinfo/mask/%s.png",
	loadType = 1
}
settings[IconType.PlayerInfoCard] = {
	url = "ui/dynicon/playerinfo/card/%s.png",
	loadType = 1
}
settings[IconType.PlayerInfoFrame] = {
	url = "ui/dynicon/playerinfo/card_cover/%s.png",
	loadType = 1
}
settings[IconType.activityTabIcon] = {
	url = "ui/dynicon/activity/tab_icon/%s.png",
	loadType = 1
}
settings[IconType.StoreIcon] = {
	url = "ui/dynicon/store/%s.png",
	loadType = 1
}
settings[IconType.AirWorkShopTheme] = {
	url = "ui/dynicon/air_workshop/theme/%s.png",
	loadType = 1
}
settings[IconType.SkillEffectLabel] = {
	url = "ui/dynicon/skill_effect/skill_effect_label/%s.png",
	loadType = 1
}
settings[IconType.AirWorkShopTrophy] = {
	url = "ui/dynicon/air_workshop/trophy/%s.png",
	loadType = 1
}
settings[IconType.EquipDiceIcon] = {
	url = "ui/dynicon/equip_citiao/%s.png",
	loadType = 1
}
settings[IconType.RetrieveBanner] = {
	url = "ui/dynicon/retrieve/%s.png",
	loadType = 1
}
settings[IconType.PowerChallenge] = {
	url = "ui/dynicon/wekfare/power_challenge/%s.png",
	loadType = 1
}
settings[IconType.EchoCardUnpack] = {
	url = "ui/dynicon/echo_cutin/%s.png",
	loadType = 1
}
settings[IconType.EnemyHint] = {
	url = "ui/bigbg/battle/enemy/%s.png",
	loadType = 1
}
settings[IconType.DynSpriteAtlas_Battle] = {
	url = "ui/spriteatlas/battle.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Language] = {
	loadType = 2,
	url = getLanguagePath("ui/allimagetext/imagetext.spriteatlas")
}
settings[IconType.DynSpriteAtlas_LoadingMain] = {
	url = "ui/spriteatlas/loading.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_DungeonEntrance] = {
	url = "ui/spriteatlas/branchline.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Team] = {
	url = "ui/spriteatlas/team.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_CharacterDepot] = {
	url = "ui/spriteatlas/characterdepot.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_CharacterSystem] = {
	url = "ui/spriteatlas/charactersystem.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_CharacterSystem_Com] = {
	url = "ui/spriteatlas/charactersystem_com.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_CharacterSystem_Detail] = {
	url = "ui/spriteatlas/characterdetail.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_CharacterSystem_Authority] = {
	url = "ui/spriteatlas/authority.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor] = {
	url = "ui/spriteatlas/heartanchor.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_ResourcesExplore] = {
	url = "ui/spriteatlas/resources_explore.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Dungeon] = {
	url = "ui/spriteatlas/instance.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Material] = {
	url = "ui/spriteatlas/resources_explore.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Dice] = {
	url = "ui/spriteatlas/rungroup.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Room] = {
	url = "ui/spriteatlas/room.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Plot] = {
	url = "ui/spriteatlas/plot.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Backpack] = {
	url = "ui/spriteatlas/backpack.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Task] = {
	url = "ui/spriteatlas/task.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Store] = {
	url = "ui/spriteatlas/store.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Wekfare] = {
	url = "ui/spriteatlas/wekfare.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Fight] = {
	url = "ui/spriteatlas/fight.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_Season] = {
	url = "ui/spriteatlas/season.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_EquipExplore] = {
	url = "ui/spriteatlas/equip_explore.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_SecretTime] = {
	url = "ui/spriteatlas/secrettime.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_AirWorkShop] = {
	url = "ui/spriteatlas/air_workshop.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_TeachExplore] = {
	url = "ui/spriteatlas/teach_explore.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_MainView] = {
	url = "ui/spriteatlas/main.spriteatlas",
	loadType = 2
}
settings[IconType.DynSpriteAtlas_RetrieveMainView] = {
	url = "ui/spriteatlas/retrieve.spriteatlas",
	loadType = 2
}

return IconType
