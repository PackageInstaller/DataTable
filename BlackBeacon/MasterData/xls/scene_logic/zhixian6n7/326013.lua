local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "scene_timeline_326012_owner",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "NPC1",
          Rotation = 90,
          NPCId = 3026201,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC2",
          Rotation = -45,
          NPCId = 3026202,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3",
          Rotation = 90,
          NPCId = 3026203,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC4",
          Rotation = 45,
          NPCId = 3026204,
          Type = 0,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_326012_NPC",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TaskId = 3260103,
          Type = 5,
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
      NoPassForceDepressCameraMode = true,
      PassCamera = 104,
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

          Key = "ask",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 2226201,
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
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2226201,
          Actions = {
            {

              CustomEventName = "replace",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "drone",
              Type = 19,
              Timeout = 0.0
            },
            {

              TaskId = 3260104,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2226205,
          Actions = {
            {

              CustomEventName = "drone",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2226204,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_326012_owner",
              IsPlay = false,
              Type = 110,
              Timeout = 0.8,
              TimeoutKey = "bhcMLbhr"
            },
            {

              TimelineName = "scene_timeline_326012_found",
              IsPlay = true,
              Type = 110,
              Timeout = 0.7,
              TimeoutKey = "UQCmVfef"
            },
            {

              NPC = "Hero",
              Point = "M2",
              Rotate = 45.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.6,
              TimeoutKey = "ZRVfLZQI"
            },
            {

              StoryId = 2226206,
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
              TimeoutKey = "NvAsPOfX"
            },
            {

              TaskId = 3260105,
              Type = 5,
              Timeout = 0.0
            },
            {

              NPCName = "阿紫开无人机",
              Type = 93,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2226206,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "M3",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.6,
              TimeoutKey = "rmEMhsAf"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.9,
              TimeoutKey = "EtNvZeqG"
            },
            {

              TimelineName = "timeline_326012_eating",
              Type = 7,
              Timeout = 0.6,
              TimeoutKey = "IvWTrfUL"
            },
            {

              TaskId = 3260106,
              Type = 5,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.6,
              TimeoutKey = "woIVNxRP"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2226207,
          Actions = {
            {

              TimelineName = "timeline_326012_drone",
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

      EventName = "drone",
      Actions = {
        {

          TimelineName = "timeline_326012_drone",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.3,
          Hold = 0.5,
          BlackOut = 0.3,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.6,
          TimeoutKey = "JpHpoTlt"
        },
        {

          FadeIn = 0.5,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
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

      EventName = "replace",
      Actions = {
        {

          PosKey = "wrong1",
          NPCName = "错误点1",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 0.5,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638640875013350138,
          IsRemove = true,
          CustomEventName = "talk1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "wrong2",
          NPCName = "错误点2",
          NpcParams = {
            InteractionArea = 1.5,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 2.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638640875029843156,
          IsRemove = true,
          CustomEventName = "talk2",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "correct",
          NPCName = "正确点",
          NpcParams = {
            InteractionArea = 2.5,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638640875034535212,
          IsRemove = true,
          CustomEventName = "rightTalk",
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

      EventName = "interest1open",
      Actions = {
        {

          PosKey = "wrong1",
          NPCName = "错误的光1",
          NpcParams = {
            InteractionArea = -1.0,
            UseEffect = "Fx_LockEnemy_326|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638640924509182356,
          IsRemove = false,
          Type = 92,
          Timeout = 1.0,
          TimeoutKey = "qVsrfDUa"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "pick1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "interest2open",
      Actions = {
        {

          PosKey = "wrong2",
          NPCName = "错误的光2",
          NpcParams = {
            InteractionArea = -1.0,
            UseEffect = "Fx_LockEnemy_326|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638640927398126340,
          IsRemove = false,
          Type = 92,
          Timeout = 2.0,
          TimeoutKey = "YHaYwuvf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "pick2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "interest3open",
      Actions = {
        {

          PosKey = "correctLight",
          NPCName = "正确的光",
          NpcParams = {
            InteractionArea = -1.0,
            UseEffect = "Fx_LockEnemy_326|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638640927463131102,
          IsRemove = false,
          Type = 92,
          Timeout = 2.5,
          TimeoutKey = "ozvviCQN"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "pick3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "aziopen",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "阿紫开无人机",
          NpcParams = {
            InteractionArea = 1.5,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638830099843657696,
          IsRemove = true,
          CustomEventName = "scan",
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

      EventName = "talk1",
      Actions = {
        {

          StoryId = 2226202,
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
      FinishMarkVariable = "pick1",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "talk2",
      Actions = {
        {

          StoryId = 2226203,
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
      FinishMarkVariable = "pick2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "rightTalk",
      Actions = {
        {

          StoryId = 2226204,
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
      FinishMarkVariable = "pick3",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "scan",
      Actions = {
        {

          StoryId = 2226205,
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

      ConditionActions = {
        {

          TimelineName = "timeline_326012_drone",
          Actions = {
            {

              NPCName = "错误的光1",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "错误的光2",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "正确的光",
              Type = 93,
              Timeout = 0.0
            },
            {

              CustomEventName = "aziopen",
              Type = 19,
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

          StoryId = 2226206,
          StepId = 4,
          Actions = {
            {

              TimelineName = "timeline_326012_eating",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
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

              TimelineName = "scene_timeline_326012_NPC",
              IsPlay = false,
              Type = 110,
              Timeout = 0.6,
              TimeoutKey = "mpHgPVdP"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.6,
              TimeoutKey = "sDgroKxa"
            },
            {

              TimelineName = "scene_timeline_326012_found",
              IsPlay = false,
              Type = 110,
              Timeout = 0.8,
              TimeoutKey = "voDxSbOx"
            },
            {

              NPCId = 3026201,
              Type = 1,
              Timeout = 0.6,
              TimeoutKey = "rBiessgZ"
            },
            {

              NPCId = 3026202,
              Type = 1,
              Timeout = 0.6,
              TimeoutKey = "LjotdeGf"
            },
            {

              NPCId = 3026203,
              Type = 1,
              Timeout = 0.6,
              TimeoutKey = "rgVxHjcZ"
            },
            {

              NPCId = 3026204,
              Type = 1,
              Timeout = 0.6,
              TimeoutKey = "tRJaqwaV"
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

          TimelineName = "timeline_326012_drone",
          Actions = {
            {

              CustomEventName = "interest1open",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "interest2open",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "interest3open",
              Type = 19,
              Timeout = 0.0
            },
            {

              StoryId = 2226207,
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
              Timeout = 5.0,
              TimeoutKey = "UsgGRuzK"
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
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