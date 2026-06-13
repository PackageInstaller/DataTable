local empty = {}
return
{
  Events = {
    {

      StoryID = 100229401,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 100229401,
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
    },
    {

      Actions = {
        {

          ObjName = "/Root/Level/6/L7_/A2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/5/L6_/A2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/01/L1_/A2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/0/L0_/A2",
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
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 120,
          NPCId = 3029311,
          NPCName = "薪",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M1-2",
          Rotation = 60,
          NPCId = 3029332,
          NPCName = "阿紫",
          Type = 0,
          Timeout = 0.0
        },
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
                Id = 29311,
                param = 0,
                Name = "全部杀死",
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
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 111,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
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

          StoryId = 2229401,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.3,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.3,
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

          CustomEventName = "reset",
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

          Key = "help",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 3229407,
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

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 8,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 29312,
                    param = 0,
                    Name = "全部杀死",
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

              Key = "help2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "help2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "passer3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 9,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 29313,
                    param = 0,
                    Name = "全部杀死",
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

              Group = 29311,
              Type = 65,
              Timeout = 0.0
            },
            {

              Key = "passer32",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "passer32",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "passer4",
          IsRemoveAfterEnter = false,
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
                    Id = 29314,
                    param = 0,
                    Name = "全部杀死",
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

              Group = 29312,
              Type = 65,
              Timeout = 0.0
            },
            {

              Key = "passer42",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "passer42",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "passer5",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
                    Id = 29315,
                    param = 0,
                    Name = "全部杀死",
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

              Key = "passer52",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "passer52",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "tp4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Group = 29313,
              Type = 65,
              Timeout = 0.0
            },
            {

              Group = 29314,
              Type = 65,
              Timeout = 0.0
            },
            {

              Key = "tp42",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "tp42",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "walk",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "moveTrigger",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
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

          NPCId = 3029313,
          Actions = {
            {

              StoryId = 2229403,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.3,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.3,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {

              NPCId = 3029315,
              NPCName = "猫",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "aDkGPPEw"
            },
            {

              NPCId = 3029312,
              NPCName = "妇女",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "SLCGkcNO"
            },
            {

              TimelineName = "scene_timeline_32903_wifeEnd",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              PosKey = "bubble",
              Rotation = 0,
              NPCId = 3029314,
              NPCName = "妇女气泡",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3029312,
          Actions = {
            {

              StoryId = 2229402,
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

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.5,
              TimeoutKey = "IIKSrAaP"
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

          StoryId = 2229401,
          StepId = 2,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 2229401,
          StepId = 3,
          Actions = empty,
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 2229404,
          StepId = 8,
          Actions = {
            {

              NPCId = 3029315,
              NPCName = "猫",
              Type = 1,
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

          StoryId = 2229401,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPCId = 3029311,
              NPCName = "薪",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "hkqgXtec"
            },
            {

              NPCId = 3029332,
              NPCName = "阿紫",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "ayhFGerY"
            },
            {

              PosKey = "M2",
              Rotation = 0,
              NPCId = 3029312,
              NPCName = "妇女",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M5",
              Rotation = 120,
              NPCId = 3029311,
              NPCName = "薪2",
              Type = 0,
              Timeout = 0.6,
              TimeoutKey = "wYwLrUAK"
            },
            {

              PosKey = "M5-2",
              Rotation = -120,
              NPCId = 3029332,
              NPCName = "阿紫2",
              Type = 0,
              Timeout = 0.6,
              TimeoutKey = "peSSvzBM"
            },
            {

              KeyName = "M2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.6,
              TimeoutKey = "YOnzAcyn"
            },
            {

              TaskGroupId = 32903,
              Type = 21,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 2229402,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              Rotation = 180,
              NPCId = 3029313,
              NPCName = "老板思过",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "cat1",
              Rotation = 150,
              NPCId = 3029315,
              NPCName = "猫",
              Type = 0,
              Timeout = 0.0
            },
            {

              KeyName = "M3",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.5,
              TimeoutKey = "EozzuHEj"
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill3",
              IsShow = false,
              Type = 32,
              Timeout = 0.5,
              TimeoutKey = "ZlWChwRs"
            },
            {

              NPCId = 3029311,
              NPCName = "薪2",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "wqOAbIsY"
            },
            {

              NPCId = 3029332,
              NPCName = "阿紫2",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "VsgpyfJQ"
            },
            {

              TaskId = 3290301,
              Type = 5,
              Timeout = 0.0
            },
            {

              GroupId = 32903,
              Type = 42,
              Timeout = 1.0,
              TimeoutKey = "yRSdTRXb"
            },
            {

              ObjName = "/Root/Level/4/L5_/A2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "jfmzklJG"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229403,
          Actions = {
            {

              PosKey = "M4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.5,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = true,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              TaskId = 3290302,
              Type = 5,
              Timeout = 0.0
            },
            {

              PosKey = "catEnd",
              Rotation = 150,
              NPCId = 3029315,
              NPCName = "猫",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M4",
              NPCName = "GE",
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
              NpcId = 638688528336493276,
              IsRemove = true,
              CustomEventName = "GE",
              Type = 92,
              Timeout = 0.0
            },
            {

              KeyName = "M4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
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
                    Id = 29316,
                    param = 0,
                    Name = "全部杀死",
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

              Tips = "1038",
              Duration = 5.0,
              IsOpen = true,
              Type = 94,
              Timeout = 4.0,
              TimeoutKey = "WhwoUvrW"
            },
            {

              Seconds = 35,
              Text = "",
              EventName = "",
              Type = 66,
              Timeout = 4.0,
              TimeoutKey = "dQNnnlaD"
            },
            {

              CustomEventName = "changeEnd",
              Type = 19,
              Timeout = 39.0,
              TimeoutKey = "jzTWKglU"
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 2229404,
          Actions = {
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              NPCId = 3029315,
              NPCName = "猫",
              Type = 1,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229405,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 2229406,
          Actions = {
            {

              KeyName = "M4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              CustomEventName = "reset",
              Type = 19,
              Timeout = 0.0
            },
            {

              Seconds = 60,
              Type = 66,
              Timeout = 0.0
            },
            {

              CustomEventName = "changeEnd",
              Type = 19,
              Timeout = 60.0,
              TimeoutKey = "ZASiMWga"
            },
            {

              Tips = "1038",
              Duration = 5.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229405,
          Actions = {
            {

              CustomEventName = "BE2",
              Type = 19,
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

          GroupId = 32903,
          Actions = {
            {

              Enable = true,
              Type = 17,
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

      EventName = "tlEnd",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0,
          TimeoutKey = "NShyzYAq"
        },
        {

          TimelineName = "timeline_32903_wife",
          Type = 7,
          Timeout = 0.5,
          TimeoutKey = "YDkkJJcR"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "storyEnd",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "tlEnd2",
      Actions = empty,
      FinishMarkVariable = "storyEnd",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_32903_wife",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 32,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "GE",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPCId = 3029314,
          NPCName = "妇女气泡",
          Type = 1,
          Timeout = 0.5,
          TimeoutKey = "clRACJAe"
        },
        {

          Group = 29315,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "XfnwtkbV"
        },
        {

          Group = 29316,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "PoHGMQLK"
        },
        {

          NPC = "Hero",
          Point = "finalTalk",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "LSIoZeKR"
        },
        {

          StoryId = 2229404,
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
          TimeoutKey = "zgLtBmPa"
        },
        {

          TaskId = 3290303,
          Type = 5,
          Timeout = 1.0,
          TimeoutKey = "cPgWMGoC"
        },
        {

          Target = "Hero",
          MagicId = 3290301,
          Type = 103,
          Timeout = 0.0
        },
        {

          Enable = false,
          Type = 17,
          Timeout = 0.5,
          TimeoutKey = "vfSxXrNr"
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = true,
          Type = 32,
          Timeout = 0.5,
          TimeoutKey = "QnfghIZg"
        }
      },
      FinishMarkVariable = "GE",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "changeEnd",
      Actions = {
        {

          Type = 68,
          Timeout = 0.0
        },
        {

          Type = 71,
          Timeout = 0.0
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

          Group = 29312,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "AGtsOGEQ"
        },
        {

          Group = 29313,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "npfjOJDp"
        },
        {

          Group = 29314,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "fVIrwWUN"
        },
        {

          Group = 29315,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "hGIskRdP"
        },
        {

          Group = 29316,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "dGbgPIer"
        },
        {

          StoryId = 2229405,
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
          TimeoutKey = "CwcWbUOV"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "GE",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "BE",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          StoryId = 2229405,
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
          TimeoutKey = "JyYsWYLS"
        },
        {

          TaskId = 3290303,
          Type = 5,
          Timeout = 1.0,
          TimeoutKey = "dyBKkaoM"
        },
        {

          NPCId = 3029314,
          NPCName = "妇女气泡",
          Type = 1,
          Timeout = 0.5,
          TimeoutKey = "JniOrLDs"
        },
        {

          Group = 29316,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "AGnWfBia"
        },
        {

          Group = 29315,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "IbiRLcKG"
        },
        {

          NPC = "Hero",
          Point = "finalTalk",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "PvUtlNaB"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BE2",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "again",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "eDtUuyyC"
        },
        {

          Key = "moveTrigger",
          SyncValType = 2,
          Value = false,
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
            MonsterCount = 8,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 29312,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.3,
          TimeoutKey = "kfkEjUbY"
        },
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
                Id = 29316,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.6,
          TimeoutKey = "uRiaeBuA"
        },
        {

          StoryId = 2229406,
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
          Timeout = 1.1,
          TimeoutKey = "rbWOihYr"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "reset",
      Actions = {
        {

          Key = "help2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "passer32",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "passer42",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "passer52",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "tp42",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "stopStory",
      Actions = {
        {

          Type = 46,
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 2229404,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 8,
    MonsterCount = 53,
    MonsterInfo = {
      [ 3290304 ] = 1,
      [ 3290302 ] = 22,
      [ 3290301 ] = 18,
      [ 3290306 ] = 6,
      [ 3290305 ] = 6
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}