local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 115,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 115,
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupId = 32801301,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 32801302,
          Type = 27,
          Timeout = 0.0
        },
        {

          CustomEventName = "创建守卫1A",
          Type = 19,
          Timeout = 0.0
        },
        {

          Key = "moveTrigger",
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Change_/Change_Dark/Prop",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      Actions = {
        {

          Key = "hasBeenFound",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Type = 46,
          Timeout = 0.0
        },
        {

          StoryId = 2228102,
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
          Timeout = 0.1,
          TimeoutKey = "fwOLConC"
        },
        {

          Target = "1_32801302_0",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "hasBeenFound",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "hasArrived",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Group = 32801302,
          Type = 65,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          TaskId = 3280101,
          Type = 5,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "hasArrived",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "needReturn",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          PosKey = "Q1",
          Rotation = 180,
          NPCId = 3028101,
          NPCName = "钓鱼佬气泡",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "G1",
          NPCName = "守卫1B",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 6.0
          },
          Rotation = 0,
          NpcId = 638676982491626408,
          IsRemove = true,
          CustomEventName = "交谈2",
          Type = 92,
          Timeout = 0.0
        },
        {

          NPCId = 3028101,
          NPCName = "钓鱼佬气泡",
          Type = 1,
          Timeout = 2.0,
          TimeoutKey = "PldYKLwv"
        },
        {

          Target = "1_32801302_0",
          MagicId = 3000003,
          Level = 0,
          Type = 16,
          Timeout = 2.5,
          TimeoutKey = "BoSYaiPk"
        },
        {

          PosKey = "Q1",
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
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "needReturn",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2228102,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.1,
              TimeoutKey = "EJPtYSBi"
            },
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = -90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "nPvNvNtZ"
            },
            {

              Target = "1_32801301_0",
              MagicId = 3000002,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "uRqRpOyY"
            },
            {

              Target = "1_32801301_1",
              MagicId = 3000002,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "dyQSpKRT"
            },
            {

              Target = "1_32801302_0",
              MagicId = 3000002,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "nZIpFyRP"
            },
            {

              NPCName = "守卫1A",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "守卫1B",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "守卫2",
              Type = 93,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 2.0,
              TimeoutKey = "QLAuADgZ"
            },
            {

              CustomEventName = "创建守卫1A",
              Type = 19,
              Timeout = 2.0,
              TimeoutKey = "iWRxDfJR"
            },
            {

              Group = 32801302,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "ruTEXTCX"
            },
            {

              GroupId = 32801302,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "oeXPauNJ"
            },
            {

              Target = "1_32801301_0",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "DTqGvtXl"
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

          StoryId = 2228104,
          Actions = {
            {

              Key = "moveTrigger",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
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

          StoryId = 2228204,
          Actions = {
            {

              Target = "1_32801301_0",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
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

          StoryId = 2228205,
          Actions = {
            {

              Target = "1_32801301_0",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
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

      EventName = "交谈1",
      Actions = {
        {

          Target = "1_32801301_0",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          StoryId = 2228204,
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "交谈2",
      Actions = {
        {

          Target = "1_32801301_0",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.2,
          TimeoutKey = "oujCAZCO"
        },
        {

          Type = 14,
          Timeout = 0.2,
          TimeoutKey = "iupLErwG"
        },
        {

          Type = 60,
          Timeout = 5.0,
          TimeoutKey = "nkCBFbsl"
        },
        {

          StoryId = 2228205,
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "交谈3",
      Actions = {
        {

          Target = "1_32801301_1",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          StoryId = 2228205,
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "创建守卫1A",
      Actions = {
        {

          PosKey = "G1",
          NPCName = "守卫1A",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 5.0
          },
          Rotation = 0,
          NpcId = 638677156956693598,
          IsRemove = true,
          CustomEventName = "交谈1",
          Type = 92,
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

      EventName = "创建守卫2",
      Actions = {
        {

          PosKey = "G2",
          NPCName = "守卫2",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 5.0
          },
          Rotation = 0,
          NpcId = 638677160042218519,
          IsRemove = true,
          CustomEventName = "交谈3",
          Type = 92,
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

      Actions = {
        {

          Direction = 3,
          Type = 51,
          Timeout = 0.0
        },
        {

          Point = "tp3",
          Type = 3,
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