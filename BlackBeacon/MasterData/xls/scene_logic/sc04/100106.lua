local empty = {}
return
{
  Events = {
    {

      EventName = "OldFirstBegin",
      Actions = {
        {

          TimelineName = "timeline0_0",
          Fadein = 0.0,
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
          BeforeHold = 0.5,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          CustomEventName = "场景开关",
          Type = 19,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "bornpoint0",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          Camera = 4,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_0_1",
          IsPlay = true,
          Type = 110,
          Timeout = 18.0,
          TimeoutKey = "sEjdJCuJ"
        },
        {

          CustomEventName = "UIclose",
          Type = 19,
          Timeout = 0.0
        },
        {

          CameraFarClipPlane = 1000.0,
          Type = 107,
          Timeout = 0.0
        },
        {

          StoryId = 5000101,
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
          Timeout = 4.15,
          TimeoutKey = "CUsMYSlp"
        },
        {

          StoryId = 5000102,
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
          Timeout = 13.5,
          TimeoutKey = "nwVJkvXc"
        },
        {

          Target = "God",
          MagicId = 1000101,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          PlayBgm = "storybgm_001",
          Type = 76,
          Timeout = 6.0,
          TimeoutKey = "rEKqJATy"
        },
        {

          PlayBgm = "scene_ambience_BlackBeacon_SFX",
          ChangeTime = 3.0,
          Type = 82,
          Timeout = 0.0
        },
        {

          Key = "is_timer_end",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 18.0,
          TimeoutKey = "OyxSpfZh"
        },
        {

          Target = "Hero",
          Enable = false,
          Type = 119,
          Timeout = 0.0
        },
        {

          NPCId = 100001,
          NPCName = "111",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCName = "lnwihfBu",
          Type = 93,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Cube (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Type = 46,
          Timeout = 5000102.0,
          TimeoutKey = "cwdxggOG"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          CustomEventName = "OldFirstBegin",
          Type = 19,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 403210033,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill2",
          IsShow = false,
          Type = 32,
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

      Actions = {
        {

          Key = "play",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Enable = true,
          Type = 119,
          Timeout = 5.0,
          TimeoutKey = "AmtzaZYH"
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "play",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "story",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 5000106,
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
      ConditionVariable = "is_story",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cancelFocus",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "100001_focus",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "interact1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline_player1",
              Fadein = 3.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = true,
              IsCloseTransparent = false,
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

              TimelineName = "scene_timeline_0_1",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_player1",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "jISWSWDt"
            },
            {

              StoryId = 5000103,
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
              Timeout = 5.5,
              TimeoutKey = "lvHIaUcm"
            },
            {

              StoryId = 4000101,
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
              Timeout = 9.5,
              TimeoutKey = "aCkvWeKp"
            },
            {

              NPC = "Hero",
              Point = "bornpoint0_1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 4.0,
              TimeoutKey = "ZPtJdTlW"
            },
            {

              Camera = 5,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 4.0,
              TimeoutKey = "GsojmlsR"
            },
            {

              ChangeTime = 0.0,
              Type = 75,
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

          StoryId = 1000002,
          Actions = {
            {

              ChangeTime = 1.0,
              Type = 74,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1000003,
          Actions = {
            {

              TimelineName = "timeline0_2down",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.5,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = true,
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

          StoryId = 4000101,
          Actions = {
            {

              TimelineName = "timeline_player1",
              Type = 7,
              Timeout = 0.75,
              TimeoutKey = "kohsBCCA"
            },
            {

              TimelineName = "timeline_player1_1",
              Type = 7,
              Timeout = 0.75,
              TimeoutKey = "yDUUpLZo"
            },
            {

              TimelineName = "scene_timeline_player1",
              IsPlay = false,
              Type = 110,
              Timeout = 0.75,
              TimeoutKey = "UTUctrIh"
            },
            {

              CustomEventName = "关闭scene_timeline_player1_2",
              Type = 19,
              Timeout = 0.75,
              TimeoutKey = "EOoNOrKr"
            },
            {

              CustomEventName = "关闭scene_timeline_player1_3",
              Type = 19,
              Timeout = 0.75,
              TimeoutKey = "xhLJOiqa"
            },
            {

              TimelineName = "scene_timeline_player2",
              IsPlay = true,
              Type = 110,
              Timeout = 0.75,
              TimeoutKey = "AtPCCdIZ"
            },
            {

              StoryId = 5000104,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1000103,
              Level = 0,
              Type = 16,
              Timeout = 0.75,
              TimeoutKey = "MTHPtIvy"
            },
            {

              TimelineName = "timeline_player2",
              Fadein = 7.0,
              Fadeout = 10000.0,
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
              Timeout = 11.0,
              TimeoutKey = "fSnxksxV"
            },
            {

              StoryId = 4000104,
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
              Timeout = 14.0,
              TimeoutKey = "aLcWGczb"
            },
            {

              TimelineName = "scene_timeline_FX_prologue_dim2",
              IsPlay = true,
              Type = 110,
              Timeout = 3.0,
              TimeoutKey = "IgvtzsVY"
            },
            {

              Camera = 4,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 18.0,
              TimeoutKey = "lsUhGtHH"
            },
            {

              NPC = "Hero",
              Point = "bornpoint0_1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 1.0,
              TimeoutKey = "iSiiwKpn"
            },
            {

              PlayBgm = "storybgm_019",
              Type = 76,
              Timeout = 16.0,
              TimeoutKey = "rFoLOndS"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 5000102,
          Actions = {
            {

              TimelineName = "timeline0_0",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4000104,
          Actions = {
            {

              TimelineName = "timeline_player2",
              Type = 7,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_player3",
              Fadein = 0.5,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = true,
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

              StoryId = 5000105,
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
              TimeoutKey = "lCvarhnA"
            },
            {

              PlayBgm = "scene_sc03_SFX",
              ChangeTime = 3.0,
              Type = 82,
              Timeout = 0.0
            },
            {

              StoryId = 4000102,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = true,
              IsSettleStory = false,
              Type = 10,
              Timeout = 8.5,
              TimeoutKey = "rKuPXzBI"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4000102,
          Actions = {
            {

              CustomEventName = "场景开关2",
              Type = 19,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1000104,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              ChangeTime = 0.0,
              Type = 75,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 10001013,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 4032098,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = -30.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              Camera = 1001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.5,
              TimeoutKey = "kGRxOVoj"
            },
            {

              TimelineName = "timeline_player3",
              Type = 7,
              Timeout = 0.5,
              TimeoutKey = "ySyFqsxU"
            },
            {

              PlayBgm = "scene_ambience_BlackBeacon_SFX",
              ChangeTime = 3.0,
              Type = 82,
              Timeout = 0.0
            },
            {

              ChangeTime = 0.0,
              Type = 75,
              Timeout = 0.5,
              TimeoutKey = "YTzXXkuW"
            },
            {

              TimelineName = "scene_timeline_player2",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
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

          NPCId = 100001,
          Actions = {
            {

              CustomEventName = "交互后",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GroupId = 100001,
          Actions = {
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
                    Id = 4100102,
                    param = 2,
                    Name = "全部杀死",
                    CustomEventName = "monster3",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 100010103,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Key = "step2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 100010106,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Key = "0normal",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1001992,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1001993,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "跳过开头tl",
      Actions = {
        {

          TimelineName = "scene_timeline_0_1",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          Type = 46,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "is_timer_end",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "关闭scene_timeline_player1_2",
      Actions = {
        {

          TimelineName = "scene_timeline_player1_2",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        },
        {

          Key = "scene_timeline_player1_2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "scene_timeline_player1_2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "场景开关2",
      Actions = {
        {

          ObjName = "/Root/LevelObj/Fx_Sc0401_01/dm_kuosan",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/qiao",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Sc00_build_01ani_pre (1)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Sc00_build_01ani_pre (3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Sc0401_01/Y_guangyun01_1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Sc0401_01/Y_guangyun01_2",
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

      EventName = "聚焦石碑交互点",
      Actions = {
        {

          PosKey = "int1",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 3.0,
          StopLuaScript = false,
          BackToDefault = false,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          TipsId = 10010602,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 1.0,
          TimeoutKey = "IPvtbxvk"
        }
      },
      FinishMarkVariable = "100001_focus",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "100001_interacted",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "UIclose",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = false,
          Type = 32,
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

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
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

      EventName = "timeline",
      Actions = {
        {

          StoryId = 1000003,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          EventName = "first_fight_end",
          Params = empty,
          Type = 133,
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

      EventName = "关闭scene_timeline_player1_3",
      Actions = {
        {

          TimelineName = "scene_timeline_player1_3",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        },
        {

          Key = "scene_timeline_player1_3",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "scene_timeline_player1_3",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "monster2",
      Actions = {
        {

          GroupId = 100001,
          Type = 42,
          Timeout = 1.0,
          TimeoutKey = "xsubhnBT"
        },
        {

          ChangeTime = 1.0,
          Type = 74,
          Timeout = 1.0,
          TimeoutKey = "YKlTkLvP"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "交互后",
      Actions = {
        {

          TimelineName = "timeline_player1",
          Fadein = 3.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = true,
          IsCloseTransparent = true,
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
          TimeoutKey = "eEycBBAH"
        },
        {

          TimelineName = "scene_timeline_0_1",
          IsPlay = false,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "xcBWWUno"
        },
        {

          TimelineName = "scene_timeline_player1",
          IsPlay = true,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "JmoOhDHV"
        },
        {

          TimelineName = "scene_timeline_player1_2",
          IsPlay = true,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "ufLqcUgp"
        },
        {

          Key = "scene_timeline_player1_2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 3.0,
          TimeoutKey = "mvlzwzIa"
        },
        {

          StoryId = 5000103,
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
          Timeout = 5.5,
          TimeoutKey = "dKexDSyk"
        },
        {

          StoryId = 4000101,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 9.5,
          TimeoutKey = "TuMCtLqi"
        },
        {

          NPC = "Hero",
          Point = "bornpoint0_1",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 4.0,
          TimeoutKey = "lLPJRXas"
        },
        {

          Camera = 5,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 4.0,
          TimeoutKey = "pyGlzceO"
        },
        {

          Key = "is_loop",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ChangeTime = 0.0,
          Type = 75,
          Timeout = 2.0,
          TimeoutKey = "jQCkKvQB"
        },
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          BackToDefault = false,
          Type = 63,
          Timeout = 0.0
        },
        {

          TipsId = 10010602,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          EventName = "touch_beacon",
          Params = empty,
          Type = 133,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "100001_interacted",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "场景开关",
      Actions = {
        {

          ObjName = "/Root/LevelObj/Fx_Sc0401_01/dm_kuosan",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/qiao",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Sc00_build_01ani_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Sc00_build_01ani_pre (3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Sc0401_01/Y_guangyun01_1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Sc0401_01/Y_guangyun01_2",
          Visible = false,
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

      EventName = "monster3",
      Actions = {
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
                Id = 4100103,
                param = 2,
                Name = "全部杀死",
                CustomEventName = "timeline",
                Timeout = 2.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 1.0,
          TimeoutKey = "AkiohplD"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "UIopen",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = true,
          Type = 32,
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

          TimelineName = "timeline0_0",
          Actions = {
            {

              GuideId = 1001001,
              Type = 41,
              Timeout = 0.0
            },
            {

              TimelineName = "fx_guangqiao",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Key = "scene_timeline_0_1",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "5000101",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "5000102",
              Type = 52,
              Timeout = 0.0
            },
            {

              CustomEventName = "跳过开头tl",
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

          TimelineName = "scene_timeline_FX_prologue_dim2",
          Actions = {
            {

              TimelineName = "scene_timeline_FX_prologue_dim2",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "is_loop",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline0_2down",
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
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline0_1up",
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 4100101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "monster2",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              PosKey = "0_4100101_0",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 1.5,
              TimeoutKey = "KWgogLqM"
            },
            {

              Target = "God",
              MagicId = 100010101,
              Level = 0,
              Type = 16,
              Timeout = 0.3,
              TimeoutKey = "XGGESteD"
            },
            {

              Target = "Hero",
              MagicId = 10001015,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Key = "step1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              StoryId = 201406,
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

              ChangeTime = 1.0,
              Type = 74,
              Timeout = 0.0
            },
            {

              CustomEventName = "UIopen",
              Type = 19,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Enable = true,
              Type = 119,
              Timeout = 0.0
            },
            {

              EventName = "first_fight_start",
              Params = empty,
              Type = 133,
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

          StoryId = 4000101,
          StepId = 15,
          Actions = {
            {

              Target = "Hero",
              MagicId = 1000102,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_FX_prologue_dim2",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_player1",
              Type = 7,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_player1_1",
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
              Timeout = 0.0,
              TimeoutKey = "qYVQoVAK"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4000101,
          StepId = 6,
          Actions = {
            {

              PlayBgm = "storybgm_003",
              Type = 76,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 5000102,
          StepId = 5,
          Actions = {
            {

              TimelineName = "scene_timeline_FX_prologue_dim1_2",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1000102,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4000101,
          StepId = 8,
          Actions = {
            {

              TimelineName = "scene_timeline_player1_3",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Key = "scene_timeline_player1_3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              CustomEventName = "关闭scene_timeline_player1_2",
              Type = 19,
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

          GuideID = 1001001,
          Actions = {
            {

              TipsId = 10010601,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 1.0,
              TimeoutKey = "FflbhGKr"
            },
            {

              TimelineName = "scene_timeline_player1",
              Type = 7,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_FX_prologue_dim1_2",
              IsPlay = true,
              Type = 110,
              Timeout = 5.0,
              TimeoutKey = "NLDkrVvg"
            },
            {

              Target = "Hero",
              MagicId = 1000102,
              Level = 0,
              Type = 16,
              Timeout = 5.0,
              TimeoutKey = "YkGMKLHC"
            },
            {

              TimelineName = "scene_timeline_FX_prologue_dim2",
              IsPlay = true,
              Type = 110,
              Timeout = 13.0,
              TimeoutKey = "xWscBIup"
            },
            {

              Key = "is_story",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 14.0,
              TimeoutKey = "dfaVUXaC"
            },
            {

              Key = "is_loop",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              PosKey = "int1",
              NPCName = "lnwihfBu",
              NpcParams = {
                InteractionArea = 5.0,
                UseEffect = "Fx_Investigate_1|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638702303635273029,
              IsRemove = true,
              CustomEventName = "交互后",
              Type = 92,
              Timeout = 14.0,
              TimeoutKey = "xCEMJItz"
            },
            {

              KeyName = "int1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 14.0,
              TimeoutKey = "BjDCZkdF"
            },
            {

              CustomEventName = "聚焦石碑交互点",
              Type = 19,
              Timeout = 20.0,
              TimeoutKey = "SkejblIU"
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

      StoryID = 100100011,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 100100011,
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
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 11,
    MonsterInfo = {
      [ 2010150115 ] = 11
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}