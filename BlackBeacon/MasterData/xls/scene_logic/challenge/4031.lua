local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "on",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0,
          TimeoutKey = "NmnbBdtL"
        },
        {

          Enable = true,
          Type = 120,
          Timeout = 0.0
        },
        {

          Type = 49,
          Timeout = 0.0
        },
        {

          CustomEventName = "start",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "NeOhFvhb"
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Tips = "962",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 1.0,
          TimeoutKey = "KSpTBcgd"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Key = "cancel_born_skill",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m1",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031001,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m3",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m2",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031002,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m4",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m3",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031003,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m6",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m4",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031004,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m7",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m5",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031005,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m1",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "start",
      Actions = {
        {

          Type = 48,
          Timeout = 0.0
        },
        {

          CustomEventName = "chong1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m0",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m6",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031006,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m8",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m7",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031007,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m5",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "chong2",
      Actions = {
        {

          GroupId = 403102,
          Type = 27,
          Timeout = 0.0
        },
        {

          CustomEventName = "chong1",
          Type = 19,
          Timeout = 15.0,
          TimeoutKey = "kkTcPUFY"
        },
        {

          Group = 403101,
          Type = 65,
          Timeout = 0.0
        },
        {

          Tips = "963",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 13.0,
          TimeoutKey = "cTBpTwLz"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "chong1",
      Actions = {
        {

          GroupId = 403101,
          Type = 27,
          Timeout = 0.0
        },
        {

          CustomEventName = "chong2",
          Type = 19,
          Timeout = 15.0,
          TimeoutKey = "kPJSotsr"
        },
        {

          Group = 403102,
          Type = 65,
          Timeout = 0.0
        },
        {

          Tips = "963",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 13.0,
          TimeoutKey = "xQwZhwuy"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          Key = "on",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Group = 403101,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403102,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031002,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031005,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031007,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031008,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4031009,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m8",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031008,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m0",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 4,
            MonsterCount = 32,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4031009,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 4031009,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 4031009,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 4031009,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Target = "Hero",
          MagicId = 399933,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 2.0,
          TimeoutKey = "JWpZSLNW"
        }
      },
      ValidInTower = false,
      Type = 35,
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
  MonsterCountInfo = {
    EventCount = 9,
    MonsterCount = 40,
    MonsterInfo = {
      [ 20104301 ] = 10,
      [ 20104501 ] = 15,
      [ 20104401 ] = 10,
      [ 20204301 ] = 5
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}