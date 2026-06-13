local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Level/10801",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          TimelineName = "timeline_1081303_puzzletips",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = true,
          BlackIn = 0.5,
          Hold = 1.0,
          BlackOut = 0.5,
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

          StoryId = 4081703,
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
          Timeout = 2.0,
          TimeoutKey = "wxZqUaXj"
        },
        {

          PosKey = "interact",
          NPCName = "pkXQjKxx",
          NpcParams = {
            InteractionArea = 1.75,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.0
          },
          Rotation = 0,
          NpcId = 638782604756148030,
          IsRemove = true,
          CustomEventName = "触发开关",
          Type = 92,
          Timeout = 0.0,
          TimeoutKey = "jlBBNTuc"
        },
        {

          PosKey = "camera",
          Rotation = 0,
          NPCId = 1081303,
          NPCName = "相机",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "camera_mod",
          Rotation = 180,
          NPCId = 1089999,
          NPCName = "相机模型",
          Type = 0,
          Timeout = 0.0
        },
        {

          StoryId = 5081706,
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
          MagicId = 1081302,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          TaskId = 1081303,
          Type = 5,
          Timeout = 0.0
        },
        {

          TipsId = 1081101,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 1.0,
          TimeoutKey = "vIvIipza"
        },
        {

          ObjName = "/Root/Scene/Zone_08/Prop_08/sc08_prop_73_08_pre2/Fx_SculptureHint3_weak",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_08/Prop_08/sc08_prop_73_08_pre3/Fx_SculptureHint3_weak",
          Visible = true,
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

      ConditionActions = {
        {

          StoryId = 4081703,
          Actions = {
            {

              TimelineName = "timeline_1081303_puzzletips",
              Type = 7,
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

      EventName = "触发开关",
      Actions = {
        {

          CustomEventName = "机关不动",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "机关打开",
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

          Tips = "1080",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          PosKey = "interact",
          NPCName = "ZTMcFPiq",
          NpcParams = {
            InteractionArea = 1.75,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.0
          },
          Rotation = 0,
          NpcId = 638782608980422880,
          IsRemove = true,
          CustomEventName = "触发开关",
          Type = 92,
          Timeout = 1.5,
          TimeoutKey = "iKzmwLGL"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "finalPuzzle2_ready",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "机关打开",
      Actions = {
        {

          Tips = "982",
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

          TimelineName = "timeline_1081303_finalpuzzletips",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.5,
          Hold = 1.0,
          BlackOut = 0.5,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.5,
          BeforeHold = 1.0,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          Visible = false,
          Type = 142,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/10813/scene_timeline_1081301_finalPuzzle2",
          PlatCount = 0,
          Type = 96,
          Timeout = 2.5,
          TimeoutKey = "vbgQnQbt"
        },
        {

          StoryId = 5081705,
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
          Timeout = 3.5,
          TimeoutKey = "DrKmETUi"
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.0,
          TimeoutKey = "xsHWiELD"
        },
        {

          TaskId = 1081304,
          Type = 5,
          Timeout = 0.0
        },
        {

          TipsId = 1081101,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10813/Switch2/T3001041B/T3001041_Pieces",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10813/Switch2/T3001041B/T3001041_2/MP",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "finalPuzzle2_ready",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Direction = 2,
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