local empty = {}
return {
  Events = {
    {
      ConditionActions = {
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              Type = 59,
              Timeout = 0.0
            },
            {
              TreasureChestId = 10632,
              PosKey = "LB1",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "BOXEND10632",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "hrPkHLay"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              Type = 59,
              Timeout = 0.0
            },
            {
              TreasureChestId = 10633,
              PosKey = "LB1",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "BOXEND10633",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "IXFrEwEt"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              PosKey = "LB1",
              Rotation = 0,
              NPCId = 106041,
              NPCName = "1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "YMCnbFrz"
            },
            {
              NPCId = 106041,
              NPCName = "1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "EdJMlTiB"
            }
          },
          ValidInTower = false
        }
      },
      Type = 22,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterLockEnemyCount = 0,
    MonsterGroupId = 0,
    MonsterWave = 0,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true
  },
  FinishiConditionDict = empty,
  mDefaultStartTime = true,
  mDefaultEndTime = true
}
