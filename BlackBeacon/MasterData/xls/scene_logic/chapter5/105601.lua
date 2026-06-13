local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Configs = {
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560101",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560102",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560103",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560104",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560105",
              NpcId = 201203,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560106",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560107",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560108",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560109",
              NpcId = 201203,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560110",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560111",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560112",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560113",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = true
            }
          },
          Type = 104,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 180,
          NPCId = 10560101,
          NPCName = "路人（害怕）",
          Type = 0,
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

      NoPassCamera = 117,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
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

          ObjName = "SceneNPC1_/1056and1058/105601",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupId = 10560101,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1056,
          Type = 21,
          Timeout = 0.0
        },
        {

          GroupID = 8,
          Type = 86,
          Timeout = 0.0
        },
        {

          StoryId = 5051101,
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

          KeyName = "M2",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          CustomEventName = "box10507",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "boxlite10508",
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ContainerName = "Level",
          Names = {
            "L15"
          },
          States = {
            "2"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L12"
          },
          States = {
            "2"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L17"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L18"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
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

          Key = "B1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "EndGuide",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
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

          Key = "Z3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
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
                    Id = 10510612,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb2",
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

              PosKey = "F1",
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
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 86,
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

          Key = "BOXFIGHT",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 6,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10510615,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "box10520",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10510616,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "box10508",
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
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "10508",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "TimeLine_10560101",
              Fadein = 1.0,
              Fadeout = 1.0,
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

              ContainerName = "Level",
              Names = {
                "L18"
              },
              States = {
                "3"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            },
            {

              ContainerName = "Level",
              Names = {
                "L17"
              },
              States = {
                "3"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            },
            {

              StoryId = 5051102,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "Z2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L1"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
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

          StoryId = 6050401,
          Actions = {
            {

              TreasureChestId = 10507,
              PosKey = "BOX1",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd10507",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "JGuOJSir"
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

          StoryId = 4051101,
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

              GroupID = 8,
              Type = 87,
              Timeout = 0.0
            },
            {

              NPCId = 10560102,
              NPCName = "路人",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "dcbcZyjX"
            },
            {

              TaskId = 105602,
              Type = 5,
              Timeout = 1.0,
              TimeoutKey = "cpnQBKHz"
            },
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 2.0,
              TimeoutKey = "LIsnrlDJ"
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

          NPCId = 1052037,
          Actions = {
            {

              NPCId = 1052037,
              NPCName = "chazhen",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10508,
              PosKey = "BOX1",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd10508",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "WZyPDBqF"
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
        },
        {

          NPCId = 1052038,
          Actions = {
            {

              NPCId = 1052038,
              NPCName = "chazhen",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10509,
              PosKey = "BOX3",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd10509",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "GbWuaZKG"
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

      ConditionActions = {
        {

          NPCId = 10560102,
          Actions = {
            {

              StoryId = 4051101,
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

      EventName = "box10508",
      Actions = {
        {

          TreasureChestId = 10508,
          PosKey = "BOX2",
          Rotation = -90,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "boxEnd10508",
          Type = 124,
          Timeout = 1.0,
          TimeoutKey = "ApZUkOea"
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

          PosKey = "BOX2",
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
          TimeoutKey = "foOGrycy"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10508",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "boxEnd10509",
      Actions = {
        {

          Variable = "10509",
          Type = 128,
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

      EventName = "box10509",
      Actions = {
        {

          PosKey = "BOX3",
          Rotation = 0,
          NPCId = 1052038,
          NPCName = "chazhen",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10509",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "box10507",
      Actions = {
        {

          PosKey = "BOX1",
          NPCName = "UFVGZbLD",
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
          NpcId = 638624390723686243,
          IsRemove = true,
          CustomEventName = "boxPre10507",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10507",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "boxEnd10507",
      Actions = {
        {

          Variable = "10507",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10507CLOSE",
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

      EventName = "boxPre10507",
      Actions = {
        {

          StoryId = 6050401,
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

      EventName = "qb1",
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

          PosKey = "M2",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 4.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 4.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          NPCId = 10560101,
          NPCName = "路人（害怕）",
          Type = 1,
          Timeout = 0.7,
          TimeoutKey = "IRRvtiBq"
        },
        {

          PosKey = "M2",
          Rotation = 180,
          NPCId = 10560102,
          NPCName = "路人",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "dPKqUNeS"
        },
        {

          ContainerName = "Level",
          Names = {
            "L18"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 4.0,
          TimeoutKey = "uuIzAido"
        },
        {

          ContainerName = "Level",
          Names = {
            "L17"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 4.0,
          TimeoutKey = "lPiJonPQ"
        },
        {

          ObjName = "/Root/Level/6/L7_/A1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 4.0,
          TimeoutKey = "SEgfkGAk"
        },
        {

          KeyName = "M2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 1.0,
          TimeoutKey = "pEHqCcBI"
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

          TimelineName = "TimeLine_10560103",
          Fadein = 1.0,
          Fadeout = 1.0,
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
          Timeout = 1.5,
          TimeoutKey = "rMvZiHwE"
        },
        {

          StoryId = 5051103,
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

      EventName = "boxEnd10508",
      Actions = {
        {

          Variable = "10508",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10508CLOSE",
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

      EventName = "boxlite10508",
      Actions = {
        {

          TreasureChestId = 10520,
          PosKey = "LB1",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "",
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10521,
          PosKey = "LB2",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "",
          Type = 124,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10508",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "box10520",
      Actions = {
        {

          TreasureChestId = 10520,
          PosKey = "LB1",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "",
          Type = 124,
          Timeout = 0.5,
          TimeoutKey = "ImhsStbk"
        },
        {

          TreasureChestId = 10521,
          PosKey = "LB2",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "",
          Type = 124,
          Timeout = 0.5,
          TimeoutKey = "EvxzQliz"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10507CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10507",
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

      EventName = "GBOX10507OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10507",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10507",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10508CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10508",
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

      EventName = "GBOX10508OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10508",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10508",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TimelineName = "TimeLine_10560101",
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
                    Id = 10510611,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb1",
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

              TaskId = 105601,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "TimeLine_10560102",
          Actions = empty,
          ValidInTower = false
        },
        {

          TimelineName = "TimeLine_10560103",
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.5,
              TimeoutKey = "BuWsOgNe"
            },
            {

              TaskId = 105603,
              Type = 5,
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

          NPCName = "10560102",
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L15"
              },
              States = {
                "4"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "10560103",
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L12"
              },
              States = {
                "4"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 30,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10507OPEN",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10508OPEN",
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

          CustomEventName = "GBOX10507CLOSE",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10508CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
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
      [ 20304402 ] = 1,
      [ 20204301 ] = 4,
      [ 20204601 ] = 5,
      [ 20204401 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}