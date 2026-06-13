local empty = {}
return
{
  Events = {
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

      ConditionActions = {
        {

          Key = "a",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "a1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "b",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "b1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "c",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "c1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "d",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "d1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "e",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "e1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "f",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "f1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
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