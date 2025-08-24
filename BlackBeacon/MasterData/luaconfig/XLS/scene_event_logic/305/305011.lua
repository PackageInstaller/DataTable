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
              TipsId = 3050201,
              Visible = false,
              Type = 15,
              Timeout = 0.0
            },
            {
              StoryId = 2205111,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {
              NPCId = 305021,
              Type = 1,
              Timeout = 0.0
            },
            {
              Variable = "M5",
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 30,
              Timeout = 0.0
            },
            {
              CondId = 3051041,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {
              Variable = "M4ED",
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 29,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = true,
          Actions = {
            {
              StoryId = 3205104,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {
              NPCId = 305021,
              Type = 1,
              Timeout = 0.0
            },
            {
              PosKey = "M2",
              Rotation = 0,
              NPCId = 305021,
              NPCName = "M5",
              Type = 0,
              Timeout = 0.1,
              TimeoutKey = "841216"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = true,
          Actions = {
            {
              StoryId = 3205104,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {
              NPCId = 305021,
              Type = 1,
              Timeout = 0.0
            },
            {
              PosKey = "M2",
              Rotation = 0,
              NPCId = 305021,
              NPCName = "M5",
              Type = 0,
              Timeout = 0.1,
              TimeoutKey = "48641548"
            }
          },
          ValidInTower = false
        }
      },
      Type = 22,
      ConditionVariable = "",
      IsNotCondition = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterGroupId = 0,
    MonsterWave = 0,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true
  },
  FinishiConditionDict = empty
}
