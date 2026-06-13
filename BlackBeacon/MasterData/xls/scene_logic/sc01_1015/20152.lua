local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 3,
            MonsterCount = 11,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 101522,
                param = 1,
                Name = "剩余",
                Timeout = 0.0,
                AIGroupId = 100,
                AIGroup = 1,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 1,
                Id = 101521,
                param = 1,
                Name = "剩余",
                Timeout = 0.0,
                AIGroupId = 100,
                AIGroup = 1,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 2015203,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 100,
                AIGroup = 1,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 5.0,
          TimeoutKey = "IuqsGcJM"
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          SkillLevel = 2,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          TipsId = 20151,
          Visible = true,
          Flip = true,
          Type = 15,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/Zhuzi/Axis/maodian/sc01_bld_01a5_03_mod/FX_Liehen2",
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

      NoPassCamera = 101503,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 101503,
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

          Enable = true,
          Type = 120,
          Timeout = 5.0,
          TimeoutKey = "noPWWDYX"
        },
        {

          Type = 48,
          Timeout = 5.0,
          TimeoutKey = "KaiQGQGI"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = empty,
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
    MonsterCount = 11,
    MonsterInfo = {
      [ 20102901 ] = 2,
      [ 20101501 ] = 3,
      [ 20101401 ] = 4,
      [ 20101101 ] = 2
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = true
}