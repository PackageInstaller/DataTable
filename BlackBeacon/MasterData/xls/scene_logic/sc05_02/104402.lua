local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "timeline_104401_enter",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = true,
          IsCloseTransparent = false,
          BlackIn = 1.0,
          Hold = 1.0,
          BlackOut = 0.5,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.75,
          TimeoutKey = "NfWCDzfs"
        },
        {

          Key = "qian_night",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          PosKey = "NPC1",
          NPCName = "control",
          NpcParams = {
            InteractionArea = 1.5,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638302194483823706,
          IsRemove = false,
          CustomEventName = "控制台交互",
          Type = 92,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 3001044001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1044,
          Type = 21,
          Timeout = 0.0
        },
        {

          Key = "nightSwitch",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

          ObjName = "/Root/Change_/Change_night/langan1 (4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/104402",
          Visible = true,
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
          ObjectName = "Btn_skill8",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/camerashake",
          Visible = true,
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

      NoPassCamera = 10406,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10406,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ContainerName = "Level",
          Names = {
            "L2"
          },
          States = {
            "2"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 3,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 104403,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 104401,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.05,
          TimeoutKey = "yAvdItMs"
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 104404,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 104401,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.05,
          TimeoutKey = "rJEcBkQF"
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 104406,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 104401,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.05,
          TimeoutKey = "eNSgFFAN"
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 104407,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 104401,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.05,
          TimeoutKey = "mfPNjaJj"
        },
        {

          GroupId = 104403,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 104404,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 104405,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 104406,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 104407,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "item",
          Rotation = 0,
          NPCId = 10450106,
          NPCName = "闪避药水",
          Type = 0,
          Timeout = 0.0
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 1.0,
          IsWhite = false,
          Type = 59,
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

          Type = 46,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Key = "stop_2040903",
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
      Type = 2,
      ConditionVariable = "stop_2040903",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "tips0",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              GroupId = 104401,
              Type = 42,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              GroupId = 104402,
              Type = 42,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "isInBattle",
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

              Type = 69,
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

          Key = "save1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save0",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Camera = 104405,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = "gftlCpBE"
            },
            {

              PosKey = "focus1",
              IsOpen = true,
              CameraStyle = 1,
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

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 2.0,
              TimeoutKey = "cLoKTwaB"
            },
            {

              Tips = "1028",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 2.5,
              TimeoutKey = "yfkZQtNe"
            }
          },
          ValidInTower = false
        },
        {

          Key = "save2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              PosKey = "focus2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.5,
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

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 2.0,
              TimeoutKey = "QpyHCkjV"
            },
            {

              Tips = "1028",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 2.5,
              TimeoutKey = "mCtoUoQc"
            }
          },
          ValidInTower = false
        },
        {

          Key = "save3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Camera = 104406,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = "KsMlIRmu"
            },
            {

              PosKey = "focus3",
              IsOpen = true,
              CameraStyle = 1,
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

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 2.0,
              TimeoutKey = "wztxRcza"
            },
            {

              Tips = "1028",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 2.5,
              TimeoutKey = "xiKtUOMG"
            }
          },
          ValidInTower = false
        },
        {

          Key = "save4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save3",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Camera = 104404,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = "GabkiQku"
            },
            {

              Tips = "1028",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 2.5,
              TimeoutKey = "tvGiaBIh"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "isInBattle",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4040811,
          Actions = {
            {

              TimelineName = "timeline_104401_3",
              Type = 7,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_104401_2",
              Type = 7,
              Timeout = 0.0
            },
            {

              PosKey = "NPC2",
              NPCName = "bCkHuwBr",
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
              NpcId = 638303924916321294,
              IsRemove = true,
              CustomEventName = "调查剧情1",
              Type = 92,
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

          StoryId = 4040811,
          Actions = {
            {

              NPCName = "control",
              Type = 93,
              Timeout = 0.0
            },
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
      ConditionVariable = "pass",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
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

          GroupId = 104401,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "控制台可交互",
      Actions = {
        {

          StoryId = 4040811,
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
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "isInBattle",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "控制台不可交互",
      Actions = {
        {

          Tips = "1018",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "isInBattle",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "debuff",
      Actions = {
        {

          Target = "Hero",
          MagicId = 40104411,
          Level = 0,
          Type = 16,
          Timeout = 1.0,
          TimeoutKey = "NFKbOloa"
        },
        {

          Target = "Hero",
          MagicId = 40104403,
          Level = 0,
          Type = 16,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Target = "Hero",
          MagicId = 40104406,
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

      EventName = "调查剧情1",
      Actions = {
        {

          StoryId = 4040809,
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

      EventName = "控制台交互",
      Actions = {
        {

          CustomEventName = "控制台可交互",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "控制台不可交互",
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

      EventName = "调查剧情2",
      Actions = {
        {

          StoryId = 4040810,
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

          TimelineName = "timeline_104401_enter",
          Actions = {
            {

              PosKey = "NPC2",
              NPCName = "wJViVHzr",
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
              NpcId = 638310989249217163,
              IsRemove = true,
              CustomEventName = "调查剧情1",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "NPC3",
              NPCName = "nwKFQAfH",
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
              NpcId = 638310989533027646,
              IsRemove = true,
              CustomEventName = "调查剧情2",
              Type = 92,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              CustomEventName = "debuff",
              Type = 19,
              Timeout = 0.0
            },
            {

              StoryId = 5040801,
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

              Key = "save0",
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
                MonsterCount = 2,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104405,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "iLQoZEaA"
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

          StoryId = 4040811,
          StepId = 11,
          Actions = {
            {

              ObjName = "/Root/Level_/FX_water",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Key = "is_water_open",
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
        },
        {

          StoryId = 4040811,
          StepId = 14,
          Actions = {
            {

              ObjName = "/Root/Level_/4-8-1control_left",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          StoryId = 4040811,
          StepId = 16,
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L3"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level_/4-8-1control_right",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "pass",
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

          NPCId = 10450106,
          Actions = {
            {

              UIName = "fight",
              ObjectName = "Btn_skill3",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 40104408,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 40104407,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Key = "104501_shanbi_recovery",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "104501_speed_up",
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
      Type = 20,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          DeathType = "DEFAULT",
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

              Type = 132,
              Timeout = 1.0,
              TimeoutKey = "oZprpJDP"
            },
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "waJncJpB"
            },
            {

              CustomEventName = "debuff",
              Type = 19,
              Timeout = 1.1,
              TimeoutKey = "hytWryfL"
            },
            {

              Tips = "1019",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 1.5,
              TimeoutKey = "twvCPZls"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Type = 69,
              Timeout = 1.0,
              TimeoutKey = "ZeRrfcNd"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104403,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "kRcZwlEZ"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104404,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "LeWtWPHQ"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104405,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "LFCEVmGD"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104406,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "hETaUUtD"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104407,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "CQrqMjOs"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Group = 104403,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "snhSTVmv"
            },
            {

              Group = 104404,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "xPLQeqPh"
            },
            {

              Group = 104405,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "afsaIUdy"
            },
            {

              Group = 104406,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "lnSqJtCV"
            },
            {

              Group = 104407,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "qoCxNaus"
            },
            {

              GroupId = 104403,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "OHqvrwXz"
            },
            {

              GroupId = 104404,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "NwQJaVli"
            },
            {

              GroupId = 104405,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "kZliuekW"
            },
            {

              GroupId = 104406,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "raCjLSRY"
            },
            {

              GroupId = 104407,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "qNSFnuch"
            }
          },
          ValidInTower = false
        }
      },
      Type = 38,
      ConditionVariable = "save0",
      IsNotCondition = false,
      IsForeverVariable = false,
      HyperlinkStr = "http://redmine.mingzhougame.com/issues/2957"
    },
    {

      ConditionActions = {
        {

          DeathType = "DEFAULT",
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

              Type = 132,
              Timeout = 1.0,
              TimeoutKey = "oYWgVCwC"
            },
            {

              NPC = "Hero",
              Point = "savePoint1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "dlJwUodT"
            },
            {

              CustomEventName = "debuff",
              Type = 19,
              Timeout = 1.1,
              TimeoutKey = "KVLyouKj"
            },
            {

              Tips = "1019",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 1.5,
              TimeoutKey = "CBJXhUaf"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Type = 69,
              Timeout = 1.0,
              TimeoutKey = "PVdhKwUn"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104404,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "ejpDetOy"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104405,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "tPtMphUU"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104406,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "yhoxiwFo"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104407,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "keBwkCJU"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Group = 104404,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "nXBedvfC"
            },
            {

              Group = 104405,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "TogltMZO"
            },
            {

              Group = 104406,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "ILATYYit"
            },
            {

              Group = 104407,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "GeGfCeVT"
            },
            {

              GroupId = 104404,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "rkjhgEwW"
            },
            {

              GroupId = 104405,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "cJdFlnhh"
            },
            {

              GroupId = 104406,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "XjDiikGm"
            },
            {

              GroupId = 104407,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "eERJPiBy"
            }
          },
          ValidInTower = false
        }
      },
      Type = 38,
      ConditionVariable = "save1",
      IsNotCondition = false,
      IsForeverVariable = false,
      HyperlinkStr = "http://redmine.mingzhougame.com/issues/2957"
    },
    {

      ConditionActions = {
        {

          DeathType = "DEFAULT",
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

              Type = 132,
              Timeout = 1.0,
              TimeoutKey = "MaawuLMh"
            },
            {

              NPC = "Hero",
              Point = "savePoint2",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "HJiWOJSM"
            },
            {

              CustomEventName = "debuff",
              Type = 19,
              Timeout = 1.1,
              TimeoutKey = "aDhNAwOs"
            },
            {

              Tips = "1019",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 1.5,
              TimeoutKey = "IaxTMYzD"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Type = 69,
              Timeout = 1.0,
              TimeoutKey = "OdJLWQtQ"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104405,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "AGyzIjBL"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104406,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "SAHZyeRE"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104407,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "GRrGnXSl"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Group = 104405,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "duDEBKJI"
            },
            {

              Group = 104406,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "FVzSDWRQ"
            },
            {

              Group = 104407,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "XKtZnnEC"
            },
            {

              GroupId = 104405,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "DYJfYHHE"
            },
            {

              GroupId = 104406,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "pqooQrhs"
            },
            {

              GroupId = 104407,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "zhzBkhsg"
            }
          },
          ValidInTower = false
        }
      },
      Type = 38,
      ConditionVariable = "save2",
      IsNotCondition = false,
      IsForeverVariable = false,
      HyperlinkStr = "http://redmine.mingzhougame.com/issues/2957"
    },
    {

      ConditionActions = {
        {

          DeathType = "DEFAULT",
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

              Type = 132,
              Timeout = 1.0,
              TimeoutKey = "eHXmhlKq"
            },
            {

              NPC = "Hero",
              Point = "savePoint3",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "fCrzCxhm"
            },
            {

              CustomEventName = "debuff",
              Type = 19,
              Timeout = 1.1,
              TimeoutKey = "ejcxesaU"
            },
            {

              Tips = "1019",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 1.5,
              TimeoutKey = "hCvJXrNH"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Type = 69,
              Timeout = 1.0,
              TimeoutKey = "nVxNiRTn"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104406,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "PDyqWSgb"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104407,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "kAcanhys"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Group = 104406,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "mrJntEYf"
            },
            {

              Group = 104407,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "LFcpmABf"
            },
            {

              GroupId = 104406,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "CaoQQWvv"
            },
            {

              GroupId = 104407,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "FkNkTRJf"
            }
          },
          ValidInTower = false
        }
      },
      Type = 38,
      ConditionVariable = "save3",
      IsNotCondition = false,
      IsForeverVariable = false,
      HyperlinkStr = "http://redmine.mingzhougame.com/issues/2957"
    },
    {

      ConditionActions = {
        {

          DeathType = "DEFAULT",
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

              Type = 132,
              Timeout = 1.0,
              TimeoutKey = "TfGegYjQ"
            },
            {

              NPC = "Hero",
              Point = "savePoint4",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "YqXgGzwd"
            },
            {

              CustomEventName = "debuff",
              Type = 19,
              Timeout = 1.1,
              TimeoutKey = "XCumWVxG"
            },
            {

              Tips = "1019",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 1.5,
              TimeoutKey = "tSKxMXZo"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Type = 69,
              Timeout = 1.0,
              TimeoutKey = "OaedXfqd"
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104407,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 104401,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.1,
              TimeoutKey = "nNqxijdl"
            }
          },
          ValidInTower = false
        },
        {

          DeathType = "DEFAULT",
          Actions = {
            {

              Group = 104407,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "LDofwlPB"
            },
            {

              GroupId = 104407,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "jXiSeWxL"
            }
          },
          ValidInTower = false
        }
      },
      Type = 38,
      ConditionVariable = "save4",
      IsNotCondition = false,
      IsForeverVariable = false,
      HyperlinkStr = "http://redmine.mingzhougame.com/issues/2957"
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
    EventCount = 20,
    MonsterCount = 48,
    MonsterInfo = {
      [ 20104301 ] = 13,
      [ 20104501 ] = 10,
      [ 20104502 ] = 25
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}