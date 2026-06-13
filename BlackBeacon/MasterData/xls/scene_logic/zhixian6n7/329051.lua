local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 180,
          NPCId = 3029351,
          NPCName = "伞店",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 150,
          NPCId = 3029352,
          NPCName = "老头",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M5",
          Rotation = 180,
          NPCId = 3029515,
          NPCName = "老头孙子",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          Rotation = 90,
          NPCId = 3029353,
          NPCName = "情侣1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M7",
          Rotation = 60,
          NPCId = 3029354,
          NPCName = "情侣2气泡",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M4",
          Rotation = 60,
          NPCId = 3029355,
          NPCName = "情侣2",
          Type = 0,
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

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
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

          StoryId = 2229701,
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

          GroupID = 1,
          Type = 86,
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

          StoryId = 2229702,
          Actions = {
            {

              CondId = 32905012,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "talk1",
          ValidInTower = false
        },
        {

          StoryId = 2229703,
          Actions = {
            {

              CondId = 32905013,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "talk2",
          ValidInTower = false
        },
        {

          StoryId = 2229704,
          Actions = {
            {

              CondId = 32905011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "talk3",
          ValidInTower = false
        },
        {

          StoryId = 2229705,
          Actions = {
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              FadeIn = 0.3,
              Hold = 1.0,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.5,
              TimeoutKey = "oywqYwFo"
            },
            {

              NPC = "Hero",
              Point = "M6",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "tYawUXlX"
            }
          },
          FinishMarkVariable = "talk4",
          ValidInTower = false
        },
        {

          StoryId = 2229701,
          Actions = {
            {

              TaskGroupId = 32905,
              Type = 21,
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

          NPCId = 3029351,
          Actions = {
            {

              StoryId = 2229702,
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
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          NPCId = 3029352,
          Actions = {
            {

              StoryId = 2229703,
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
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          NPCId = 3029353,
          Actions = {
            {

              StoryId = 2229704,
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

              NPCId = 3029354,
              NPCName = "情侣2气泡",
              Type = 1,
              Timeout = 0.01,
              TimeoutKey = "pIJUJUJY"
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "story",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          StoryId = 2229705,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = true,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          Camera = 113,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0,
          TimeoutKey = "IHRowPqF"
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

          StoryId = 2229705,
          StepId = 2,
          Actions = {
            {

              PosKey = "tp4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = -1.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 1,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TaskId = 3290501,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 1.5,
              TimeoutKey = "RofVmoqg"
            },
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 2.0,
              TimeoutKey = "dMdbKOmU"
            },
            {

              CustomEventName = "story",
              Type = 19,
              Timeout = 2.3,
              TimeoutKey = "YVqFoJKK"
            }
          },
          ValidInTower = false
        }
      },
      Type = 14,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "talk1",
            "talk2",
            "talk3"
          },
          Actions = {
            {

              TaskId = 3290501,
              Type = 5,
              Timeout = 0.5,
              TimeoutKey = "tlTBiWRI"
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "talk4",
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}