local empty = {}
return
{
  Events = {
    {

      Actions = empty,
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 1070900,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1070900,
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

          TimelineName = "scene_timeline_107100201",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TaskId = 1071001,
          Type = 5,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

          Key = "cam1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline_107100201",
              Fadein = 3.0,
              Fadeout = 3.0,
              IsCanSkip = false,
              NotPauseLua = true,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = true,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area06/sc06_area_digong_06_pre/sc06_area_digong_06_m2_mod/sc06_area_digong_06_m2_03",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area05/sc06_area_digong_05_pre/sc06_area_digong_05_m2_mod/sc06_area_digong_05_m2_08",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area05/sc06_area_digong_05_pre/sc06_area_digong_05_m2_mod/sc06_area_digong_05_m2_07",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area06/build/sc06_build_70_pre",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area06/build/sc06_build_70_pre (1)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              CustomEventName = "特殊镜头恢复",
              Type = 19,
              Timeout = 5.0,
              TimeoutKey = "IJhjdfrs"
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 5.0,
              TimeoutKey = "JzuufrFg"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 5.0,
              TimeoutKey = "qmKeucqZ"
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

          Key = "victory",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "victory",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "victory",
      IsNotCondition = true,
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

              StoryId = 5071603,
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

              TimelineName = "scene_timeline_107100202",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "first",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "first",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cam1",
          Actions = empty,
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "特殊镜头恢复",
      Actions = {
        {

          TimelineName = "timeline_107100201",
          Type = 7,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_ Complete/area06/sc06_area_digong_06_pre/sc06_area_digong_06_m2_mod/sc06_area_digong_06_m2_03",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = "jFTKoeOW"
        },
        {

          ObjName = "/Root/Change_/Change_ Complete/area06/build/sc06_build_70_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_ Complete/area06/build/sc06_build_70_pre (1)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_ Complete/area05/sc06_area_digong_05_pre/sc06_area_digong_05_m2_mod/sc06_area_digong_05_m2_07",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_ Complete/area05/sc06_area_digong_05_pre/sc06_area_digong_05_m2_mod/sc06_area_digong_05_m2_08",
          Visible = true,
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

      Actions = {
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_107100201",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_107100202",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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