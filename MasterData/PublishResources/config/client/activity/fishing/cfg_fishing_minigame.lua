local key = {
  ID = 1,
  BaseFishScore = 2,
  BaseScoreMult = 3,
  FishingSuccessAddScoreMult = 4,
  OrderFinishAddScoreMult = 5,
  SkillNeedCount = 6,
  SkillTime = 7,
  SkillClickInterval = 8,
  SkillFishSpeedMult = 9,
  SkillFishingAniMult = 10,
  SkillSupplyIntervalMult = 11,
  JudgeRangeMult = 12,
  FishingNetModelScaleMult = 13,
  CatchedFishDisappearTime = 14,
  PoolEmptyRefreshFishTime = 15,
  CatchedFishNetRestTime = 16,
  NotCatchedFishNetResetTime = 17,
  NetDefaultRotateAngle = 18,
  FishNetBrokenTime = 19,
  FishNetOffset = 20
}
local config = {
  {
    1,
    100,
    1,
    0.01,
    0.03,
    25,
    10,
    1,
    2,
    1.2,
    3,
    1,
    5,
    0.5,
    0,
    0.5,
    0.3,
    330,
    3,
    {50, 50}
  }
}
return config, "ID", key
