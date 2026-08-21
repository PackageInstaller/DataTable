local key = {
  ID = 1,
  PageClass = 2,
  PagePrefab = 3,
  DataClass = 4,
  LoadDataTimes = 5,
  SingleClass = 6,
  SinglePrefab = 7
}
local common = {
  "UIActivityDataLoader_Campaign",
  "UIPetForecastDataLoader",
  "UIN33EightPetsContent",
  "UIN33EightPetsContent.prefab",
  "UISpecialTask",
  "UISpecialTaskV3",
  "UILuckLandEntry",
  "UILuckLandEntry.prefab",
  "UIActivityDataLoader_None",
  "UICommonLineMissionMain",
  "UISeasonMazeEnter"
}
local config = {
  BetweenTheChapters = {
    "BetweenTheChapters",
    "UIActivityBetweenTheChaptersContent",
    "UIActivityBetweenTheChaptersContent.prefab",
    common[1]
  },
  DoubleDrop = {
    "DoubleDrop",
    "UIActivityDoubleDropContent",
    "UIActivityDoubleDropContent.prefab",
    common[1]
  },
  DanTang = {
    "DanTang",
    "UICampaignCenterDanTang",
    "UICampaignCenterDanTang.prefab",
    common[1]
  },
  CrazyLogin = {
    "CrazyLogin",
    "UIActivityCrazyLoginContent",
    "UIActivityCrazyLoginContent.prefab",
    common[1]
  },
  CrazyLoginV2 = {
    "CrazyLoginV2",
    "UICrazyLoginV2Content",
    "UICrazyLoginV2Content.prefab",
    common[1]
  },
  PetTry = {
    "PetTry",
    "UIActivityPetTryContent",
    "UIActivityPetTryContent.prefab",
    common[1]
  },
  PetTryPlus = {
    "PetTryPlus",
    "UIActivityPetTryPlusContent",
    "UIActivityPetTryPlusContent.prefab",
    common[1]
  },
  DanTangPre = {
    "DanTangPre",
    "UICampaignCenterDanTangPre",
    "UICampaignCenterDanTangPre.prefab",
    common[1]
  },
  PetForecast = {
    "PetForecast",
    "UIPetForecastContent",
    "UIPetForecastContent.prefab",
    common[2]
  },
  PetForecast2 = {
    "PetForecast2",
    "UIPetForecast2Content",
    "UIPetForecast2Content.prefab",
    common[2]
  },
  PetForecastNew = {
    "PetForecastNew",
    "UIPetForecastNew",
    "UIPetForecastNew.prefab",
    common[2]
  },
  ReturnSystem = {
    "ReturnSystem",
    "UIActivityReturnSystemMainContent",
    "UIActivityReturnSystemMainContent.prefab",
    common[1]
  },
  TempSignIn = {
    "TempSignIn",
    "UITempSignInContent",
    "UITempSignInContent.prefab",
    "UITempSignInDataLoader"
  },
  WorldBossMulti = {
    "WorldBossMulti",
    "UIWorldBossMulti",
    "UIWorldBossMulti.prefab",
    "UIActivityDataLoaderEmpty"
  },
  SecondAnniversary = {
    "SecondAnniversary",
    "UIN31SecondAnniversaryContent",
    "UIN31SecondAnniversaryContent.prefab",
    common[1]
  },
  Training = {
    "Training",
    "UIN30Training",
    "UIN30Training.prefab",
    common[1]
  },
  BlackBox = {
    "BlackBox",
    "UIActivityBlackBoxMainContent",
    "UIActivityBlackBoxMainContent.prefab",
    common[1]
  },
  PopStar = {
    "PopStar",
    "UIPopStarMainController",
    "UIPopStarMainController.prefab",
    common[1]
  },
  SummonGift = {
    "SummonGift",
    "UIActivitySummonGiftController",
    "UIActivitySummonGiftController.prefab",
    "UIActivitySummonGiftSideDataLoader"
  },
  ActiveTask = {
    "ActiveTask",
    "UIActiveTaskMainContent",
    "UIActiveTaskMainContent.prefab",
    common[1]
  },
  N33EightPets = {
    "N33EightPets",
    common[3],
    common[4],
    common[1]
  },
  TimeLogin = {
    "TimeLogin",
    "UIActivityTimeLoginContent",
    "UIActivityTimeLoginContent.prefab",
    common[1]
  },
  TimeLoginV2 = {
    "TimeLoginV2",
    "UITimeLoginV2Content",
    "UITimeLoginV2Content.prefab",
    common[1]
  },
  UISpecialTask = {
    common[5],
    common[5],
    "UISpecialTask.prefab",
    common[1]
  },
  FavourPet = {
    "FavourPet",
    "UIFavourPetVote",
    "UIFavourPet_Vote.prefab",
    common[1]
  },
  FavourPet2 = {
    "FavourPet2",
    "UIFavourPetVote2",
    "UIFavourPet_Vote2.prefab",
    common[1]
  },
  FavourPet3 = {
    "FavourPet3",
    "UIFavourPetVote3",
    "UIFavourPet_Vote3.prefab",
    common[1]
  },
  UISpecialTaskV2_S3 = {
    "UISpecialTaskV2_S3",
    "UISpecialTaskV2",
    "UISpecialTaskV2_S3.prefab",
    common[1]
  },
  UISpecialTaskV3 = {
    common[6],
    common[6],
    "UISpecialTaskV3.prefab",
    common[1]
  },
  SouthSeaN9 = {
    "SouthSeaN9",
    "UICN16N45SeaNoteEnter",
    "UICN16N45SeaNoteEnter.prefab",
    common[1]
  },
  ShareSkin = {
    "ShareSkin",
    "UIShareSkin",
    "UIShareSkin.prefab",
    common[1]
  },
  N39EightPets = {
    "N39EightPets",
    common[3],
    common[4],
    common[1]
  },
  LuckLand = {
    "LuckLand",
    common[7],
    common[8],
    common[1]
  },
  EliminateWorldBoss = {
    "EliminateWorldBoss",
    "UIEliminateWorldBossContent",
    "UIEliminateWorldBossContent.prefab",
    common[9]
  },
  NewYearDinner = {
    "NewYearDinner",
    "UIActivityN0Cook",
    "UIActivityN0Cook.prefab",
    common[1]
  },
  CollectCard = {
    "CollectCard",
    "UICollectCardContent",
    "UICollectCardContent.prefab",
    common[1],
    1
  },
  NewYearLuckBag = {
    "NewYearLuckBag",
    "UIActivityNewYearLuckBagContent",
    "UIActivityNewYearLuckBagContent.prefab",
    common[1]
  },
  JumpMiniGame = {
    "JumpMiniGame",
    "UIActivityN28Entry",
    "UIActivityN28Entry.prefab",
    common[1]
  },
  MessengerGame = {
    "MessengerGame",
    "UIN27MiniGameController",
    "UIN27MiniGameController.prefab",
    common[1]
  },
  EventTrailer_CN13 = {
    "EventTrailer_CN13",
    "UIEventTrailerContent",
    "UIEventTrailerContent.prefab",
    common[9]
  },
  WeekTower = {
    "WeekTower",
    "UIWeekTowerController",
    "UIWeekTowerController.prefab",
    common[1]
  },
  FrogMiniGame = {
    "FrogMiniGame",
    "UICN14N43FrogEntry",
    "UICN14N43FrogEntry.prefab",
    common[1]
  },
  StoryCopy = {
    "StoryCopy",
    common[10],
    "UICommonLineMissionMainN23.prefab",
    common[1]
  },
  VigorousReward = {
    "VigorousReward",
    "UIVigorousRewardController",
    "UIVigorousRewardController.prefab",
    common[9]
  },
  SendPet = {
    "SendPet",
    "UISendPetContent",
    "UISendPetContent.prefab",
    common[1]
  },
  Alice = {
    "Alice",
    "UIActivityAlice",
    "UIActivityAlice.prefab",
    common[1]
  },
  FishingGame = {
    "FishingGame",
    "UICN17N46FishingGameEntry",
    "UICN17N46FishingGameEntry.prefab",
    common[1]
  },
  PerfectPuzzle = {
    "PerfectPuzzle",
    "UIActivityCN13PerfectPuzzleEntryController",
    "UIActivityCN13PerfectPuzzleEntryController.prefab",
    common[1]
  },
  N4CrisisContract = {
    "N4CrisisContract",
    "UIActivityN4CC",
    "UIActivityN4CC.prefab",
    common[1]
  },
  UISeasonMazeEnter = {
    common[11],
    common[11],
    "UISeasonMazeEnter.prefab",
    common[1]
  },
  StoryCopyN22 = {
    "StoryCopyN22",
    common[10],
    "UICommonLineMissionMainN22.prefab",
    common[1]
  },
  LuckLandNew = {
    "LuckLandNew",
    common[7],
    common[8],
    common[1]
  }
}
return config, "ID", key
