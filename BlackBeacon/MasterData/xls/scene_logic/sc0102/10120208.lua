local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          ChangeTime = 3.0,
          Type = 75,
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

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
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

          ObjName = "LevelObj/sc01_prp_21b_mod/sc01_prp_21b_02_mod/Fx_Pickable",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/sc01_prp_21b_mod/sc01_prp_21b_03_mod/FX_Liehen4",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Key = "UnlockM1",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_fx_1.9block",
          IsPlay = true,
          Type = 110,
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

          Key = "story1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "story1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0,
              TimeoutKey = "1"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 10,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10120801,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10120802,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10120804,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0,
              TimeoutKey = "2"
            },
            {

              TimelineName = "timeline_boos",
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
              Timeout = 0.0,
              TimeoutKey = "3"
            },
            {

              PlayBgm = "bgm_modern_elite",
              Type = 76,
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

          StoryId = 100101042,
          Actions = {
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
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101103,
          Actions = {
            {

              TimelineName = "timeline_1_2meier_enji",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
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

              TaskId = 101204,
              Type = 5,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.5,
              TimeoutKey = "lsWeIWKs"
            },
            {

              StoryId = 201227,
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
              Timeout = 4.5,
              TimeoutKey = "rFgPtwwI"
            },
            {

              Type = 46,
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

          TaskId = 101203,
          Type = 5,
          Timeout = 0.0
        },
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

      ConditionActions = {
        {

          GroupId = 10120208,
          Actions = {
            {

              GuideId = 100120801,
              Type = 41,
              Timeout = 0.5,
              TimeoutKey = "WljMcSHD"
            }
          },
          FinishMarkVariable = "firstime",
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "firstime",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          TaskId = 101203,
          Type = 5,
          Timeout = 0.0
        },
        {

          StoryId = 201223,
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
          TimeoutKey = "xnTjEmrn"
        },
        {

          PosKey = "NPC",
          Rotation = 0,
          NPCId = 101103,
          Type = 0,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
          Timeout = 0.0
        },
        {

          TipsId = 1012020801,
          Visible = false,
          Flip = false,
          Type = 15,
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

      EventName = "大招连携教学",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_boos",
          Actions = {
            {

              StoryId = 201222,
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

          TimelineName = "timeline_1_2meier_enji",
          Actions = {
            {

              StoryId = 100101042,
              EnableBlackFade = true,
              DelayDestroy = true,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0,
              TimeoutKey = "AaGZFaJV"
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

          GuideID = 100120801,
          Actions = {
            {

              GuideId = 100120802,
              Type = 41,
              Timeout = 0.5,
              TimeoutKey = "SyDfLYMZ"
            }
          },
          ValidInTower = false
        },
        {

          GuideID = 100120802,
          Actions = {
            {

              GuideId = 100120803,
              Type = 41,
              Timeout = 0.5,
              TimeoutKey = "itfylkIA"
            }
          },
          ValidInTower = false
        },
        {

          GuideID = 100120803,
          Actions = {
            {

              GuideId = 100120804,
              Type = 41,
              Timeout = 1.0,
              TimeoutKey = "nORaHFLq"
            }
          },
          ValidInTower = false
        },
        {

          GuideID = 100120804,
          Actions = {
            {

              GuideId = 100120805,
              Type = 41,
              Timeout = 1.0,
              TimeoutKey = "WsAwPjjE"
            }
          },
          ValidInTower = false
        },
        {

          GuideID = 100120805,
          Actions = {
            {

              GuideId = 100120806,
              Type = 41,
              Timeout = 8.0,
              TimeoutKey = "cUSnWcmV"
            }
          },
          ValidInTower = false
        },
        {

          GuideID = 100120806,
          Actions = {
            {

              GuideId = 100120807,
              Type = 41,
              Timeout = 0.5,
              TimeoutKey = "OLEKlEvO"
            }
          },
          ValidInTower = false
        }
      },
      Type = 15,
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 10,
    MonsterInfo = {
      [ 20101401 ] = 2,
      [ 20102901 ] = 1,
      [ 20101501 ] = 4,
      [ 20104001 ] = 2,
      [ 20101201 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}