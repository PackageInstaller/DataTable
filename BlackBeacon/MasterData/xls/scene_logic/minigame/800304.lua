local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "create_gap_time",
          SyncValType = 1,
          Value = 0.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "point_gap_time",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "start_enemy_amout",
          SyncValType = 1,
          Value = 4.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "max_enemy_amount",
          SyncValType = 1,
          Value = 8.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "amount_mosquito",
          SyncValType = 1,
          Value = 6.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "amount_bird",
          SyncValType = 1,
          Value = 4.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "weight_mosquito",
          SyncValType = 1,
          Value = 150.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "weight_bird",
          SyncValType = 1,
          Value = 100.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Key = "end_time",
          SyncValType = 1,
          Value = 60.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Seconds = 60,
          Text = "限时清怪",
          EventName = "时间结束",
          Type = 66,
          Timeout = 1.0,
          TimeoutKey = "qfrdnkTl"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 2010340101,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 2010340101,
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

          GroupId = 800302,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 800304,
          Type = 27,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 300205501,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 80030103,
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
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 80030104,
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
          Timeout = 0.0
        },
        {

          SpawnType = 3,
          UnitGroupID = 0,
          TotalSpawnCount = 0,
          UnitKindCount = 2,
          MaxActiveUnitCount = 8,
          BornPosType = 1,
          MinCreateRadius = 4,
          MaxCreateRadius = 8,
          AIDifficultyTag = -1,
          EventName = "",
          SpawnDuration = 60.0,
          SpawnTimeInterval = 0.5,
          timeIntervalKinds = {
            {
              UnitID = 3002053,
              Weight = 3,
              Limit = 3,
              OrientationType = 3,
              UnitLevel = 1,
              AIDifficultyTag = -1
            },
            {
              UnitID = 3002054,
              Weight = 5,
              Limit = 5,
              OrientationType = 2,
              UnitLevel = 1,
              AIDifficultyTag = -1
            }
          },
          OtherUnitID = 3002053,
          Type = 139,
          Timeout = 0.5,
          TimeoutKey = "ZBlVCBak"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "时间结束",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.5,
          TimeoutKey = "CikIROjI"
        },
        {

          Tips = "984",
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

      Actions = {
        {

          TimelineName = "timeline_BattingBoomer",
          Type = 7,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_wall_BattingBommer",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
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
    EventCount = 2,
    MonsterCount = 2,
    MonsterInfo = {
      [ 3002057 ] = 1,
      [ 3002056 ] = 1
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}