local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          KeyName = "M1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        }
      },
      ValidInTower = true,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 1070200,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 107020202,
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

          GroupId = 107020202,
          Type = 27,
          Timeout = 0.0
        },
        {

          TaskId = 107201,
          Type = 5,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10703,
          PosKey = "BOX1",
          Rotation = 90,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10703",
          Type = 124,
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

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                    Id = 107020201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb",
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

              AreaName = "camera3",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "camera4",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Z2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 2,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "5",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 107020202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb2",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
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

          Key = "camera1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1070202,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              TipsId = 107020101,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "camera3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1070201,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1070200,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera5",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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

          Key = "cheat",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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

          Key = "tips1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TipsId = 107020201,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tp4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 107020201,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "qb2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4070305,
          Actions = {
            {

              TimelineName = "Timeline_1070202_FView",
              Type = 7,
              Timeout = 0.0
            },
            {

              GroupId = 107020201,
              Type = 42,
              Timeout = 2.0,
              TimeoutKey = "tAgnmpxn"
            },
            {

              TipsId = 107020201,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 2.0,
              TimeoutKey = "hjajqcGL"
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

          StoryId = 5070302,
          Actions = {
            {

              PosKey = "M1",
              NPCName = "hnQUKvjr",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = true,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638770483279868648,
              IsRemove = false,
              CustomEventName = "F_control",
              Type = 92,
              Timeout = 0.0
            },
            {

              TipsId = 107020101,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
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

          NPCId = 107020203,
          Actions = empty,
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

          Direction = 4,
          Type = 51,
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

      EventName = "qb",
      Actions = {
        {

          Camera = 1070202,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
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
          Timeout = 0.0
        },
        {

          StoryId = 5070302,
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

      EventName = "qb2",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          CustomEventName = "F_view",
          Type = 19,
          Timeout = 0.0,
          TimeoutKey = "GlmfmgYl"
        },
        {

          ResId = 10210107,
          PosKey = "battery1",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "battery1",
          Cd = 0.5,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210107,
          PosKey = "battery2",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "battery2",
          Cd = 0.5,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "qb2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "F_control",
      Actions = {
        {

          KeyNames = "R2,P2",
          Type = 117,
          Timeout = 0.0
        },
        {

          KeyNames = "R3,P3",
          Type = 117,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_107020201",
          Fadein = 0.5,
          Fadeout = 0.5,
          IsCanSkip = false,
          NotPauseLua = false,
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
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/slot2/tl_work",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          Key = "baodi",
          AddType = 0,
          Type = 115,
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

      EventName = "F_view",
      Actions = {
        {

          StoryId = 4070305,
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
          Timeout = 1.75,
          TimeoutKey = "gTscJmVu"
        },
        {

          TimelineName = "Timeline_1070202_FView",
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
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10703OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BOXGUIDEFX/Fx_Common_BoxGuide10703",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10703",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOXEND10703",
      Actions = {
        {

          Variable = "10703",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10703CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10703CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BOXGUIDEFX/Fx_Common_BoxGuide10703",
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

          NPCName = "battery1",
          HitType = 1,
          Actions = {
            {

              KeyNames = "R2,P2",
              IsPause = true,
              Type = 118,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ LYG/sc06_area_lingyange/floor2/prop/sc06_prop_70_pre (1)/battery_on/FX_qinghua_stop2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (2)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (3)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51a_pre/door_freeze/FX_qinghua_stop1_2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (4)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (5)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (06)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "battery1",
          HitType = 2,
          Actions = {
            {

              KeyNames = "R2,P2",
              IsPause = false,
              Type = 118,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ LYG/sc06_area_lingyange/floor2/prop/sc06_prop_70_pre (1)/battery_on/FX_qinghua_stop2",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (2)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (3)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51a_pre/door_freeze/FX_qinghua_stop1_2",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (4)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (5)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (06)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room2/sc06_area_lingyange_2lou_02_pre/sc06_build_51b_pre (1)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "battery2",
          HitType = 1,
          Actions = {
            {

              KeyNames = "R3,P3",
              IsPause = true,
              Type = 118,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ LYG/sc06_area_lingyange/floor2/prop/sc06_prop_70_pre/battery_on/FX_qinghua_stop2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (4)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (5)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (6)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (7)/wall_freeze/FX_qinghua_stop1_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "battery2",
          HitType = 2,
          Actions = {
            {

              KeyNames = "R3,P3",
              IsPause = false,
              Type = 118,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ LYG/sc06_area_lingyange/floor2/prop/sc06_prop_70_pre/battery_on/FX_qinghua_stop2",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (4)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (5)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (6)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Room3/sc06_area_lingyange_2lou_03_pre/sc06_build_51b_pre (7)/wall_freeze/FX_qinghua_stop1_1",
              IsAutoSave = false,
              Type = 53,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      SceneTimelineObjectList = {
        {
          ContainerName = "Level",
          KeyNames = "R2,P2|plat2",
          AnimNames = "RR90,RR180,RR270,RR360",
          CurrType = 0,
          Status = true
        },
        {
          ContainerName = "Level",
          KeyNames = "R3,P3|plat3",
          AnimNames = "RT90,RT180,RT270,RT360",
          CurrType = 0,
          Status = true
        }
      },
      Actions = empty,
      ValidInTower = false,
      Type = 34,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10703OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10703CLOSE",
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

      ConditionActions = {
        {

          ConditionVariableList = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          Key = "baodi",
          IsEveryStepCheck = true,
          SuccessEvent = "baodi",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 33,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "baodi",
      Actions = {
        {

          Key = "baodi",
          Type = 116,
          Timeout = 0.0
        },
        {

          GroupId = 107020202,
          Type = 42,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
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
    EventCount = 2,
    MonsterCount = 6,
    MonsterInfo = {
      [ 20204301 ] = 2,
      [ 20204901 ] = 2,
      [ 20104901 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}