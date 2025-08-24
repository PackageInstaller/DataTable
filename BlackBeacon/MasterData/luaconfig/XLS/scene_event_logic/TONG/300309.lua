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
              NPCId = 300305,
              NPCName = "shujia2",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300309,
              NPCName = "shujia5",
              Type = 1,
              Timeout = 0.0
            },
            {
              RefreshCfg = {
                Weight = 100,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 3002,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0
                  }
                }
              },
              Type = 8,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              PosKey = "M3",
              Rotation = 0,
              NPCId = 300305,
              NPCName = "shujia2",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "svuKypRV"
            }
          },
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
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0
  },
  FinishiConditionDict = empty,
  MonsterCountInfo = {EventCount = 1, MonsterCount = 3}
}
