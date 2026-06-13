local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PlayBgm = "storybgm_003",
          Type = 76,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_maze_enji",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "enji",
          Rotation = 0,
          NPCId = 101505,
          NPCName = "恩基气泡",
          Type = 0,
          Timeout = 0.0
        },
        {

          Key = "enji2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "enji3",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 0,
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

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032107,
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

      NoPassCamera = 117,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = empty,
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "maze1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "focus1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "enji",
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

          StoryId = 4010605,
          Actions = {
            {

              CustomEventName = "去除enji1",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "去除enji2",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "去除enji3",
              Type = 19,
              Timeout = 0.0
            },
            {

              TaskId = 101502,
              Type = 5,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 14,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 10150501,
                    param = 1,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10150502,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10150503,
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
              Timeout = 0.5,
              TimeoutKey = "nZhQNLUb"
            },
            {

              PlayBgm = "bgm_modern_common",
              Type = 76,
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

          NPCId = 101505,
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
              Point = "nanna",
              Rotate = 100.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.7,
              TimeoutKey = "XIisNeZP"
            },
            {

              StoryId = 4010605,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 1.5,
              TimeoutKey = "hKNkwrgT"
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
        },
        {

          Camera = 1,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        },
        {

          StoryId = 5010606,
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
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GroupId = 101502,
          Actions = {
            {

              StoryId = 5010604,
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
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "去除enji1",
      Actions = {
        {

          TimelineName = "scene_timeline_maze_enji",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "enji1",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "enji1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "去除enji2",
      Actions = {
        {

          TimelineName = "scene_timeline_maze_enji2",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        },
        {

          Key = "enji2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "enji2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "enji2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "去除enji3",
      Actions = {
        {

          TimelineName = "scene_timeline_maze_enji3",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "enji3",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "enji3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "scene_timeline_maze_enji2",
          Actions = {
            {

              CustomEventName = "去除enji2",
              Type = 19,
              Timeout = 0.1,
              TimeoutKey = "TqyRABRb"
            },
            {

              TimelineName = "scene_timeline_maze_enji3",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Key = "enji3",
              SyncValType = 2,
              Value = false,
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
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4010605,
          StepId = 6,
          Actions = {
            {

              TimelineName = "scene_timeline_maze_enji2",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Key = "enji2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              CustomEventName = "去除enji1",
              Type = 19,
              Timeout = 0.0,
              TimeoutKey = "UTSmGNYu"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4010605,
          StepId = 0,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Target = "Hero",
          MagicId = 4032108,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 14,
    MonsterInfo = {
      [ 20101501 ] = 9,
      [ 20101301 ] = 1,
      [ 20101101 ] = 1,
      [ 20101401 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}