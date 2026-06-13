local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "M1_1",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 3.0
          },
          Rotation = 0,
          NpcId = 638447199953545245,
          IsRemove = true,
          CustomEventName = "M1_1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "M2_1",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 3.0
          },
          Rotation = 0,
          NpcId = 638474057575896398,
          IsRemove = true,
          CustomEventName = "M2_1",
          Type = 92,
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

      NoPassCamera = 107070,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 107070,
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

          Enable = true,
          Type = 17,
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

          Key = "D1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Plat701_/tl_701",
              PlatCount = 1,
              PlatList = {
                "Plat701"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Camera = 107070,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Plat701_/GameObject",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Plat701_/GameObject (1)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Plat701_/GameObject (1)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 30.0,
              TimeoutKey = "RpaWbBOS"
            },
            {

              StoryId = 10707011,
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
              TimeoutKey = "ilfFVzhA"
            },
            {

              ObjName = "Level/Plat701_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Plat701_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate",
              IsAutoSave = false,
              Type = 53,
              Timeout = 1.0,
              TimeoutKey = "FzjkpnOP"
            }
          },
          ValidInTower = false
        },
        {

          Key = "D2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1070701,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "D3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 107070,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "D4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 10707011,
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

          Key = "CAM1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 10707011,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
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
          ValidInTower = false
        },
        {

          Key = "CAM2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 10707011,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "M4",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
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

          Key = "CAM1",
          Actions = {
            {

              Camera = 1070701,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "CAM2",
          Actions = {
            {

              Camera = 1070701,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 12,
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

      EventName = "M1_1",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "M1_2",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481818454953985,
          IsRemove = true,
          CustomEventName = "M1_2",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "ZmJXOqFF"
        },
        {

          Path = "Level/sc06_prop_84_pre (1)/X1",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Key = "1",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "M2_1",
      Actions = {
        {

          PosKey = "M2",
          NPCName = "M2_2",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481818691681876,
          IsRemove = true,
          CustomEventName = "M2_2",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "nLlBmZoX"
        },
        {

          Path = "Level/sc06_prop_84_pre/X1",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Key = "2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "M1_2",
      Actions = {
        {

          Path = "Level/sc06_prop_84_pre (1)/X2",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "M1_3",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481832537552361,
          IsRemove = true,
          CustomEventName = "M1_3",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "PCQsvavc"
        },
        {

          Key = "1",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "M2_2",
      Actions = {
        {

          Path = "Level/sc06_prop_84_pre/X2",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "M2_3",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481832552407656,
          IsRemove = true,
          CustomEventName = "M2_3",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "ERSovUJg"
        },
        {

          Key = "2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "M1_3",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "M1_4",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481833253927260,
          IsRemove = true,
          CustomEventName = "M1_4",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "SpTTtOOD"
        },
        {

          Path = "Level/sc06_prop_84_pre (1)/X3",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Key = "1",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "1",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "M2_3",
      Actions = {
        {

          PosKey = "M2",
          NPCName = "M2_4",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481833272938198,
          IsRemove = true,
          CustomEventName = "M2_4",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "nqKEwvdS"
        },
        {

          Path = "Level/sc06_prop_84_pre/X3",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Key = "2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "M1_4",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "TRrvvBKK",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481834609290609,
          IsRemove = true,
          CustomEventName = "M1_1",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "RbWPMBUv"
        },
        {

          Path = "Level/sc06_prop_84_pre (1)/X4",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Key = "1",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "M2_4",
      Actions = {
        {

          PosKey = "M2",
          NPCName = "UVAeDgCY",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638481834888758774,
          IsRemove = true,
          CustomEventName = "M2_1",
          Type = 92,
          Timeout = 3.0,
          TimeoutKey = "CndvaiHb"
        },
        {

          Path = "Level/sc06_prop_84_pre/X4",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Key = "2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "666",
      Actions = {
        {

          TimelineName = "tl_1070701",
          Fadein = 1.0,
          Fadeout = 1.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          Path = "Level/tl703/X7",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "JFEcIJSm"
        },
        {

          Path = "Level/tl704/X8",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "aPFmbCNJ"
        },
        {

          Path = "Level/sc06_prop_84_pre (1)/1",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/sc06_prop_84_pre/1",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Tips = "作者通道",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
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
            "2"
          },
          Actions = {
            {

              Path = "Level/sc06_prop_84_pre/1",
              PlatCount = 0,
              Type = 96,
              Timeout = 3.0,
              TimeoutKey = "OmriHsYZ"
            },
            {

              Path = "Level/sc06_prop_84_pre (1)/1",
              PlatCount = 0,
              Type = 96,
              Timeout = 3.0,
              TimeoutKey = "SKSuOjeE"
            },
            {

              TimelineName = "tl_1070701",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 3.0,
              TimeoutKey = "kypPBKht"
            },
            {

              Path = "Level/tl703/X7",
              PlatCount = 0,
              Type = 96,
              Timeout = 4.0,
              TimeoutKey = "drSipUYW"
            },
            {

              Path = "Level/tl704/X8",
              PlatCount = 0,
              Type = 96,
              Timeout = 4.0,
              TimeoutKey = "FMubmIkR"
            }
          },
          FinishMarkVariable = "end1",
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "end1",
      IsNotCondition = true,
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