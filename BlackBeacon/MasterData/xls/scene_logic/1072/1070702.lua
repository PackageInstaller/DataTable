local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupId = 107070202,
          Type = 27,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          GroupId = 107070201,
          Type = 27,
          Timeout = 0.0
        },
        {

          TimelineName = "tl_1070702",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "M1",
          NpcParams = {
            InteractionArea = 1.5,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638474144942373160,
          IsRemove = true,
          CustomEventName = "M1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "M2",
          NpcParams = {
            InteractionArea = 1.5,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638474144947420505,
          IsRemove = true,
          CustomEventName = "M2",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M4",
          NPCName = "M4",
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
          NpcId = 638474144951601248,
          IsRemove = true,
          CustomEventName = "M4",
          Type = 92,
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

      NoPassCamera = 107070,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 107070,
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

      ConditionActions = {
        {

          Key = "D1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "遇到了将军的雕塑（以为是雕塑）的剧情",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
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

      ConditionActions = {
        {

          Key = "D1",
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
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 1070701,
          Actions = {
            {

              Tips = "浓雾消失，后方好像传来了什么动静",
              Duration = 3.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            },
            {

              ObjName = "兵马俑房/M201011",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Group = 10702099,
              Type = 65,
              Timeout = 0.0
            },
            {

              GroupId = 10702098,
              Type = 27,
              Timeout = 0.0
            },
            {

              Group = 107070201,
              Type = 65,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 1070702,
          Actions = {
            {

              Tips = "被锁住了",
              Duration = 2.0,
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

      EventName = "M4",
      Actions = {
        {

          Tips = "浓雾消失，后方好像传来了什么动静",
          Duration = 3.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          Group = 107070202,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 107070203,
          Type = 27,
          Timeout = 0.0
        },
        {

          TimelineName = "tl_1070702",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        },
        {

          AreaName = "D1",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          Group = 107070201,
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

      EventName = "M1",
      Actions = {
        {

          Tips = "被锁住了",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
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

      EventName = "M2",
      Actions = {
        {

          Path = "tl_702",
          Rewind = 0.0,
          IsSaveState = true,
          Type = 56,
          Timeout = 0.0
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
  FinishiConditionDict = empty,
  mDefaultStartTime = true,
  mDefaultEndTime = true
}