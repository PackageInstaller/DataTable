local t = {
  [1001001] = {
    atk = {
      CancelUpSkActs = {},
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 0,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 2,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    exatk = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "exatk4",
        "exatk3",
        "exatk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "exatk4",
        "exatk3",
        "exatk2",
        "exatk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"heavy"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "exatk",
      Id = 1,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "exatk1"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_1",
      Id = 3,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 4,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1001220,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_2"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_1",
      Id = 5,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeAttrCur = 74,
      UiChargeAttrMax = 75,
      UiChargeIsReduce = true,
      UiChargeType = 1,
      UiSkill = "skill03_1"
    },
    skill03_2 = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_2",
      Id = 6,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1001321,
      UiChargeType = 1,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03_2"
    },
    skill03_2_akt = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {"exatk4"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_2_akt",
      Id = 7,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_2"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001001,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 8,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001004] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.5,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 0,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 1,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    prick = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = {"prickStart"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = {"prickStart"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "prick",
      Id = 6,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "prickStart"
    },
    thunderSpear = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderSpear1",
        "thunderSpear2"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderSpear1",
        "thunderSpear2"
      },
      IconName = "thunderSpear",
      Id = 2,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.75,
      IndicatorFineSizeY = 7,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderSpear1"
    },
    thunderSprint1 = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderSprint1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderSprint1"
      },
      IconName = "thunderSprint1",
      Id = 3,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 10,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderSprint1"
    },
    thunderSprint2 = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderSprint2"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderSprint2"
      },
      IconName = "thunderSprint2",
      Id = 4,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 10,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderSprint2"
    },
    thunderSprint3 = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderSprint3"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderSprint3"
      },
      IconName = "thunderSprint3",
      Id = 5,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 10,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderSprint3"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001004,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 7,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001008] = {
    arashi = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"arashi"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"arashi"},
      IconName = "arashi",
      Id = 2,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 9,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 10,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "arashi"
    },
    area = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = {"area"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "area",
      Id = 5,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeAttrCur = 74,
      UiChargeAttrMax = 75,
      UiChargeIsReduce = true,
      UiChargeType = 1,
      UiSkill = "area"
    },
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.5,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 0,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 1,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    punish = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = {"punish"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "punish",
      Id = 3,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "punishStart"
    },
    punish4 = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"punish4"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"punish4"},
      IconName = "punish4",
      Id = 7,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 16,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 4.5,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 16,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 16,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeAttrCur = 74,
      UiChargeAttrMax = 75,
      UiChargeIsReduce = true,
      UiChargeType = 1,
      UiSkill = "punish4"
    },
    punishMult = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = {"punishMult"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "punishMult",
      Id = 4,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1008057,
      UiChargeType = 2,
      UiEnable = true,
      UiSkill = "punishStart"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001008,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 6,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ultStart"
    }
  },
  [1001009] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 8,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    boomerang = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"streak", "boomerang"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"streak", "boomerang"},
      IconName = "boomerang",
      Id = 10,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.5,
      IndicatorFineSizeY = 7,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "boomerang"
    },
    cleave = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = {"cleave"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "cleave",
      Id = 15,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "cleave"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 9,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    insertSword = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "waltz",
        "insertSword"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "waltz",
        "insertSword"
      },
      IconName = "insertSword",
      Id = 16,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCastSet = {
        "insertSword.onBef"
      },
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "insertSword"
    },
    streak = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.4,
      HitUpSkActs = {"streak"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.4,
      HoldUpSkActs = {"streak"},
      IconName = "streak",
      Id = 14,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 8,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 8,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDensityWeight = {
        {
          5,
          -0.02,
          90,
          4
        },
        {
          10,
          -0.02,
          90,
          4
        },
        {
          0,
          0,
          0,
          0
        }
      },
      SearchDistWeight = {
        {
          0,
          0,
          0
        },
        {
          5,
          -1,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "streak1"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 13,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult1"
    },
    waltz = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = {"waltz"},
      HitUpCacheTime = 0.4,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "waltz",
      Id = 11,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "waltz1"
    },
    waltz2 = {
      CancelUpSkActs = nil,
      CharId = 1001009,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "waltz2",
      Id = 12,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "waltz2"
    }
  },
  [1001010] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001010,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 7,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001010,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 8,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001010,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_1"},
      IconName = "skill02_1",
      Id = 9,
      IndicatorAimSet = {"skill02_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 13,
      IndicatorCoarseType = 2,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3.5,
      IndicatorFineSizeY = 3.5,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 360,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001010,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_1",
      Id = 10,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeAttrCur = 74,
      UiChargeAttrMax = 75,
      UiChargeIsReduce = true,
      UiChargeType = 1,
      UiSkill = "skill03_1"
    },
    skill03_2 = {
      CancelUpSkActs = nil,
      CharId = 1001010,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_2",
      Id = 12,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "skill03_2"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001010,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 11,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001011] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 10,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 11,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 17,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02ExStart = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill02ExStart"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02ExStart",
      Id = 14,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02ExStart"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_1"},
      IconName = "skill02_1",
      Id = 12,
      IndicatorAimSet = {"skill02_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2Start = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "skill02_2Start"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "skill02_2Start"
      },
      IconName = "skill02_2Start",
      Id = 13,
      IndicatorAimSet = {
        "skill02_2Start"
      },
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 12,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_2Start"
    },
    skill03 = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03",
      Id = 15,
      IndicatorAutoLock = true,
      IndicatorCastSet = {"skill03"},
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeAttrCur = 74,
      UiChargeAttrMax = 75,
      UiChargeIsReduce = true,
      UiChargeType = 1,
      UiSkill = "skill03"
    },
    skill03End = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03End"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03End",
      Id = 16,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeAttrCur = 74,
      UiChargeAttrMax = 75,
      UiChargeIsReduce = true,
      UiChargeType = 1,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03End"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001011,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 18,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001012] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 8,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 9,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_1"},
      IconName = "skill02_1",
      Id = 10,
      IndicatorAimSet = {"skill02_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 2,
      IndicatorFineRes = "Fx_skillarea_sector_2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_2"},
      IconName = "skill02_2",
      Id = 13,
      IndicatorAimSet = {"skill02_2"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 2,
      IndicatorFineRes = "Fx_skillarea_semicircle_1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1012001,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_2"
    },
    skill02_2_ult = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_2"},
      IconName = "skill02_2_ult",
      Id = 16,
      IndicatorAimSet = {"skill02_2"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 2,
      IndicatorFineRes = "Fx_skillarea_semicircle_1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_2"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill03_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill03_1"},
      IconName = "skill03_1",
      Id = 11,
      IndicatorAimSet = {"skill03_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_circle_1",
      IndicatorFineSizeX = 4.5,
      IndicatorFineSizeY = 4.5,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_1"
    },
    skill03_2 = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill03_2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill03_2"},
      IconName = "skill03_2",
      Id = 14,
      IndicatorAimSet = {"skill03_2"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_circle_1",
      IndicatorFineSizeX = 4.5,
      IndicatorFineSizeY = 4.5,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1012002,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03_2"
    },
    skill03_2_ult = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill03_2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill03_2"},
      IconName = "skill03_2_ult",
      Id = 17,
      IndicatorAimSet = {"skill03_2"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_circle_1",
      IndicatorFineSizeX = 4.5,
      IndicatorFineSizeY = 4.5,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03_2"
    },
    spAtk = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = {"spAtk"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "spAtk",
      Id = 15,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5},
        {0}
      },
      SearchDensityWeight = {
        {
          10,
          -0.2,
          90,
          4
        },
        {
          10,
          -0.2,
          90,
          4
        },
        {
          10,
          -0.2,
          90,
          4
        }
      },
      SearchDistWeight = nil,
      SearchViscousWeight = {
        {2},
        {2}
      },
      UiChargeIsReduce = true,
      UiChargeMagic = 1012067,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "spAtk"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001012,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 12,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5},
        {0}
      },
      SearchDensityWeight = {
        {
          10,
          -0.2,
          90,
          4
        },
        {
          10,
          -0.2,
          90,
          4
        },
        {
          10,
          -0.2,
          90,
          4
        }
      },
      SearchDistWeight = nil,
      SearchViscousWeight = {
        {2},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "ultStart"
    }
  },
  [1001013] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001013,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 13,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001013,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 14,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001013,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_1"},
      IconName = "skill02_1",
      Id = 15,
      IndicatorAimSet = {"skill02_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 13,
      IndicatorCoarseType = 2,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 5.5,
      IndicatorFineSizeY = 5.5,
      IndicatorFineType = 1,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 360,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001013,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_2"},
      IconName = "skill02_2",
      Id = 18,
      IndicatorAimSet = {"skill02_2"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 13,
      IndicatorCoarseType = 2,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 5.5,
      IndicatorFineSizeY = 5.5,
      IndicatorFineType = 1,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 360,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_2"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001013,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_1",
      Id = 16,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_1"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001013,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 17,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001014] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 20,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 22,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    dashAtk = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {"dashAtk"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dashAtk",
      Id = 21,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "dashAtk"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 29,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02 = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02",
      Id = 23,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02"
    },
    skill02Pro = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02Pro"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02Pro",
      Id = 24,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 101436,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02Pro"
    },
    skill02Pros = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill02Pros"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02Pros",
      Id = 25,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02Pros"
    },
    skill03 = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03"},
      HitUpCacheTime = 0.35,
      HitUpSkActs = {"skill03Atk"},
      HoldCacheTime = 0.4,
      HoldSkActs = {"skill03"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill03Atk"},
      IconName = "skill03",
      Id = 26,
      IndicatorAimSet = {"skill03Atk"},
      IndicatorAutoLock = true,
      IndicatorCastSet = {"skill03"},
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03Atk"
    },
    skill03Pro = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill03Pro"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill03Pro"},
      IconName = "skill03Pro",
      Id = 27,
      IndicatorAimSet = {"skill03Pro"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 101436,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03Atk"
    },
    skill04_1 = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill04_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = {"heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill04_1",
      Id = 28,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill04_1"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001014,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 30,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001015] = {
    Block = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {"block"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "Block",
      Id = 37,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "Block"
    },
    BlockHitSp = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {"BlockHitSp"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "BlockHitSp",
      Id = 38,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "BlockHitSp"
    },
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 32,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 34,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    exatk = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "exatk5",
        "exatk4",
        "exatk3",
        "exatk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "exatk5",
        "exatk4",
        "exatk3",
        "exatk2",
        "exatk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {
        "PursuitStart"
      },
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "exatk",
      Id = 33,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "exatk1"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 43,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_1"},
      IconName = "skill02_1",
      Id = 35,
      IndicatorAimSet = {"skill02_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 16,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 7.5,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 9,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 36,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 101551,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_2"
    },
    skill03_2 = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_2",
      Id = 39,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 101552,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03_2"
    },
    skillPassive = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skillPassive"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skillPassive",
      Id = 40,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skillPassive"
    },
    skillPassive2 = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skillPassive2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skillPassive2",
      Id = 41,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skillPassive2"
    },
    skillPassive3 = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skillPassive3"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skillPassive3",
      Id = 42,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skillPassive3"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001015,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 44,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001016] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001016,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 18,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    balletHold = {
      CancelUpSkActs = nil,
      CharId = 1001016,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "balletHold",
      Id = 23,
      IndicatorAutoLock = true,
      IndicatorCastSet = {
        "balletStart",
        "balletLoop"
      },
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 16,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 4.5,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = false,
      UiChargeMagic = 1016038,
      UiChargeType = 2,
      UiSkill = "balletLoopIcon"
    },
    balletUp = {
      CancelUpSkActs = nil,
      CharId = 1001016,
      HitCacheTime = 0.4,
      HitSkActs = {"ballet"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = {"ballet"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "balletUp",
      Id = 21,
      IndicatorAimSet = {"ballet"},
      IndicatorAutoLock = true,
      IndicatorCastSet = {
        "balletStart",
        "balletLoop"
      },
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 16,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 4.5,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "balletLoopIcon"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001016,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 19,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    exQte = {
      CancelUpSkActs = nil,
      CharId = 1001016,
      HitCacheTime = 0.4,
      HitSkActs = {"exQte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "exQte",
      Id = 24,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "exQte"
    },
    martele = {
      CancelUpSkActs = nil,
      CharId = 1001016,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.5,
      HitUpSkActs = {"martele"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.5,
      HoldUpSkActs = {"martele"},
      IconName = "martele",
      Id = 20,
      IndicatorAimSet = {"martele"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 5.3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_semicircle_1",
      IndicatorFineSizeX = 2.65,
      IndicatorFineSizeY = 2.65,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "martele"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001016,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 22,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001017] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 46,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 47,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    spAtk = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "spAtk3",
        "spAtk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "spAtk3",
        "spAtk2",
        "spAtk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"heavy"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "spAtk",
      Id = 52,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "spAtk1"
    },
    stab = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"stab"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"stab"},
      IconName = "stab",
      Id = 53,
      IndicatorAimSet = {"stab"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 11,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.8,
      IndicatorFineSizeY = 5.2,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "stabStart"
    },
    storm = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"storm"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"storm"},
      IconName = "storm",
      Id = 48,
      IndicatorAimSet = {"storm"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 14,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.8,
      IndicatorFineSizeY = 6.5,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "storm"
    },
    streak = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = {"streak"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "streak",
      Id = 49,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "streak"
    },
    streakEx = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = {"streakEx"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "streakEx",
      Id = 51,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 101740,
      UiChargeType = 2,
      UiEnhance = true,
      UiSkill = "streakExStart"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001017,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 50,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ultStart"
    }
  },
  [1001018] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001018,
      HitCacheTime = 0.4,
      HitSkActs = {"counter"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 0,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001018,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 1,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    exQte = {
      CancelUpSkActs = nil,
      CharId = 1001018,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"exQte"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"exQte"},
      IconName = "exQte",
      Id = 5,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_semicircle_1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "exQte"
    },
    skill2_1 = {
      CancelUpSkActs = nil,
      CharId = 1001018,
      HitCacheTime = 0.4,
      HitSkActs = {"skill2_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill2_1",
      Id = 2,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill2_1"
    },
    skill3_1 = {
      CancelUpSkActs = nil,
      CharId = 1001018,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill3_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill3_1"},
      IconName = "skill3_1",
      Id = 3,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_semicircle_1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill3_1"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001018,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 4,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001019] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001019,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 22,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    crush = {
      CancelUpSkActs = nil,
      CharId = 1001019,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"crush"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"crush"},
      IconName = "crush",
      Id = 25,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 12,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "crush"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001019,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 23,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "dashOut"
    },
    shield = {
      CancelUpSkActs = nil,
      CharId = 1001019,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"shield"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"shield"},
      IconName = "shield",
      Id = 26,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 12,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeAttrCur = 74,
      UiChargeAttrMax = 75,
      UiChargeIsReduce = true,
      UiChargeType = 1,
      UiSkill = "shield"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001019,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 24,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001020] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 55,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 56,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 64,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_1",
      Id = 58,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.35,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 59,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_2"
    },
    skill02_3 = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_3"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_3",
      Id = 60,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_3"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill03_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill03_1"},
      IconName = "skill03_1",
      Id = 61,
      IndicatorAimSet = {"skill03_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 12,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_1_start"
    },
    skill03_2_atk = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "skill03_2_atk"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "skill03_2_atk"
      },
      IconName = "skill03_2_atk",
      Id = 63,
      IndicatorAimSet = {
        "skill03_2_atk"
      },
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 12,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 5,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_2_atk"
    },
    skill03_2_start = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03_2_start"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_2_start",
      Id = 62,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_2_start"
    },
    spatk = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.5,
      HitSkActs = {"counter"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"spatk"},
      HoldCacheTime = 0.4,
      HoldSkActs = {"heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "spatk",
      Id = 57,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "spatk_start"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001020,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 65,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001021] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001021,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "skill03_1"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 0,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001021,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 1,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001021,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_1"},
      IconName = "skill02_1",
      Id = 2,
      IndicatorAimSet = {"skill02_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 10,
      IndicatorCoarseType = 2,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 6,
      IndicatorFineSizeY = 6,
      IndicatorFineType = 1,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 360,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001021,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 5,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1021001,
      UiChargeType = 2,
      UiSkill = "skill02_2"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001021,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"heavy"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"heavy"},
      IconName = "skill03_1",
      Id = 3,
      IndicatorAimSet = {"heavy"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.25,
      IndicatorFineSizeY = 10,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_1"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001021,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 4,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001022] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.5,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 8,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    butterFly1 = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"butterFly1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"butterFly1"},
      IconName = "butterFly1",
      Id = 12,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.75,
      IndicatorFineSizeY = 6,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "butterFly1"
    },
    butterFly2 = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"butterFly2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"butterFly2"},
      IconName = "butterFly2",
      Id = 13,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.75,
      IndicatorFineSizeY = 6,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "butterFly2"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 10,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    furyAtk = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = {
        "furyCounter"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "furyAtk",
      Id = 9,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "furyAtk"
    },
    furyDash = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = {
        "furyDashOut",
        "furyDashIn"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "furyDash",
      Id = 11,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    switchBack = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = {"switchBack"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "switchBack",
      Id = 20,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "switchBack"
    },
    switchFury = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = {"switchFury"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "switchFury",
      Id = 19,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "switchFury"
    },
    thunderDao1 = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderDao1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderDao1"
      },
      IconName = "thunderDao1",
      Id = 14,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 4,
      IndicatorFineSizeY = 6,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderDao1"
    },
    thunderDao2 = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderDao2"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderDao2"
      },
      IconName = "thunderDao2",
      Id = 15,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 5,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderDao2"
    },
    thunderDao3 = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderDao3"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderDao3"
      },
      IconName = "thunderDao3",
      Id = 16,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderDao3"
    },
    thunderDaoComb2 = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderDaoComb2"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderDaoComb2"
      },
      IconName = "thunderDaoComb2",
      Id = 17,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 5,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderDaoComb2"
    },
    thunderDaoComb3 = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "thunderDaoComb3"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "thunderDaoComb3"
      },
      IconName = "thunderDaoComb3",
      Id = 18,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "thunderDaoComb3"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001022,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 21,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001023] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 67,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 68,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 75,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02Ex = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02Ex"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02Ex",
      Id = 71,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02Ex"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill02_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill02_1"},
      IconName = "skill02_1",
      Id = 69,
      IndicatorAimSet = {"skill02_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 16,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 8,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 70,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_2"
    },
    skill03AreaAtk = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03AreaAtk"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03AreaAtk",
      Id = 73,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03AreaAtk"
    },
    skill03AreaAtkPro = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "skill03AreaAtkPro"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "skill03AreaAtkPro"
      },
      IconName = "skill03AreaAtkPro",
      Id = 74,
      IndicatorAimSet = {
        "skill03AreaAtkPro"
      },
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 30,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchOcclusWeight = {
        {-100},
        {-100},
        {-100}
      },
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 102388,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03AreaAtkPro"
    },
    skill03Flash = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03Flash"
      },
      HitUpCacheTime = 0.4,
      HitUpSkActs = {
        "skill03Area"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {
        "skill03Flash"
      },
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "skill03Area"
      },
      IconName = "skill03Flash",
      Id = 72,
      IndicatorAimSet = {
        "skill03Area"
      },
      IndicatorAutoLock = false,
      IndicatorCastSet = {
        "skill03FlashStr"
      },
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 16,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 0.5,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.3,
      IndicatorViscous = false,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03Area"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001023,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 76,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001024] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {
        "counter",
        "heavy",
        "heavyAir",
        "heavyGround",
        "heavyLast"
      },
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 78,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 79,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 88,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_1", "skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_1",
      Id = 80,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 81,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_2"
    },
    skill02_2_0 = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill02_2_0",
        "skill02_2_1"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2_0",
      Id = 82,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_2_1"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03_1",
        "skill03_1Fast"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_1",
      Id = 83,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_1"
    },
    skillPassiveAtk1 = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skillPassiveAtk3",
        "skillPassiveAtk2",
        "skillPassiveAtk1"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skillPassiveAtk1",
      Id = 85,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skillPassiveAtk1"
    },
    skillPassiveAtk2 = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skillPassiveAtk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skillPassiveAtk2",
      Id = 86,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skillPassiveAtk2"
    },
    skillPassiveAtk3 = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skillPassiveAtk3"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skillPassiveAtk3",
      Id = 87,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skillPassiveAtk3"
    },
    skillPassiveStr = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skillPassiveStr"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skillPassiveStr",
      Id = 84,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skillPassiveStr"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001024,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 89,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001025] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk5",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk5",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.5,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 27,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = {
        {15},
        {15},
        {10}
      },
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 28,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "dashOut"
    },
    kickAss = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = {"kickAss"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "kickAss",
      Id = 32,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = {
        {20},
        {20},
        {15}
      },
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "kickAss"
    },
    kneeStrike = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"kneeStrike"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"kneeStrike"},
      IconName = "kneeStrike",
      Id = 29,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 2.5,
      IndicatorFineSizeY = 6,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "kneeStrike"
    },
    penetrating = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "penetrating"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "penetrating"
      },
      IconName = "penetrating",
      Id = 31,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.75,
      IndicatorFineSizeY = 8,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "penetrating"
    },
    smashDown = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = {"smashDown"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "smashDown",
      Id = 33,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "smashDown"
    },
    spiralPrick = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = {
        "spiralPrick"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "spiralPrick",
      Id = 30,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = {
        {20},
        {20},
        {15}
      },
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "spiralPrick"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001025,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 34,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001026] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 91,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 92,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "dashOut"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 102,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02Air = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02Air",
      Id = 97,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_1"
    },
    skill02ButtonCd = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02ButtonCd",
      Id = 96,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 102622,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02ButtonCd"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_1",
      Id = 93,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2", "skill02_1"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 94,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 102622,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_2Button"
    },
    skill02_3 = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill02_3",
        "skill02_2",
        "skill02_1"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_3",
      Id = 95,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 102622,
      UiChargeType = 2,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill02_3Button"
    },
    skill03 = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {"skill03_L"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03",
      Id = 98,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = false,
      UiSkill = "skill03_L"
    },
    skill03_Ex = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03_ExL"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_Ex",
      Id = 101,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03_ExL"
    },
    skill03_Sp = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03_SpR",
        "skill03_SpL"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_Sp",
      Id = 99,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03_SpL"
    },
    skill03_Ult = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03_Ult",
        "skill03_UltR"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_Ult",
      Id = 100,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "skill03_Ult"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001026,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 103,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001027] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk5",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk5",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 25,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 26,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    linkQte = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {"linkQte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "linkQte",
      Id = 32,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "linkQte"
    },
    link_skill2_1 = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {
        "link_skill2_1"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "link_skill2_1",
      Id = 33,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "link_skill2_1"
    },
    link_skill3_1 = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {
        "link_skill3_1"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "link_skill3_1",
      Id = 34,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "link_skill3_1"
    },
    skill2_1 = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill2_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill2_1"},
      IconName = "skill2_1",
      Id = 27,
      IndicatorAimSet = {"skill2_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_H1001027_skill1area_sector",
      IndicatorFineSizeX = 1,
      IndicatorFineSizeY = 1,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill2_1"
    },
    skill2_2 = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {"skill2_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill2_2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill2_2"},
      IconName = "skill2_2",
      Id = 28,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "skill2_2"
    },
    skill3_1 = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.5,
      HitUpSkActs = {"skill3_1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.5,
      HoldUpSkActs = {"skill3_1"},
      IconName = "skill3_1",
      Id = 29,
      IndicatorAimSet = {"skill3_1"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_H1001027_skill2area_sector",
      IndicatorFineSizeX = 1,
      IndicatorFineSizeY = 1,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorSlomo = true,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill3_1"
    },
    skill3_2 = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {"skill3_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"skill3_2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"skill3_2"},
      IconName = "skill3_2",
      Id = 30,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "skill3_2"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001027,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 31,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001028] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "atk",
      Id = 105,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 106,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "dashOut"
    },
    qte = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {"qte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "qte",
      Id = 111,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "qte"
    },
    skill02_1 = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill02_3",
        "skill02_2",
        "skill02_1"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_1",
      Id = 107,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_1"
    },
    skill02_2 = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_2",
      Id = 108,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_2"
    },
    skill02_3 = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {"skill02_3"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill02_3",
      Id = 109,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill02_3"
    },
    skill03_1 = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {
        "skill03_1",
        "skill03_1Pro_1"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "skill03_1",
      Id = 110,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "skill03_1"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001028,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 112,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001029] = {
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk5",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk5",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 17,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    chain = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = {"chain"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"chain"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "chain",
      Id = 22,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "chain"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 18,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    justiceSword = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = {
        "justiceSword"
      },
      HitUpCacheTime = 0.4,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "justiceSword",
      Id = 23,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "justiceSword"
    },
    spreadCrime = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "spreadCrime"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "spreadCrime"
      },
      IconName = "spreadCrime",
      Id = 21,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 10,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 6,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnhance = true,
      UiSkill = "spreadCrime"
    },
    trialTime1 = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"trialTime1"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"trialTime1"},
      IconName = "trialTime1",
      Id = 19,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 1.5,
      IndicatorFineSizeY = 7,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "trialTime1"
    },
    trialTime2 = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"trialTime2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"trialTime2"},
      IconName = "trialTime2",
      Id = 20,
      IndicatorAimSet = {"hitUp", "holdUp"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 4,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1021001,
      UiChargeType = 2,
      UiSkill = "trialTime2"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001029,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 24,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    }
  },
  [1001030] = {
    air_sprint = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {"air_sprint"},
      HitUpCacheTime = 0.5,
      HitUpSkActs = {"air_sprint"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.5,
      HoldUpSkActs = {"air_sprint"},
      IconName = "air_sprint",
      Id = 8,
      IndicatorAimSet = {"air_sprint"},
      IndicatorAutoLock = true,
      IndicatorCoarseRes = "Fx_skill_maxrange",
      IndicatorCoarseSizeX = 16,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N1",
      IndicatorFineSizeX = 2,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 1,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiChargeMagic = 1030204,
      UiChargeType = 2,
      UiEnhance = true,
      UiSkill = "air_sprint"
    },
    atk = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "counter",
        "atk4",
        "atk3",
        "atk2",
        "atk1"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = {"counter", "heavy"},
      HoldTimeThreshold = 0.15,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"counter"},
      IconName = "atk",
      Id = 1,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "atk1"
    },
    dash = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {"dashOut", "dashIn"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "dash",
      Id = 2,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1999259,
      UiChargeType = 2,
      UiSkill = "dashOut"
    },
    fish_drop2 = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {"fish_drop2"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"fish_drop2"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"fish_drop2"},
      IconName = "fish_drop2",
      Id = 11,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1030205,
      UiChargeType = 2,
      UiEnhance = true,
      UiSkill = "fish_drop2"
    },
    linkQte = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {"linkQte"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "linkQte",
      Id = 13,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiEnable = true,
      UiEnhance = true,
      UiSkill = "linkQte"
    },
    sprint = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {"sprint"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"sprint"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"sprint"},
      IconName = "sprint",
      Id = 4,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1030201,
      UiChargeType = 2,
      UiEnhance = true,
      UiSkill = "sprint"
    },
    stab = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {"stab"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"stab"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"stab"},
      IconName = "stab",
      Id = 5,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "stab"
    },
    sweep = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {"sweep"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"sweep"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"sweep"},
      IconName = "sweep",
      Id = 6,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1030202,
      UiChargeType = 2,
      UiSkill = "sweep"
    },
    throw_fan = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = nil,
      HitUpCacheTime = 0.2,
      HitUpSkActs = {"throw_fan"},
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {"throw_fan"},
      IconName = "throw_fan",
      Id = 3,
      IndicatorAimSet = {"throw_fan"},
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineRes = "Fx_skillarea_N2",
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 8.2,
      IndicatorFineType = 2,
      IndicatorMaskType = 1,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "throw_fan"
    },
    ult = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {
        "ultEmpty",
        "ultFast",
        "ult"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "ult",
      Id = 12,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiSkill = "ult"
    },
    xiuyouyanji = {
      CancelUpSkActs = nil,
      CharId = 1001030,
      HitCacheTime = 0.4,
      HitSkActs = {
        "xiuyouyanji"
      },
      HitUpCacheTime = 0.2,
      HitUpSkActs = {
        "xiuyouyanji"
      },
      HoldCacheTime = 0.4,
      HoldSkActs = nil,
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = {
        "xiuyouyanji"
      },
      IconName = "xiuyouyanji",
      Id = 7,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = nil,
      SearchDistWeight = nil,
      SearchViscousWeight = nil,
      UiChargeIsReduce = true,
      UiChargeMagic = 1030203,
      UiChargeType = 2,
      UiEnhance = true,
      UiSkill = "xiuyouyanji"
    }
  },
  [3001000] = {
    turnOver = {
      CancelUpSkActs = nil,
      CharId = 3001000,
      HitCacheTime = 0.4,
      HitSkActs = {"turnOver"},
      HitUpCacheTime = 0.2,
      HitUpSkActs = nil,
      HoldCacheTime = 0.4,
      HoldSkActs = {"turnOver"},
      HoldTimeThreshold = 0.2,
      HoldUpCacheTime = 0.2,
      HoldUpSkActs = nil,
      IconName = "turnOver",
      Id = 1,
      IndicatorAutoLock = true,
      IndicatorCoarseSizeX = 3,
      IndicatorCoarseType = 1,
      IndicatorFineSizeX = 3,
      IndicatorFineSizeY = 3,
      IndicatorFineType = 2,
      IndicatorMaskType = 0,
      IndicatorMaxDist = 10,
      IndicatorSecAngle = 60,
      IndicatorSecRadius = 5,
      IndicatorSensitivity = 0.5,
      IndicatorViscous = true,
      SearchAngleWeight = {
        {5, -0.05},
        {0, 0},
        {8, -0.1}
      },
      SearchDistWeight = {
        {
          8,
          -2,
          0
        },
        {
          10,
          -2,
          0
        },
        {
          5,
          -1,
          0
        }
      },
      SearchViscousWeight = {
        {3},
        {2}
      },
      UiChargeIsReduce = true,
      UiEnable = true,
      UiSkill = "turnOver"
    }
  }
}
t[1001001].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].dash.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].dash.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].dash.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001001].exatk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].exatk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].exatk.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].exatk.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].exatk.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001001].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_1.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].skill02_1.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].skill02_1.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001001].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill02_2.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].skill02_2.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].skill02_2.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001001].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_1.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].skill03_1.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].skill03_1.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001001].skill03_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].skill03_2.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].skill03_2.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001001].skill03_2_akt.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2_akt.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2_akt.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2_akt.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].skill03_2_akt.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].skill03_2_akt.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].skill03_2_akt.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001001].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001001].ult.SearchAngleWeight = t[1001001].atk.SearchAngleWeight
t[1001001].ult.SearchDistWeight = t[1001001].atk.SearchDistWeight
t[1001001].ult.SearchViscousWeight = t[1001001].atk.SearchViscousWeight
t[1001004].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].dash.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001004].dash.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001004].dash.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001004].prick.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].prick.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].prick.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].prick.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001004].prick.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001004].prick.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001004].thunderSpear.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSpear.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSpear.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSpear.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001004].thunderSpear.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001004].thunderSpear.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001004].thunderSprint1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint1.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001004].thunderSprint1.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001004].thunderSprint1.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001004].thunderSprint2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint2.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001004].thunderSprint2.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001004].thunderSprint2.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001004].thunderSprint3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint3.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].thunderSprint3.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001004].thunderSprint3.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001004].thunderSprint3.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001004].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001004].ult.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001004].ult.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001004].ult.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001008].arashi.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].arashi.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].arashi.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].area.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].area.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].area.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].area.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].area.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001008].area.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001008].area.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001008].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].atk.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001008].atk.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001008].atk.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001008].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].dash.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001008].dash.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001008].dash.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001008].punish.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punish.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punish.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punish.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punish.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001008].punish.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001008].punish.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001008].punish4.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punish4.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punish4.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punish4.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001008].punish4.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001008].punish4.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001008].punishMult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punishMult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punishMult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punishMult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].punishMult.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001008].punishMult.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001008].punishMult.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001008].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001008].ult.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001008].ult.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001008].ult.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001009].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].boomerang.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].boomerang.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].boomerang.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].boomerang.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001009].boomerang.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001009].boomerang.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001009].cleave.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].cleave.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].cleave.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].cleave.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].cleave.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001009].cleave.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001009].cleave.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001009].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].dash.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001009].dash.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001009].dash.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001009].insertSword.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].insertSword.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].insertSword.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].insertSword.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001009].insertSword.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001009].insertSword.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001009].streak.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].streak.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].streak.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].streak.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001009].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].ult.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001009].ult.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001009].ult.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001009].waltz.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001009].waltz.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001009].waltz.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001009].waltz2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001009].waltz2.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001009].waltz2.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001009].waltz2.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001010].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].dash.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001010].dash.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001010].dash.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001010].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill02_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill02_1.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001010].skill02_1.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001010].skill02_1.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001010].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_1.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001010].skill03_1.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001010].skill03_1.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001010].skill03_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].skill03_2.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001010].skill03_2.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001010].skill03_2.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001010].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001010].ult.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001010].ult.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001010].ult.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001011].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001011].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001011].skill02ExStart.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02ExStart.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02ExStart.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02ExStart.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02ExStart.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].skill02ExStart.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].skill02ExStart.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001011].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].skill02_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].skill02_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001011].skill02_2Start.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02_2Start.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02_2Start.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill02_2Start.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].skill02_2Start.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].skill02_2Start.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001011].skill03.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].skill03.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].skill03.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001011].skill03End.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03End.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03End.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03End.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].skill03End.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].skill03End.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].skill03End.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001011].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001011].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001011].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001011].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001012].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].atk.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].atk.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].atk.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].dash.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].dash.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].dash.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_1.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].skill02_1.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].skill02_1.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_2.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].skill02_2.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].skill02_2.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].skill02_2_ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_2_ult.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_2_ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill02_2_ult.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].skill02_2_ult.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].skill02_2_ult.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_1.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].skill03_1.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].skill03_1.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].skill03_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_2.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].skill03_2.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].skill03_2.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].skill03_2_ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_2_ult.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_2_ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].skill03_2_ult.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001012].skill03_2_ult.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].skill03_2_ult.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001012].spAtk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].spAtk.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].spAtk.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].spAtk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].spAtk.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001012].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001012].ult.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001013].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].dash.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001013].dash.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001013].dash.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001013].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill02_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill02_1.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001013].skill02_1.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001013].skill02_1.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001013].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill02_2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill02_2.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001013].skill02_2.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001013].skill02_2.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001013].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill03_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill03_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].skill03_1.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001013].skill03_1.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001013].skill03_1.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001013].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001013].ult.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001013].ult.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001013].ult.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001014].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].dashAtk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dashAtk.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dashAtk.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dashAtk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].dashAtk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].dashAtk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].dashAtk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].skill02.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].skill02.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].skill02.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].skill02Pro.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pro.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pro.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pro.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pro.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].skill02Pro.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].skill02Pro.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].skill02Pros.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pros.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pros.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pros.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill02Pros.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].skill02Pros.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].skill02Pros.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].skill03.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill03.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].skill03.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].skill03.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].skill03Pro.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill03Pro.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill03Pro.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill03Pro.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].skill03Pro.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].skill03Pro.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].skill04_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill04_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill04_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].skill04_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].skill04_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].skill04_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001014].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001014].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001014].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001014].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].Block.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].Block.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].Block.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].Block.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].Block.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].Block.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].Block.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].BlockHitSp.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].BlockHitSp.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].BlockHitSp.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].BlockHitSp.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].BlockHitSp.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].BlockHitSp.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].BlockHitSp.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].exatk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].exatk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].exatk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].exatk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].exatk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill02_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill02_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].skill02_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].skill02_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill02_2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].skill02_2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].skill02_2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].skill03_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill03_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill03_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill03_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skill03_2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].skill03_2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].skill03_2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].skillPassive.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].skillPassive.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].skillPassive.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].skillPassive2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].skillPassive2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].skillPassive2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].skillPassive3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive3.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive3.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].skillPassive3.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].skillPassive3.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].skillPassive3.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001015].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001015].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001015].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001015].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001016].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].atk.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001016].atk.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001016].atk.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001016].balletHold.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletHold.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletHold.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletHold.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletHold.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletHold.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001016].balletHold.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001016].balletHold.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001016].balletUp.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletUp.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletUp.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].balletUp.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001016].balletUp.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001016].balletUp.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001016].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].dash.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001016].dash.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001016].dash.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001016].exQte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].exQte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].exQte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].exQte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].exQte.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001016].exQte.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001016].exQte.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001016].martele.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].martele.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].martele.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].martele.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001016].martele.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001016].martele.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001016].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001016].ult.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001016].ult.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001016].ult.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001017].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001017].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001017].spAtk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].spAtk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].spAtk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].spAtk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].spAtk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001017].stab.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].stab.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].stab.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].stab.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].stab.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].stab.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001017].storm.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].storm.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].storm.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].storm.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].storm.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].storm.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001017].streak.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streak.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streak.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streak.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streak.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].streak.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].streak.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001017].streakEx.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streakEx.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streakEx.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streakEx.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].streakEx.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].streakEx.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].streakEx.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001017].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001017].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001017].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001017].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001018].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].atk.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001018].atk.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001018].atk.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001018].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].dash.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001018].dash.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001018].dash.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001018].exQte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].exQte.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].exQte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].exQte.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001018].exQte.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001018].exQte.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001018].skill2_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].skill2_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].skill2_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].skill2_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].skill2_1.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001018].skill2_1.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001018].skill2_1.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001018].skill3_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].skill3_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].skill3_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].skill3_1.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001018].skill3_1.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001018].skill3_1.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001018].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001018].ult.SearchAngleWeight = t[1001010].atk.SearchAngleWeight
t[1001018].ult.SearchDistWeight = t[1001010].atk.SearchDistWeight
t[1001018].ult.SearchViscousWeight = t[1001010].atk.SearchViscousWeight
t[1001019].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].atk.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001019].atk.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001019].atk.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001019].crush.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].crush.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].crush.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].crush.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001019].crush.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001019].crush.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001019].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].dash.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001019].dash.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001019].dash.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001019].shield.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].shield.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].shield.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].shield.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001019].shield.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001019].shield.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001019].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001019].ult.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001019].ult.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001019].ult.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001020].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].skill02_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].skill02_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].skill02_2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].skill02_2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].skill02_3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_3.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_3.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill02_3.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].skill02_3.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].skill02_3.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].skill03_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].skill03_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].skill03_2_atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_2_atk.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_2_atk.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_2_atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].skill03_2_atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].skill03_2_atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].skill03_2_start.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_2_start.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_2_start.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_2_start.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].skill03_2_start.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].skill03_2_start.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].skill03_2_start.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].spatk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].spatk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].spatk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].spatk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].spatk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001020].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001020].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001020].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001020].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001021].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].atk.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001021].atk.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001021].atk.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001021].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].dash.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001021].dash.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001021].dash.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001021].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill02_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill02_1.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001021].skill02_1.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001021].skill02_1.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001021].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill02_2.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001021].skill02_2.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001021].skill02_2.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001021].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill03_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].skill03_1.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001021].skill03_1.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001021].skill03_1.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001021].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001021].ult.SearchAngleWeight = t[1001013].atk.SearchAngleWeight
t[1001021].ult.SearchDistWeight = t[1001013].atk.SearchDistWeight
t[1001021].ult.SearchViscousWeight = t[1001013].atk.SearchViscousWeight
t[1001022].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].atk.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].atk.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].atk.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].butterFly1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].butterFly1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].butterFly1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].butterFly1.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].butterFly1.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].butterFly1.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].butterFly2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].butterFly2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].butterFly2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].butterFly2.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].butterFly2.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].butterFly2.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].dash.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].dash.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].dash.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].furyAtk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyAtk.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyAtk.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyAtk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyAtk.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].furyAtk.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].furyAtk.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].furyDash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyDash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyDash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyDash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].furyDash.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].furyDash.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].furyDash.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].switchBack.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchBack.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchBack.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchBack.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchBack.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].switchBack.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].switchBack.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].switchFury.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchFury.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchFury.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchFury.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].switchFury.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].switchFury.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].switchFury.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].thunderDao1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao1.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].thunderDao1.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].thunderDao1.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].thunderDao2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao2.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].thunderDao2.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].thunderDao2.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].thunderDao3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao3.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDao3.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].thunderDao3.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].thunderDao3.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].thunderDaoComb2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDaoComb2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDaoComb2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDaoComb2.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].thunderDaoComb2.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].thunderDaoComb2.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].thunderDaoComb3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDaoComb3.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDaoComb3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].thunderDaoComb3.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].thunderDaoComb3.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].thunderDaoComb3.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001022].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001022].ult.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001022].ult.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001022].ult.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001023].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].skill02Ex.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02Ex.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02Ex.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02Ex.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02Ex.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].skill02Ex.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].skill02Ex.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].skill02_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].skill02_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill02_2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].skill02_2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].skill02_2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].skill03AreaAtk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03AreaAtk.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03AreaAtk.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03AreaAtk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03AreaAtk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].skill03AreaAtk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].skill03AreaAtk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].skill03AreaAtkPro.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03AreaAtkPro.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03AreaAtkPro.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03AreaAtkPro.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].skill03AreaAtkPro.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].skill03AreaAtkPro.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].skill03Flash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].skill03Flash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].skill03Flash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].skill03Flash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001023].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001023].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001023].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001023].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skill02_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skill02_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skill02_2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skill02_2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skill02_2_0.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2_0.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2_0.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2_0.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill02_2_0.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skill02_2_0.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skill02_2_0.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill03_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill03_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skill03_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skill03_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skill03_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skillPassiveAtk1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skillPassiveAtk1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skillPassiveAtk1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skillPassiveAtk2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skillPassiveAtk2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skillPassiveAtk2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skillPassiveAtk3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk3.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk3.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveAtk3.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skillPassiveAtk3.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skillPassiveAtk3.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].skillPassiveStr.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveStr.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveStr.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveStr.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].skillPassiveStr.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].skillPassiveStr.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].skillPassiveStr.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001024].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001024].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001024].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001024].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001025].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].atk.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].atk.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].dash.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].dash.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].dash.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001025].kickAss.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].kickAss.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].kickAss.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].kickAss.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].kickAss.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].kickAss.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].kneeStrike.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].kneeStrike.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].kneeStrike.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].kneeStrike.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].kneeStrike.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].kneeStrike.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001025].penetrating.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].penetrating.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].penetrating.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].penetrating.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].penetrating.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].penetrating.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001025].smashDown.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].smashDown.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].smashDown.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].smashDown.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].smashDown.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].smashDown.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].smashDown.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001025].spiralPrick.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].spiralPrick.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].spiralPrick.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].spiralPrick.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].spiralPrick.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].spiralPrick.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001025].ult.SearchAngleWeight = t[1001004].atk.SearchAngleWeight
t[1001025].ult.SearchDistWeight = t[1001004].atk.SearchDistWeight
t[1001025].ult.SearchViscousWeight = t[1001004].atk.SearchViscousWeight
t[1001026].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill02Air.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02Air.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02Air.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02Air.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02Air.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill02Air.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill02Air.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill02ButtonCd.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02ButtonCd.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02ButtonCd.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02ButtonCd.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02ButtonCd.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02ButtonCd.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill02ButtonCd.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill02ButtonCd.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill02_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill02_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill02_2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill02_2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill02_3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_3.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_3.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill02_3.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill02_3.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill02_3.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill03.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill03.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill03.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill03_Ex.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ex.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ex.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ex.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ex.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill03_Ex.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill03_Ex.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill03_Sp.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Sp.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Sp.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Sp.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Sp.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill03_Sp.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill03_Sp.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].skill03_Ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].skill03_Ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].skill03_Ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].skill03_Ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001026].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001026].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001026].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001026].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001027].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].atk.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].atk.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].atk.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].dash.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].dash.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].dash.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].linkQte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].linkQte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].linkQte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].linkQte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].linkQte.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].linkQte.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].linkQte.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].link_skill2_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill2_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill2_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill2_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill2_1.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].link_skill2_1.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].link_skill2_1.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].link_skill3_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill3_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill3_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill3_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].link_skill3_1.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].link_skill3_1.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].link_skill3_1.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].skill2_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill2_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill2_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill2_1.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].skill2_1.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].skill2_1.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].skill2_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill2_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill2_2.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].skill2_2.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].skill2_2.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].skill3_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill3_1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill3_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill3_1.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].skill3_1.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].skill3_1.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].skill3_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill3_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].skill3_2.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].skill3_2.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].skill3_2.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001027].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001027].ult.SearchAngleWeight = t[1001008].arashi.SearchAngleWeight
t[1001027].ult.SearchDistWeight = t[1001008].arashi.SearchDistWeight
t[1001027].ult.SearchViscousWeight = t[1001008].arashi.SearchViscousWeight
t[1001028].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].atk.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].atk.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].atk.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].atk.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001028].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].dash.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].dash.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].dash.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001028].qte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].qte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].qte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].qte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].qte.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].qte.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].qte.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001028].skill02_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].skill02_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].skill02_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001028].skill02_2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_2.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_2.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_2.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].skill02_2.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].skill02_2.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001028].skill02_3.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_3.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_3.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_3.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill02_3.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].skill02_3.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].skill02_3.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001028].skill03_1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill03_1.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill03_1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill03_1.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].skill03_1.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].skill03_1.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].skill03_1.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001028].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001028].ult.SearchAngleWeight = t[1001011].atk.SearchAngleWeight
t[1001028].ult.SearchDistWeight = t[1001011].atk.SearchDistWeight
t[1001028].ult.SearchViscousWeight = t[1001011].atk.SearchViscousWeight
t[1001029].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].atk.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].atk.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].atk.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001029].chain.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].chain.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].chain.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].chain.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].chain.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].chain.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001029].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].dash.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].dash.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].dash.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001029].justiceSword.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].justiceSword.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].justiceSword.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].justiceSword.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].justiceSword.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].justiceSword.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].justiceSword.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001029].spreadCrime.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].spreadCrime.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].spreadCrime.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].spreadCrime.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].spreadCrime.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].spreadCrime.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001029].trialTime1.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].trialTime1.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].trialTime1.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].trialTime1.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].trialTime1.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].trialTime1.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001029].trialTime2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].trialTime2.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].trialTime2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].trialTime2.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].trialTime2.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].trialTime2.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001029].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001029].ult.SearchAngleWeight = t[1001009].atk.SearchAngleWeight
t[1001029].ult.SearchDistWeight = t[1001009].atk.SearchDistWeight
t[1001029].ult.SearchViscousWeight = t[1001009].atk.SearchViscousWeight
t[1001030].air_sprint.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].air_sprint.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].atk.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].atk.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].atk.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].atk.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].dash.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].dash.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].dash.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].dash.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].dash.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].dash.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].dash.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].fish_drop2.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].fish_drop2.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].fish_drop2.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].fish_drop2.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].fish_drop2.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].linkQte.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].linkQte.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].linkQte.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].linkQte.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].linkQte.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].linkQte.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].linkQte.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].sprint.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].sprint.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].sprint.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].sprint.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].sprint.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].stab.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].stab.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].stab.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].stab.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].stab.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].sweep.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].sweep.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].sweep.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].sweep.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].sweep.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].throw_fan.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].throw_fan.HitSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].throw_fan.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].throw_fan.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].throw_fan.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].throw_fan.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].ult.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].ult.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].ult.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].ult.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].ult.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].ult.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].ult.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[1001030].xiuyouyanji.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].xiuyouyanji.HoldSkActs = t[1001001].atk.CancelUpSkActs
t[1001030].xiuyouyanji.SearchAngleWeight = t[1001030].air_sprint.SearchAngleWeight
t[1001030].xiuyouyanji.SearchDistWeight = t[1001030].air_sprint.SearchDistWeight
t[1001030].xiuyouyanji.SearchViscousWeight = t[1001030].air_sprint.SearchViscousWeight
t[3001000].turnOver.CancelUpSkActs = t[1001001].atk.CancelUpSkActs
t[3001000].turnOver.HitUpSkActs = t[1001001].atk.CancelUpSkActs
t[3001000].turnOver.HoldUpSkActs = t[1001001].atk.CancelUpSkActs
return t
