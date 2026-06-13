local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "tl_10706032",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          StoryId = 5071302,
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
          Timeout = 5.0,
          TimeoutKey = "dyMoYDQI"
        },
        {

          PosKey = "M1",
          Rotation = 10,
          NPCId = 107060301,
          NPCName = "M1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = -20,
          NPCId = 107060302,
          NPCName = "M2",
          Type = 0,
          Timeout = 0.0
        },
        {

          TaskId = 107603,
          Type = 5,
          Timeout = 0.0
        },
        {

          LineCount = 2,
          StateInfos = {
            {
              KeyName = "M1",
              IsOpen = true
            },
            {
              KeyName = "M2",
              IsOpen = true
            }
          },
          Type = 98,
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

      NoPassCamera = 1070603,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1070601,
      PassCameraIsNewConfig = true,
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

          CustomEventName = "PREBOX10707",
          Type = 19,
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

          Key = "CAM1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1070601,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
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

          NPCId = 107060301,
          Actions = {
            {

              StoryId = 4071302,
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

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "M1",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "M1",
          ValidInTower = false
        },
        {

          NPCId = 107060302,
          Actions = {
            {

              StoryId = 4071303,
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

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "M2",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "M2",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 107071,
          Actions = {
            {

              PosKey = "BOXSTORY",
              NPCName = "rllDikNK",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = true,
                LongPressTime = 3.0,
                LongPressStop = false,
                LongPressPause = true,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638785188080240582,
              IsRemove = true,
              CustomEventName = "BOX10707",
              Type = 92,
              Timeout = 0.0
            },
            {

              StoryId = 6071301,
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

      Actions = {
        {

          Direction = 1,
          Type = 51,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "tl_10706031",
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "M1",
            "M2"
          },
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              TaskId = 107604,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "tp1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Level_01/sc06_house_06a_pre (1)/scene_timeline_opendoor",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              PosKey = "tp1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 3.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "1",
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10707CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10707",
          IsAutoSave = false,
          Type = 53,
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

      EventName = "GBOX10707OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10707",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10707",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "PREBOX10707",
      Actions = {
        {

          PosKey = "BOXSTORY",
          Rotation = 0,
          NPCId = 107071,
          NPCName = "奥尔加",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10707",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOX10707",
      Actions = {
        {

          TreasureChestId = 10707,
          PosKey = "BOX1",
          Rotation = 180,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10707",
          Type = 124,
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

      EventName = "BOXEND10707",
      Actions = {
        {

          Variable = "10707",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10707CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10707OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "SHOWBOX",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10707CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
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