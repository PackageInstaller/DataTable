local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          NPCName = "M1",
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
          NpcId = 638466389667736011,
          IsRemove = true,
          CustomEventName = "M1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "2",
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
          NpcId = 638466389671496644,
          IsRemove = true,
          CustomEventName = "M2",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          NPCName = "M3",
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
          NpcId = 638466389675624330,
          IsRemove = true,
          CustomEventName = "M3",
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
          NpcId = 638466389679441980,
          IsRemove = true,
          CustomEventName = "M4",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M5",
          NPCName = "M5",
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
          NpcId = 638466389683811371,
          IsRemove = true,
          CustomEventName = "M5",
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

      NoPassCamera = 241,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 241,
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

          ResId = 201114,
          PosKey = "NPC",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 0,
          NPCName = "NPC",
          AutoSave = false,
          Type = 2,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 2,
            MonsterGroupId = 0,
            MonsterWave = 5,
            MonsterCount = 55,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 240102,
                param = 0,
                Name = "全部杀死",
                Timeout = 10.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 240102,
                param = 0,
                Name = "全部杀死",
                Timeout = 10.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 240102,
                param = 0,
                Name = "全部杀死",
                Timeout = 10.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 240102,
                param = 0,
                Name = "全部杀死",
                Timeout = 10.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 240102,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
            MonsterLockEnemyInfoList = {
              {
                Target = "NPC",
                Weight = 3,
                Behit = 1,
                IgnoreDistance = true
              },
              {
                Target = "Hero",
                Weight = 0,
                Behit = 0,
                IgnoreDistance = true
              }
            },
          },
          Type = 8,
          Timeout = 1.0,
          TimeoutKey = "YaOhbsRR"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "M1",
      Actions = {
        {

          GroupId = 24101,
          Type = 27,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "M1",
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

          GroupId = 24102,
          Type = 27,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "M2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "M3",
      Actions = {
        {

          GroupId = 24103,
          Type = 27,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "M3",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "M4",
      Actions = {
        {

          GroupId = 24104,
          Type = 27,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "M4",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "M5",
      Actions = {
        {

          GroupId = 24105,
          Type = 27,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "M5",
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
            "M1",
            "M2",
            "M3",
            "M4",
            "M5"
          },
          Actions = empty,
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
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 55,
    MonsterInfo = {
      [ 20101501 ] = 55
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}