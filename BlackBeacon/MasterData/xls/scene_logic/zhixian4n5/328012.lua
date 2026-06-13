local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 115,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 115,
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

          GroupId = 32801201,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 32801202,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "G1",
          NPCName = "守卫1",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 5.0
          },
          Rotation = 0,
          NpcId = 638672837081768004,
          IsRemove = true,
          CustomEventName = "交谈1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "G2",
          NPCName = "守卫2",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 5.0
          },
          Rotation = 0,
          NpcId = 638675542074725534,
          IsRemove = true,
          CustomEventName = "交谈2",
          Type = 92,
          Timeout = 0.0
        },
        {

          StoryId = 2228103,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Change_/Change_Dark/Prop",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10/3/sc05_prp_55c_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10/3/FX",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "hasBeenFound",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Type = 46,
          Timeout = 0.0
        },
        {

          StoryId = 2228206,
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
          Timeout = 0.1,
          TimeoutKey = "fwOLConC"
        },
        {

          Target = "1_32801202_0",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "hasBeenFound",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "hasArrived",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Group = 32801202,
          Type = 65,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "hasArrived",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2228206,
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
              Point = "M1",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "nPvNvNtZ"
            },
            {

              Target = "1_32801202_0",
              MagicId = 3000002,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "OHpoGoEr"
            },
            {

              Target = "1_32801201_0",
              MagicId = 3000002,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "uRqRpOyY"
            },
            {

              Target = "1_32801201_1",
              MagicId = 3000002,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "HbUeOnXr"
            },
            {

              Type = 60,
              Timeout = 2.0,
              TimeoutKey = "HktMyKtf"
            },
            {

              Group = 32801202,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "SzfUsRlR"
            },
            {

              GroupId = 32801202,
              Type = 27,
              Timeout = 1.1,
              TimeoutKey = "NOtoyYrW"
            },
            {

              Target = "1_32801201_1",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
              Timeout = 1.0,
              TimeoutKey = "oawlpqoV"
            },
            {

              Target = "1_32801201_0",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
              Timeout = 1.0,
              TimeoutKey = "jcSQPMLk"
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

          StoryId = 2228103,
          Actions = {
            {

              Key = "moveTrigger",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
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

          StoryId = 2228206,
          Actions = {
            {

              PosKey = "G1",
              NPCName = "1",
              NpcParams = {
                InteractionArea = 2.0,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 5.0
              },
              Rotation = 0,
              NpcId = 638675493314474714,
              IsRemove = true,
              CustomEventName = "交谈1",
              Type = 92,
              Timeout = 1.0,
              TimeoutKey = "MrOkAsBO"
            },
            {

              Key = "hasTalked1",
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
      Type = 5,
      ConditionVariable = "hasTalked1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2228206,
          Actions = {
            {

              PosKey = "G2",
              NPCName = "2",
              NpcParams = {
                InteractionArea = 2.0,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 5.0
              },
              Rotation = 0,
              NpcId = 638675546193193512,
              IsRemove = true,
              CustomEventName = "交谈2",
              Type = 92,
              Timeout = 1.0,
              TimeoutKey = "jCarCXhx"
            },
            {

              Key = "hasTalked2",
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
      Type = 5,
      ConditionVariable = "hasTalked2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2228202,
          Actions = {
            {

              Target = "1_32801201_0",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
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

          StoryId = 2228203,
          Actions = {
            {

              Target = "1_32801201_1",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
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

      EventName = "交谈1",
      Actions = {
        {

          Target = "1_32801201_0",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          StoryId = 2228202,
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

          Key = "hasTalked1",
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

      EventName = "交谈2",
      Actions = {
        {

          Target = "1_32801201_1",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          StoryId = 2228203,
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

          Key = "hasTalked2",
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

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          Point = "tp4",
          Type = 3,
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