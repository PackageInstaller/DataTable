local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "A1",
          Rotation = 0,
          NPCId = 101105,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "A2",
          Rotation = 0,
          NPCId = 101106,
          Type = 0,
          Timeout = 0.0
        },
        {

          StoryId = 4041401,
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

          Configs = {
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10470101",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10470102",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10470103",
              NpcId = 201203,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10470104",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10470105",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10470106",
              NpcId = 201203,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            }
          },
          Type = 104,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/SceneNPC1_/104701",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          ContainerName = "Level",
          Names = {
            "L6"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10407",
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

          Key = "C1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
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
                    RefreshCondition = 1,
                    Id = 10410911,
                    param = 1,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10410912,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb",
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
        },
        {

          Key = "C2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "people1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "C3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10410913,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "AC",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10410914,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "AA",
                    Timeout = 0.5,
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
      ConditionVariable = "people2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4041404,
          Actions = {
            {

              TaskId = 104803,
              Type = 5,
              Timeout = 2.0,
              TimeoutKey = "KmFfTvqa"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 1.0,
              TimeoutKey = "vHYWquHd"
            },
            {

              FadeIn = 0.5,
              Hold = 1.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_n04622",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "hUAFpNry"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4041401,
          Actions = {
            {

              TaskId = 104107,
              Type = 5,
              Timeout = 0.0
            },
            {

              TaskGroupId = 1048,
              Type = 21,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4041402,
          Actions = {
            {

              TaskId = 104801,
              Type = 5,
              Timeout = 0.0
            },
            {

              ContainerName = "Level",
              Names = {
                "L7"
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
        },
        {

          StoryId = 4041403,
          Actions = {
            {

              TaskId = 104802,
              Type = 5,
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

          NPCId = 101105,
          Actions = {
            {

              StoryId = 4041402,
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

          NPCId = 101106,
          Actions = {
            {

              StoryId = 4041403,
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

          NPCId = 101107,
          Actions = {
            {

              StoryId = 4041402,
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

          Direction = 1,
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

      EventName = "BOXSTORY",
      Actions = {
        {

          CustomEventName = "BOXSTORY03",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "BOXSTORY02",
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

      EventName = "BOXSTORY02",
      Actions = {
        {

          StoryId = 6040602,
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
      ConditionVariable = "bug",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10407",
      Actions = {
        {

          Variable = "10407",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10407CLOSE",
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

      EventName = "BOX10407",
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

          ObjName = "/Root/Level1/1041051",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "etgyAaoh"
        },
        {

          TreasureChestId = 10407,
          PosKey = "BOX1",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10407",
          Type = 124,
          Timeout = 1.0,
          TimeoutKey = "iRDndvPw"
        },
        {

          CustomEventName = "BOXSTORY",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "hwDymtJf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "AC",
      Actions = {
        {

          StoryId = 5041401,
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
          TimeoutKey = "uRuMVEim"
        },
        {

          PosKey = "M16",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 1.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "OVCBgxJf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          ContainerName = "Level",
          Names = {
            "L5"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
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

      EventName = "AA",
      Actions = {
        {

          StoryId = 4041404,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 1.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0,
          TimeoutKey = "GbsXxGwj"
        },
        {

          NPC = "Hero",
          Point = "M16",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.5,
          TimeoutKey = "YLBtIFFl"
        },
        {

          PosKey = "z",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 1.6,
          TimeoutKey = "JMNRyIhC"
        },
        {

          TimelineName = "timeline_n04622",
          IsPlay = true,
          Type = 110,
          Timeout = 1.5,
          TimeoutKey = "kOXaTUya"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "PREBOX10407",
      Actions = {
        {

          ObjName = "/Root/Level1/1041051",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PosKey = "BOXNPC1",
          Rotation = 0,
          NPCId = 104071,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10407",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOXSTORY03",
      Actions = {
        {

          StoryId = 6040603,
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
      ConditionVariable = "bug",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10407OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10407",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10407",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10407CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10407",
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

          TaskId = 104803,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TaskId = 104802,
          Actions = {
            {

              Key = "people2",
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

          TaskId = 104801,
          Actions = {
            {

              Key = "people1",
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
      Type = 14,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10407OPEN",
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

          CustomEventName = "GBOX10407CLOSE",
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
    EventCount = 2,
    MonsterCount = 11,
    MonsterInfo = {
      [ 20104501 ] = 5,
      [ 20104601 ] = 2,
      [ 20204601 ] = 3,
      [ 20204401 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}