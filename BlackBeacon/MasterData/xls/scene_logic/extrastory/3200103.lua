return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "Level/Level_02/320/32001/3200103",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      Actions = {
        {

          ObjName = "/Root/Change_/Change_day/sc06_area_06/prop/sc06_prop_01_pre24",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_day/sc06_area_06/prop/sc06_prop_01_pre31",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_day/sc06_area_06/prop/sc06_prop_01_pre28",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_day/sc06_area_06/prop/sc06_prop_01_pre29",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_day/sc06_area_06/prop/sc06_prop_01_pre17",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_day/sc06_area_06/prop/sc06_prop_01_pre27",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
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

          Intensity = 0.025,
          Type = 105,
          Timeout = 0.0
        },
        {

          StoryId = 2220101,
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
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "Plate1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200103/PressurePlate/1/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200103/Lamp/1_Off/lamp_switch_on",
              Rewind = 0.0,
              CustomEventName = "",
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200103/Lamp/2_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              KeyName = "target2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "Plate1",
          ValidInTower = false
        },
        {

          Key = "Plate2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200103/PressurePlate/2/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200103/Lamp/3_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200103/Lamp/4_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              KeyName = "target3",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "Plate2",
          ValidInTower = false
        },
        {

          Key = "Plate3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200103/PressurePlate/3/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200103/Lamp/5_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200103/Lamp/6_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "Plate3",
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

          Key = "Mist",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              CustomEventName = "雾气加深",
              Type = 19,
              Timeout = 0.0
            },
            {

              StoryId = 3220108,
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
              TimeoutKey = "ZHuoHirE"
            },
            {

              KeyName = "target1",
              IsOpen = true,
              IsContinue = false,
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

      EventName = "雾气加深",
      Actions = {
        {

          Intensity = 0.025,
          Type = 105,
          Timeout = 0.0
        },
        {

          Intensity = 0.0275,
          Type = 105,
          Timeout = 0.1,
          TimeoutKey = "APEFdHHD"
        },
        {

          Intensity = 0.03,
          Type = 105,
          Timeout = 0.2,
          TimeoutKey = "caSQrcyz"
        },
        {

          Intensity = 0.0325,
          Type = 105,
          Timeout = 0.3,
          TimeoutKey = "VhCIzykg"
        },
        {

          Intensity = 0.035,
          Type = 105,
          Timeout = 0.4,
          TimeoutKey = "mBJrFIUP"
        },
        {

          Intensity = 0.0375,
          Type = 105,
          Timeout = 0.5,
          TimeoutKey = "rcBRVSxZ"
        },
        {

          Intensity = 0.04,
          Type = 105,
          Timeout = 0.6,
          TimeoutKey = "WnhLwqkU"
        },
        {

          Intensity = 0.0425,
          Type = 105,
          Timeout = 0.7,
          TimeoutKey = "oJOkIQvM"
        },
        {

          Intensity = 0.045,
          Type = 105,
          Timeout = 0.8,
          TimeoutKey = "wjVsvGLC"
        },
        {

          Intensity = 0.0475,
          Type = 105,
          Timeout = 0.9,
          TimeoutKey = "ODfOGkIu"
        },
        {

          Intensity = 0.05,
          Type = 105,
          Timeout = 1.0,
          TimeoutKey = "illgklZD"
        },
        {

          Intensity = 0.0525,
          Type = 105,
          Timeout = 1.1,
          TimeoutKey = "xUdsGQvZ"
        },
        {

          Intensity = 0.055,
          Type = 105,
          Timeout = 1.2,
          TimeoutKey = "ppIdXuTN"
        },
        {

          Intensity = 0.0575,
          Type = 105,
          Timeout = 1.3,
          TimeoutKey = "MQcdSZcu"
        },
        {

          Intensity = 0.06,
          Type = 105,
          Timeout = 1.4,
          TimeoutKey = "NHdnJFMX"
        },
        {

          Intensity = 0.0625,
          Type = 105,
          Timeout = 1.5,
          TimeoutKey = "FVmnJlep"
        },
        {

          Intensity = 0.065,
          Type = 105,
          Timeout = 1.6,
          TimeoutKey = "DFJANQGY"
        },
        {

          Intensity = 0.0675,
          Type = 105,
          Timeout = 1.7,
          TimeoutKey = "rwWyQQfG"
        },
        {

          Intensity = 0.07,
          Type = 105,
          Timeout = 1.8,
          TimeoutKey = "tOjmqCeK"
        },
        {

          Intensity = 0.0725,
          Type = 105,
          Timeout = 1.9,
          TimeoutKey = "CskLlpiJ"
        },
        {

          Intensity = 0.075,
          Type = 105,
          Timeout = 2.0,
          TimeoutKey = "mJjWLAmN"
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

          ConditionVariableList = {
            "Plate1",
            "Plate2",
            "Plate3"
          },
          Actions = {
            {

              StoryId = 100220102,
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
              Timeout = 1.0,
              TimeoutKey = "VmGTGYCl"
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
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
      StoryId = 100220102,
      Name = "剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}