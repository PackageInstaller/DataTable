local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
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

          Key = "3001086Complete",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_AirWall1090301",
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
          Value = 18.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090501001,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "BDdzGYqm"
        },
        {

          GroupId = 1090301001,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "shunxukaiqi",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "dangqianwancheng",
          SyncValType = 1,
          Value = 0.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090501006,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "FnrOKatK"
        },
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 8.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.5,
          TimeoutKey = "vZjQmWJp"
        },
        {

          GroupId = 1090501008,
          Type = 27,
          Timeout = 0.6,
          TimeoutKey = "CQmwimYz"
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

      Actions = {
        {

          Key = "3001086Complete",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "3001086Complete",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "VwBoUOTs"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "3001086Complete",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "ObjComplete30010861",
      Actions = {
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 35.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090501003,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "q1"
        },
        {

          GroupId = 1090501005,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "q1"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "ObjComplete30010862",
      Actions = {
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 15.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090501002,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "q2"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "ObjComplete30010863",
      Actions = {
        {

          Group = 1090501006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090501007,
          Type = 65,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10904,
          PosKey = "Box",
          Rotation = 90,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BoxEnd10904",
          Type = 124,
          Timeout = 3.0,
          TimeoutKey = "JitxydBT"
        },
        {

          PosKey = "Box",
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
          Timeout = 4.0,
          TimeoutKey = "fJrcYpQi"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 2.0,
          TimeoutKey = "bAEhbiMy"
        },
        {

          Group = 1090501009,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10904",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "3001086Complete",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.0,
          TimeoutKey = "YZnUGcAQ"
        },
        {

          GroupID = 1,
          Type = 87,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.3,
          TimeoutKey = "ekBlkyPG"
        },
        {

          StoryId = 34010902,
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
          TimeoutKey = "MFOMBoBd"
        },
        {

          Key = "Complete",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_AirWall1090301",
          IsPlay = false,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "GjyylKyo"
        },
        {

          TaskId = 1090501,
          Type = 5,
          Timeout = 0.0
        },
        {

          TipsId = 10905011,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          PosKey = "tp4",
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

          Camera = 117,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          CustomEventName = "NoBoxSetup",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "BoxSetup",
          Type = 19,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 1.3,
          TimeoutKey = "PjLKJaru"
        }
      },
      FinishMarkVariable = "end",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "end",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "Finish1",
      Actions = {
        {

          StoryId = 35010901,
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
          TimeoutKey = "bUiyBnNB"
        },
        {

          PosKey = "WallFocus",
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
          Timeout = 2.0,
          TimeoutKey = "DLJHqfTV"
        },
        {

          PosKey = "Focus",
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
          Timeout = 5.0,
          TimeoutKey = "uNlenZyA"
        },
        {

          Camera = 1090901,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 2.0,
          TimeoutKey = "yxPQrmQm"
        },
        {

          Camera = 1090001,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 5.0,
          TimeoutKey = "uayQXDOn"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "Finish2",
      Actions = {
        {

          Group = 1090501005,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "aWzcKxyr"
        },
        {

          Group = 1090501003,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "gOfXEcZu"
        },
        {

          Group = 1090501002,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "NgeyXgrX"
        },
        {

          Group = 1090301001,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = "SUpUMcmS"
        },
        {

          Key = "q1",
          Type = 52,
          Timeout = 1.0,
          TimeoutKey = "CoIlyJBI"
        },
        {

          Key = "q2",
          Type = 52,
          Timeout = 1.0,
          TimeoutKey = "BlPlVfZY"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      StoryID = 1003010901,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 1003010901,
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

          StoryId = 1003010901,
          Actions = {
            {

              StoryId = 34010901,
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
              TimeoutKey = "UwJCTovP"
            },
            {

              TaskGroupId = 10905,
              Type = 21,
              Timeout = 2.0,
              TimeoutKey = "qhuEsoxl"
            },
            {

              PosKey = "WallFocus",
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

              PosKey = "Focus",
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
              Timeout = 2.0,
              TimeoutKey = "BcEbtwwC"
            },
            {

              Camera = 1090001,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 2.0,
              TimeoutKey = "XXRgSyXM"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 34010901,
          Actions = {
            {

              GroupId = 10905011,
              Type = 42,
              Timeout = 0.75,
              TimeoutKey = "gbguZLzn"
            },
            {

              TipsId = 10905011,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.75,
              TimeoutKey = "ZBTDyDVs"
            },
            {

              BackToDefault = true,
              Type = 63,
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

          StoryId = 34010902,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
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

          Key = "EnterFocus",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "Focus",
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
              Timeout = 0.5,
              TimeoutKey = "xhfTVbUq"
            },
            {

              Camera = 1090001,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
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

          Key = "block4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              CustomEventName = "BoxFocus",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "Complete",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BoxFocus",
      Actions = {
        {

          PosKey = "BoxFocus",
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
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10904",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BoxSetup",
      Actions = {
        {

          GroupId = 1090501004,
          Type = 27,
          Timeout = 0.2,
          TimeoutKey = "tswcSTsZ"
        },
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

          GroupId = 1090501007,
          Type = 27,
          Timeout = 0.2,
          TimeoutKey = "eQnuoSUz"
        },
        {

          Group = 1090501008,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090501006,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 1090501009,
          Type = 27,
          Timeout = 0.2,
          TimeoutKey = "YltTUmEk"
        },
        {

          Type = 134,
          Timeout = 0.5,
          TimeoutKey = "mqQrnNND"
        },
        {

          Variable = "Open",
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 30,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10904",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "NoBoxSetup",
      Actions = {
        {

          Group = 1090501006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090501008,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10904",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "BoxEnd10904",
      Actions = {
        {

          Variable = "10904",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10904CLOSE",
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

      EventName = "Finish3",
      Actions = {
        {

          BackToDefault = true,
          Type = 63,
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

      EventName = "清理障碍",
      Actions = {
        {

          Group = 1090501003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090501002,
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

          Group = 1090501005,
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
                Id = 109030102,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 109030103,
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

      EventName = "GBOX10904CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuide/Fx_Common_BoxGuide10904",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      EventName = "GBOX10904OPEN",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuide/Fx_Common_BoxGuide10904",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10904",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10904OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "Open",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10904CLOSE",
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
    EventCount = 1,
    MonsterCount = 12,
    MonsterInfo = {
      [ 20105901 ] = 2,
      [ 20106001 ] = 4,
      [ 20106101 ] = 4,
      [ 20105801 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}