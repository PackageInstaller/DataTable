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
              NPCId = 300606,
              NPCName = "书架3",
              Type = 1,
              Timeout = 0.0
            },
            {
              StoryId = 2206103,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              Type = 10,
              Timeout = 0.0
            },
            {
              NPCId = 300604,
              NPCName = "书架1",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300605,
              NPCName = "书架2",
              Type = 1,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = empty,
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = empty,
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
    SendWave = false,
    WaveStyle = 0
  },
  FinishiConditionDict = empty
}
