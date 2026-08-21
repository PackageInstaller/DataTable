require("test_robot_running_mode")
local registry = {
  [TestRobotRunningMode.Mission] = {
    RunDataClassName = "TestRobotElementalMissionRunData",
    TestCaseLuaName = "stc_elemental_mission_test"
  },
  [TestRobotRunningMode.ExtraMission] = {
    RunDataClassName = "ElementalExtraMissionRunData",
    TestCaseLuaName = "stc_elemental_extra_mission_test"
  },
  [TestRobotRunningMode.Maze] = {
    RunDataClassName = "TestRobotElementalMazeRunData",
    TestCaseLuaName = "stc_itp_maze",
    InitTotalProgressProvider = "Progress_GetMazeInitTotalProgress"
  },
  [TestRobotRunningMode.Tower] = {
    RunDataClassName = "ElementalTowerRunData",
    TestCaseLuaName = "stc_elemental_tower"
  },
  [TestRobotRunningMode.ResDungeon] = {
    RunDataClassName = "ElementalResDungeonRunData",
    TestCaseLuaName = "stc_elemental_res_dungeon"
  },
  [TestRobotRunningMode.GoldbergEvent] = {
    RunDataClassName = "ElementalGoldbergEventRunData",
    TestCaseLuaName = "stc_elemental_goldberg"
  },
  [TestRobotRunningMode.SummerII] = {
    RunDataClassName = "ElementalSummerIIEventRunData",
    TestCaseLuaName = "stc_goldberg_summer_ii"
  },
  [TestRobotRunningMode.BlackFist] = {
    RunDataClassName = "TestRobotBlackFistRunData",
    TestCaseLuaName = "stc_black_fist"
  },
  [TestRobotRunningMode.WorldBoss] = {
    RunDataClassName = "ElementalWorldBossRunData",
    TestCaseLuaName = "stc_world_boss"
  },
  [TestRobotRunningMode.Cartridge] = {
    RunDataClassName = "TestRobotElementalCartridgeRunData",
    TestCaseLuaName = "stc_aircraft_cartridge"
  },
  [TestRobotRunningMode.Tale] = {
    RunDataClassName = "SmokeTestRunData_Tale",
    TestCaseLuaName = "stc_tale"
  },
  [TestRobotRunningMode.DifficultyMission] = {
    RunDataClassName = "DifficultyMissionRunData",
    TestCaseLuaName = "stc_difficulty_mission"
  },
  [TestRobotRunningMode.SailingMission] = {
    RunDataClassName = "SailingMissionRunData",
    TestCaseLuaName = "stc_sailing_mission"
  },
  [TestRobotRunningMode.MiniMaze] = {
    RunDataClassName = "ElementalGoldbergEventRunData",
    TestCaseLuaName = "stc_mini_maze"
  },
  [TestRobotRunningMode.ActivityDifficultyMission] = {
    RunDataClassName = "DifficultyMissionRunData",
    TestCaseLuaName = "stc_activity_difficulty_mission"
  },
  [TestRobotRunningMode.ActivityDifficultyMissionN29] = {
    RunDataClassName = "DifficultyMissionRunData",
    TestCaseLuaName = "stc_activity_difficulty_mission_n29"
  },
  [TestRobotRunningMode.ActivityDifficultyMissionN31] = {
    RunDataClassName = "DifficultyMissionRunData",
    TestCaseLuaName = "stc_activity_difficulty_mission_n31"
  },
  [TestRobotRunningMode.ActivityDifficultyMissionN32] = {
    RunDataClassName = "DifficultyMissionRunData",
    TestCaseLuaName = "stc_activity_difficulty_mission_n32"
  },
  [TestRobotRunningMode.Season] = {
    RunDataClassName = "ElementalSeasonRunData",
    TestCaseLuaName = "stc_elemental_season"
  },
  [TestRobotRunningMode.EightPets] = {
    RunDataClassName = "ElementalEightPetsRunData",
    TestCaseLuaName = "stc_elemental_eight_pets"
  },
  [TestRobotRunningMode.CCAffix] = {
    RunDataClassName = "CCAffixRunData",
    TestCaseLuaName = "stc_cc_affix"
  },
  [TestRobotRunningMode.ActivityDifficultyMissionCN6] = {
    RunDataClassName = "DifficultyMissionRunData",
    TestCaseLuaName = "stc_activity_difficulty_mission_cn6"
  },
  [TestRobotRunningMode.PopStarPro] = {
    RunDataClassName = "ElementalGoldbergEventRunData",
    TestCaseLuaName = "stc_pop_star_pro"
  },
  [TestRobotRunningMode.AniPopStar] = {
    RunDataClassName = "TestRobotElementalAniPopStarRunData",
    TestCaseLuaName = "stc_ani_pop_star",
    InitTotalProgressProvider = "Progress_GetAniPopStarInitTotalProgress"
  },
  [TestRobotRunningMode.TalentCampaign] = {
    RunDataClassName = "ElementalGoldbergEventRunData",
    TestCaseLuaName = "stc_talent_campaign"
  },
  [TestRobotRunningMode.SeasonMaze] = {
    RunDataClassName = "ElementalSeasonMazeRunData",
    TestCaseLuaName = "stc_elemental_season_maze"
  }
}
return registry
