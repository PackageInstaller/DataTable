local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Scene/04_SL/sc01_area_04/Building/sc01_area_04_pre/Prop/sc01_prp_30a_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/04_SL/sc01_area_04/Building/sc01_area_04_pre/Prop/sc01_prp_30a_pre (1)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/Damen/sc01_bld_06a1_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/04_SL/sc01_area_04/Building/sc01_area_04_pre/Building/sc01_bld_15d_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/sc01_prp_08a_pre (13)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/sc01_prp_08a_pre (14)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/sc01_prp_08a_pre (15)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TaskGroupId = 10151,
          Type = 21,
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

      NoPassCamera = 10403,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10403,
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

          GroupId = 1015202,
          Type = 27,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          PosKey = "T1",
          Rotation = 0,
          NPCId = 1015201,
          Type = 0,
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

          Key = "NPC_on",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "NPC_off",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          Rotation = 0,
          NPCId = 1015202,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M21",
          Rotation = 0,
          NPCId = 1015203,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M22",
          Rotation = 0,
          NPCId = 1015204,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M20",
          Rotation = 0,
          NPCId = 1015205,
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "NPC_on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "NPC_on",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "NPC_off",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          NPCId = 1015202,
          NPCName = "1",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 1015203,
          NPCName = "1",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 1015204,
          NPCName = "1",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 1015205,
          NPCName = "1",
          Type = 1,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "NPC_off",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
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
                    Id = 1015201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "LE",
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

              Enable = false,
              Type = 17,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 6,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 1015202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "LE",
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

              Enable = false,
              Type = 17,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
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
                    Id = 1015203,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "LE",
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

              Enable = false,
              Type = 17,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 1015204,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "LE",
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

              Enable = false,
              Type = 17,
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

          Key = "CAM",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1015301,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "CAM",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CAM",
          Actions = {
            {

              Camera = 10403,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "CAM",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 1015204,
          Actions = {
            {

              TimelineName = "1015202",
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

              PosKey = "M12",
              Rotation = 0,
              NPCId = 1015215,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M13",
              Rotation = 0,
              NPCId = 1015216,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M14",
              Rotation = 0,
              NPCId = 1015217,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M15",
              Rotation = 0,
              NPCId = 1015218,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M16",
              Rotation = 0,
              NPCId = 1015219,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M17",
              Rotation = 0,
              NPCId = 1015220,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M18",
              Rotation = 0,
              NPCId = 1015221,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M23",
              Rotation = 0,
              NPCId = 1015223,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M24",
              Rotation = 0,
              NPCId = 1015224,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M25",
              Rotation = 0,
              NPCId = 1015225,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M26",
              Rotation = 0,
              NPCId = 1015226,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M27",
              Rotation = 0,
              NPCId = 1015227,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M28",
              Rotation = 0,
              NPCId = 1015228,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M29",
              Rotation = 0,
              NPCId = 1015229,
              Type = 0,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "1015204",
          ValidInTower = false
        },
        {

          NPCId = 1015204,
          Actions = {
            {

              Camera = 1015301,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "1015204",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "1015204",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 1015202,
          Actions = {
            {

              PosKey = "M1",
              Rotation = 0,
              NPCId = 1015206,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M2",
              Rotation = 0,
              NPCId = 1015207,
              Type = 0,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "1015202",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "1015202",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 1015205,
          Actions = {
            {

              PosKey = "M19",
              Rotation = 0,
              NPCId = 1015222,
              Type = 0,
              Timeout = 0.0
            },
            {

              TimelineName = "1015203",
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
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 1015222,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              FadeIn = 1.0,
              Hold = 0.5,
              FadeOut = 1.0,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "K04",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "1"
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

      ConditionActions = {
        {

          NPCId = 1015208,
          Actions = {
            {

              StoryId = 1015210111,
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

          NPCId = 1015209,
          Actions = {
            {

              StoryId = 10152901,
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

          NPCId = 1015210,
          Actions = {
            {

              StoryId = 10152902,
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

          NPCId = 1015211,
          Actions = {
            {

              StoryId = 10152903,
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

          NPCId = 1015212,
          Actions = {
            {

              StoryId = 10152904,
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

      ConditionActions = {
        {

          NPCId = 1015203,
          Actions = {
            {

              PosKey = "M5",
              Rotation = 0,
              NPCId = 1015208,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M6",
              Rotation = 0,
              NPCId = 1015209,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M7",
              Rotation = 0,
              NPCId = 1015210,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M8",
              Rotation = 0,
              NPCId = 1015211,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M9",
              Rotation = 0,
              NPCId = 1015212,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M10",
              Rotation = 0,
              NPCId = 1015213,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M11",
              Rotation = 0,
              NPCId = 1015214,
              Type = 0,
              Timeout = 0.0
            },
            {

              TimelineName = "1015201",
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
            }
          },
          FinishMarkVariable = "1015203",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "1015203",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 1015215,
          Actions = {
            {

              StoryId = 101521011,
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

          NPCId = 1015216,
          Actions = {
            {

              StoryId = 10152901,
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

          NPCId = 1015217,
          Actions = {
            {

              StoryId = 10152902,
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

          NPCId = 1015218,
          Actions = {
            {

              StoryId = 10152903,
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

          NPCId = 1015219,
          Actions = {
            {

              StoryId = 10152904,
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

      ConditionActions = {
        {

          NPCId = 1015201,
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
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Direction = 3,
          TpName = "FX_Sc01_door_1",
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

      EventName = "LE",
      Actions = {
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          Type = 22,
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

          TimelineName = "1015202",
          Actions = empty,
          FinishMarkVariable = "CAM",
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

          IsValid = true,
          IsNeedRetain = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          IsValid = true,
          IsNeedRetain = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          IsValid = true,
          IsNeedRetain = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 22,
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
    EventCount = 4,
    MonsterCount = 18,
    MonsterInfo = {
      [ 20102901 ] = 10,
      [ 20104001 ] = 6,
      [ 20101201 ] = 1,
      [ 20101101 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}