local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          AtmosphereIndex = 0,
          Type = 136,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
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

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
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

          RandomCount = 5,
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
              ActionTag = "Z",
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21091101,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "again",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDifficultyTag = 0
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
              ActionTag = "Z",
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21091102,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "again",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDifficultyTag = 0
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
              ActionTag = "Z",
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21091103,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "again",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDifficultyTag = 0
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
              ActionTag = "Z",
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21091104,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "again",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDifficultyTag = 0
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
              ActionTag = "Z",
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21091105,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "again",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDifficultyTag = 0
                }
              },
            }
          },
          Type = 84,
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

      EventName = "again",
      Actions = {
        {

          RandomCount = 2,
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
              ActionTag = "Z",
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21091106,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDifficultyTag = 0
                }
              },
              MonsterLockEnemyInfoList = empty,
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
              ActionTag = "Z",
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21091107,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDifficultyTag = 0
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

          Type = 22,
          Timeout = 0.0
        },
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.5,
          TimeoutKey = "jegoccpN"
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