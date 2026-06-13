local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "switch_on",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "transformed",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
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

      NoPassCamera = 1031001,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1031001,
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

          Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre (1)/switch_on",
          Rewind = 0.0,
          CustomEventName = "",
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre/switch_on",
          Rewind = 0.0,
          CustomEventName = "",
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_314010401",
          Fadein = 1.0,
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

          CustomEventName = "try_switch",
          Type = 19,
          Timeout = 4.5,
          TimeoutKey = "eqVquCvb"
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

          StoryId = 2214104,
          Actions = {
            {

              TimelineName = "timeline_314010406",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
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

              FadeIn = 0.5,
              Hold = 1.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 6.5,
              TimeoutKey = "wfSAXCrk"
            },
            {

              ObjName = "Level/timeline_314010407",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "uZWwuZjj"
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

          StoryId = 2214105,
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

      EventName = "Over",
      Actions = {
        {

          StoryId = 2214104,
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
          TimeoutKey = "weSoZXeX"
        },
        {

          TaskId = 31404,
          Type = 5,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_314010407",
          IsPlay = true,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "NsLpgvxL"
        },
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
          Point = "hero",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "YomFogJW"
        },
        {

          Type = 61,
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

      EventName = "try_switch",
      Actions = {
        {

          Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre/switch_on",
          Rewind = 0.0,
          CustomEventName = "",
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Key = "switch_on",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "switch_on",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "transform",
      Actions = {
        {

          Path = "Level/Section_02/Zone_02/Plat7_/sc03_02_anim_03 (1)/switch_on",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/Section_02/Zone_02/sc03_02_anim_02 (1)/switch_on",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "CGpoIJXL"
        },
        {

          Path = "Level/Section_02/Zone_02/sc03_02_anim_01 (1)/switch_on",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "wpMuAzds"
        },
        {

          Path = "Level/timeline_314010404",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "SbLKVuPq"
        },
        {

          Key = "transformed",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "transformed",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_314010401",
          Actions = {
            {

              PosKey = "Monster1",
              Rotation = 0,
              NPCId = 301401,
              NPCName = "Monster1",
              Type = 0,
              Timeout = 0.0
            },
            {

              StoryId = 2214103,
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

              TaskId = 31402,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "Switch",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "Switch",
              Camp = 4,
              Rotation = 0,
              Level = 0,
              NPCName = "Switch",
              Cd = 999.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.0
            },
            {

              NpcName = "Switch",
              CanHit = false,
              Type = 77,
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

          TimelineName = "timeline_314010403",
          Actions = {
            {

              TimelineName = "timeline_314010403",
              Type = 7,
              Timeout = 0.5,
              TimeoutKey = "SlOZKkVZ"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 1,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 14003,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "Over",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.0,
              TimeoutKey = "SNiZankT"
            },
            {

              StoryId = 3214103,
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
              TimeoutKey = "CTHwBqMi"
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

          TimelineName = "timeline_314010406",
          Actions = {
            {

              StoryId = 2214105,
              EnableBlackFade = false,
              DelayDestroy = true,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0,
              TimeoutKey = "ctrHxNHK"
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

          TimelineName = "timeline_314010405",
          Actions = empty,
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

          TimelineName = "timeline_314010401",
          Actions = {
            {

              CustomEventName = "try_switch",
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

          TimelineName = "timeline_314010403",
          Actions = {
            {

              CustomEventName = "transform",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "transformed",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_314010406",
          Actions = {
            {

              Key = "wfSAXCrk",
              Type = 52,
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

          TimelineName = "timeline_314010403",
          Actions = {
            {

              Key = "ARaUmNza",
              Type = 52,
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

          NPCName = "Switch",
          HitType = 0,
          Actions = {
            {

              Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre/switch_on",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              NPCId = 301401,
              NPCName = "Monster1",
              Type = 1,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_314010403",
              Fadein = 0.5,
              Fadeout = 0.0,
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

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 11.25,
              TimeoutKey = "ARaUmNza"
            },
            {

              TaskId = 31403,
              Type = 5,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              CustomEventName = "transform",
              Type = 19,
              Timeout = 0.25,
              TimeoutKey = "EjwHknZG"
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
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 1,
    MonsterInfo = {
      [ 20103201 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}