local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          StoryId = 5061105,
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
          TimeoutKey = "nDbULUeE"
        },
        {

          Camera = 10611101,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          GroupId = 10670601,
          Type = 27,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 106999,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          Key = "lantern_room",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "total_lantern_num",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "jinghua_num",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 10670602,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10670603,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "show_tips",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "reset_times",
          SyncValType = 1,
          Value = 0.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          KeyName = "w1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

          Enable = true,
          Type = 17,
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

          Key = "room_pass",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 5061103,
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

          TipsId = 1067006,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          TipsId = 10670061,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          LineCount = 3,
          StateInfos = {
            {
              KeyName = "q1",
              IsOpen = false
            },
            {
              KeyName = "q2",
              IsOpen = false
            },
            {
              KeyName = "q3",
              IsOpen = false
            }
          },
          Type = 98,
          Timeout = 0.0
        },
        {

          Group = 10670603,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "room_pass",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "room_restart",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Target = "1_10670601_0",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "bmSHmypk"
        },
        {

          Target = "1_10670601_2",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "geXkUZSp"
        },
        {

          Target = "1_10670601_1",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "RgLBPYvV"
        },
        {

          Target = "1_10670603_0",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "cuAHSCTn"
        },
        {

          GroupId = 10670601,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "XWxCMWoD"
        },
        {

          Group = 10670601,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "YENWxVOi"
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

          Tips = "976",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 1.5,
          TimeoutKey = "whKwWEex"
        },
        {

          Key = "jinghua_num",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "KqsCpUzp"
        },
        {

          Group = 10670603,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "UQePjmKY"
        },
        {

          GroupId = 10670603,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "DqUjkJGN"
        },
        {

          TipsId = 1067006,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.5,
          TimeoutKey = "IiaPAzVh"
        },
        {

          TipsId = 10670061,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 1.0,
          TimeoutKey = "KkUzKKAg"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "room_restart",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "show_tips",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1067061,
          Type = 42,
          Timeout = 2.0,
          TimeoutKey = "LeFGjGQn"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "show_tips",
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
                MonsterWave = 2,
                MonsterCount = 6,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 106706001,
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
                    Id = 106706002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear1",
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

              Camera = 106045,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "enemy2",
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

      ConditionActions = {
        {

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1060452,
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
      ConditionVariable = "clear",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cam1",
          Actions = {
            {

              Camera = 106045,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.1,
              TimeoutKey = "PQWiRxoQ"
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "clear",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4061101,
          Actions = {
            {

              CustomEventName = "取消聚焦青化雾",
              Type = 19,
              Timeout = 0.0
            },
            {

              TipsId = 1067006,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 5061103,
          Actions = {
            {

              CustomEventName = "over",
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

      EventName = "over",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          PosKey = "tp1",
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

          Type = 60,
          Timeout = 0.0
        },
        {

          KeyName = "tp1",
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

      EventName = "clear1",
      Actions = {
        {

          Target = "1_10670601_0",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "LSoDaODc"
        },
        {

          Target = "1_10670601_1",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "xwlpzvKk"
        },
        {

          Target = "1_10670601_2",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "YSLUMlBg"
        },
        {

          Target = "1_10670603_0",
          MagicId = 1067041,
          Level = 0,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "MfINWsxT"
        },
        {

          Tips = "977",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 1.5,
          TimeoutKey = "GKVbDajG"
        },
        {

          LineCount = 3,
          StateInfos = {
            {
              KeyName = "q1",
              IsOpen = true
            },
            {
              KeyName = "q2",
              IsOpen = true
            },
            {
              KeyName = "q3",
              IsOpen = true
            }
          },
          Type = 98,
          Timeout = 0.0
        },
        {

          TipsId = 1067006,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 0.25,
          TimeoutKey = "NIhpPbNd"
        },
        {

          StoryId = 5061107,
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
          TimeoutKey = "hhrmrNgw"
        },
        {

          Camera = 1060452,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 1.5,
          TimeoutKey = "YknkDbSg"
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

          Group = 10670601,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "UrGNcLQz"
        },
        {

          GroupId = 10670601,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "tvydBqRy"
        },
        {

          Key = "jinghua_num",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "wgyyOmJj"
        },
        {

          Group = 10670603,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "atSJkgSN"
        },
        {

          GroupId = 10670603,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "jecQgpdo"
        }
      },
      FinishMarkVariable = "clear",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "取消聚焦青化雾",
      Actions = {
        {

          PosKey = "q2",
          IsOpen = false,
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
        }
      },
      FinishMarkVariable = "focus_end",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "focus_end",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4061101,
          StepId = 3,
          Actions = {
            {

              CustomEventName = "取消聚焦青化雾",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4061101,
          StepId = 2,
          Actions = {
            {

              PosKey = "q2",
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
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
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
    MonsterCount = 6,
    MonsterInfo = {
      [ 20105201 ] = 1,
      [ 20204901 ] = 5
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}