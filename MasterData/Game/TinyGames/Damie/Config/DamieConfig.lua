local DamieConfig = {}
DamieConfig.ActivityEndTime = "2022/04/10 15:59"
DamieConfig.BossId = 18
DamieConfig.BossRemainTime = 2
DamieConfig.SpecialBossRemainTime = 3
DamieConfig.BossMaxPressedCount = 35
DamieConfig.BonusTimeArg = 0.3
DamieConfig.BossBornScoreTag = {
  15,
  40,
  50,
  60,
  65,
  70
}
DamieConfig.TotalTime = 35
DamieConfig.TimerInterval = 0.3
DamieConfig.StepState = {
  first = 1,
  second = 2,
  third = 3,
  fourth = 4,
  fifth = 5
}
DamieConfig.StepTime = {
  3,
  8,
  18,
  30
}
DamieConfig.CharaConfig = {
  [1] = {
    casterMaxCount = 1,
    interval = 0.5,
    remainTime = 1.5
  },
  [2] = {
    casterMaxCount = 2,
    interval = {0, 0.3},
    remainTime = {0.7, 1.0}
  },
  [3] = {
    casterMaxCount = 3,
    perCastInterval = {
      0,
      0.3,
      0.5
    },
    interval = {0, 0.3},
    remainTime = {0.7, 1.0}
  },
  [4] = {
    casterMaxCount = 4,
    perCastInterval = {
      0,
      0.3,
      0.5
    },
    interval = 0.3,
    remainTime = {0.6, 0.8}
  },
  [5] = {
    casterMaxCount = 5,
    perCastInterval = {
      0,
      0.3,
      0.5
    },
    interval = 0.2,
    remainTime = 0.6
  }
}
DamieConfig.CharaVoSheetName = "VO_Fes_2022F"
return DamieConfig
