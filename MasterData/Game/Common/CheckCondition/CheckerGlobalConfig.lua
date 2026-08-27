local CheckerTypeId = {
  PlayerLevel = 1,
  CompleteTask = 2,
  CompleteStage = 3,
  BuildingLevel = 4,
  FunctionUnlock = 5,
  FrienshipLevel = 6,
  CompleteDungeon = 7,
  CompleteAvg = 8,
  MinHeroStar = 9,
  MaxHeroStar = 10,
  InfinityDungeon = 11,
  TimeRange = 12,
  PlayerLevelUpLimit = 13,
  UserChannel = 14,
  StOCareerLevelLimit = 16,
  CharDungeonConsume = 18,
  DungeonTowerUnlock = 19,
  ActivityOpen = 21,
  ActivityTechBranchLevel = 22,
  ActivityLevel = 23,
  HeroPotential = 24,
  HeroLevel = 25,
  ActivityTask = 26,
  SectorStagePassTm = 27,
  WarChessSeasonPassDiff = 28,
  SkinVoice = 29,
  IsActOpening = 30,
  LastLoginBefore = 32,
  WarChessSeasonPassDiffInterval = 33,
  TimeRangeOffset = 34,
  BuyExplorationFund = 35,
  SectorUnlock = 36,
  ActLevelPass4Diff = 37,
  ActCardTypeUseNum = 38,
  ActCardTotalUseNum = 39,
  ActivitySlider = 40,
  ActCardNormalRound = 41,
  ActivityGeneralNormal = 42,
  StageChallengeComplete = 43,
  Carnival24UnLockStage = 44,
  ActDSStage = 45
}
local CheckerExtra = {}
CheckerExtra.CheckerActivityType = {
  [CheckerTypeId.ActivityOpen] = true,
  [CheckerTypeId.ActivityTechBranchLevel] = true,
  [CheckerTypeId.ActivityLevel] = true,
  [CheckerTypeId.ActivitySlider] = true,
  [CheckerTypeId.ActivityGeneralNormal] = true,
  [CheckerTypeId.Carnival24UnLockStage] = true
}

function CheckerExtra.IsHasActivityChecker(checkerTypes)
  if checkerTypes == nil then
    return false
  end
  for _, checkerType in ipairs(checkerTypes) do
    if CheckerExtra.CheckerActivityType[checkerType] then
      return true
    end
  end
  return false
end

local CheckerGlobalConfig = {
  [CheckerTypeId.PlayerLevel] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerPlayLevel")
  },
  [CheckerTypeId.CompleteTask] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerTask")
  },
  [CheckerTypeId.CompleteStage] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerSectorStage")
  },
  [CheckerTypeId.BuildingLevel] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerBuilding")
  },
  [CheckerTypeId.FunctionUnlock] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerFuncUnlock")
  },
  [CheckerTypeId.FrienshipLevel] = {
    Checker = require("Game.Common.CheckCondition.Checker.CherkerFriendshipLevel")
  },
  [CheckerTypeId.CompleteDungeon] = {
    Checker = require("Game.Common.CheckCondition.Checker.CherkerGeneralDungeon")
  },
  [CheckerTypeId.CompleteAvg] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckAvg")
  },
  [CheckerTypeId.MinHeroStar] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckMinHeroStar")
  },
  [CheckerTypeId.MaxHeroStar] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckMaxHeroStar")
  },
  [CheckerTypeId.InfinityDungeon] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerInfinityDungeon")
  },
  [CheckerTypeId.TimeRange] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerTimeRange")
  },
  [CheckerTypeId.TimeRangeOffset] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerTimeRangeOffset")
  },
  [CheckerTypeId.PlayerLevelUpLimit] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerPlayerLevelUpLimit")
  },
  [CheckerTypeId.UserChannel] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerUserChannel")
  },
  [CheckerTypeId.StOCareerLevelLimit] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerStOCareerLevel")
  },
  [CheckerTypeId.CharDungeonConsume] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerCharDungeonConsume")
  },
  [CheckerTypeId.DungeonTowerUnlock] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerDungeonTower")
  },
  [CheckerTypeId.ActivityOpen] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActivity")
  },
  [CheckerTypeId.ActivityTechBranchLevel] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActivityTechBranchLevel")
  },
  [CheckerTypeId.ActivityLevel] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActivityLevel")
  },
  [CheckerTypeId.HeroPotential] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerHeroPotential")
  },
  [CheckerTypeId.HeroLevel] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerHeroLevel")
  },
  [CheckerTypeId.ActivityTask] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActivityTask")
  },
  [CheckerTypeId.SectorStagePassTm] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckSectorStagePassTm")
  },
  [CheckerTypeId.SkinVoice] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckSkinVoice")
  },
  [CheckerTypeId.IsActOpening] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckIsActOpen")
  },
  [CheckerTypeId.WarChessSeasonPassDiff] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckWarChessSeasonPassDiff")
  },
  [CheckerTypeId.LastLoginBefore] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerLastLoginBefore")
  },
  [CheckerTypeId.WarChessSeasonPassDiffInterval] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerWarChessSeasonPassDiffInterval")
  },
  [CheckerTypeId.BuyExplorationFund] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerBuyExplorationFund")
  },
  [CheckerTypeId.ActLevelPass4Diff] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActLevelPass4Diff")
  },
  [CheckerTypeId.ActCardTypeUseNum] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActCardTypeUseNum")
  },
  [CheckerTypeId.ActCardNormalRound] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActCardSetNormalRound")
  },
  [CheckerTypeId.ActCardTotalUseNum] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActCardTotalUseNum")
  },
  [CheckerTypeId.SectorUnlock] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerSectorUnlock")
  },
  [CheckerTypeId.ActivitySlider] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActivitySlider")
  },
  [CheckerTypeId.ActivityGeneralNormal] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerActivityGeneralNormal")
  },
  [CheckerTypeId.StageChallengeComplete] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerStageChallengeComplete")
  },
  [CheckerTypeId.Carnival24UnLockStage] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckerCarnival24UnLockStage")
  },
  [CheckerTypeId.ActDSStage] = {
    Checker = require("Game.Common.CheckCondition.Checker.CheckDSStage")
  }
}
local ChckerCfg = {
  CheckerTypeId,
  CheckerGlobalConfig,
  CheckerExtra
}
return ChckerCfg
