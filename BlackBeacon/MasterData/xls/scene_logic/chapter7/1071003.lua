local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ResId = 10210107,
          PosKey = "battery1",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "battery1",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210107,
          PosKey = "battery2",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "battery2",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          GroupId = 107100301,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "interact1",
          NPCName = "dVAoovJc",
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
          NpcId = 638582959432721247,
          IsRemove = true,
          CustomEventName = "开关1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "interact2",
          NPCName = "idRlhZll",
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
          NpcId = 638582960989687080,
          IsRemove = true,
          CustomEventName = "开关2",
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

      NoPassCamera = 1070900,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1070900,
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
        },
        {

          KeyName = "tp3",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

          Key = "cam0",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1070900,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area09/sc06_area_digong_09_pre/sc06_area_digong_09_m2_mod/sc06_area_digong_09_m2_02",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          Key = "victory",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TipsId = 107100101,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
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

          Key = "tips",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 5071604,
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
              Timeout = 0.0,
              TimeoutKey = "nOeUuMUo"
            },
            {

              TaskId = 1071002,
              Type = 5,
              Timeout = 0.0,
              TimeoutKey = "CbMldVWI"
            },
            {

              TipsId = 107100101,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0,
              TimeoutKey = "OUssjEBC"
            },
            {

              Direction = 3,
              Type = 51,
              Timeout = 1.5,
              TimeoutKey = "SJDvnTCf"
            },
            {

              PosKey = "focus0",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.5,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 1.5,
              TimeoutKey = "GOJwZdls"
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 4.0,
              TimeoutKey = "CIgAYDSJ"
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

          Key = "cam0",
          Actions = {
            {

              Camera = 1071003,
              IsNewConfig = true,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area09/sc06_area_digong_09_pre/sc06_area_digong_09_m2_mod/sc06_area_digong_09_m2_02",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          TaskId = 1071003,
          Type = 5,
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

      EventName = "旋转平台",
      Actions = {
        {

          CustomEventName = "旋转平台5",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "旋转平台6",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "旋转平台7",
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

      EventName = "旋转平台5",
      Actions = {
        {

          Path = "/Root/Level/5/5_plat",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "frozen1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "旋转平台6",
      Actions = {
        {

          Path = "/Root/Level/6/6_plat",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
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

      EventName = "旋转平台7",
      Actions = {
        {

          Path = "/Root/Level/7/7_plat",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "frozen2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "开关1",
      Actions = {
        {

          PosKey = "focus1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 5.0,
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

          Camera = 107100301,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          CustomEventName = "旋转平台",
          Type = 19,
          Timeout = 0.0
        },
        {

          Type = 60,
          Timeout = 5.0,
          TimeoutKey = "NngtGmYE"
        },
        {

          Camera = 1071003,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 5.0,
          TimeoutKey = "uArvwWnp"
        },
        {

          PosKey = "interact1",
          NPCName = "rmspwHcI",
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
          NpcId = 638582971089297497,
          IsRemove = true,
          CustomEventName = "开关1",
          Type = 92,
          Timeout = 5.0,
          TimeoutKey = "fxpZLnIj"
        },
        {

          Path = "/Root/Change_/Change_ Complete/area09/prop/sc06_prop_73_pre (1)/tl_work",
          PlatCount = 0,
          Type = 96,
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

      EventName = "开关2",
      Actions = {
        {

          PosKey = "focus2",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 5.0,
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

          Type = 61,
          Timeout = 0.0
        },
        {

          CustomEventName = "旋转平台",
          Type = 19,
          Timeout = 0.0
        },
        {

          Camera = 107100302,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        },
        {

          Type = 60,
          Timeout = 5.0,
          TimeoutKey = "WZIBIdsG"
        },
        {

          PosKey = "interact2",
          NPCName = "KFRuNYQH",
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
          NpcId = 638582971172801126,
          IsRemove = true,
          CustomEventName = "开关2",
          Type = 92,
          Timeout = 5.0,
          TimeoutKey = "QWTzKTxV"
        },
        {

          Camera = 1071003,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 5.0,
          TimeoutKey = "iImnoBrn"
        },
        {

          Path = "/Root/Change_/Change_ Complete/area09/prop/sc06_prop_73_pre (3)/tl_work",
          PlatCount = 0,
          Type = 96,
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

          NPCName = "battery1",
          HitType = 1,
          Actions = {
            {

              Key = "frozen1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area09/prop/sc06_prop_70_pre/battery_on/FX_qinghua_stop2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/5/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/5/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/5/sc06_build_51b_pre (2)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "battery1",
          HitType = 2,
          Actions = {
            {

              Key = "frozen1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area09/prop/sc06_prop_70_pre/battery_on/FX_qinghua_stop2",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/5/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/5/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/5/sc06_build_51b_pre (2)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "battery2",
          HitType = 1,
          Actions = {
            {

              Key = "frozen2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area09/prop/sc06_prop_70_pre (1)/battery_on/FX_qinghua_stop2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/7/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/7/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/7/sc06_build_51b_pre (2)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "battery2",
          HitType = 2,
          Actions = {
            {

              Key = "frozen2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area09/prop/sc06_prop_70_pre (1)/battery_on/FX_qinghua_stop2",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/7/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/7/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/7/sc06_build_51b_pre (2)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 19,
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