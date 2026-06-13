local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Intensity = 0.065,
          Type = 105,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc05_area_52/Prop/sc05_prp_51a_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc05_area_52/Prop/sc05_prp_51a_pre (2)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc05_area_52/Prop/sc05_prp_51a_pre (3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc05_area_52/Prop/sc05_prp_51a_pre (4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc05_area_52/Prop/sc05_prp_51a_pre (6)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level_/320/32005",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupId = 2009,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 2010,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 2011,
          Type = 27,
          Timeout = 0.0
        },
        {

          StartDistance = -15.0,
          Type = 123,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/langan1 (6)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing1 (1)/sc05_prp_60d_pre (16)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing1 (1)/sc05_prp_60d_pre (19)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/langan1 (4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/langan1 (5)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level_/320/32005/320_rail3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing1 (1)/sc05_prp_60d_pre (15)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing1 (1)/sc05_prp_60a_pre (10)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing1 (1)/sc05_prp_60a_pre (12)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing1 (1)/sc05_prp_60a_pre (11)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing1 (1)/sc05_prp_60d_pre (20)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/chongluan/sc05_prp_59e_pre (2)",
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

          Key = "qian_dark",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "darkSwitch",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 5,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 20012,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear1",
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
                Id = 20013,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
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

      NoPassCamera = 32001,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 32001,
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

          StoryId = 2220501,
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 3,
          Type = 86,
          Timeout = 0.0
        },
        {

          TaskGroupId = 32005,
          Type = 21,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
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

          Key = "tips",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = empty,
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

          Key = "end",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              StoryId = 100220502,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
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
      ConditionVariable = "ClearAll",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "monster2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              CustomEventName = "怪物组2仇恨恢复",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "monster3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              CustomEventName = "怪物组3仇恨恢复",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "monster4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              CustomEventName = "怪物组4仇恨恢复",
              Type = 19,
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

          StoryId = 2220501,
          Actions = {
            {

              CustomEventName = "怪物组1仇恨恢复",
              Type = 19,
              Timeout = 0.1,
              TimeoutKey = "JlAxBTQV"
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

          NPCId = 302017,
          Actions = {
            {

              TimelineName = "timeline_320050101",
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
              BeforeBlackIn = 0.5,
              BeforeHold = 1.0,
              BeforeBlackOut = 0.5,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "BRIBiiUC"
            },
            {

              ObjName = "Level_/320/32005/StreetLamp/1_off/street_lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.5,
              TimeoutKey = "HGdfoOFo"
            },
            {

              CustomEventName = "雾气减弱1",
              Type = 19,
              Timeout = 2.5,
              TimeoutKey = "GHsZzFwI"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            },
            {

              TaskId = 3200501,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302018,
          Actions = {
            {

              TimelineName = "timeline_320050102",
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
              BeforeBlackIn = 0.5,
              BeforeHold = 1.0,
              BeforeBlackOut = 0.5,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {

              Camera = 116,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "AOHoalLV"
            },
            {

              ObjName = "Level_/320/32005/StreetLamp/2_off/street_lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.5,
              TimeoutKey = "WefMWhZd"
            },
            {

              ObjName = "Level_/320/32005/StreetLamp/3_off/street_lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.5,
              TimeoutKey = "pOnJyZiH"
            },
            {

              CustomEventName = "雾气减弱2",
              Type = 19,
              Timeout = 2.0,
              TimeoutKey = "puYvgMfI"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              GroupID = 2,
              Type = 87,
              Timeout = 0.0
            },
            {

              TaskId = 3200503,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302012,
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

              ObjName = "Scene/sc05_area_52/Prop/sc05_prp_20a_pre (18)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "pNwcGNng"
            },
            {

              ObjName = "Scene/sc05_area_52/Prop/sc05_prp_20a_pre (13)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "OtDfFfQL"
            },
            {

              ObjName = "Scene/sc05_area_52/Prop/sc05_prp_20a_pre (14)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "vdgxlFLB"
            },
            {

              ObjName = "Scene/sc05_area_52/Prop/sc05_prp_20a_pre (20)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "mOwIzmAj"
            },
            {

              PosKey = "interact2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 2.0,
              Type = 62,
              Timeout = 2.0,
              TimeoutKey = "eTYTrxfn"
            },
            {

              PosKey = "interact2",
              Rotation = 0,
              NPCId = 302018,
              NPCName = "开灯2",
              Type = 0,
              Timeout = 0.0
            },
            {

              KeyName = "interact2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 2.5,
              TimeoutKey = "IsrPYJcg"
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
                    Id = 20014,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear3",
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

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 2,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20015,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear4",
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

              TaskId = 3200502,
              Type = 5,
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

      EventName = "怪物组1仇恨恢复",
      Actions = {
        {

          Target = "0_20012_0",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20012_1",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20012_2",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20012_3",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20012_4",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
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

      EventName = "clear3",
      Actions = {
        {

          GroupID = 3,
          Type = 87,
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

      EventName = "雾气减弱1",
      Actions = {
        {

          Intensity = 0.04,
          Type = 105,
          Timeout = 2.0,
          TimeoutKey = "AoXxzZWo"
        },
        {

          Intensity = 0.0425,
          Type = 105,
          Timeout = 1.8,
          TimeoutKey = "XMzvxFWA"
        },
        {

          Intensity = 0.045,
          Type = 105,
          Timeout = 1.6,
          TimeoutKey = "ejmhoHiN"
        },
        {

          Intensity = 0.0475,
          Type = 105,
          Timeout = 1.4,
          TimeoutKey = "hSneKPcx"
        },
        {

          Intensity = 0.05,
          Type = 105,
          Timeout = 1.2,
          TimeoutKey = "MXjASRGn"
        },
        {

          Intensity = 0.0525,
          Type = 105,
          Timeout = 1.0,
          TimeoutKey = "QViSnxTm"
        },
        {

          Intensity = 0.055,
          Type = 105,
          Timeout = 0.8,
          TimeoutKey = "IdvbLyEu"
        },
        {

          Intensity = 0.0575,
          Type = 105,
          Timeout = 0.6,
          TimeoutKey = "HSwOxvSF"
        },
        {

          Intensity = 0.06,
          Type = 105,
          Timeout = 0.4,
          TimeoutKey = "QvqcSyzP"
        },
        {

          Intensity = 0.0625,
          Type = 105,
          Timeout = 0.2,
          TimeoutKey = "ltbWVASD"
        },
        {

          Intensity = 0.065,
          Type = 105,
          Timeout = 0.0,
          TimeoutKey = "fLoVwpdw"
        },
        {

          StartDistance = -14.0,
          Type = 123,
          Timeout = 0.4,
          TimeoutKey = "gnhhrhAk"
        },
        {

          StartDistance = -13.0,
          Type = 123,
          Timeout = 0.8,
          TimeoutKey = "nNAqelSe"
        },
        {

          StartDistance = -12.0,
          Type = 123,
          Timeout = 1.2,
          TimeoutKey = "iyyHSxng"
        },
        {

          StartDistance = -11.0,
          Type = 123,
          Timeout = 1.6,
          TimeoutKey = "wZWIdjnI"
        },
        {

          StartDistance = -10.0,
          Type = 123,
          Timeout = 2.0,
          TimeoutKey = "zDVjFWgM"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear1",
      Actions = {
        {

          PosKey = "interact1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 0.0,
          TimeoutKey = "voEjvQoy"
        },
        {

          PosKey = "interact1",
          Rotation = 0,
          NPCId = 302017,
          NPCName = "开灯1",
          Type = 0,
          Timeout = 0.5,
          TimeoutKey = "ZDYidMcu"
        },
        {

          KeyName = "interact1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.5,
          TimeoutKey = "maTRiczl"
        },
        {

          StoryId = 3220501,
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
          TimeoutKey = "pqjYjYaC"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "怪物组4仇恨恢复",
      Actions = {
        {

          Target = "0_20015_0",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20015_1",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
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

      EventName = "怪物组2仇恨恢复",
      Actions = {
        {

          Target = "0_20013_0",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20013_1",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20013_2",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20013_3",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
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

      EventName = "雾气减弱2",
      Actions = {
        {

          Intensity = 0.033,
          Type = 105,
          Timeout = 0.4,
          TimeoutKey = "LZmwvBBo"
        },
        {

          Intensity = 0.026,
          Type = 105,
          Timeout = 0.8,
          TimeoutKey = "TBSaUnRC"
        },
        {

          Intensity = 0.019,
          Type = 105,
          Timeout = 1.2,
          TimeoutKey = "zxNvTyoc"
        },
        {

          Intensity = 0.012,
          Type = 105,
          Timeout = 1.6,
          TimeoutKey = "mwkGkbbr"
        },
        {

          Intensity = 0.005,
          Type = 105,
          Timeout = 2.0,
          TimeoutKey = "JcZeGwXI"
        },
        {

          StartDistance = -9.0,
          Type = 123,
          Timeout = 0.4,
          TimeoutKey = "DfjlJBkV"
        },
        {

          StartDistance = -8.0,
          Type = 123,
          Timeout = 0.8,
          TimeoutKey = "VRGOAelX"
        },
        {

          StartDistance = -7.0,
          Type = 123,
          Timeout = 1.2,
          TimeoutKey = "vFhyxchx"
        },
        {

          StartDistance = -6.0,
          Type = 123,
          Timeout = 1.6,
          TimeoutKey = "WRiUMQow"
        },
        {

          StartDistance = -5.0,
          Type = 123,
          Timeout = 2.0,
          TimeoutKey = "AEBiJcDJ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear4",
      Actions = {
        {

          TaskId = 3200504,
          Type = 5,
          Timeout = 0.0
        },
        {

          StoryId = 3220504,
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

          KeyName = "interact3",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "ClearAll",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "怪物组3仇恨恢复",
      Actions = {
        {

          Target = "0_20014_0",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20014_1",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20014_2",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_20014_3",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
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

      EventName = "clear2",
      Actions = {
        {

          StoryId = 3220502,
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

          PosKey = "interact3",
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
          Timeout = 0.5,
          TimeoutKey = "SjbgsLmK"
        },
        {

          PosKey = "interact3",
          Rotation = 0,
          NPCId = 302012,
          NPCName = "移除路障",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "cmOeWFHB"
        },
        {

          KeyName = "interact3",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 1.0,
          TimeoutKey = "BpRjXRVh"
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

          TimelineName = "timeline_320050101",
          Actions = {
            {

              KeyName = "target",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_320050101",
          Actions = {
            {

              KeyName = "target",
              IsOpen = true,
              IsContinue = true,
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

      StoryID = 100220501,
      Actions = {
        {

          StoryId = 100220501,
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
    [ 7 ] = {
      StoryId = 100220502,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 4,
    MonsterCount = 15,
    MonsterInfo = {
      [ 20204301 ] = 8,
      [ 20204601 ] = 5,
      [ 20304302 ] = 1,
      [ 20304402 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}