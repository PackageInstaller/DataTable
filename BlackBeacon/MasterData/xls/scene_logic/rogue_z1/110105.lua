local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "Change_/Change_day/sc01_chapter_01_pre",
          Visible = false,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/13_SQBJ/sc01_area_13/Building/sc01_area_13_pre/Building/sc01_bld_11b_pre (229)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_area_13/Building/sc01_area_13_pre/Building/sc01_bld_11b_pre (228)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_area_13/Building/sc01_area_13_pre/Building/sc01_bld_11b_pre (227)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_area_13/Building/sc01_area_13_pre/Building/sc01_bld_12a_pre (352)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_area_13/Building/sc01_area_13_pre/Building/sc01_bld_12a_pre (351)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          RandomCount = 3,
          RandomMonsterCfgList = {
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 1,
              MonsterCount = 3,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 1011,
                  param = 0,
                  Name = "全部杀死",
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
              MonsterCount = 3,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 1012,
                  param = 0,
                  Name = "全部杀死",
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
              MonsterCount = 5,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 1013,
                  param = 0,
                  Name = "全部杀死",
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

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
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

          Type = 12,
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
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 0,
    MonsterInfo = empty,
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}