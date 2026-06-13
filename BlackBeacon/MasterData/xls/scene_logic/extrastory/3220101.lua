local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
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

      NoPassCamera = 119,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 119,
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
        },
        {

          TaskGroupId = 32201,
          Type = 21,
          Timeout = 0.0
        },
        {

          PosKey = "NPC1",
          Rotation = 180,
          NPCId = 302222,
          NPCName = "酒馆老板",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC2",
          Rotation = 90,
          NPCId = 302223,
          NPCName = "大爷",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3",
          Rotation = 180,
          NPCId = 302224,
          NPCName = "建筑工人",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC4",
          Rotation = 60,
          NPCId = 302225,
          NPCName = "食客",
          Type = 0,
          Timeout = 0.0
        },
        {

          LineCount = 4,
          StateInfos = {
            {
              KeyName = "NPC1",
              IsOpen = true
            },
            {
              KeyName = "NPC2",
              IsOpen = true
            },
            {
              KeyName = "NPC3",
              IsOpen = true
            },
            {
              KeyName = "NPC4",
              IsOpen = true
            }
          },
          Type = 98,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Intensity = 0.03,
          Type = 105,
          Timeout = 0.0
        },
        {

          StartDistance = 30.0,
          Type = 123,
          Timeout = 0.0
        },
        {

          PosKey = "NPC5",
          Rotation = 180,
          NPCId = 302226,
          NPCName = "游客",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC6",
          Rotation = 127,
          NPCId = 302227,
          NPCName = "游客",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC7",
          Rotation = -130,
          NPCId = 302229,
          NPCName = "游客",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC8",
          Rotation = 20,
          NPCId = 3022210,
          NPCName = "游客",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC9",
          Rotation = -90,
          NPCId = 3022211,
          NPCName = "游客",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC10",
          Rotation = 100,
          NPCId = 3022212,
          NPCName = "游客",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC11",
          Rotation = -82,
          NPCId = 3022213,
          NPCName = "游客",
          Type = 0,
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

          StoryId = 2222201,
          Actions = {
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "NPC1",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "1",
          ValidInTower = false
        },
        {

          StoryId = 2222202,
          Actions = {
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "NPC2",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "2",
          ValidInTower = false
        },
        {

          StoryId = 2222203,
          Actions = {
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "NPC4",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "3",
          ValidInTower = false
        },
        {

          StoryId = 2222204,
          Actions = {
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "NPC3",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "4",
          ValidInTower = false
        },
        {

          StoryId = 2222205,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
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

      ConditionActions = {
        {

          NPCId = 302222,
          Actions = {
            {

              StoryId = 2222201,
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
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302223,
          Actions = {
            {

              StoryId = 2222202,
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
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302224,
          Actions = {
            {

              StoryId = 2222204,
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
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302225,
          Actions = {
            {

              StoryId = 2222203,
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
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "关闭战斗UI",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = false,
          Type = 32,
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

      ConditionActions = {
        {

          ConditionVariableList = {
            "1",
            "2",
            "3",
            "4"
          },
          Actions = {
            {

              StoryId = 2222205,
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

              TaskId = 3220101,
              Type = 5,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "PASS",
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "PASS",
      IsNotCondition = true,
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
      FinishMarkVariable = "end",
      ValidInTower = false,
      Type = 35,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      StoryID = 100222201,
      Actions = {
        {

          StoryId = 100222201,
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
        }
      },
      ValidInTower = false,
      Type = 37,
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