local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RandomCount = 6,
          RandomMonsterCfgList = {
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = false,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104101,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "group2",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = false,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104103,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "group2",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = false,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104105,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "group2",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = false,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104107,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "group2",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = false,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104109,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "group2",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 6,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = false,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104111,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "group2",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            }
          },
          Type = 84,
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

      NoPassCamera = 210,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 210,
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

      EventName = "group2",
      Actions = {
        {

          RandomCount = 6,
          RandomMonsterCfgList = {
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104102,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104104,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104106,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104108,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 4,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104110,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 6,
              SendWave = false,
              WaveStyle = 0,
              WallObjPath = "",
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 2104112,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            }
          },
          Type = 84,
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

          Direction = 1,
          Type = 51,
          Timeout = 4.0,
          TimeoutKey = "WepUrXRL"
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
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "1.杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 0,
    MonsterInfo = empty,
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}