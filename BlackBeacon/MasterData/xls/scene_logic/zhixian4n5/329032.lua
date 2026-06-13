return
{
  Events = {
    {

      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          KeyName = "M2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill8",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          Enable = false,
          Type = 17,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 3290301,
          Type = 103,
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

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
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

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_32903_pareja",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "情侣",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638683366571988240,
          IsRemove = true,
          CustomEventName = "sos",
          Type = 92,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/6/L7_/A2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/4/L5_/A4",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright",
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

      ConditionActions = {
        {

          StoryId = 2229407,
          Actions = {
            {

              TimelineName = "timeline_32903_xinFall",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = true,
              DelayDestroy = false,
              BeforeBlackIn = 0.3,
              BeforeHold = 0.5,
              BeforeBlackOut = 0.3,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              HeroId = 1001024,
              Type = 29,
              Timeout = 0.4,
              TimeoutKey = "cXlFCygy"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.5,
              TimeoutKey = "TgXaspdR"
            },
            {

              TimelineName = "scene_timeline_32903_pareja",
              IsPlay = false,
              Type = 110,
              Timeout = 0.6,
              TimeoutKey = "ATdrSSXz"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229408,
          Actions = {
            {

              PosKey = "M3",
              NPCName = "薪",
              NpcParams = {
                InteractionArea = 2.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638683946382908892,
              IsRemove = true,
              CustomEventName = "finalTalk",
              Type = 92,
              Timeout = 0.0
            },
            {

              TaskId = 3290304,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "M3",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229412,
          Actions = {
            {

              PosKey = "M2",
              NPCName = "catCmr",
              NpcParams = {
                InteractionArea = 2.0,
                UseEffect = "",
                IsHasAction = true,
                LongPress = true,
                LongPressTime = 1.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638693362132740080,
              IsRemove = false,
              CustomEventName = "catCmr",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229409,
          Actions = {
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              PosKey = "tp4",
              NPCName = "fakeSalida",
              NpcParams = {
                InteractionArea = -1.0,
                UseEffect = "Fx_Transmit3_idel|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638803383291206195,
              IsRemove = true,
              Type = 92,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "finishStory",
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "sos",
      Actions = {
        {

          StoryId = 2229407,
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

          Type = 71,
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

      EventName = "finalTalk",
      Actions = {
        {

          StoryId = 2229409,
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

          PosKey = "M2",
          NPCName = "猫",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 2.0
          },
          Rotation = 0,
          NpcId = 638690072395700017,
          IsRemove = true,
          CustomEventName = "cat",
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

      EventName = "cat",
      Actions = {
        {

          StoryId = 2229412,
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

      EventName = "catCmr",
      Actions = {
        {

          TimelineName = "timeline_32903_catCmr",
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

          Target = "Hero",
          Type = 37,
          Timeout = 0.5,
          TimeoutKey = "emvohBlW"
        },
        {

          NPC = "Hero",
          Point = "M1",
          Rotate = 135.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "kPYrBoZm"
        },
        {

          TimelineName = "timeline_32903_catCmr",
          Type = 7,
          Timeout = 4.0,
          TimeoutKey = "cElgtxsE"
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

          TimelineName = "timeline_32903_xinFall",
          Actions = {
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = 170.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 0.0
            },
            {

              StoryId = 2229408,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_32903_parejaCat",
              IsPlay = true,
              Type = 110,
              Timeout = 0.6,
              TimeoutKey = "dYVxIJjt"
            },
            {

              PosKey = "M3",
              Rotation = 170,
              NPCId = 3029311,
              NPCName = "薪",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_32903_catCmr",
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              Type = 60,
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

          GuideID = 3290321,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 4.35,
              TimeoutKey = "WniWrKmV"
            },
            {

              TimelineName = "timeline_32903_xinFall",
              Type = 7,
              Timeout = 4.75,
              TimeoutKey = "VXxMHzky"
            },
            {

              StoryId = 3229406,
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
              TimeoutKey = "MgZtntwr"
            }
          },
          ValidInTower = false
        }
      },
      Type = 15,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_32903_xinFall",
          Actions = {
            {

              GuideId = 3290321,
              Type = 41,
              Timeout = 4.0,
              TimeoutKey = "PnbJdeqf"
            },
            {

              StoryId = 3229404,
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

              StoryId = 3229405,
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
              Timeout = 2.5,
              TimeoutKey = "ngpLpkvE"
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
    },
    {

      ConditionActions = {
        {

          Key = "tp4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              TaskId = 3290305,
              Type = 5,
              Timeout = 0.0
            },
            {

              StoryId = 100229402,
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
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "finishStory",
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
      StoryId = 100229402,
      Name = "6.剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}