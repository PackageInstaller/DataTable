return
{
  Events = {
    {

      Actions = {
        {

          CustomEventName = "UIclose",
          Type = 19,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Enable = false,
          Type = 119,
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

      NoPassCamera = 10801,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 10801,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
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

          Key = "Boyuan",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 904080115,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.2,
              StopStayTime = 0.3,
              StopFadeOutTime = 0.2,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {

              Point = "camera1",
              Type = 3,
              Timeout = 0.0
            },
            {

              PosKey = "camera1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_1080102_BoyuanUpstairTimeline",
              IsPlay = true,
              Type = 110,
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

          StoryId = 904080115,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 1.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              PosKey = "M2",
              Rotation = -120,
              NPCId = 10801201,
              NPCName = "Boyuan",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "RHxOXBzf"
            },
            {

              PosKey = "camera_mod1",
              Rotation = -90,
              NPCId = 1089999,
              NPCName = "相机模型",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "tRXVGKRl"
            },
            {

              TimelineName = "scene_timeline_1080102_BoyuanUpstairTimeline",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "lGBoUYTV"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 904080116,
          Actions = {
            {

              CfgId = 108010201,
              Type = 140,
              Timeout = 0.0
            },
            {

              PosKey = "camera1",
              Rotation = 0,
              NPCId = 108010201,
              NPCName = "相机1",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M2",
              Rotation = 0,
              NPCId = 10801202,
              NPCName = "铂鸢气泡",
              Type = 0,
              Timeout = 2.0,
              TimeoutKey = "jdaQnSNz"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 904080117,
          Actions = {
            {

              PosKey = "M4",
              Rotation = 0,
              NPCId = 10801203,
              NPCName = "铂鸢2",
              Type = 0,
              Timeout = 0.0
            },
            {

              FadeIn = 0.2,
              Hold = 1.0,
              FadeOut = 0.2,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.3,
              TimeoutKey = "BiANTcQW"
            },
            {

              PosKey = "铂鸢2",
              IsOpen = true,
              CameraStyle = 0,
              Duration = -1.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.2,
              TimeoutKey = "NVkJZJAy"
            },
            {

              NPCId = 1089999,
              NPCName = "相机模型",
              Type = 1,
              Timeout = 0.3,
              TimeoutKey = "AmpktAMy"
            },
            {

              NPCId = 108010201,
              NPCName = "相机1",
              Type = 1,
              Timeout = 0.3,
              TimeoutKey = "toqGJkqV"
            },
            {

              NPCId = 10801201,
              NPCName = "铂鸢",
              Type = 1,
              Timeout = 0.3,
              TimeoutKey = "lEsYpYzI"
            },
            {

              NPCId = 10801202,
              NPCName = "铂鸢气泡",
              Type = 1,
              Timeout = 0.3,
              TimeoutKey = "VNfgccHN"
            },
            {

              PosKey = "camera_mod2",
              Rotation = 90,
              NPCId = 1089999,
              NPCName = "相机模型2",
              Type = 0,
              Timeout = 0.4,
              TimeoutKey = "rnWIUPAY"
            },
            {

              StoryId = 904080118,
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
              Timeout = 0.9,
              TimeoutKey = "GUldeISv"
            },
            {

              Type = 141,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 904080118,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            },
            {

              CfgId = 108010202,
              Type = 140,
              Timeout = 0.0
            },
            {

              PosKey = "camera2",
              Rotation = 90,
              NPCId = 108010202,
              NPCName = "相机2",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M4",
              Rotation = 0,
              NPCId = 10801204,
              NPCName = "铂鸢气泡2",
              Type = 0,
              Timeout = 3.0,
              TimeoutKey = "FYcfwHcu"
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

      EventName = "camera1",
      Actions = {
        {

          CfgId = 108010201,
          Type = 140,
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

      EventName = "camera2",
      Actions = {
        {

          CfgId = 108010202,
          Type = 140,
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

          NPCId = 10801201,
          Actions = {
            {

              StoryId = 904080116,
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

          NPCId = 10801202,
          Actions = {
            {

              StoryId = 904080117,
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

          NPCId = 10801204,
          Actions = {
            {

              NPCId = 108010202,
              NPCName = "相机2",
              Type = 1,
              Timeout = 0.0
            },
            {

              Type = 141,
              Timeout = 0.0
            },
            {

              TaskId = 1080104,
              Type = 5,
              Timeout = 0.0
            },
            {

              StoryId = 1001080102,
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
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "UIclose",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skil2",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
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

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "TeamHeads",
          IsShow = false,
          Type = 32,
          Timeout = 0.01,
          TimeoutKey = "CvyInzZA"
        }
      },
      ValidInTower = false,
      Type = 9,
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
      StoryId = 1001080102,
      Name = "6.剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}