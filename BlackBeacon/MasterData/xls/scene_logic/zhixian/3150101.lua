local empty = {}
return
{
  Events = {
    {

      Actions = {
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

      NoPassCamera = 10404,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10404,
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

          ObjName = "Level/Section_02/Zone_03_1/sc03_prp_04a_pre(43)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Section_02/Zone_03_1/sc03_prp_04a_pre(47)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Section_02/Zone_03_1/sc03_prp_04a_pre(46)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Section_02/Zone_03_1/PuzzleRoom/Plat201_/sc03_03_anim_03(MISSILE_BLOCK)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Section_02/Zone_03_1/PuzzleRoom/Plat204_",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc03_zone_03_1/Prop",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/collapse/sc03_zone_03_1/Prop/sc03_prp_05a_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Path = "Level/Section_02/Zone_03_1/sc03_prp_04a_pre(45)/switch_on",
          Rewind = 0.0,
          IsSaveState = true,
          Type = 56,
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

          GroupId = 1501,
          Type = 27,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/Plat/Plat31501_",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/Plat/Plat31502_",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Path = "Level/zhixian315/timeline/timeline_315010101",
          PlatCount = 1,
          PlatList = {
            "Plat201"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/zhixian315/timeline/timeline_315010102",
          PlatCount = 1,
          PlatList = {
            "Plat202"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/zhixian315/timeline/timeline_315010103",
          PlatCount = 1,
          PlatList = {
            "Plat203"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/zhixian315/timeline/timeline_315010104",
          PlatCount = 1,
          PlatList = {
            "Plat31502"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/zhixian315/timeline/timeline_315010105",
          PlatCount = 1,
          PlatList = {
            "Plat31501"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/timeline/timeline_315010106",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "NPC1",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "switch",
          Cd = 0.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
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
      Actions = empty,
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "magic01",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "Hero",
              MagicId = 403231501,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "magic02",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "Hero",
              MagicId = 403231502,
              Level = 0,
              Type = 16,
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

          Key = "conversation",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 3215101,
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

              KeyName = "NPC1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
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

          StoryId = 2215101,
          Actions = {
            {

              TaskGroupId = 315,
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

          NPCId = 301501,
          Actions = {
            {

              PosKey = "focus1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 4.0,
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

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.5,
              TimeoutKey = "mutkLVyr"
            },
            {

              Direction = 4,
              Type = 51,
              Timeout = 4.0,
              TimeoutKey = "xoLNzLTB"
            },
            {

              Path = "Level/zhixian315/timeline/timeline_315010107",
              PlatCount = 0,
              Type = 96,
              Timeout = 4.0,
              TimeoutKey = "AZwuePnI"
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 4.0,
              TimeoutKey = "VkKKhOoA"
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

          NPCName = "switch",
          HitType = 0,
          Actions = {
            {

              NpcName = "switch",
              CanHit = true,
              Type = 77,
              Timeout = 0.1,
              TimeoutKey = "FKgSpLvc"
            },
            {

              Path = "Level/Section_02/Zone_03_1/sc03_prp_04a_pre(48)/switch_on",
              Rewind = 999999.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              PosKey = "focus1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 4.0,
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

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.5,
              TimeoutKey = "wYvdgHtf"
            },
            {

              Direction = 4,
              Type = 51,
              Timeout = 4.0,
              TimeoutKey = "TSwSQCaB"
            },
            {

              Path = "Level/zhixian315/timeline/timeline_315010107",
              PlatCount = 0,
              Type = 96,
              Timeout = 4.0,
              TimeoutKey = "VNJchHXb"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 4.0,
              TimeoutKey = "GiUtXYJd"
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}