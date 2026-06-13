local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ResId = 10210107,
          PosKey = "battery",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "battery",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          GroupId = 107100101,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "interact",
          NPCName = "dOqQOusi",
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
          NpcId = 638581484412416300,
          IsRemove = true,
          CustomEventName = "旋转平台",
          Type = 92,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_chapter7_common",
          Type = 76,
          Timeout = 0.0
        },
        {

          BUSName = "HallReverb",
          BUSLevel = 1.0,
          Type = 127,
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

      Actions = {
        {

          TimelineName = "timeline_107100101",
          Fadein = 0.0,
          Fadeout = 2.0,
          IsCanSkip = true,
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

          StoryId = 5071601,
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

          TaskGroupId = 10710,
          Type = 21,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 1070903,
          Level = 1,
          Type = 16,
          Timeout = 0.75,
          TimeoutKey = "qnKFFQJE"
        },
        {

          Target = "God",
          MagicId = 1070904,
          Level = 1,
          Type = 16,
          Timeout = 0.75,
          TimeoutKey = "WpbZFUYF"
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

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1071001,
              IsNewConfig = true,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "focus",
              IsOpen = true,
              CameraStyle = 1,
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

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 5071602,
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
              TimeoutKey = "swLuydWF"
            },
            {

              TipsId = 107100101,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "first",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "first",
      IsNotCondition = true,
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

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              TipsId = 107100101,
              Visible = false,
              Flip = false,
              Type = 15,
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

          Key = "cam1",
          Actions = {
            {

              Camera = 1070900,
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

      EventName = "旋转平台 冻结",
      Actions = {
        {

          Path = "/GroupCtrlObj/tl_703",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "frozen",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "旋转平台 未冻结",
      Actions = {
        {

          Path = "/GroupCtrlObj/tl_703",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/GroupCtrlObj/tl_704",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "frozen",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "旋转平台",
      Actions = {
        {

          CustomEventName = "旋转平台 未冻结",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "旋转平台 冻结",
          Type = 19,
          Timeout = 0.0
        },
        {

          PosKey = "interact",
          NPCName = "sLDNuiGo",
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
          NpcId = 638582090721204985,
          IsRemove = true,
          CustomEventName = "旋转平台",
          Type = 92,
          Timeout = 5.0,
          TimeoutKey = "VAezLVJJ"
        },
        {

          Path = "/Root/Change_/Change_ Complete/area08/prop/sc06_prop_73_pre (2)/tl_work",
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

          TimelineName = "timeline_107100101",
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
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "battery",
          HitType = 1,
          Actions = {
            {

              Key = "frozen",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area08/prop/sc06_prop_70_pre/battery_on/FX_qinghua_stop2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/2/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/2/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
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

          NPCName = "battery",
          HitType = 2,
          Actions = {
            {

              Key = "frozen",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area08/prop/sc06_prop_70_pre/battery_on/FX_qinghua_stop2",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/2/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/2/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
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