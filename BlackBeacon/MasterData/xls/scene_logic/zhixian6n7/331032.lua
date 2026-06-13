return
{
  Events = {
    {

      Actions = {
        {

          TaskId = 3310303,
          Type = 5,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Level_02/331/jaula",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          KeyName = "center",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 30,
          NPCId = 3031311,
          NPCName = "族人1",
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

          Key = "snakeTrigger",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              StoryId = 2231307,
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
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Point = "M2",
              Type = 3,
              Timeout = 0.2,
              TimeoutKey = "TdjuKJDG"
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

          StoryId = 2231307,
          Actions = {
            {

              TimelineName = "scene_timeline_331_snake",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_02/331/jaula/scene_timeline_331_jaulaShake",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              ObjName = "/Root/Level/Level_02/331/jaula/scene_timeline_331_jaula",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              StoryId = 3231301,
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
              Timeout = 0.4,
              TimeoutKey = "hwgvxijk"
            },
            {

              TimelineName = "scene_timeline_331_snake",
              IsPlay = false,
              Type = 110,
              Timeout = 3.0,
              TimeoutKey = "ttKiRwXh"
            },
            {

              TimelineName = "timeline_331_snakeCmr2",
              Type = 7,
              Timeout = 3.0,
              TimeoutKey = "UcFwQQtM"
            },
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 2.6,
              TimeoutKey = "Gkishjzz"
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

      EventName = "End",
      Actions = {
        {

          TaskId = 3310305,
          Type = 5,
          Timeout = 0.0
        },
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.5,
          TimeoutKey = "rfiBFptw"
        },
        {

          NPC = "Hero",
          Point = "center",
          Rotate = -95.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "uDUqMXjI"
        },
        {

          PosKey = "M2",
          Rotation = 85,
          NPCId = 3031311,
          NPCName = "族人1",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "LRtKvirO"
        },
        {

          StoryId = 100231302,
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
          Timeout = 1.5,
          TimeoutKey = "agWdAcPK"
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

          TimelineName = "timeline_331_snakeCmr2",
          Actions = {
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0,
              TimeoutKey = "wmrZkpHw"
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              Point = "snake",
              Type = 3,
              Timeout = 0.1,
              TimeoutKey = "DjBxuEed"
            },
            {

              PosKey = "snake",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.5,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 1,
              OTSDuration = 0.5,
              Type = 62,
              Timeout = 0.1,
              TimeoutKey = "joTqMaLF"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 31312,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "End",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 0.0
            },
            {

              TaskId = 3310304,
              Type = 5,
              Timeout = 0.0
            },
            {

              StoryId = 3231302,
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
              Timeout = 4.0,
              TimeoutKey = "BNfvYfyq"
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

          StoryId = 2231307,
          StepId = 2,
          Actions = {
            {

              ObjName = "/Root/Level/Level_02/331/jaula/scene_timeline_331_jaulaShake",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = "0"
            },
            {

              TimelineName = "timeline_331_snakeCmr1",
              Fadein = 0.5,
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
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.2,
              TimeoutKey = "HfeOzCJO"
            },
            {

              NPCId = 3031311,
              NPCName = "族人1",
              Type = 1,
              Timeout = 0.3,
              TimeoutKey = "aHvjXoFa"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231307,
          StepId = 3,
          Actions = {
            {

              TimelineName = "timeline_331_snakeCmr1",
              Type = 7,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_331_snakeCmr2",
              Fadein = 1.0,
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
      StoryId = 100231302,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 4,
    MonsterInfo = {
      [ 20104901 ] = 1,
      [ 20204901 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}