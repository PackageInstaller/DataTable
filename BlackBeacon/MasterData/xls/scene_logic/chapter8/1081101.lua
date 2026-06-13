return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "interact1",
          NPCName = "CtZRzMOh",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638772053087387719,
          IsRemove = true,
          CustomEventName = "半成品1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "interact2",
          NPCName = "lCvbeSCZ",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638772053090403971,
          IsRemove = true,
          CustomEventName = "半成品2",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "interact3",
          NPCName = "kEgNVghO",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638772053093726748,
          IsRemove = true,
          CustomEventName = "半成品3",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "interact5",
          NPCName = "NROgDLwI",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638772053098435438,
          IsRemove = true,
          CustomEventName = "萨尔维斯的遗书",
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

      NoPassCamera = 1,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 1,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
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

          Target = "God",
          MagicId = 1081101,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          TaskGroupId = 10811,
          Type = 21,
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

      EventName = "半成品1",
      Actions = {
        {

          StoryId = 4081401,
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

          CondId = 10811012,
          CondValue = 1,
          Type = 31,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "interact1",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "半成品2",
      Actions = {
        {

          StoryId = 4081402,
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

          CondId = 10811013,
          CondValue = 1,
          Type = 31,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "interact2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "半成品3",
      Actions = {
        {

          StoryId = 4081403,
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

          CondId = 10811011,
          CondValue = 1,
          Type = 31,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "interact3",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "萨尔维斯的遗书",
      Actions = {
        {

          StoryId = 4081406,
          EnableBlackFade = false,
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
          Timeout = 0.0
        },
        {

          Tips = "暂定将这个剧情配置未战后剧情了",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          TaskId = 1081103,
          Type = 5,
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

      EventName = "首次触发开关",
      Actions = {
        {

          TimelineName = "timeline_1081101_puzzletips",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.5,
          Hold = 0.5,
          BlackOut = 0.5,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.5,
          BeforeHold = 0.5,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "hero",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.75,
          TimeoutKey = "uKDBQCHJ"
        },
        {

          StoryId = 4081405,
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
          Timeout = 1.5,
          TimeoutKey = "ERSkynhP"
        },
        {

          Path = "/Root/Level/10811/Door/scene_timeline_1081101_doorShake",
          PlatCount = 0,
          Type = 96,
          Timeout = 2.0,
          TimeoutKey = "XRFGeIEn"
        },
        {

          ObjName = "/Root/Level/10811/Door/scene_timeline_1081101_doorShake/FX_door_dust_1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 2.25,
          TimeoutKey = "nMcxyjPJ"
        },
        {

          PosKey = "interact4",
          NPCName = "acwvFpQy",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.0
          },
          Rotation = 0,
          NpcId = 638773853264440016,
          IsRemove = true,
          CustomEventName = "触发开关",
          Type = 92,
          Timeout = 0.75,
          TimeoutKey = "tZAfPAGb"
        },
        {

          PosKey = "cam",
          Rotation = 0,
          NPCId = 1081101,
          NPCName = "相机",
          Type = 0,
          Timeout = 0.75,
          TimeoutKey = "QMWKOdzW"
        },
        {

          PosKey = "cam_mod",
          Rotation = 90,
          NPCId = 1089999,
          NPCName = "相机模型",
          Type = 0,
          Timeout = 0.75,
          TimeoutKey = "TinBUMhM"
        },
        {

          StoryId = 5081402,
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
          Timeout = 120.0,
          TimeoutKey = "delay_tips1"
        },
        {

          TipsId = 1081101,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 1.0,
          TimeoutKey = "NlaiXsOn"
        },
        {

          ObjName = "/Root/Change_/Change_Night/Zone_12/Prop_12/sc08_prop_73_06_pre0/Fx_SculptureHint2_weak",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Night/Zone_12/Prop_12/sc08_prop_73_06_pre1/Fx_SculptureHint2_weak",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Night/Zone_12/Prop_12/sc08_prop_73_06_pre2/Fx_SculptureHint2_weak",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      EventName = "触发开关",
      Actions = {
        {

          CustomEventName = "机关不动",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "机关门打开",
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

      EventName = "机关不动",
      Actions = {
        {

          Path = "/Root/Level/10811/Door/scene_timeline_1081101_doorShake",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Tips = "1080",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          PosKey = "interact4",
          NPCName = "aAQyeuYv",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.0
          },
          Rotation = 0,
          NpcId = 638776505017702404,
          IsRemove = true,
          CustomEventName = "触发开关",
          Type = 92,
          Timeout = 1.5,
          TimeoutKey = "jihrtvEm"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "door_ready",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "机关门打开",
      Actions = {
        {

          Path = "/Root/Level/10811/Door/scene_timeline_1081101_doorOpen",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Tips = "981",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          Key = "delay_tips1",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "delay_tips2",
          Type = 52,
          Timeout = 0.0
        },
        {

          TaskId = 1081102,
          Type = 5,
          Timeout = 0.0
        },
        {

          TipsId = 1081101,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 1.0,
          TimeoutKey = "UStnKBVI"
        },
        {

          ObjName = "/Root/Level/10811/Switch/T3001041B/T3001041_Pieces",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10811/Switch/T3001041B/T3001041_2/MP",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "door_ready",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "interact1",
            "interact2",
            "interact3"
          },
          Actions = {
            {

              StoryId = 4081404,
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
          FinishMarkVariable = "analysis",
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "analysis",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4081404,
          Actions = {
            {

              PosKey = "interact4",
              NPCName = "CxuSQuKa",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638772059595936720,
              IsRemove = true,
              CustomEventName = "首次触发开关",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "interact4",
              IsOpen = true,
              CameraStyle = 0,
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

              StoryId = 5081401,
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
              TimeoutKey = "AZBdmwIL"
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

          TaskId = 1081101,
          Actions = {
            {

              KeyName = "interact4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TaskId = 1081102,
          Actions = {
            {

              KeyName = "interact4",
              IsOpen = false,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 14,
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
      StoryId = 4081406,
      Name = "6.剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}