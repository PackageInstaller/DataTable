local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "npc1",
          Rotation = -90,
          NPCId = 10610401,
          NPCName = "平民A",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc2",
          Rotation = 180,
          NPCId = 10610402,
          NPCName = "平民B",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc3",
          Rotation = -90,
          NPCId = 10610403,
          NPCName = "平民C",
          Type = 0,
          Timeout = 0.0
        },
        {

          GroupId = 106104,
          Type = 27,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          PosKey = "npc4",
          Rotation = 0,
          NPCId = 1061001,
          NPCName = "水井",
          Type = 0,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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

      NoPassCamera = 106045,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 106045,
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

          Target = "God",
          MagicId = 106999,
          Level = 0,
          Type = 16,
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

          Key = "enemy1",
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
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10610101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
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

          Key = "enemy2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10610102,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "switch",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "971",
              Duration = 3.0,
              IsOpen = true,
              Type = 94,
              Timeout = 1.0,
              TimeoutKey = "BcwecTvT"
            }
          },
          FinishMarkVariable = "first_switch",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "first_switch",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cam",
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

          Key = "cam",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "npc1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
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

              TaskId = 106101,
              Type = 5,
              Timeout = 0.0
            },
            {

              StoryId = 5060302,
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
          FinishMarkVariable = "cam1",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "cam1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "trg1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "972",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
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

          Key = "cam",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 10610402,
          Actions = {
            {

              CondId = 106101,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              FadeIn = 1.0,
              Hold = 1.0,
              FadeOut = 1.0,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPCId = 10610401,
              Type = 1,
              Timeout = 1.5,
              TimeoutKey = "NdtwhqBg"
            },
            {

              CustomEventName = "yindaoxian",
              Type = 19,
              Timeout = 1.6,
              TimeoutKey = "aKUwDrll"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4060302,
          Actions = {
            {

              CondId = 106102,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              NPCId = 10610402,
              Type = 1,
              Timeout = 1.5,
              TimeoutKey = "BODTaUHP"
            },
            {

              FadeIn = 1.0,
              Hold = 1.0,
              FadeOut = 1.0,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4060303,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 8,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10610101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10610101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "baohu",
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

              NPCId = 10610403,
              NPCActionName = "skill1_6",
              Type = 100,
              Timeout = 0.0
            },
            {

              StoryId = 5060303,
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
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 10610401,
          Actions = {
            {

              StoryId = 10610402,
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

          NPCId = 10610402,
          Actions = {
            {

              CondId = 106102,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              StoryId = 4060302,
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

          NPCId = 10610403,
          Actions = {
            {

              StoryId = 4060303,
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

          NPCId = 1061001,
          Actions = {
            {

              PosKey = "npc4",
              Rotation = 0,
              NPCId = 10610404,
              NPCName = "关卡技能升级",
              Type = 0,
              Timeout = 3.5,
              TimeoutKey = "fuLXoFiq"
            },
            {

              Path = "/Root/Level/Level_01/sc06_build_40_pre/TL_WaterWell",
              PlatCount = 0,
              Type = 96,
              Timeout = 1.0,
              TimeoutKey = "VGmBHMPa"
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 10610404,
          Actions = {
            {

              Level = 1,
              TowerValid = false,
              Type = 95,
              Timeout = 0.0
            },
            {

              Tips = "关卡技能升级提示，拂雾青灯的效率获得了提升（需包装）",
              Duration = 3.0,
              IsOpen = true,
              Type = 94,
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

      EventName = "baohu",
      Actions = {
        {

          CondId = 106103,
          CondValue = 1,
          Type = 31,
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

          NPCId = 10610403,
          Type = 1,
          Timeout = 1.0,
          TimeoutKey = "AoPOlaWR"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "yindaoxian",
      Actions = {
        {

          KeyName = "switch",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.5,
          TimeoutKey = "eHZWFlWr"
        },
        {

          KeyName = "switch",
          IsOpen = false,
          IsContinue = true,
          Type = 70,
          Timeout = 3.5,
          TimeoutKey = "ubtzchax"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "switch",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TaskId = 106102,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              StoryId = 4060304,
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
              Timeout = 2.5,
              TimeoutKey = "MdVlOzZw"
            }
          },
          ValidInTower = false
        }
      },
      Type = 14,
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
    MonsterCount = 15,
    MonsterInfo = {
      [ 20204901 ] = 12,
      [ 20205001 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}