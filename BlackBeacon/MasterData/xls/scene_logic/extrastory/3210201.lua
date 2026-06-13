local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Level/Section_02/Zone_02/sc03_prp_04a_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Section_02/Zone_02/sc03_prp_04a_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/Section_02/Zone_02/sc03_02_anim_02 (1)/switch_on",
          Rewind = 0.01,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/Section_02/Zone_02/sc03_02_anim_01 (1)/switch_on",
          Rewind = 0.01,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/ExtraStory/321/32102/Room1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling1-2/spiling_down",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling2-1/spiling_down",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling2-3/spiling_down",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling3-2/spiling_down",
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

          ResId = 10210105,
          PosKey = "T1",
          Camp = 4,
          Rotation = 0,
          Level = 1,
          NPCName = "spiling1-1",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "T2",
          Camp = 4,
          Rotation = 0,
          Level = 1,
          NPCName = "spiling1-3",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "T3",
          Camp = 4,
          Rotation = 0,
          Level = 1,
          NPCName = "spiling2-2",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "T4",
          Camp = 4,
          Rotation = 0,
          Level = 1,
          NPCName = "spiling3-1",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "T5",
          Camp = 4,
          Rotation = 0,
          Level = 1,
          NPCName = "spiling3-3",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
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

          PosKey = "npc1",
          Rotation = 150,
          NPCId = 302121,
          NPCName = "看戏沙玛士",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "aiczpifj"
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
                Id = 21001,
                param = 0,
                Name = "全部杀死",
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

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
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
        },
        {

          FadeIn = 0.0,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          StoryId = 2221201,
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
          TimeoutKey = "izljXIbU"
        }
      },
      ValidInTower = false,
      Type = 1,
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

          TaskGroupId = 32102,
          Type = 21,
          Timeout = 0.0
        },
        {

          KeyName = "npc1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          PosKey = "npc1",
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

          Key = "dialog1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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

              Type = 14,
              Timeout = 0.5,
              TimeoutKey = "mmEGsTvo"
            },
            {

              NPC = "Hero",
              Point = "hero1",
              Rotate = 30.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "YrpZpUSq"
            },
            {

              Group = 21001,
              Type = 65,
              Timeout = 0.0
            },
            {

              PosKey = "npc2-1",
              Rotation = 225,
              NPCId = 302122,
              NPCName = "训练中伊蕾",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "Erpylrkl"
            },
            {

              StoryId = 2221203,
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
              TimeoutKey = "RSMmZOXi"
            },
            {

              Type = 71,
              Timeout = 1.0,
              TimeoutKey = "npkQbZan"
            },
            {

              TaskId = 3210202,
              Type = 5,
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

          StoryId = 2221202,
          Actions = {
            {

              KeyName = "interact",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              PosKey = "interact",
              NPCName = "switch",
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
              NpcId = 638519748592717977,
              IsRemove = true,
              CustomEventName = "开启楼梯",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2221203,
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

              NPCId = 302122,
              NPCName = "训练中伊蕾",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "tuQEAiGI"
            },
            {

              PosKey = "npc2-2",
              Rotation = -45,
              NPCId = 302123,
              NPCName = "旁观伊蕾",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "PjsWUDdX"
            },
            {

              GroupID = 1,
              Type = 86,
              Timeout = 1.0,
              TimeoutKey = "wypqepSv"
            },
            {

              CustomEventName = "木桩关闭",
              Type = 19,
              Timeout = 2.0,
              TimeoutKey = "SDyBKyiT"
            },
            {

              Path = "/Root/Level/Section_02/Zone_02/sc03_02_anim_02 (1)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 2.0,
              TimeoutKey = "frcFIjLR"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 7,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 21003,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 21002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "training_over",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 3.0,
              TimeoutKey = "XwlqQzAL"
            },
            {

              TimelineName = "timeline_321020101",
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
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 1.0,
              TimeoutKey = "jHUEASHm"
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

          NPCId = 302121,
          Actions = {
            {

              StoryId = 2221202,
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

              Type = 71,
              Timeout = 0.0
            },
            {

              TaskId = 3210201,
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

      EventName = "开启楼梯",
      Actions = {
        {

          Path = "/Root/Level/Section_02/Zone_02/sc03_02_anim_02 (1)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          KeyName = "hero1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

      EventName = "木桩关闭",
      Actions = {
        {

          NpcName = "spiling1-1",
          Type = 83,
          Timeout = 0.0
        },
        {

          NpcName = "spiling1-3",
          Type = 83,
          Timeout = 0.0
        },
        {

          NpcName = "spiling2-2",
          Type = 83,
          Timeout = 0.0
        },
        {

          NpcName = "spiling3-1",
          Type = 83,
          Timeout = 0.0
        },
        {

          NpcName = "spiling3-3",
          Type = 83,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling1-1/spiling_switch",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling1-3/spiling_switch",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling2-2/spiling_switch",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling3-1/spiling_switch",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling3-3/spiling_switch",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
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

      EventName = "training_over",
      Actions = {
        {

          GroupID = 1,
          Type = 87,
          Timeout = 0.0
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

          PosKey = "focus",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 3.0,
          StopLuaScript = true,
          BackToDefault = true,
          HideUI = true,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "CqHUWDDN"
        },
        {

          NPCId = 302123,
          NPCName = "旁观伊蕾",
          Type = 1,
          Timeout = 1.0,
          TimeoutKey = "jiAJQlGk"
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
                Id = 21004,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "over",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 1.0,
          TimeoutKey = "wteNRrYt"
        },
        {

          StoryId = 3221201,
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

          TaskId = 3210203,
          Type = 5,
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

      EventName = "over",
      Actions = {
        {

          StoryId = 100221202,
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
          Timeout = 1.0,
          TimeoutKey = "FdOQoTzx"
        },
        {

          TaskId = 3210204,
          Type = 5,
          Timeout = 0.0
        },
        {

          FadeIn = 0.5,
          Hold = 2.0,
          FadeOut = 0.0,
          IsWhite = false,
          Type = 59,
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

          StoryId = 100221202,
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

      ConditionActions = {
        {

          NPCName = "spiling1-1",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling1-1/spiling_hit",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling1-3",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling1-3/spiling_hit",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling2-2",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling2-2/spiling_hit",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling3-1",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling3-1/spiling_hit",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling3-3",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/ExtraStory/321/32102/Room1/Spiling/spiling3-3/spiling_hit",
              PlatCount = 0,
              Type = 96,
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

      ConditionActions = {
        {

          NPCName = "spiling1-1",
          HitType = 2,
          Actions = {
            {

              NpcName = "spiling1-1",
              Type = 83,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "T1",
              Camp = 4,
              Rotation = 0,
              Level = 1,
              NPCName = "spiling1-1",
              Cd = 0.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.5,
              TimeoutKey = "HZcBklAX"
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling1-3",
          HitType = 2,
          Actions = {
            {

              NpcName = "spiling1-3",
              Type = 83,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "T2",
              Camp = 4,
              Rotation = 0,
              Level = 1,
              NPCName = "spiling1-3",
              Cd = 0.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.5,
              TimeoutKey = "eXXXRdgW"
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling2-2",
          HitType = 2,
          Actions = {
            {

              NpcName = "spiling2-2",
              Type = 83,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "T3",
              Camp = 4,
              Rotation = 0,
              Level = 1,
              NPCName = "spiling2-2",
              Cd = 0.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.5,
              TimeoutKey = "fcTJvvnf"
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling3-1",
          HitType = 2,
          Actions = {
            {

              NpcName = "spiling3-1",
              Type = 83,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "T4",
              Camp = 4,
              Rotation = 0,
              Level = 1,
              NPCName = "spiling3-1",
              Cd = 0.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.5,
              TimeoutKey = "wIEjnRuT"
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "spiling3-3",
          HitType = 2,
          Actions = {
            {

              NpcName = "spiling3-3",
              Type = 83,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "T5",
              Camp = 4,
              Rotation = 0,
              Level = 1,
              NPCName = "spiling3-3",
              Cd = 0.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.5,
              TimeoutKey = "ldVksRBK"
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
    EventCount = 3,
    MonsterCount = 9,
    MonsterInfo = {
      [ 20102504 ] = 1,
      [ 20104201 ] = 6,
      [ 20103202 ] = 1,
      [ 20102501 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}