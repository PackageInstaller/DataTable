return
{
  Events = {
    {

      Actions = {
        {

          TaskGroupId = 31902,
          Type = 21,
          Timeout = 0.0
        },
        {

          Key = "into_fengzheng",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "catch",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "nowaytorun",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          Key = "kaoda",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupID = 10,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 4,
          Type = 86,
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

      NoPassCamera = 319020101,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 319020105,
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

          GroupId = 1902,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "fengzheng",
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
          NpcId = 638460252111606115,
          IsRemove = true,
          CustomEventName = "get_fengzheng",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 45,
          NPCId = 301906,
          NPCName = "fu",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          Rotation = 135,
          NPCId = 301907,
          NPCName = "qi",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M4",
          Rotation = 90,
          NPCId = 301908,
          NPCName = "beihairen",
          Type = 0,
          Timeout = 0.0
        },
        {

          StoryId = 32019000,
          BarrageStyle = 2,
          Alpha = 1.0,
          Speed = 200,
          Type = 113,
          Timeout = 0.0,
          TimeoutKey = ""
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
            "L11"
          },
          States = {
            "4"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L0"
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
            "L1"
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
            "L6"
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
            "L7"
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
        },
        {

          ContainerName = "Level",
          Names = {
            "L15"
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

      Actions = {
        {

          Key = "nowaytorun",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_juese_319020102",
          IsPlay = false,
          Type = 110,
          Timeout = 0.5,
          TimeoutKey = "AknTplab"
        },
        {

          NPC = "Hero",
          Point = "M6",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "ZMndWYkm"
        },
        {

          Group = 1901,
          Type = 65,
          Timeout = 0.0
        },
        {

          IsNeedAnimation = true,
          Type = 106,
          Timeout = 0.0
        },
        {

          StoryId = 2219109,
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

          TaskId = 3190202,
          Type = 5,
          Timeout = 0.0
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
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "nowaytorun",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "camera1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Camera = 319020103,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Camera = 319020104,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Camera = 319020105,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              Key = "catch",
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

              StoryId = 3219103,
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

          Key = "Z3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "TimeLine_juese_319020102",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              StoryId = 3219114,
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

              StoryId = 32019306,
              BarrageStyle = 2,
              Alpha = 0.0,
              Speed = 200,
              Type = 113,
              Timeout = 5.0,
              TimeoutKey = "aWsMMKzp"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "catch",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "dm1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 32019302,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "dm2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 32019303,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "dm4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 32019305,
              BarrageStyle = 0,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "dm3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 32019304,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "dm5",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              CustomEventName = "kd",
              Type = 19,
              Timeout = 0.0
            },
            {

              Key = "kaoda",
              SyncValType = 2,
              Value = false,
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

          Key = "Z1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              GroupID = 4,
              Type = 87,
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

              NPC = "Hero",
              Point = "M5",
              Rotate = -90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "ctaOWzRR"
            },
            {

              AreaName = "Z2",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              StoryId = 2219108,
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
              Timeout = 2.0,
              TimeoutKey = "IMXJpCIT"
            },
            {

              TimelineName = "TimeLine_juese_319020101",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "pKfXrWkX"
            },
            {

              NPCId = 301906,
              NPCName = "fu",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "ayvdSgjl"
            },
            {

              NPCId = 301907,
              NPCName = "qi",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "IUuuxFea"
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "into_fengzheng",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2219106,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              GroupId = 31902,
              Type = 42,
              Timeout = 0.0
            },
            {

              Enable = true,
              Type = 17,
              Timeout = 0.0
            },
            {

              StoryId = 32019301,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219107,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              KeyName = "M2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219108,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219109,
          Actions = {
            {

              CustomEventName = "薪登场",
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

          NPCId = 301906,
          Actions = {
            {

              PosKey = "M1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              StoryId = 2219106,
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
              TimeoutKey = "tXBLNYdM"
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

          Enable = false,
          Type = 17,
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

          GroupId = 31902,
          Actions = {
            {

              StoryId = 32019301,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              GuideId = 319002,
              Type = 41,
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

      EventName = "get_fengzheng",
      Actions = {
        {

          StoryId = 2219107,
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

          Key = "into_fengzheng",
          SyncValType = 2,
          Value = true,
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

      EventName = "kd",
      Actions = {
        {

          StoryId = 32019307,
          BarrageStyle = 0,
          Alpha = 1.0,
          Speed = 200,
          Type = 113,
          Timeout = 0.0
        },
        {

          StoryId = 3219115,
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
          TimeoutKey = "kcPnYmJZ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "kaoda",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "薪登场",
      Actions = {
        {

          TimelineName = "TimeLine_319020101",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.5,
          Hold = 1.0,
          BlackOut = 0.5,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.5,
          BeforeHold = 1.0,
          BeforeBlackOut = 0.5,
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

      ConditionActions = {
        {

          TimelineName = "TimeLine_319020101",
          Actions = {
            {

              StoryId = 2219117,
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

          StoryId = 2219108,
          StepId = 10,
          Actions = {
            {

              Camera = 319020102,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "runstart",
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
              Timeout = 0.0
            },
            {

              GroupId = 1901,
              Type = 27,
              Timeout = 0.0
            },
            {

              TaskId = 3190201,
              Type = 5,
              Timeout = 0.0
            },
            {

              StyleIndex = 2,
              InitValue = 0,
              UpInterval = 1,
              UpSpeed = 0,
              CurrRoomFinalValue = 100,
              AllRoomFinalValue = 100,
              IsNeedAnimation = true,
              Type = 101,
              Timeout = 0.0
            },
            {

              GroupID = 2,
              Type = 86,
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

          TaskId = 3190201,
          Actions = {
            {

              GroupID = 10,
              Type = 87,
              Timeout = 0.0
            },
            {

              Key = "kaoda",
              SyncValType = 2,
              Value = false,
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

      ConditionActions = {
        {

          TimelineName = "TimeLine_319020101",
          Actions = {
            {

              StoryId = 3219104,
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
              Timeout = 3.0,
              TimeoutKey = "soBQgHiK"
            },
            {

              StoryId = 32019306,
              BarrageStyle = 0,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
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
      StoryId = 2219117,
      Name = "6.剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}