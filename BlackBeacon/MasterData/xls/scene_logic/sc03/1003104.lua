local empty = {}
return
{
  Events = {
    {

      Actions = {
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

          StoryId = 100103032,
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
          Timeout = 4.0,
          TimeoutKey = "1"
        },
        {

          BackToDefault = false,
          Type = 63,
          Timeout = 0.0
        },
        {

          ObjName = "Level/T1/Fx_1001008_henji",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "4-1-2Timeline",
          Fadein = 2.0,
          Fadeout = 2.0,
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

          Path = "Level/T1/R3/sc03_04_anim_33/switch_on",
          Rewind = 0.0,
          IsSaveState = true,
          Type = 56,
          Timeout = 0.0
        },
        {

          ObjName = "NPC",
          Visible = false,
          IsAutoSave = true,
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

      NoPassCamera = 1031001,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1031001,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          IsOpen = false,
          Type = 79,
          Timeout = 0.0
        },
        {

          IsSkip = false,
          Type = 36,
          Timeout = 0.0
        },
        {

          ObjName = "Level/T1/future1_1/sence_on",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/T1/future1_1/sence_end",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.1,
          TimeoutKey = "564615"
        },
        {

          CustomEventName = "prebox",
          Type = 19,
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

          Key = "laser",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              ObjName = "/Root/Level/T1/R3/PlatGroup",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              GroupId = 1031001,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "11"
            },
            {

              GroupId = 1031002,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "12"
            },
            {

              GroupId = 1031003,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "13"
            },
            {

              GroupId = 1031004,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "14"
            },
            {

              PlatName = "plat1",
              IsMove = true,
              Anim = "LaserAnimation1",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "1"
            },
            {

              PlatName = "plat3",
              IsMove = true,
              Anim = "LaserAnimation3",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "3"
            },
            {

              PlatName = "plat2",
              IsMove = true,
              Anim = "LaserAnimation2",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "2"
            },
            {

              PlatName = "plat4",
              IsMove = true,
              Anim = "LaserAnimation4",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "4"
            },
            {

              Camera = 1031401,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomWall2",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomPlat",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0,
              TimeoutKey = ""
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
                WallObjPath = "2",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 100310401,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "end",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 32.0,
              TimeoutKey = "7"
            },
            {

              ObjName = "/Root/Scene/sc03_zone_04/Portal (2)/Portal01 (57)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Scene/sc03_zone_04/Portal (2)/Portal01 (59)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Scene/sc03_zone_04/Portal (2)/Portal01 (58)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_11_mod",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "laser",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "center",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 1.0,
              TimeoutKey = "MhxqybUc"
            },
            {

              StoryId = 2030401,
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
              TimeoutKey = "2030401"
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 1.0,
              TimeoutKey = "shu"
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

          StoryId = 100103032,
          Actions = {
            {

              TimelineName = "4-1-2Timeline",
              Type = 7,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "tp1off",
          ValidInTower = false
        },
        {

          StoryId = 6030201,
          Actions = {
            {

              PosKey = "BOX1",
              Rotation = 0,
              NPCId = 1032030,
              NPCName = "chazhen",
              Type = 0,
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

          StoryId = 100103041,
          Actions = {
            {

              ObjName = "Level/T1/future1_1/sence_end",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 35,
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

          NPCId = 1032030,
          Actions = {
            {

              NPCId = 1032030,
              NPCName = "chazhen",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10303,
              PosKey = "BOX1",
              Rotation = 180,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "IZsZfhHi"
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
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = empty,
      FinishMarkVariable = "endend",
      ValidInTower = true,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "end",
      Actions = {
        {

          TimelineName = "laser_cam",
          Type = 7,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomPlat",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomWall1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Type = 12,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Group = 1031004,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Group = 1031003,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Group = 1031002,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Group = 1031001,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          BackToDefault = false,
          Type = 63,
          Timeout = 0.0
        },
        {

          Camera = 1031001,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "cam1"
        },
        {

          Type = 34,
          Timeout = 0.0
        },
        {

          KeyName = "tp3",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          Type = 34,
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

      EventName = "boxEnd",
      Actions = {
        {

          Variable = "10303",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10303CLOSE",
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

      EventName = "prebox",
      Actions = {
        {

          PosKey = "BOX1",
          NPCName = "pNutlDEw",
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
          NpcId = 638666013491449267,
          IsRemove = true,
          CustomEventName = "box",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10303",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "box",
      Actions = {
        {

          StoryId = 6030201,
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

      EventName = "GBOX10303OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10303",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10303",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10303CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10303",
          IsAutoSave = false,
          Type = 53,
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

          StoryId = 100103032,
          StepId = 0,
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
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_11_mod",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/PlatGroup",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TaskId = 103106,
          Type = 5,
          Timeout = 0.0
        },
        {

          TimelineName = "laser_cam",
          Type = 7,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomWall2",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Pos = 2,
          IsGoOut = false,
          Type = 78,
          Timeout = 0.0
        },
        {

          BackToDefault = false,
          Type = 63,
          Timeout = 0.0
        },
        {

          KeyName = "center",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 21,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10303CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10303OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
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
      [ 20101301 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}