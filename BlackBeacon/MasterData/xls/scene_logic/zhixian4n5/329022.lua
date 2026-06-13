local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "scene_timeline_32902_zhang",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_32902_listener",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_32902_puppet",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level1/329",
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
        },
        {

          PosKey = "M4",
          Rotation = 90,
          NPCId = 3029225,
          NPCName = "木偶师",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 90,
          NPCId = 3029229,
          NPCName = "碗盖女",
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

      NoPassCamera = 117,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
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

          PosKey = "M1",
          Rotation = -90,
          NPCId = 3029224,
          NPCName = "奶茶店老板",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          NPCName = "泥人张",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638695321090450210,
          IsRemove = true,
          CustomEventName = "toy",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M4",
          Rotation = 90,
          NPCId = 3029227,
          NPCName = "木偶师交互",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "碗盖女交互",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 90,
          NpcId = 638698736533183034,
          IsRemove = true,
          CustomEventName = "bowlTalk",
          Type = 92,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
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

          Key = "teaching",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 2229207,
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

              NPCId = 3029222,
              NPCName = "听众1",
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 3029223,
              NPCName = "听众2",
              Type = 1,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "unlock",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "end",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 100229202,
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

              Type = 71,
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

          StoryId = 2229208,
          Actions = {
            {

              TimelineName = "scene_timeline_32902_zhang",
              IsPlay = false,
              Type = 110,
              Timeout = 0.1,
              TimeoutKey = "fBmeIGVD"
            },
            {

              TimelineName = "scene_timeline_32902_zhangWorking",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_32902_zhangWorking",
              IsPlay = false,
              Type = 110,
              Timeout = 15.1,
              TimeoutKey = "kbKSLtgm"
            },
            {

              TimelineName = "scene_timeline_32902_zhang",
              IsPlay = true,
              Type = 110,
              Timeout = 15.0,
              TimeoutKey = "jaUApauu"
            },
            {

              PosKey = "M3",
              NPCName = "NBREdfGR",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "",
                IsHasAction = true,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638695325148326736,
              IsRemove = true,
              CustomEventName = "toy2",
              Type = 92,
              Timeout = 15.0,
              TimeoutKey = "LtNXyghx"
            },
            {

              PosKey = "M3",
              Rotation = 0,
              NPCId = 3029228,
              NPCName = "泥人张气泡",
              Type = 0,
              Timeout = 0.0
            },
            {

              NPCId = 3029228,
              NPCName = "泥人张气泡",
              Type = 1,
              Timeout = 15.0,
              TimeoutKey = "pHrIhkJQ"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229205,
          Actions = {
            {

              PosKey = "M5",
              Rotation = 0,
              NPCId = 3029221,
              NPCName = "奶茶游戏",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229207,
          Actions = {
            {

              PosKey = "NPC2",
              Rotation = 0,
              NPCId = 3029223,
              NPCName = "听众2",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 3029222,
              NPCName = "听众1",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "GFRJqwmc"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229210,
          Actions = {
            {

              PosKey = "M6",
              Rotation = 0,
              NPCId = 3029226,
              NPCName = "水管游戏",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229213,
          Actions = {
            {

              CustomEventName = "bowlGame",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229212,
          Actions = {
            {

              KeyName = "end",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 100229201,
          Actions = {
            {

              StoryId = 2229204,
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
        },
        {

          StoryId = 2229204,
          Actions = {
            {

              TaskGroupId = 32902,
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

          StoryId = 2229209,
          Actions = {
            {

              CondId = 32902011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "c",
          ValidInTower = false
        },
        {

          StoryId = 2229206,
          Actions = {
            {

              CondId = 32902014,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "a",
          ValidInTower = false
        },
        {

          StoryId = 2229214,
          Actions = {
            {

              CondId = 32902013,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "b",
          ValidInTower = false
        },
        {

          StoryId = 2229211,
          Actions = {
            {

              CondId = 32902012,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "d",
          ValidInTower = false
        },
        {

          StoryId = 2229212,
          Actions = empty,
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

          NPCId = 3029221,
          Actions = {
            {

              StoryId = 2229206,
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
        },
        {

          NPCId = 3029224,
          Actions = {
            {

              StoryId = 2229205,
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
        },
        {

          NPCId = 3029227,
          Actions = {
            {

              StoryId = 2229210,
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
        },
        {

          NPCId = 3029226,
          Actions = {
            {

              StoryId = 2229211,
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

      EventName = "bowlGame",
      Actions = {
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.5,
          TimeoutKey = "GmBEnkHa"
        },
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level1/329/bowlGame/timeline",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.5,
          TimeoutKey = "dsqBVUTm"
        },
        {

          TimelineName = "timeline_32902_bowlCmr",
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
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.5,
          TimeoutKey = "azFeUDAM"
        },
        {

          TimelineName = "/Root/Level1/329/bowlGame/timeline",
          Type = 7,
          Timeout = 7.5,
          TimeoutKey = "OxLjLhhA"
        },
        {

          TimelineName = "timeline_32902_bowlCmr",
          Type = 7,
          Timeout = 7.5,
          TimeoutKey = "pmauDiur"
        },
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 7.0,
          TimeoutKey = "SHJYQshz"
        },
        {

          Target = "Hero",
          Type = 38,
          Timeout = 7.5,
          TimeoutKey = "UqlxNsEc"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "bowlTalk",
      Actions = {
        {

          StoryId = 2229213,
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

      EventName = "toy2",
      Actions = {
        {

          StoryId = 2229209,
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

      EventName = "toy",
      Actions = {
        {

          StoryId = 2229208,
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

          TimelineName = "timeline_32902_bowlCmr",
          Actions = {
            {

              PosKey = "M7",
              Rotation = 0,
              NPCId = 3029220,
              NPCName = "碗游戏",
              Type = 0,
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

          StoryId = 100229202,
          StepId = 1,
          Actions = {
            {

              TaskId = 3290202,
              Type = 5,
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

          ConditionVariableList = {
            "a",
            "b",
            "c",
            "d"
          },
          Actions = {
            {

              StoryId = 2229212,
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
              Timeout = 0.5,
              TimeoutKey = "SLTweSPn"
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
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

      StoryID = 100229201,
      Actions = {
        {

          StoryId = 100229201,
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
      Type = 37,
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
    [ 4 ] = {
      StoryId = 100229202,
      Name = "4.剧情结束"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}