-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/const/GameplayEntranceConfig.lua

module("logic.extensions.dungeon.view.entrance.const.GameplayEntranceConfig", package.seeall)

PeriodicityActivity = {
	{
		TaskText = "tip_climb_tower_bright_side",
		BgSpriteName = "wfjh_img_0004_01",
		NameText = "tip_climb_tower_activity_name",
		SystemEnum = GameEnum.SystemEnum.ClimbTowerActivity,
		ViewName = ViewName.ClimbingTowerEntryView
	},
	{
		TaskText = "tip_r_task_weekly",
		BgSpriteName = "wfjh_img_0004_02",
		NameText = "tip_roguelike_activity_name",
		SystemEnum = GameEnum.SystemEnum.RunGroupActivity,
		ViewName = ViewName.RogueFirstEntrance
	},
	{
		TaskText = "tip_left_num_s",
		BgSpriteName = "wfjh_img_0004_03",
		NameText = "管制行动",
		SystemEnum = GameEnum.SystemEnum.ControlAction,
		ViewName = ViewName.ControlActionLogin
	}
}

local const = require("logic.extensions.dungeon.view.entrance.const.GameplayEntranceEnum")
local activity = const.RecommendActivity

RecommendActivity = {
	Mainline = {
		SystemEnum = GameEnum.SystemEnum.MainLine,
		ViewName = ViewName.MainlineDungeonView
	},
	EquipFightActivity = {
		SystemEnum = GameEnum.SystemEnum.EquipFightActivity,
		ViewName = ViewName.RedMistEntryView
	},
	AirWorkShop = {
		SystemEnum = GameEnum.SystemEnum.PvpFightActivity,
		ViewName = ViewName.AirWorkShopMainView
	}
}
ChallengeActivity = {
	{
		SystemEnum = GameEnum.SystemEnum.ClimbTowerActivity,
		ViewName = ViewName.ClimbingTowerEntryView
	},
	{
		SystemEnum = GameEnum.SystemEnum.PvpFightActivity,
		ViewName = ViewName.AirWorkShopMainView
	},
	{
		SystemEnum = GameEnum.SystemEnum.RunGroupActivity,
		ViewName = ViewName.RogueFirstEntrance
	},
	{
		SystemEnum = GameEnum.SystemEnum.TeachFightActivity,
		ViewName = ViewName.TeachingChapter
	}
}
ResourceActivity = {
	{
		SystemEnum = GameEnum.SystemEnum.EquipFightActivity,
		ViewName = ViewName.RedMistEntryView
	},
	{
		SystemEnum = GameEnum.SystemEnum.MatFightActivity,
		ViewName = ViewName.StableAreaEntryView
	}
}
