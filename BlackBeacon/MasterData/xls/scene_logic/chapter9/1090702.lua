local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_AirWall1090702",
          IsPlay = true,
          Type = 110,
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

          Key = "barrierLen",
          SyncValType = 1,
          Value = 8.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090702001,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "yAVesujj"
        },
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 18.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "CebtCZgU"
        },
        {

          GroupId = 1090702008,
          Type = 27,
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

          StoryId = 1003011301,
          Actions = {
            {

              StoryId = 34011302,
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
              Timeout = 4.0,
              TimeoutKey = "WEInoYpR"
            },
            {

              PosKey = "Door",
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
              Timeout = 1.0,
              TimeoutKey = "LhEziDqn"
            },
            {

              PosKey = "Target1",
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
              Timeout = 3.0,
              TimeoutKey = "SqFUMqmS"
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 3.9,
              TimeoutKey = "TFCVbVTi"
            },
            {

              Camera = 1090001,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = "NwyHJAuz"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 34011302,
          Actions = {
            {

              GroupId = 1090702002,
              Type = 27,
              Timeout = 1.0,
              TimeoutKey = "tXWhBUHM"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              TipsId = 10901022,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              KeyName = "Target1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskGroupId = 10907,
              Type = 21,
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

          Key = "Focus",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "Jupiter",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
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
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "3001086Complete",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "普通点完成",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "木星完成",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "3001086Complete",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "普通点完成",
      Actions = {
        {

          Key = "1Complete",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "NHIiSFmr"
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

          TimelineName = "Timeline_Sc09_Shadow_6",
          IsPlay = true,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "zFmOzota"
        },
        {

          PosKey = "Story1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 1,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 2.0,
          TimeoutKey = "UnaSFUCU"
        },
        {

          Group = 1090702002,
          Type = 65,
          Timeout = 0.0
        },
        {

          Camera = 104,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "XrLVuLOF"
        },
        {

          TipsId = 10901022,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          PosKey = "Story1",
          Rotation = 0,
          NPCId = 1090001,
          NPCName = "1",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "JnIVRQiE"
        },
        {

          KeyName = "Story1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 2.0,
          TimeoutKey = "WwPOECWj"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 1.0,
          TimeoutKey = "EcJHkITA"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "1Complete",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 34011303,
          Actions = {
            {

              TimelineName = "Timeline_Sc09_Shadow_6",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "PJBIKBDH"
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

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 4,
                MonsterCount = 24,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 109070201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb1",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109070202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb2",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109070203,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb3",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109070204,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb4",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 2.5,
              TimeoutKey = "mOhgZbyY"
            },
            {

              PosKey = "Fight",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 1.5,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 1.5,
              Type = 62,
              Timeout = 2.0,
              TimeoutKey = "imrZsgfc"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 1.0,
              TimeoutKey = "HQCVtSCG"
            },
            {

              TaskId = 1090701,
              Type = 5,
              Timeout = 1.0,
              TimeoutKey = "xSFViuAb"
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

      EventName = "qb1",
      Actions = {
        {

          GroupId = 1090702003,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "XzsqcvqV"
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

          GroupId = 1090702004,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "JqiJHsym"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb3",
      Actions = {
        {

          GroupId = 1090702005,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "CXxozHXv"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb4",
      Actions = {
        {

          StoryId = 34011304,
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
          TimeoutKey = "XbMtSprF"
        },
        {

          PosKey = "Jupiter",
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
          Timeout = 2.5,
          TimeoutKey = "PoUNHvfE"
        },
        {

          GroupId = 1090702006,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "btUwmyem"
        },
        {

          GroupId = 1090702007,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "emqFvfFb"
        },
        {

          PosKey = "Target2",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 1,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "Zvnmgxla"
        },
        {

          Camera = 113,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.5,
          TimeoutKey = "QkudiFnS"
        },
        {

          Camera = 1092701,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 4.0,
          TimeoutKey = "seKIkmMb"
        },
        {

          PosKey = "Target2",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 4.5,
          TimeoutKey = "boZOLvda"
        },
        {

          TipsId = 10907021,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 4.5,
          TimeoutKey = "iMndkmWq"
        },
        {

          KeyName = "Target2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 1.0,
          TimeoutKey = "tgfdamGY"
        },
        {

          TaskId = 1090703,
          Type = 5,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "qb4",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "木星完成",
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

          PosKey = "Story2",
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
          TimeoutKey = "iOemCxod"
        },
        {

          Group = 1090702007,
          Type = 65,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_Sc09_Shadow_7",
          IsPlay = true,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "LPGsPUZn"
        },
        {

          Group = 1090702001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090702004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090702005,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090702003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Camera = 113,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "UEFLlASj"
        },
        {

          TipsId = 10907021,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          PosKey = "Story2",
          Rotation = 0,
          NPCId = 1090003,
          NPCName = "2",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "rQKdWPcS"
        },
        {

          KeyName = "Story2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 1.0,
          TimeoutKey = "gbElMeKP"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 1.0,
          TimeoutKey = "kBgToTIw"
        },
        {

          TaskId = 1090704,
          Type = 5,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "Jupiter",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "1Complete",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "清理障碍",
      Actions = {
        {

          Group = 1090702001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090702003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Key = "LockOrb",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Group = 1090702004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090702005,
          Type = 65,
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

      EventName = "FAIL",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 12,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 109070202,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 109070201,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "清理障碍",
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 34011305,
          Actions = {
            {

              StoryId = 34011306,
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
              TimeoutKey = "nBovEjUt"
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

              PosKey = "Door",
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
              Timeout = 2.0,
              TimeoutKey = "NptQAlQr"
            },
            {

              TimelineName = "Timeline_Sc09_Shadow_7",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "MMVWDNxm"
            },
            {

              TimelineName = "Timeline_AirWall1090702",
              IsPlay = false,
              Type = 110,
              Timeout = 2.5,
              TimeoutKey = "TUXEXxwj"
            },
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "mvjwNoUJ"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 1.0,
              TimeoutKey = "CmhaRlsq"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 34011306,
          Actions = {
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.5,
              TimeoutKey = "SBWVXBvT"
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            },
            {

              Direction = 4,
              Type = 51,
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

          Key = "End",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              TaskId = 1090706,
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

          Key = "Focus2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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

      StoryID = 1003011301,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 1003011301,
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

      ConditionActions = {
        {

          NPCId = 1090001,
          Actions = {
            {

              StoryId = 34011303,
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

              PosKey = "Story1",
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

              Type = 71,
              Timeout = 0.0
            },
            {

              TaskId = 1090702,
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

      ConditionActions = {
        {

          NPCId = 1090003,
          Actions = {
            {

              StoryId = 34011305,
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

              PosKey = "Story2",
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

              Type = 71,
              Timeout = 0.0
            },
            {

              TaskId = 1090705,
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
    MonsterCount = 36,
    MonsterInfo = {
      [ 20105801 ] = 8,
      [ 20106101 ] = 6,
      [ 20105901 ] = 13,
      [ 20205501 ] = 4,
      [ 20106201 ] = 3,
      [ 20105601 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}