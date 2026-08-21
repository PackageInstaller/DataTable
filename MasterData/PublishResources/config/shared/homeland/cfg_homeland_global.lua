local key = {
  ID = 1,
  StrValue = 2,
  IntValue = 3,
  FloatValue = 4,
  ArrayValue = 5,
  TableValue = 6
}
local config = {
  FishBiteHookInterval = {
    "FishBiteHookInterval",
    nil,
    10
  },
  FishBiteHookInterval1 = {
    "FishBiteHookInterval1"
  },
  FishBiteHookInterval2 = {
    "FishBiteHookInterval2"
  },
  FishBiteHookInterval3 = {
    "FishBiteHookInterval3"
  },
  GoodsMaxRefreshCount = {
    "GoodsMaxRefreshCount",
    nil,
    3
  },
  GoodsRefreshItemId = {
    "GoodsRefreshItemId",
    nil,
    3000252
  },
  GoodsAddRefreshCountTime = {
    "GoodsAddRefreshCountTime",
    nil,
    28800
  },
  GoodsRefreshMin = {
    "GoodsRefreshMin",
    nil,
    5
  },
  GoodsRefreshMax = {
    "GoodsRefreshMax",
    nil,
    5
  },
  TreasureRandomContent = {
    "TreasureRandomContent",
    nil,
    2000001
  },
  TreasureCountLimit = {
    "TreasureCountLimit",
    nil,
    3
  },
  TreasureMaxRefreshCount = {
    "TreasureMaxRefreshCount",
    nil,
    2
  },
  TreasureRefreshItemId = {
    "TreasureRefreshItemId",
    nil,
    5000002
  },
  TreasureAddRefreshCountTime = {
    "TreasureAddRefreshCountTime",
    nil,
    201600
  },
  TreasureLifeTime = {
    "TreasureLifeTime",
    nil,
    604800
  },
  TreasureDetectedRange = {
    "TreasureDetectedRange",
    nil,
    nil,
    30
  },
  TreasureInteractRange = {
    "TreasureInteractRange",
    nil,
    nil,
    0.4
  },
  TreasureOccupyRange = {
    "TreasureOccupyRange",
    nil,
    nil,
    2
  },
  TreasureBoardRange = {
    "TreasureBoardRange",
    nil,
    nil,
    1.5
  },
  TreasurePetRange = {
    "TreasurePetRange",
    nil,
    nil,
    1.5
  },
  TreasureBoardBubblePrefabID = {
    "TreasureBoardBubblePrefabID",
    nil,
    4020001
  },
  TreasureBoardPrefab = {
    "TreasureBoardPrefab",
    "hl_collect_mupai.prefab"
  },
  StoryTaskMaxInitCount = {
    "StoryTaskMaxInitCount",
    nil,
    2
  },
  StoryTaskMaxRefreshCount = {
    "StoryTaskMaxRefreshCount",
    nil,
    2
  },
  StoryTaskRefreshItemId = {
    "StoryTaskRefreshItemId",
    nil,
    3000258
  },
  StoryTaskAddRefreshCountTime = {
    "StoryTaskAddRefreshCountTime",
    nil,
    604800
  },
  StoryTaskMenuTime = {
    "StoryTaskMenuTime",
    "2022-04-21 04:00:00",
    0
  },
  DormitoryRoomPetCount = {
    "DormitoryRoomPetCount",
    nil,
    4
  },
  DailyTriggerEventLimitTimes = {
    "DailyTriggerEventLimitTimes",
    nil,
    2
  },
  SceneLimitEvents = {
    "SceneLimitEvents",
    nil,
    2
  },
  EnterSceneTriggerNum = {
    "EnterSceneTriggerNum",
    nil,
    1
  },
  SecretMsgMaxCount = {
    "SecretMsgMaxCount",
    nil,
    4
  },
  FishingPostionRandomID = {
    "FishingPostionRandomID",
    nil,
    999995000
  },
  WishingPoolMaxFishNum = {
    "WishingPoolMaxFishNum",
    nil,
    20
  },
  StoryPointAreaR = {
    "StoryPointAreaR",
    nil,
    5
  },
  StoryStandDistance = {
    "StoryStandDistance",
    nil,
    3
  },
  StoryCameraMoveTime = {
    "StoryCameraMoveTime",
    nil,
    700
  },
  StoryPetRotateTime = {
    "StoryPetRotateTime",
    nil,
    600
  },
  StoryCameraAngleMin = {
    "StoryCameraAngleMin",
    nil,
    35
  },
  StoryCameraAngleMax = {
    "StoryCameraAngleMax",
    nil,
    145
  },
  StoryCameraOverAngleX = {
    "StoryCameraOverAngleX",
    nil,
    5
  },
  StoryCameraEnterAngleX = {
    "StoryCameraEnterAngleX",
    nil,
    10
  },
  StoryCameraEnterZ = {
    "StoryCameraEnterZ",
    nil,
    nil,
    -5.5
  },
  StoryCameraFocusOffsetY = {
    "StoryCameraFocusOffsetY",
    nil,
    nil,
    -0.4
  },
  SignAccumulativeMaxDay = {
    "SignAccumulativeMaxDay",
    nil,
    5
  },
  VisitGetItemMax = {
    "VisitGetItemMax",
    nil,
    10
  },
  VisitForgeMax = {
    "VisitForgeMax",
    nil,
    10
  },
  VisitCultivationMax = {
    "VisitCultivationMax",
    nil,
    60
  },
  SignGiftId = {
    "SignGiftId",
    nil,
    3410101
  },
  SignAccumulativeMaxItemCount = {
    "SignAccumulativeMaxItemCount",
    nil,
    30000
  },
  HasHideChatBubbleId = {
    "HasHideChatBubbleId",
    nil,
    4010009
  },
  MaxBuildNum = {
    "MaxBuildNum",
    nil,
    10000
  },
  GuideFishingResult = {
    "GuideFishingResult",
    nil,
    5510008
  },
  FishTankMaxFishNum = {
    "FishTankMaxFishNum",
    nil,
    20
  },
  StateChangeLuckyValueA = {
    "StateChangeLuckyValueA",
    nil,
    1
  },
  StateChangeLuckyValueB = {
    "StateChangeLuckyValueB",
    nil,
    0
  },
  StateChangeLuckyValueC = {
    "StateChangeLuckyValueC",
    nil,
    8
  },
  RareFishingFishingChatID = {
    "RareFishingFishingChatID",
    nil,
    14152
  },
  RareFishingLimitChatID = {
    "RareFishingLimitChatID",
    nil,
    14153
  },
  PetInvinteRange = {
    "PetInvinteRange",
    nil,
    60
  },
  PetInvinteCD = {
    "PetInvinteCD",
    nil,
    60
  }
}
return config, "ID", key
