local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 8,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 10230301,
                param = 2,
                Name = "剩余",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 10230302,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "enemydead",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        },
        {

          ResId = 20111401,
          PosKey = "M15",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 100,
          NPCName = "萨尔维斯",
          AutoSave = false,
          Type = 2,
          Timeout = 0.0
        },
        {

          GroupId = 10230301,
          Type = 27,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level_3/塔3-空气墙3",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosZ",
          SyncValType = 1,
          Value = 0.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosY",
          SyncValType = 1,
          Value = -9.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosX",
          SyncValType = 1,
          Value = 189.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
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

          IsSkip = true,
          Type = 36,
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

      ConditionActions = {
        {

          Key = "gate",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 1021401,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {

              NPC = "萨尔维斯",
              Point = "M16",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.7,
              TimeoutKey = "1"
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "quit",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 100102142,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = true,
              Type = 10,
              Timeout = 1.0,
              TimeoutKey = "2"
            },
            {

              TaskId = 102303,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "item1",
              IsOpen = false,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              Type = 69,
              Timeout = 1.0,
              TimeoutKey = "CdTCxraB"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "enemydead1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "high",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "high",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 1021401,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 12,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 10230304,
                    param = 1,
                    Name = "剩余",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10230305,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "repeat",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              StoryId = 2021405,
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
              Timeout = 1.0,
              TimeoutKey = "b"
            },
            {

              ResId = 10230101,
              PosKey = "CD1",
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Rotation = 0,
              Camp = 4,
              Level = 99,
              NPCName = "gate",
              AutoSave = false,
              Type = 2,
              Timeout = 0.0
            },
            {

              PosKey = "M13",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              Key = "201114_xuli",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "201114_ArriveDestination",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Tips = "1008",
              Duration = 5.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            },
            {

              Key = "DOOROPEN",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2021405,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 100102142,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2021404,
          Actions = {
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "enemydead",
      Actions = {
        {

          StoryId = 2021403,
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

          Key = "201114_TargetPosX",
          SyncValType = 1,
          Value = 228.0077,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosY",
          SyncValType = 1,
          Value = -10.00989,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosZ",
          SyncValType = 1,
          Value = -0.07041506,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          KeyName = "M16",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          Group = 10230301,
          Type = 65,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "enemydead1",
      ValidInTower = true,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "repeat",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 6,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10230305,
                param = 1,
                Name = "全部杀死",
                CustomEventName = "repeat",
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
      ConditionVariable = "DOOROPEN",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2021404,
          StepId = 0,
          Actions = {
            {

              KeyName = "item1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 100102142,
          StepId = 0,
          Actions = {
            {

              Group = 10230304,
              Type = 65,
              Timeout = 0.5,
              TimeoutKey = "quGUdUXl"
            },
            {

              Group = 10230305,
              Type = 65,
              Timeout = 0.5,
              TimeoutKey = "WkxmQTaj"
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 100102142,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 26,
    MonsterInfo = {
      [ 20103001 ] = 5,
      [ 20102801 ] = 10,
      [ 20102701 ] = 11
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}