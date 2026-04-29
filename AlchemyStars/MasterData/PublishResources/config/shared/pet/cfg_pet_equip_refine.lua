local key = {
  ID = 1,
  PetID = 2,
  Level = 3,
  NeedItem = 4,
  Attack = 5,
  Defence = 6,
  Health = 7,
  OpenCondition = 8,
  UnLockCondition = 9,
  SkillName = 10,
  SkillType = 11,
  SkillIcon = 12,
  Desc = 13,
  BuffID = 14,
  ExtraActiveSkill = 15,
  VariantActiveSkillInfo = 16,
  ExtraChainSkill = 17,
  SubstituteSkillDesc = 18,
  elementParam = 19,
  FeatureList = 20
}
local common = {
  "str_skill_name_330011",
  "icon_1600111_atkult",
  "str_skill_passive_name_410018",
  "icon_1500181_zhuangbei",
  "str_skill_passive_name_410093",
  "icon_1600931_zhuangbei",
  "str_skill_name_3001931",
  "icon_1501931_atkult",
  "str_skill_name_3001911",
  "icon_1601911_atkult01",
  "str_skill_passive_name_410033",
  "icon_1500331_zhuangbei",
  "str_skill_name_300019",
  "icon_1600191_atkult",
  "str_skill_name_3400482",
  "icon_1400481_atkult",
  "str_skill_name_300064",
  "icon_1600641_atkult",
  "str_skill_name_300023",
  "icon_1600231_atkult",
  "str_skill_name_300090",
  "icon_1500901_atkult",
  "str_skill_passive_name_430192",
  "icon_1601921_zhuangbei",
  "str_skill_passive_name_410060",
  "icon_1600601_zhuangbei",
  "str_skill_passive_name_410046",
  "icon_1300461_zhuangbei",
  "str_skill_name_3002021",
  "icon_1602021_atkult01",
  "str_skill_name_325075",
  "icon_1500751_atkult",
  "str_skill_passive_name_420201",
  "icon_1602011_zhuangbei",
  "str_skill_name_300078",
  "icon_1500781_atkult",
  "str_skill_passive_name_410027",
  "icon_1600271_zhuangbei",
  "str_skill_name_300028",
  "icon_1600281_atkult",
  "str_skill_name_300097",
  "icon_1500971_atkult",
  "str_skill_name_300070",
  "icon_1500701_atkult",
  "str_skill_name_300025",
  "icon_1600251_atkult",
  "str_skill_name_300005",
  "icon_1600051_atkult",
  "str_skill_name_3002091",
  "icon_1602091_atkult",
  "str_skill_name_3002101",
  "icon_1502101_atkult",
  "str_skill_passive_name_410215",
  "icon_1502151_zhuangbei",
  "str_skill_name_3002181",
  "icon_1602181_atkult",
  "str_skill_name_3002191",
  "icon_1602191_atkult",
  "str_skill_passive_name_430221",
  "icon_1602211_zhuangbei",
  "str_skill_passive_name_430225",
  "icon_1602251_zhuangbei",
  "str_skill_name_300153",
  "icon_1601531_atkult",
  "str_skill_name_326155",
  "icon_1601551_atkult",
  "str_skill_passive_name_436107",
  "icon_1701071_zhuangbei",
  "str_skill_name_336108",
  "icon_1701081_atkult",
  "str_skill_passive_name_433110",
  "icon_1701101_zhuangbei",
  "str_skill_passive_name_4002321",
  "icon_1502321_zhuangbei",
  "str_skill_passive_name_4102331",
  "icon_1602331_zhuangbei",
  "str_skill_passive_name_400235",
  "icon_1502351_zhuangbei",
  "str_skill_passive_name_410173",
  "icon_1601731_zhuangbei",
  "str_skill_passive_name_410169",
  "icon_1401691_zhuangbei",
  "str_skill_passive_name_4102371",
  "icon_1602371_zhuangbei",
  "str_skill_passive_name_4102361",
  "icon_1702361_zhuangbei",
  "str_skill_name_3001761",
  "icon_1501761_atkult",
  "str_skill_name_3001821",
  "icon_1601821_atkult",
  {
    {3501001, 3},
    {3204023, 16},
    {3210403, 32},
    {3500001, 1600},
    {3000002, 160000}
  },
  {
    {3501001, 3},
    {3204022, 16},
    {3204021, 8},
    {3210403, 40},
    {3500001, 2400},
    {3000002, 240000}
  },
  {
    {3501001, 3},
    {3204021, 16},
    {3204023, 8},
    {3204022, 8},
    {3210403, 48},
    {3500001, 4000},
    {3000002, 400000}
  },
  {
    {3501001, 6},
    {3204033, 20},
    {3210503, 40},
    {3500001, 2000},
    {3000002, 200000}
  },
  {
    {3501001, 3},
    {3204013, 16},
    {3210103, 32},
    {3500001, 1600},
    {3000002, 160000}
  },
  {
    {3501001, 3},
    {3204012, 16},
    {3204011, 8},
    {3210103, 40},
    {3500001, 2400},
    {3000002, 240000}
  },
  {
    {3501001, 3},
    {3204011, 16},
    {3204013, 8},
    {3204012, 8},
    {3210103, 48},
    {3500001, 4000},
    {3000002, 400000}
  },
  {
    {3501001, 3},
    {3204043, 16},
    {3210203, 32},
    {3500001, 1600},
    {3000002, 160000}
  },
  {
    {3501001, 6},
    {3204043, 20},
    {3210503, 40},
    {3500001, 2000},
    {3000002, 200000}
  },
  {
    {3501001, 6},
    {3204012, 20},
    {3210103, 40},
    {3500001, 2000},
    {3000002, 200000}
  },
  {
    {3501001, 6},
    {3204013, 20},
    {3204011, 10},
    {3210103, 50},
    {3500001, 3000},
    {3000002, 300000}
  },
  {
    {3501001, 6},
    {3204011, 20},
    {3204012, 10},
    {3204013, 10},
    {3210103, 60},
    {3500001, 5000},
    {3000002, 500000}
  },
  {
    {3501001, 6},
    {3204023, 20},
    {3210503, 40},
    {3500001, 2000},
    {3000002, 200000}
  },
  {
    {3501001, 6},
    {3204022, 20},
    {3204021, 10},
    {3210503, 50},
    {3500001, 3000},
    {3000002, 300000}
  },
  {
    {3501001, 6},
    {3204021, 20},
    {3204023, 10},
    {3204022, 10},
    {3210503, 60},
    {3500001, 5000},
    {3000002, 500000}
  },
  {
    {3501001, 6},
    {3204042, 20},
    {3204041, 10},
    {3210503, 50},
    {3500001, 3000},
    {3000002, 300000}
  },
  {
    {3501001, 6},
    {3204013, 20},
    {3210203, 40},
    {3500001, 2000},
    {3000002, 200000}
  },
  {
    {3501001, 6},
    {3204012, 20},
    {3204011, 10},
    {3210203, 50},
    {3500001, 3000},
    {3000002, 300000}
  },
  {
    {3501001, 6},
    {3204011, 20},
    {3204013, 10},
    {3204012, 10},
    {3210203, 60},
    {3500001, 5000},
    {3000002, 500000}
  },
  {
    {3501001, 3},
    {3204042, 16},
    {3204041, 8},
    {3210203, 40},
    {3500001, 2400},
    {3000002, 240000}
  },
  {
    {3501001, 3},
    {3204041, 16},
    {3204043, 8},
    {3204042, 8},
    {3210203, 48},
    {3500001, 4000},
    {3000002, 400000}
  },
  {
    {3501001, 6},
    {3204033, 20},
    {3210203, 40},
    {3500001, 2000},
    {3000002, 200000}
  },
  {
    {3501001, 6},
    {3204032, 20},
    {3204031, 10},
    {3210203, 50},
    {3500001, 3000},
    {3000002, 300000}
  },
  {4400111},
  {442018},
  {441098},
  {4400231},
  {44009011, 44009012},
  {4400461},
  {441027},
  {440070},
  {4402151},
  {4422181},
  {4501071},
  {33610801},
  {4401091},
  {4602331},
  {2002364},
  {4401820, 4501824},
  {
    [1] = {
      [430011] = "str_skill_passive_desc_440011"
    }
  },
  {
    [1] = {
      BuffID = 62,
      [1] = {
        field = "LayerCount",
        value = 7,
        type = 2,
        isShow = false
      },
      [2] = {
        value = {7},
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "maxLayer"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 420018,
      [1] = {
        value = {
          1.1,
          0.73,
          0.37
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "ratesByDis"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100931,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.2},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4100932,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.2},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101931,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      },
      [2] = {
        value = 1101934,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [3301931] = {3401931, 3401932},
    [3351931] = {3451931, 3401932}
  },
  {
    [1] = {
      BuffID = 4101911,
      [2] = {
        value = 0.00858,
        key = {
          LogicType = "Active",
          param = "promotePercent"
        },
        isShow = false,
        type = 2
      },
      [3] = {
        value = 0.6,
        key = {
          LogicType = "Active",
          param = "maxSkillFinal"
        },
        isShow = false,
        type = 2
      },
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410033,
      [1] = {
        value = 0.025,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.025,
        key = {
          LogicType = "Exec",
          paramIndex = 2,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.025,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.025,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430033,
      [1] = {
        value = 0.025,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.025,
        key = {
          LogicType = "Exec",
          param = "addPercentPerLayer",
          paramIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.05,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.025,
        key = {},
        type = 2
      },
      [5] = {
        value = 0.05,
        key = {},
        type = 2
      }
    }
  },
  {
    [320019] = {3200192},
    [323019] = {3230192},
    [326019] = {3260192}
  },
  {
    feature = {
      [2] = {
        EnterSanValue = 100,
        MaxSanValue = 100,
        RoundDelValue = 0,
        SanSysCfgId = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410098,
      [1] = {
        field = "LayerCount",
        value = 10,
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4100981,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      [320064] = "str_skill_desc_341064",
      [323064] = "str_skill_desc_341064",
      [326064] = "str_skill_desc_341064"
    },
    [2] = {
      [430064] = "str_skill_passive_desc_440064"
    }
  },
  {
    [1] = {
      BuffID = 4100642,
      [1] = {
        value = 5,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "layer"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [300023] = {3400231},
    [303023] = {3430231},
    [306023] = {3430231}
  },
  {
    [1] = {
      [430023] = "str_skill_passive_desc_440023"
    }
  },
  {
    [1] = {
      [430090] = "str_skill_passive_desc_440090"
    }
  },
  {
    [1] = {
      BuffID = 4101922,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          param = "oneLayerValue"
        },
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 420046,
      [1] = {
        value = 0.07,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102021,
      [1] = {
        value = 1102025,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId",
          isShow = false
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410075,
      [1] = {
        value = 0.8,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 420028,
      [1] = {
        value = 0.018,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2
      }
    }
  },
  {
    [300097] = {3400971},
    [302097] = {3420971}
  },
  {
    [1] = {
      [430097] = "str_skill_passive_desc_440097"
    }
  },
  {
    [1] = {
      BuffID = 430097,
      [1] = {
        value = 0.01,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "addValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 420070,
      [1] = {
        value = 142070,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.75,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410025,
      [1] = {
        value = 400525,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.12,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100,
      [1] = {
        value = 0.7,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [330005] = {3300051, 3300052},
    [336005] = {3360051, 3360052}
  },
  {
    [1] = {
      [430209] = "str_skill_passive_desc_440209"
    }
  },
  {
    [1] = {
      BuffID = 4202091,
      [1] = {
        value = 4202095,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410210,
      [1] = {
        value = {0.36},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.18},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.36,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 200221,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "damagePercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102151,
      [1] = {
        value = 1102154,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4202150,
      [1] = {
        value = 1202155,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.65,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      [3002181] = "str_skill_desc_30021812",
      [30021811] = "str_skill_desc_300218112",
      [3402181] = "str_skill_desc_34021812",
      [3412181] = "str_skill_desc_34121812",
      [3402182] = "str_skill_desc_34021822",
      [3412182] = "str_skill_desc_34121822"
    }
  },
  {
    [3002181] = {34021812},
    [30021811] = {34121812},
    [3402182] = {34021812},
    [3412182] = {34121812}
  },
  {
    [1] = {
      BuffID = 4202191,
      [1] = {
        value = 1,
        key = {},
        type = 2
      },
      [2] = {
        value = 4202195,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4232191,
      [1] = {
        value = 1,
        key = {},
        type = 2
      },
      [2] = {
        value = 4232195,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 40021915,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102212,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4302213,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102254,
      [1] = {
        value = {2.3},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {2.3},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {1},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = 2.3,
        key = {},
        type = 2
      },
      [6] = {
        value = {1.15},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      },
      [7] = {
        value = {1.15},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 4
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4102253,
      [1] = {
        value = 41022524,
        key = {LogicType = "Load", param = "buffID"},
        type = 2
      },
      [2] = {
        value = 41022524,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101532,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4201532,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4201535,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [4] = {
      BuffID = 4301533,
      [1] = {
        value = 0.015,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [5] = {
      BuffID = 4301535,
      [1] = {
        value = 0.015,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [6] = {
      BuffID = 4301537,
      [1] = {
        value = 0.015,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [7] = {
      BuffID = 4201531,
      [1] = {
        value = 6,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "layer"
        },
        type = 2,
        isShow = false
      }
    },
    [8] = {
      BuffID = 4301534,
      [1] = {
        value = 6,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "layer"
        },
        type = 2,
        isShow = false
      }
    },
    [9] = {
      BuffID = 4261532,
      [1] = {
        value = {
          percent = {1.5}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {
          percent = {1.6}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {1.7}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {
          percent = {0.75}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {
          percent = {0.8}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 5,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [6] = {
        value = {
          percent = {0.85}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 6,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 41001550,
      [1] = {
        value = -0.35,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 430015500,
      [1] = {
        value = 0.65,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 41001551,
      [1] = {
        value = {
          percent = {0.65}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 43201551,
      [1] = {
        value = 8,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 3,
          TriggerParamIndex = 4
        },
        type = 2
      },
      [2] = {
        value = 16,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 4,
          TriggerParamIndex = 4
        },
        type = 2
      }
    },
    [5] = {
      BuffID = 43201554,
      [1] = {
        value = 16,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 3,
          TriggerParamIndex = 4
        },
        type = 2
      }
    },
    [6] = {
      BuffID = 43201557,
      [1] = {
        value = 8,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 3,
          TriggerParamIndex = 4
        },
        type = 2
      }
    },
    [7] = {
      BuffID = 43201552,
      [1] = {
        value = 8,
        key = {
          LogicType = "Exec",
          LogicIndex = 4,
          param = "clearParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = -8,
        key = {
          LogicType = "Exec",
          LogicIndex = 5,
          param = "addValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 400107,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4001073,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      [330109] = "str_skill_desc_340109",
      [433109] = "str_skill_passive_desc_453109"
    }
  },
  {
    [1] = {
      BuffID = 4331091,
      [1] = {
        value = 4501092,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101104,
      [1] = {
        value = 0.35,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102301,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102302,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4162301,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4162302,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [5] = {
      BuffID = 4302303,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 4302304,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [7] = {
      BuffID = 4302305,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [8] = {
      BuffID = 4302306,
      [1] = {
        value = 4102305,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102331,
      [1] = {
        value = 20,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "count"
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 4202331,
      [1] = {
        value = 5,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "count"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      [4102341] = "str_skill_passive_desc_440234"
    }
  },
  {
    [1] = {
      BuffID = 4102341,
      [1] = {
        value = 20,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "count"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4102351,
      [1] = {
        value = 20,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "count"
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 4202351,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "maxSkillIncrease"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4201732,
      [1] = {
        value = {
          percent = {2.125}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 5,
          param = "set"
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 4231732,
      [1] = {
        value = {
          percent = {2.125}
        },
        key = {
          LogicType = "Exec",
          LogicIndex = 5,
          param = "set"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101691,
      [1] = {
        value = 0.33,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4101696,
      [1] = {
        value = 0.22,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102372,
      [1] = {
        value = {trapID = 8502375},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {findPosTrapId = 8502375},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {trapID = 8502375},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8502375},
        key = {
          LogicType = "Load",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4162372,
      [1] = {
        value = {trapID = 8562375},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {findPosTrapId = 8562375},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {trapID = 8562375},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8562375},
        key = {
          LogicType = "Load",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      [4102361] = "str_skill_passive_desc_4402361"
    }
  },
  {
    [1] = {
      BuffID = 4102365,
      [1] = {
        value = 0.011,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      [3201821] = "str_skill_desc_3401821"
    }
  }
}
local config = {
  {
    1,
    1600111,
    1,
    {
      {3501001, 6},
      {3204013, 20},
      {3210503, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    59,
    15,
    217,
    "312,1600111,3,80&318,1600111,10",
    nil,
    "str_skill_passive_name_410011",
    4,
    "icon_1600111_zhuangbei",
    "str_skill_upgrade_refine_desc_16001111",
    common[114],
    nil,
    nil,
    nil,
    common[130],
    common[131]
  },
  {
    2,
    1600111,
    2,
    {
      {3501001, 6},
      {3204012, 20},
      {3204011, 10},
      {3210503, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    119,
    31,
    434,
    nil,
    nil,
    common[1],
    3,
    common[2],
    "str_skill_upgrade_refine_desc_16001112",
    common[114],
    nil,
    {
      [330011] = {3300111}
    },
    nil,
    common[130],
    common[131]
  },
  {
    3,
    1600111,
    3,
    {
      {3501001, 6},
      {3204011, 20},
      {3204013, 10},
      {3204012, 10},
      {3210503, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    180,
    48,
    658,
    nil,
    nil,
    common[1],
    3,
    common[2],
    "str_skill_upgrade_refine_desc_16001113",
    common[114],
    nil,
    {
      [330011] = {3300111, 3300112}
    },
    nil,
    common[130],
    common[131]
  },
  {
    4,
    1500181,
    1,
    common[91],
    45,
    12,
    182,
    "312,1500181,3,80&318,1500181,10",
    nil,
    common[3],
    4,
    common[4],
    "str_skill_upgrade_refine_desc_15001811",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430018] = "str_skill_passive_desc_440018"
      }
    },
    common[132]
  },
  {
    5,
    1500181,
    2,
    common[92],
    91,
    24,
    364,
    nil,
    nil,
    "str_skill_name_200181",
    2,
    "icon_1500181_chain",
    "str_skill_upgrade_refine_desc_15001812",
    common[115],
    nil,
    nil,
    nil,
    {
      [1] = {
        [430018] = "str_skill_passive_desc_440018"
      },
      [2] = {
        [200181] = "str_skill_desc_2400181",
        [200182] = "str_skill_desc_2400182",
        [200183] = "str_skill_desc_2400183"
      }
    },
    common[132]
  },
  {
    6,
    1500181,
    3,
    common[93],
    138,
    36,
    552,
    nil,
    nil,
    common[3],
    4,
    common[4],
    "str_skill_upgrade_refine_desc_15001813",
    common[115],
    nil,
    nil,
    nil,
    {
      [1] = {
        [430018] = "str_skill_passive_desc_450018"
      },
      [2] = {
        [200181] = "str_skill_desc_2400181",
        [200182] = "str_skill_desc_2400182",
        [200183] = "str_skill_desc_2400183"
      }
    },
    {
      [1] = {
        BuffID = 420018,
        [1] = {
          value = {
            1.1,
            0.88,
            0.66,
            0.44,
            0.22
          },
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "ratesByDis"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    7,
    1600931,
    1,
    common[94],
    73,
    15,
    194,
    "312,1600931,3,80&318,1600931,10",
    nil,
    common[5],
    4,
    common[6],
    "str_skill_upgrade_refine_desc_16009311",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430093] = "str_skill_passive_desc_4300931"
      }
    },
    common[133]
  },
  {
    8,
    1600931,
    2,
    {
      {3501001, 6},
      {3204031, 20},
      {3204032, 10},
      {3210503, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    146,
    31,
    389,
    nil,
    nil,
    "str_skill_name_330093",
    3,
    "icon_1600931_atkult",
    "str_skill_upgrade_refine_desc_16009312",
    {440093, 450093},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430093] = "str_skill_passive_desc_4300931"
      },
      [2] = {
        [330093] = "str_skill_desc_340093",
        [336093] = "str_skill_desc_346093"
      }
    },
    common[133]
  },
  {
    9,
    1600931,
    3,
    {
      {3501001, 6},
      {3204032, 20},
      {3204033, 10},
      {3204031, 10},
      {3210503, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    222,
    47,
    590,
    nil,
    nil,
    common[5],
    4,
    common[6],
    "str_skill_upgrade_refine_desc_16009313",
    {
      440093,
      450093,
      41009321
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [430093] = "str_skill_passive_desc_4300932"
      },
      [2] = {
        [330093] = "str_skill_desc_340093",
        [336093] = "str_skill_desc_346093"
      }
    },
    common[133]
  },
  {
    10,
    1501931,
    1,
    common[95],
    44,
    12,
    179,
    "312,1501931,3,80&318,1501931,10",
    nil,
    common[7],
    3,
    common[8],
    "str_skill_upgrade_refine_desc_15019311",
    nil,
    nil,
    {
      [3301931] = {3401931},
      [3351931] = {3451931}
    },
    nil,
    nil,
    common[134]
  },
  {
    11,
    1501931,
    2,
    common[96],
    88,
    24,
    358,
    nil,
    nil,
    common[7],
    3,
    common[8],
    "str_skill_upgrade_refine_desc_15019312",
    nil,
    nil,
    common[135],
    nil,
    nil,
    common[134]
  },
  {
    12,
    1501931,
    3,
    common[97],
    133,
    36,
    543,
    nil,
    nil,
    "str_skill_passive_name_430193",
    4,
    "icon_1501931_zhuangbei",
    "str_skill_upgrade_refine_desc_15019313",
    {4401933},
    nil,
    common[135],
    nil,
    {
      [1] = {
        [430193] = "str_skill_passive_desc_4401933"
      }
    },
    common[134]
  },
  {
    13,
    1601911,
    1,
    {
      {3501001, 6},
      {3204022, 20},
      {3210203, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    63,
    15,
    215,
    "312,1601911,3,80&318,1601911,10",
    nil,
    "str_skill_passive_name_410191",
    4,
    "icon_1601911_zhuangbei",
    "str_skill_upgrade_refine_desc_16019111",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [410191] = "str_skill_passive_desc_4101911"
      }
    },
    common[136]
  },
  {
    14,
    1601911,
    2,
    {
      {3501001, 6},
      {3204023, 20},
      {3204021, 10},
      {3210203, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    126,
    30,
    430,
    nil,
    nil,
    common[9],
    3,
    common[10],
    "str_skill_upgrade_refine_desc_16019112",
    {400191102},
    nil,
    nil,
    nil,
    {
      [1] = {
        [410191] = "str_skill_passive_desc_4101911"
      },
      [2] = {
        [3201911] = "str_skill_desc_32019112",
        [32019111] = "str_skill_desc_32019112"
      }
    },
    common[136]
  },
  {
    15,
    1601911,
    3,
    {
      {3501001, 6},
      {3204021, 20},
      {3204022, 10},
      {3204023, 10},
      {3210203, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    190,
    45,
    651,
    nil,
    nil,
    common[9],
    3,
    common[10],
    "str_skill_upgrade_refine_desc_16019113",
    {400191102, 400191103},
    nil,
    nil,
    nil,
    {
      [1] = {
        [410191] = "str_skill_passive_desc_4101911"
      },
      [2] = {
        [3201911] = "str_skill_desc_32019113",
        [32019111] = "str_skill_desc_32019113"
      }
    },
    common[136]
  },
  {
    16,
    1500331,
    1,
    {
      {3501001, 3},
      {3204011, 16},
      {3210503, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    52,
    11,
    169,
    "312,1500331,3,80&318,1500331,10",
    nil,
    common[11],
    4,
    common[12],
    "str_skill_upgrade_refine_desc_15003311",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430033] = "str_skill_passive_desc_4300331"
      }
    },
    common[137]
  },
  {
    17,
    1500331,
    2,
    {
      {3501001, 3},
      {3204012, 16},
      {3204013, 8},
      {3210503, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    105,
    23,
    338,
    nil,
    nil,
    "str_skill_name_300033",
    3,
    "icon_1500331_atkult",
    "str_skill_upgrade_refine_desc_15003312",
    {442033},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430033] = "str_skill_passive_desc_4300331"
      },
      [2] = {
        [320033] = "str_skill_desc_3200331",
        [325033] = "str_skill_desc_3250331"
      }
    },
    common[137]
  },
  {
    18,
    1500331,
    3,
    {
      {3501001, 3},
      {3204013, 16},
      {3204011, 8},
      {3204012, 8},
      {3210503, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    160,
    35,
    512,
    nil,
    nil,
    common[11],
    4,
    common[12],
    "str_skill_upgrade_refine_desc_15003313",
    {
      442033,
      4430331,
      4430332,
      4430333
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [430033] = "str_skill_passive_desc_4300332"
      },
      [2] = {
        [320033] = "str_skill_desc_3200331",
        [325033] = "str_skill_desc_3250331"
      }
    },
    common[137]
  },
  {
    19,
    1600191,
    1,
    {
      {3501001, 6},
      {3204022, 20},
      {3210603, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    49,
    15,
    153,
    "312,1600191,3,80&318,1600191,10",
    nil,
    common[13],
    3,
    common[14],
    "str_skill_upgrade_refine_desc_16001911",
    {3400192, 3460192},
    nil,
    common[138],
    nil,
    nil,
    nil,
    common[139]
  },
  {
    20,
    1600191,
    2,
    {
      {3501001, 6},
      {3204023, 20},
      {3204021, 10},
      {3210603, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    99,
    31,
    307,
    nil,
    nil,
    common[13],
    3,
    common[14],
    "str_skill_upgrade_refine_desc_16001912",
    {
      442019,
      3400192,
      3460192
    },
    nil,
    common[138],
    nil,
    {
      [1] = {
        [3200192] = "str_skill_desc_32001922",
        [3230192] = "str_skill_desc_32301922",
        [3260192] = "str_skill_desc_32601922"
      },
      [2] = {
        [320019] = "str_skill_desc_340019",
        [323019] = "str_skill_desc_343019",
        [326019] = "str_skill_desc_346019"
      }
    },
    nil,
    common[139]
  },
  {
    21,
    1600191,
    3,
    {
      {3501001, 6},
      {3204021, 20},
      {3204022, 10},
      {3204023, 10},
      {3210603, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    150,
    48,
    465,
    nil,
    nil,
    common[13],
    3,
    common[14],
    "str_skill_upgrade_refine_desc_16001913",
    {
      442019,
      3400191,
      3460191,
      3400192,
      3460192
    },
    nil,
    {
      [320019] = {3200192, 3200191},
      [323019] = {3230192, 3230191},
      [326019] = {3260192, 3260191}
    },
    nil,
    {
      [1] = {
        [3200192] = "str_skill_desc_32001922",
        [3230192] = "str_skill_desc_32301922",
        [3260192] = "str_skill_desc_32601922"
      },
      [2] = {
        [3200191] = "str_skill_desc_32001912",
        [3230191] = "str_skill_desc_32301912",
        [3260191] = "str_skill_desc_32601912"
      },
      [3] = {
        [320019] = "str_skill_desc_340019",
        [323019] = "str_skill_desc_343019",
        [326019] = "str_skill_desc_346019"
      }
    },
    nil,
    common[139]
  },
  {
    22,
    1500981,
    1,
    {
      {3501001, 3},
      {3204032, 16},
      {3210203, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    62,
    12,
    182,
    "312,1500981,3,80&318,1500981,10",
    nil,
    "str_skill_name_200981",
    2,
    "icon_1500981_chain",
    "str_skill_upgrade_refine_desc_15009811",
    common[116],
    nil,
    nil,
    nil,
    {
      [1] = {
        [210981] = "str_skill_desc_2009811"
      },
      [2] = {
        [210982] = "str_skill_desc_2009821"
      },
      [3] = {
        [210983] = "str_skill_desc_2009831"
      }
    }
  },
  {
    23,
    1500981,
    2,
    {
      {3501001, 3},
      {3204031, 16},
      {3204033, 8},
      {3210203, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    125,
    24,
    365,
    nil,
    nil,
    "str_skill_passive_name_410098",
    4,
    "icon_1500981_zhuangbei",
    "str_skill_upgrade_refine_desc_15009812",
    common[116],
    nil,
    nil,
    nil,
    {
      [1] = {
        [210981] = "str_skill_desc_2009811"
      },
      [2] = {
        [210982] = "str_skill_desc_2009821"
      },
      [3] = {
        [210983] = "str_skill_desc_2009831"
      },
      [4] = {
        [420098] = "str_skill_passive_desc_4200981"
      }
    },
    common[140]
  },
  {
    24,
    1500981,
    3,
    {
      {3501001, 3},
      {3204033, 16},
      {3204032, 8},
      {3204031, 8},
      {3210203, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    190,
    37,
    553,
    nil,
    nil,
    "str_skill_name_300098",
    3,
    "icon_1500981_atkult",
    "str_skill_upgrade_refine_desc_15009813",
    {441098, 443098},
    nil,
    nil,
    nil,
    {
      [1] = {
        [210981] = "str_skill_desc_2009811"
      },
      [2] = {
        [210982] = "str_skill_desc_2009821"
      },
      [3] = {
        [210983] = "str_skill_desc_2009831"
      },
      [4] = {
        [420098] = "str_skill_passive_desc_4200981"
      },
      [5] = {
        [330098] = "str_skill_desc_3300981",
        [335098] = "str_skill_desc_3350981"
      }
    },
    common[140]
  },
  {
    25,
    1400481,
    1,
    common[98],
    43,
    11,
    182,
    "312,1400481,3,80&318,1400481,10",
    nil,
    "str_skill_passive_name_430048",
    4,
    "icon_1400481_zhuangbei",
    "str_skill_upgrade_refine_desc_14004811",
    {44004811, 44004812},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430048] = "str_skill_passive_desc_4400481"
      }
    }
  },
  {
    26,
    1400481,
    2,
    {
      {3501001, 3},
      {3204041, 16},
      {3204042, 8},
      {3210203, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    86,
    23,
    364,
    nil,
    nil,
    common[15],
    3,
    common[16],
    "str_skill_upgrade_refine_desc_14004812",
    {
      44004811,
      44004812,
      4400482
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [430048] = "str_skill_passive_desc_4400481"
      },
      [2] = {
        [320048] = "str_skill_desc_3400482",
        [322048] = "str_skill_desc_3420482"
      }
    }
  },
  {
    27,
    1400481,
    3,
    {
      {3501001, 3},
      {3204042, 16},
      {3204043, 8},
      {3204041, 8},
      {3210203, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    130,
    35,
    552,
    nil,
    nil,
    common[15],
    3,
    common[16],
    "str_skill_upgrade_refine_desc_14004813",
    {
      44004811,
      44004812,
      4400482,
      4400483
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [430048] = "str_skill_passive_desc_4400481"
      },
      [2] = {
        [320048] = "str_skill_desc_3400483",
        [322048] = "str_skill_desc_3420483"
      }
    }
  },
  {
    28,
    1600641,
    1,
    common[99],
    65,
    14,
    188,
    "312,1600641,3,80&318,1600641,10",
    nil,
    common[17],
    3,
    common[18],
    "str_skill_upgrade_refine_desc_16006411",
    {3410641},
    nil,
    nil,
    nil,
    {
      [1] = {
        [320064] = "str_skill_desc_341064",
        [323064] = "str_skill_desc_341064",
        [326064] = "str_skill_desc_341064"
      }
    }
  },
  {
    29,
    1600641,
    2,
    {
      {3501001, 6},
      {3204041, 20},
      {3204042, 10},
      {3210503, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    130,
    28,
    377,
    nil,
    nil,
    "str_skill_passive_name_410064",
    4,
    "icon_1600641_zhuangbei",
    "str_skill_upgrade_refine_desc_16006412",
    {4400642, 3410641},
    nil,
    nil,
    nil,
    common[141],
    common[142]
  },
  {
    30,
    1600641,
    3,
    {
      {3501001, 6},
      {3204042, 20},
      {3204043, 10},
      {3204041, 10},
      {3210503, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    198,
    42,
    572,
    nil,
    nil,
    common[17],
    3,
    common[18],
    "str_skill_upgrade_refine_desc_16006413",
    {
      4400642,
      3410641,
      3430641
    },
    nil,
    nil,
    nil,
    common[141],
    common[142]
  },
  {
    31,
    1600231,
    1,
    {
      {3501001, 6},
      {3204011, 20},
      {3210203, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    59,
    12,
    173,
    "312,1600231,3,80&318,1600231,10",
    nil,
    common[19],
    3,
    common[20],
    "str_skill_upgrade_refine_desc_16002311",
    nil,
    nil,
    common[143]
  },
  {
    32,
    1600231,
    2,
    {
      {3501001, 6},
      {3204012, 20},
      {3204013, 10},
      {3210203, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    119,
    25,
    346,
    nil,
    nil,
    "str_skill_passive_name_430023",
    4,
    "icon_1600231_zhuangbei",
    "str_skill_upgrade_refine_desc_16002312",
    common[117],
    nil,
    common[143],
    nil,
    common[144]
  },
  {
    33,
    1600231,
    3,
    {
      {3501001, 6},
      {3204013, 20},
      {3204011, 10},
      {3204012, 10},
      {3210203, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    181,
    38,
    525,
    nil,
    nil,
    common[19],
    3,
    common[20],
    "str_skill_upgrade_refine_desc_16002313",
    common[117],
    nil,
    {
      [300023] = {3400231, 3400232},
      [303023] = {3430231, 3430232},
      [306023] = {3430231, 3430232}
    },
    nil,
    common[144]
  },
  {
    34,
    1500901,
    1,
    common[91],
    41,
    13,
    154,
    "312,1500901,3,80&318,1500901,10",
    nil,
    "str_skill_passive_name_430090",
    4,
    "icon_1500901_zhuangbei",
    "str_skill_upgrade_refine_desc_15009011",
    common[118],
    nil,
    nil,
    nil,
    common[145]
  },
  {
    35,
    1500901,
    2,
    common[92],
    82,
    26,
    308,
    nil,
    nil,
    common[21],
    3,
    common[22],
    "str_skill_upgrade_refine_desc_15009012",
    common[118],
    nil,
    {
      [320090] = {3400901},
      [322090] = {3420901}
    },
    nil,
    common[145]
  },
  {
    36,
    1500901,
    3,
    common[93],
    124,
    40,
    467,
    nil,
    nil,
    common[21],
    3,
    common[22],
    "str_skill_upgrade_refine_desc_15009013",
    common[118],
    nil,
    {
      [320090] = {3400901, 3400902},
      [322090] = {3420901, 3420902}
    },
    nil,
    common[145]
  },
  {
    37,
    1601921,
    1,
    {
      {3501001, 6},
      {3204033, 20},
      {3210103, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    58,
    14,
    207,
    "312,1601921,3,80&318,1601921,10",
    nil,
    common[23],
    4,
    common[24],
    "str_skill_upgrade_refine_desc_16019211",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430192] = "str_skill_passive_desc_440192",
        [436192] = "str_skill_passive_desc_446192"
      }
    },
    common[146]
  },
  {
    38,
    1601921,
    2,
    {
      {3501001, 6},
      {3204031, 20},
      {3204032, 10},
      {3210103, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    116,
    28,
    415,
    nil,
    nil,
    common[23],
    4,
    common[24],
    "str_skill_upgrade_refine_desc_16019212",
    {4401922},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430192] = "str_skill_passive_desc_440193",
        [436192] = "str_skill_passive_desc_446193"
      }
    },
    common[146]
  },
  {
    39,
    1601921,
    3,
    {
      {3501001, 6},
      {3204032, 20},
      {3204033, 10},
      {3204031, 10},
      {3210103, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    176,
    43,
    629,
    nil,
    nil,
    "str_skill_name_3001920",
    3,
    "icon_1601921_atkult01",
    "str_skill_upgrade_refine_desc_16019213",
    {4401922, 4401923},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430192] = "str_skill_passive_desc_440193",
        [436192] = "str_skill_passive_desc_446193"
      },
      [2] = {
        [3301920] = "str_skill_desc_34019200",
        [3301921] = "str_skill_desc_34019201",
        [3301922] = "str_skill_desc_34019202",
        [3301923] = "str_skill_desc_34019203"
      }
    },
    common[146]
  },
  {
    40,
    1600601,
    1,
    {
      {3501001, 6},
      {3204022, 20},
      {3210403, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    69,
    13,
    183,
    "312,1600601,3,80&318,1600601,10",
    nil,
    common[25],
    4,
    common[26],
    "str_skill_upgrade_refine_desc_16006011",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420060] = "str_skill_passive_desc_4400601"
      }
    },
    {
      [1] = {
        BuffID = 410060,
        [1] = {
          value = 1100605,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420060,
        [1] = {
          value = 1100605,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    41,
    1600601,
    2,
    {
      {3501001, 6},
      {3204023, 20},
      {3204021, 10},
      {3210403, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    138,
    27,
    366,
    nil,
    nil,
    common[25],
    4,
    common[26],
    "str_skill_upgrade_refine_desc_16006012",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420060] = "str_skill_passive_desc_4400602"
      }
    },
    {
      [1] = {
        BuffID = 410060,
        [1] = {
          value = 1100605,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420060,
        [1] = {
          value = 1100605,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        },
        [3] = {
          value = 0.25,
          key = {
            LogicType = "Active",
            LogicIndex = 2,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    42,
    1600601,
    3,
    {
      {3501001, 6},
      {3204021, 20},
      {3204022, 10},
      {3204023, 10},
      {3210403, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    210,
    41,
    555,
    nil,
    nil,
    "str_skill_name_200601",
    2,
    "icon_1600601_chain",
    "str_skill_upgrade_refine_desc_16006013",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420060] = "str_skill_passive_desc_4400602"
      },
      [2] = {
        [200601] = "str_skill_desc_243601"
      },
      [3] = {
        [200602] = "str_skill_desc_243602"
      },
      [4] = {
        [200603] = "str_skill_desc_243603"
      }
    },
    {
      [1] = {
        BuffID = 410060,
        [1] = {
          value = 1100605,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420060,
        [1] = {
          value = 1100605,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        },
        [3] = {
          value = 0.25,
          key = {
            LogicType = "Active",
            LogicIndex = 2,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 300060,
        [1] = {
          value = {
            [200601] = 240604,
            [200602] = 240605,
            [200603] = 240606
          },
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "param"
          },
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 306060,
        [1] = {
          value = {
            [200601] = 240604,
            [200602] = 240605,
            [200603] = 240606
          },
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "param"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    43,
    1300461,
    1,
    {
      {3501001, 3},
      {3204043, 16},
      {3210103, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    38,
    13,
    143,
    "312,1300461,3,80&318,1300461,10",
    nil,
    common[27],
    4,
    common[28],
    "str_skill_upgrade_refine_desc_13004611",
    common[119],
    nil,
    nil,
    nil,
    {
      [1] = {
        [430046] = "str_skill_passive_desc_4400461"
      }
    }
  },
  {
    44,
    1300461,
    2,
    {
      {3501001, 3},
      {3204041, 16},
      {3204042, 8},
      {3210103, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    76,
    26,
    286,
    nil,
    nil,
    "str_skill_name_200461",
    2,
    "icon_1300461_chain",
    "str_skill_upgrade_refine_desc_13004612",
    common[119],
    nil,
    nil,
    nil,
    {
      [1] = {
        [430046] = "str_skill_passive_desc_4400461"
      },
      [2] = {
        [220461] = "str_skill_desc_240461"
      },
      [3] = {
        [220462] = "str_skill_desc_240462"
      },
      [4] = {
        [220463] = "str_skill_desc_240463"
      }
    },
    common[147]
  },
  {
    45,
    1300461,
    3,
    {
      {3501001, 3},
      {3204042, 16},
      {3204043, 8},
      {3204041, 8},
      {3210103, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    115,
    39,
    433,
    nil,
    nil,
    common[27],
    4,
    common[28],
    "str_skill_upgrade_refine_desc_13004613",
    {4400461, 4400463},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430046] = "str_skill_passive_desc_4400463"
      },
      [2] = {
        [220461] = "str_skill_desc_240461"
      },
      [3] = {
        [220462] = "str_skill_desc_240462"
      },
      [4] = {
        [220463] = "str_skill_desc_240463"
      }
    },
    common[147]
  },
  {
    46,
    1602021,
    1,
    common[100],
    52,
    13,
    198,
    "312,1602021,3,80&318,1602021,10",
    nil,
    "str_skill_passive_name_420202",
    4,
    "icon_1602021_zhuangbei",
    "str_skill_upgrade_refine_desc_16020211",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430202] = "str_skill_passive_desc_440202"
      }
    },
    common[148]
  },
  {
    47,
    1602021,
    2,
    common[101],
    104,
    27,
    396,
    nil,
    nil,
    common[29],
    3,
    common[30],
    "str_skill_upgrade_refine_desc_16020212",
    {4402022},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430202] = "str_skill_passive_desc_440202"
      },
      [2] = {
        [3402021] = "str_skill_desc_3402022",
        [3432021] = "str_skill_desc_3432022"
      }
    },
    common[148]
  },
  {
    48,
    1602021,
    3,
    common[102],
    158,
    41,
    600,
    nil,
    nil,
    common[29],
    3,
    common[30],
    "str_skill_upgrade_refine_desc_16020213",
    {4402022, 4402023},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430202] = "str_skill_passive_desc_440202"
      },
      [2] = {
        [3402021] = "str_skill_desc_3402023",
        [3432021] = "str_skill_desc_3432023"
      }
    },
    common[148]
  },
  {
    49,
    1500751,
    1,
    {
      {3501001, 3},
      {3204032, 16},
      {3210403, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    37,
    12,
    138,
    "312,1500751,3,80&318,1500751,10",
    nil,
    "str_skill_passive_name_430075",
    4,
    "icon_1500751_zhuangbei",
    "str_skill_upgrade_refine_desc_15007511",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430075] = "str_skill_passive_desc_440075"
      }
    },
    common[149]
  },
  {
    50,
    1500751,
    2,
    {
      {3501001, 3},
      {3204031, 16},
      {3204033, 8},
      {3210403, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    75,
    25,
    276,
    nil,
    nil,
    common[31],
    3,
    common[32],
    "str_skill_upgrade_refine_desc_15007512",
    {3400750},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430075] = "str_skill_passive_desc_440075"
      },
      [2] = {
        [320075] = "str_skill_desc_340075",
        [322075] = "str_skill_desc_342075",
        [325075] = "str_skill_desc_345075"
      }
    },
    common[149]
  },
  {
    51,
    1500751,
    3,
    {
      {3501001, 3},
      {3204033, 16},
      {3204032, 8},
      {3204031, 8},
      {3210403, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    114,
    39,
    418,
    nil,
    nil,
    common[31],
    3,
    common[32],
    "str_skill_upgrade_refine_desc_15007513",
    {3400750, 3400751},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430075] = "str_skill_passive_desc_440075"
      },
      [2] = {
        [320075] = "str_skill_desc_350075",
        [322075] = "str_skill_desc_352075",
        [325075] = "str_skill_desc_355075"
      }
    },
    common[149]
  },
  {
    52,
    1602011,
    1,
    {
      {3501001, 6},
      {3204023, 20},
      {3210103, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    57,
    14,
    203,
    "312,1602011,3,80&318,1602011,10",
    nil,
    common[33],
    4,
    common[34],
    "str_skill_upgrade_refine_desc_16020111",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420201] = "str_skill_passive_desc_4202011"
      }
    },
    {
      [1] = {
        BuffID = 420201,
        [1] = {
          value = 0.15,
          key = {LogicType = "Active", param = "baseValue"},
          type = 2
        }
      }
    }
  },
  {
    53,
    1602011,
    2,
    {
      {3501001, 6},
      {3204022, 20},
      {3204021, 10},
      {3210103, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    115,
    28,
    407,
    nil,
    nil,
    "str_skill_name_300201",
    3,
    "icon_1602011_atkult01",
    "str_skill_upgrade_refine_desc_16020112",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420201] = "str_skill_passive_desc_4202011"
      },
      [2] = {
        [300201] = "str_skill_desc_342201"
      }
    },
    {
      [1] = {
        BuffID = 420201,
        [1] = {
          value = 0.15,
          key = {LogicType = "Active", param = "baseValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 4002011,
        [1] = {
          value = 0.9,
          key = {
            LogicType = "Load",
            param = "shieldPercent"
          },
          type = 2
        }
      }
    }
  },
  {
    54,
    1602011,
    3,
    {
      {3501001, 6},
      {3204021, 20},
      {3204023, 10},
      {3204022, 10},
      {3210103, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    174,
    43,
    617,
    nil,
    nil,
    common[33],
    4,
    common[34],
    "str_skill_upgrade_refine_desc_16020113",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420201] = "str_skill_passive_desc_4432011"
      },
      [2] = {
        [300201] = "str_skill_desc_342201"
      }
    },
    {
      [1] = {
        BuffID = 420201,
        [1] = {
          value = 0.15,
          key = {LogicType = "Active", param = "baseValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 4002011,
        [1] = {
          value = 0.9,
          key = {
            LogicType = "Load",
            param = "shieldPercent"
          },
          type = 2
        }
      },
      [3] = {
        BuffID = 420201,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            param = "curHpParamMax"
          },
          type = 2
        }
      }
    }
  },
  {
    55,
    1500781,
    1,
    {
      {3501001, 3},
      {3204033, 16},
      {3210203, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    43,
    11,
    182,
    "312,1500781,3,80&318,1500781,10",
    nil,
    "str_skill_passive_name_430078",
    4,
    "icon_1500781_zhuangbei",
    "str_skill_upgrade_refine_desc_15007811",
    {44007811, 44007812},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430078] = "str_skill_passive_desc_4400781"
      }
    }
  },
  {
    56,
    1500781,
    2,
    {
      {3501001, 3},
      {3204031, 16},
      {3204032, 8},
      {3210203, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    86,
    23,
    364,
    nil,
    nil,
    common[35],
    3,
    common[36],
    "str_skill_upgrade_refine_desc_15007812",
    {
      44007811,
      44007812,
      4400782
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [430078] = "str_skill_passive_desc_4400781"
      },
      [2] = {
        [320078] = "str_skill_desc_3400782",
        [322078] = "str_skill_desc_3420782"
      }
    }
  },
  {
    57,
    1500781,
    3,
    {
      {3501001, 3},
      {3204032, 16},
      {3204033, 8},
      {3204031, 8},
      {3210203, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    131,
    36,
    553,
    nil,
    nil,
    common[35],
    3,
    common[36],
    "str_skill_upgrade_refine_desc_15007813",
    {
      44007811,
      44007812,
      4400782,
      4400783
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [430078] = "str_skill_passive_desc_4400781"
      },
      [2] = {
        [320078] = "str_skill_desc_3400783",
        [322078] = "str_skill_desc_3420783"
      }
    }
  },
  {
    58,
    1602041,
    1,
    {
      {3501001, 6},
      {3204032, 20},
      {3210103, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    64,
    13,
    186,
    "312,1602041,3,80&318,1602041,10",
    nil,
    "str_skill_passive_name_4102041",
    4,
    "icon_1602041_zhuangbei",
    "str_skill_upgrade_refine_desc_16020411",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102041] = "str_skill_passive_desc_4502041"
      }
    },
    {
      [1] = {
        BuffID = 43002043,
        [1] = {
          value = 1.24,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.24,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    59,
    1602041,
    2,
    {
      {3501001, 6},
      {3204031, 20},
      {3204033, 10},
      {3210103, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    128,
    27,
    372,
    nil,
    nil,
    "str_skill_name_2002041",
    2,
    "icon_1602041_chain",
    "str_skill_upgrade_refine_desc_16020412",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102041] = "str_skill_passive_desc_4502041"
      },
      [2] = {
        [2302041] = "str_skill_desc_2502041",
        [2302042] = "str_skill_desc_2502042",
        [2302043] = "str_skill_desc_2502043"
      }
    },
    {
      [1] = {
        BuffID = 43002043,
        [1] = {
          value = 1.24,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.24,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4202041,
        [1] = {
          value = 0.65,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    60,
    1602041,
    3,
    {
      {3501001, 6},
      {3204033, 20},
      {3204032, 10},
      {3204031, 10},
      {3210103, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    194,
    42,
    564,
    nil,
    nil,
    "str_skill_name_3002041",
    3,
    "icon_1602041_atkult",
    "str_skill_upgrade_refine_desc_16020413",
    {4062040},
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102041] = "str_skill_passive_desc_4502041"
      },
      [2] = {
        [2302041] = "str_skill_desc_2502041",
        [2302042] = "str_skill_desc_2502042",
        [2302043] = "str_skill_desc_2502043",
        [3002041] = "str_skill_desc_3502041",
        [3032041] = "str_skill_desc_3532041",
        [3062041] = "str_skill_desc_3562041"
      }
    },
    {
      [1] = {
        BuffID = 43002043,
        [1] = {
          value = 1.24,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.24,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4202041,
        [1] = {
          value = 0.65,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    61,
    1600271,
    1,
    {
      {3501001, 6},
      {3204043, 20},
      {3210103, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    61,
    15,
    217,
    "312,1600271,3,80&318,1600271,10",
    nil,
    "str_skill_name_330027",
    3,
    "icon_1600271_atkult",
    "str_skill_upgrade_refine_desc_16002711",
    common[120],
    nil,
    nil,
    nil,
    {
      [1] = {
        [330027] = "str_skill_desc_3400271",
        [333027] = "str_skill_desc_3430271"
      }
    }
  },
  {
    62,
    1600271,
    2,
    {
      {3501001, 6},
      {3204041, 20},
      {3204042, 10},
      {3210103, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    122,
    31,
    434,
    nil,
    nil,
    common[37],
    4,
    common[38],
    "str_skill_upgrade_refine_desc_16002712",
    common[120],
    nil,
    nil,
    nil,
    {
      [1] = {
        [330027] = "str_skill_desc_3400272",
        [333027] = "str_skill_desc_3430272"
      },
      [2] = {
        [420027] = "str_skill_desc_4400271"
      }
    },
    {
      [1] = {
        BuffID = 4200272,
        [1] = {
          value = 2,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "layer"
          },
          type = 2
        }
      }
    }
  },
  {
    63,
    1600271,
    3,
    {
      {3501001, 6},
      {3204042, 20},
      {3204043, 10},
      {3204041, 10},
      {3210103, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    185,
    48,
    658,
    nil,
    nil,
    common[37],
    4,
    common[38],
    "str_skill_upgrade_refine_desc_16002713",
    common[120],
    nil,
    nil,
    nil,
    {
      [1] = {
        [330027] = "str_skill_desc_3400272",
        [333027] = "str_skill_desc_3430272"
      },
      [2] = {
        [420027] = "str_skill_desc_440027"
      }
    },
    {
      [1] = {
        BuffID = 4200272,
        [1] = {
          value = 2,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "layer"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4100273,
        [1] = {
          value = 4400271,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2
        }
      }
    }
  },
  {
    64,
    1600281,
    1,
    common[100],
    42,
    14,
    164,
    "312,1600281,3,80&318,1600281,10",
    nil,
    "str_skill_passive_name_410028",
    4,
    "icon_1600281_zhuangbei",
    "str_skill_upgrade_refine_desc_16002811",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420028] = "str_skill_passive_desc_450028"
      }
    },
    common[150]
  },
  {
    65,
    1600281,
    2,
    common[101],
    84,
    29,
    329,
    nil,
    nil,
    common[39],
    3,
    common[40],
    "str_skill_upgrade_refine_desc_16002812",
    {442028},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420028] = "str_skill_passive_desc_450028",
        [330028] = "str_skill_desc_350028",
        [336028] = "str_skill_desc_356028"
      }
    },
    common[150]
  },
  {
    66,
    1600281,
    3,
    common[102],
    128,
    44,
    499,
    nil,
    nil,
    common[39],
    3,
    common[40],
    "str_skill_upgrade_refine_desc_16002813",
    {444028},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420028] = "str_skill_passive_desc_450028",
        [330028] = "str_skill_desc_360028",
        [336028] = "str_skill_desc_366028",
        [3600281] = "str_skill_desc_360028",
        [3660281] = "str_skill_desc_366028"
      }
    },
    common[150]
  },
  {
    67,
    1500971,
    1,
    {
      {3501001, 3},
      {3204013, 16},
      {3210203, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    43,
    11,
    184,
    "312,1500971,3,80&318,1500971,10",
    nil,
    common[41],
    3,
    common[42],
    "str_skill_upgrade_refine_desc_15009711",
    nil,
    nil,
    common[151]
  },
  {
    68,
    1500971,
    2,
    {
      {3501001, 3},
      {3204012, 16},
      {3204011, 8},
      {3210203, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    87,
    22,
    369,
    nil,
    nil,
    "str_skill_passive_name_430097",
    4,
    "icon_1500971_zhuangbei",
    "str_skill_upgrade_refine_desc_15009712",
    nil,
    nil,
    common[151],
    nil,
    common[152],
    common[153]
  },
  {
    69,
    1500971,
    3,
    {
      {3501001, 3},
      {3204011, 16},
      {3204013, 8},
      {3204012, 8},
      {3210203, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    131,
    34,
    560,
    nil,
    nil,
    common[41],
    3,
    common[42],
    "str_skill_upgrade_refine_desc_15009713",
    nil,
    nil,
    {
      [300097] = {3400971, 3400972},
      [302097] = {3420971, 3420972}
    },
    nil,
    common[152],
    common[153]
  },
  {
    70,
    1500701,
    1,
    {
      {3501001, 3},
      {3204021, 16},
      {3210203, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    58,
    11,
    162,
    "312,1500701,3,80&318,1500701,10",
    nil,
    common[43],
    3,
    common[44],
    "str_skill_upgrade_refine_desc_15007011",
    common[121],
    nil,
    nil,
    nil,
    {
      [1] = {
        [300070] = "str_skill_desc_350070",
        [305070] = "str_skill_desc_355070"
      }
    }
  },
  {
    71,
    1500701,
    2,
    {
      {3501001, 3},
      {3204022, 16},
      {3204023, 8},
      {3210203, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    116,
    23,
    324,
    nil,
    nil,
    "str_skill_passive_name_410070",
    4,
    "icon_1500701_zhuangbei",
    "str_skill_upgrade_refine_desc_15007012",
    common[121],
    nil,
    nil,
    nil,
    {
      [1] = {
        [420070] = "str_skill_passive_desc_450070",
        [300070] = "str_skill_desc_350070",
        [305070] = "str_skill_desc_355070"
      }
    },
    common[154]
  },
  {
    72,
    1500701,
    3,
    {
      {3501001, 3},
      {3204023, 16},
      {3204021, 8},
      {3204022, 8},
      {3210203, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    176,
    36,
    491,
    nil,
    nil,
    common[43],
    3,
    common[44],
    "str_skill_upgrade_refine_desc_15007013",
    {440070, 443070},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420070] = "str_skill_passive_desc_450070",
        [300070] = "str_skill_desc_360070",
        [305070] = "str_skill_desc_365070"
      }
    },
    common[154]
  },
  {
    73,
    1600251,
    1,
    common[103],
    52,
    14,
    207,
    "312,1600251,3,80&318,1600251,10",
    nil,
    "str_skill_passive_name_410025",
    4,
    "icon_1600251_zhuangbei",
    "str_skill_upgrade_refine_desc_16002511",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430025] = "str_skill_passive_desc_440025"
      }
    },
    {
      [1] = {
        BuffID = 410025,
        [1] = {
          value = 400525,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.12,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    74,
    1600251,
    2,
    common[104],
    104,
    28,
    414,
    nil,
    nil,
    common[45],
    3,
    common[46],
    "str_skill_upgrade_refine_desc_16002512",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430025] = "str_skill_passive_desc_440025",
        [320025] = "str_skill_desc_350025",
        [326025] = "str_skill_desc_356025"
      }
    },
    common[155]
  },
  {
    75,
    1600251,
    3,
    common[105],
    158,
    43,
    628,
    nil,
    nil,
    common[45],
    3,
    common[46],
    "str_skill_upgrade_refine_desc_16002513",
    {46002511},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430025] = "str_skill_passive_desc_440025",
        [320025] = "str_skill_desc_360025",
        [326025] = "str_skill_desc_366025"
      }
    },
    common[155]
  },
  {
    76,
    1500241,
    1,
    {
      {3501001, 3},
      {3204023, 16},
      {3210503, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    41,
    10,
    192,
    "312,1500241,3,80&318,1500241,10",
    nil,
    "str_skill_passive_name_410024",
    4,
    "icon_1500241_zhuangbei",
    "str_skill_upgrade_refine_desc_15002411",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [410024] = "str_skill_passive_desc_440024"
      }
    },
    {
      [1] = {
        BuffID = 15002415,
        [1] = {
          value = 1100244,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    77,
    1500241,
    2,
    {
      {3501001, 3},
      {3204022, 16},
      {3204021, 8},
      {3210503, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    82,
    21,
    384,
    nil,
    nil,
    "str_skill_name_300024",
    3,
    "icon_1500241_atkult",
    "str_skill_upgrade_refine_desc_15002412",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [410024] = "str_skill_passive_desc_440024",
        [330024] = "str_skill_desc_340024",
        [332024] = "str_skill_desc_342024",
        [335024] = "str_skill_desc_345024"
      }
    },
    {
      [1] = {
        BuffID = 15002415,
        [1] = {
          value = 1100244,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 3,
          isShow = false
        }
      },
      [2] = {
        BuffID = 15002412,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      },
      [3] = {
        BuffID = 15002413,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      },
      [4] = {
        BuffID = 15002414,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      },
      [5] = {
        BuffID = 15002416,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      }
    }
  },
  {
    78,
    1500241,
    3,
    {
      {3501001, 3},
      {3204021, 16},
      {3204023, 8},
      {3204022, 8},
      {3210503, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    125,
    32,
    582,
    nil,
    nil,
    "str_skill_name_200241",
    2,
    "icon_1500241_chain",
    "str_skill_upgrade_refine_desc_15002413",
    {15002417},
    nil,
    nil,
    nil,
    {
      [1] = {
        [410024] = "str_skill_passive_desc_440024",
        [330024] = "str_skill_desc_340024",
        [332024] = "str_skill_desc_342024",
        [335024] = "str_skill_desc_345024",
        [200241] = "str_skill_desc_240241",
        [200242] = "str_skill_desc_240242",
        [200243] = "str_skill_desc_240243",
        [202241] = "str_skill_desc_240241",
        [202242] = "str_skill_desc_240242",
        [202243] = "str_skill_desc_240243"
      }
    },
    {
      [1] = {
        BuffID = 15002415,
        [1] = {
          value = 1100244,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 3,
          isShow = false
        }
      },
      [2] = {
        BuffID = 15002412,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      },
      [3] = {
        BuffID = 15002413,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      },
      [4] = {
        BuffID = 15002414,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      },
      [5] = {
        BuffID = 15002416,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 3,
          isShow = false
        }
      },
      [6] = {
        BuffID = 15302410,
        [1] = {
          value = {
            [2] = 230244,
            [11] = 230245,
            [15] = 230246
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 3,
          isShow = false
        }
      },
      [7] = {
        BuffID = 15302411,
        [1] = {
          value = {
            [0] = 230244,
            [9] = 230245,
            [14] = 230246
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 3,
          isShow = false
        }
      }
    }
  },
  {
    79,
    1600051,
    1,
    {
      {3501001, 3},
      {3204042, 16},
      {3210703, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    58,
    12,
    180,
    "312,1600051,3,80&318,1600051,10",
    nil,
    common[47],
    3,
    common[48],
    "str_skill_upgrade_refine_desc_16000511",
    nil,
    nil,
    {
      [330005] = {3300051},
      [336005] = {3360051}
    }
  },
  {
    80,
    1600051,
    2,
    {
      {3501001, 3},
      {3204041, 16},
      {3204043, 8},
      {3210703, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    117,
    25,
    361,
    nil,
    nil,
    common[47],
    3,
    common[48],
    "str_skill_upgrade_refine_desc_16000512",
    nil,
    nil,
    common[156]
  },
  {
    81,
    1600051,
    3,
    {
      {3501001, 3},
      {3204043, 16},
      {3204042, 8},
      {3204041, 8},
      {3210703, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    177,
    38,
    547,
    nil,
    nil,
    "str_skill_passive_name_410005",
    4,
    "icon_1600051_zhuangbei",
    "str_skill_upgrade_refine_desc_16000513",
    nil,
    nil,
    common[156],
    nil,
    {
      [1] = {
        [430005] = "str_skill_passive_desc_443005"
      }
    },
    {
      [1] = {
        BuffID = 4300051,
        [1] = {
          value = 8,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "maxSoulCount"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    82,
    1602091,
    1,
    common[99],
    59,
    15,
    222,
    "312,1602091,3,80&318,1602091,10",
    nil,
    "str_skill_passive_name_430209",
    4,
    "icon_1602091_zhuangbei",
    "str_skill_upgrade_refine_desc_16020911",
    nil,
    nil,
    nil,
    nil,
    common[157],
    common[158]
  },
  {
    83,
    1602091,
    2,
    common[106],
    119,
    31,
    444,
    nil,
    nil,
    common[49],
    3,
    common[50],
    "str_skill_upgrade_refine_desc_16020912",
    nil,
    nil,
    {
      [3002091] = {3002093},
      [3062091] = {3062093}
    },
    nil,
    common[157],
    common[158]
  },
  {
    84,
    1602091,
    3,
    {
      {3501001, 6},
      {3204041, 20},
      {3204043, 10},
      {3204042, 10},
      {3210503, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    181,
    47,
    673,
    nil,
    nil,
    common[49],
    3,
    common[50],
    "str_skill_upgrade_refine_desc_16020913",
    nil,
    nil,
    {
      [3002091] = {3002093, 3002092},
      [3062091] = {3062093, 3062092}
    },
    nil,
    common[157],
    common[158]
  },
  {
    85,
    1502101,
    1,
    {
      {3501001, 3},
      {3204033, 16},
      {3210103, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    54,
    12,
    169,
    "312,1502101,3,80&318,1502101,10",
    nil,
    "str_skill_passive_name_410210",
    4,
    "icon_1502101_zhuangbei",
    "str_skill_upgrade_refine_desc_15021011",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [410210] = "str_skill_passive_desc_440210",
        [415210] = "str_skill_passive_desc_445210"
      }
    },
    common[159]
  },
  {
    86,
    1502101,
    2,
    {
      {3501001, 3},
      {3204032, 16},
      {3204031, 8},
      {3210103, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    108,
    24,
    339,
    nil,
    nil,
    common[51],
    3,
    common[52],
    "str_skill_upgrade_refine_desc_15021012",
    {4402102},
    nil,
    nil,
    nil,
    {
      [1] = {
        [410210] = "str_skill_passive_desc_440210",
        [415210] = "str_skill_passive_desc_445210"
      },
      [2] = {
        [3302101] = "str_skill_desc_34021011",
        [3322101] = "str_skill_desc_34221011",
        [3352101] = "str_skill_desc_34521011"
      }
    },
    common[159]
  },
  {
    87,
    1502101,
    3,
    {
      {3501001, 3},
      {3204031, 16},
      {3204033, 8},
      {3204032, 8},
      {3210103, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    164,
    37,
    514,
    nil,
    nil,
    common[51],
    3,
    common[52],
    "str_skill_upgrade_refine_desc_15021013",
    {4402102, 4402103},
    nil,
    nil,
    nil,
    {
      [1] = {
        [410210] = "str_skill_passive_desc_440210",
        [415210] = "str_skill_passive_desc_445210"
      },
      [2] = {
        [3302101] = "str_skill_desc_34021012",
        [3322101] = "str_skill_desc_34221012",
        [3352101] = "str_skill_desc_34521012"
      }
    },
    {
      [1] = {
        BuffID = 410210,
        [1] = {
          value = {0.36},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {0.36},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "percent"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.36,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    88,
    1602141,
    1,
    common[107],
    42,
    13,
    142,
    "312,1602141,3,80&318,1602141,10",
    nil,
    "str_skill_passive_name_410214",
    4,
    "icon_1602141_zhuangbei",
    "str_skill_upgrade_refine_desc_16021411",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430214] = "str_skill_passive_desc_440214"
      }
    },
    common[160]
  },
  {
    89,
    1602141,
    2,
    common[108],
    85,
    26,
    284,
    nil,
    nil,
    "str_skill_name_2002141",
    2,
    "icon_1602141_chain",
    "str_skill_upgrade_refine_desc_16021412",
    {4402141},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430214] = "str_skill_passive_desc_440214"
      },
      [2] = {
        [2302141] = "str_skill_desc_2402141",
        [2302142] = "str_skill_desc_2402142",
        [2302143] = "str_skill_desc_2402143"
      }
    },
    common[160]
  },
  {
    90,
    1602141,
    3,
    common[109],
    129,
    39,
    430,
    nil,
    nil,
    "str_skill_name_3002141",
    3,
    "icon_1602141_atkult",
    "str_skill_upgrade_refine_desc_16021413",
    {4402141, 4402143},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430214] = "str_skill_passive_desc_440214"
      },
      [2] = {
        [2302141] = "str_skill_desc_2402141",
        [2302142] = "str_skill_desc_2402142",
        [2302143] = "str_skill_desc_2402143"
      },
      [3] = {
        [3002141] = "str_skill_desc_3402141",
        [3062141] = "str_skill_desc_3462141"
      }
    },
    common[160]
  },
  {
    91,
    1502151,
    1,
    common[98],
    46,
    12,
    198,
    "312,1502151,3,80&318,1502151,10",
    nil,
    common[53],
    4,
    common[54],
    "str_skill_upgrade_refine_desc_15021511",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430215] = "str_skill_passive_desc_440215",
        [435215] = "str_skill_passive_desc_445215"
      }
    },
    common[161]
  },
  {
    92,
    1502151,
    2,
    common[110],
    92,
    24,
    396,
    nil,
    nil,
    common[53],
    4,
    common[54],
    "str_skill_upgrade_refine_desc_15021512",
    common[122],
    nil,
    nil,
    nil,
    {
      [1] = {
        [430215] = "str_skill_passive_desc_450215",
        [435215] = "str_skill_passive_desc_455215"
      }
    },
    common[161]
  },
  {
    93,
    1502151,
    3,
    common[111],
    139,
    37,
    601,
    nil,
    nil,
    common[53],
    4,
    common[54],
    "str_skill_upgrade_refine_desc_15021513",
    common[122],
    nil,
    nil,
    nil,
    {
      [1] = {
        [430215] = "str_skill_passive_desc_460215",
        [435215] = "str_skill_passive_desc_465215"
      }
    },
    {
      [1] = {
        BuffID = 4102151,
        [1] = {
          value = 1102154,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4202150,
        [1] = {
          value = 1202155,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.65,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4202155,
        [1] = {
          value = 6,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 3,
            TriggerParamIndex = 3
          },
          type = 2
        }
      },
      [4] = {
        BuffID = 4252155,
        [1] = {
          value = 6,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 3,
            TriggerParamIndex = 3
          },
          type = 2
        }
      },
      [5] = {
        BuffID = 4302155,
        [1] = {
          value = 6,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 3,
            TriggerParamIndex = 3
          },
          type = 2
        }
      },
      [6] = {
        BuffID = 4352155,
        [1] = {
          value = 6,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 3,
            TriggerParamIndex = 3
          },
          type = 2
        }
      }
    }
  },
  {
    94,
    1602181,
    1,
    common[107],
    62,
    14,
    176,
    "312,1602181,3,80&318,1602181,10",
    nil,
    common[55],
    3,
    common[56],
    "str_skill_upgrade_refine_desc_16021811",
    nil,
    nil,
    {
      [3002181] = {3402181},
      [30021811] = {3412181},
      [3402182] = {3402181},
      [3412182] = {3412181}
    },
    nil,
    common[162]
  },
  {
    95,
    1602181,
    2,
    common[108],
    124,
    28,
    352,
    nil,
    nil,
    "str_skill_passive_name_410218",
    3,
    common[56],
    "str_skill_upgrade_refine_desc_16021812",
    common[123],
    nil,
    common[163],
    nil,
    common[162]
  },
  {
    96,
    1602181,
    3,
    common[109],
    185,
    42,
    562,
    nil,
    nil,
    common[55],
    4,
    "icon_1602181_zhuangbei",
    "str_skill_upgrade_refine_desc_16021813",
    common[123],
    nil,
    common[163],
    nil,
    common[162],
    nil,
    {
      forceParam = {
        [12] = {
          UnlockParam2 = {
            11,
            14,
            17
          }
        }
      }
    }
  },
  {
    97,
    1602191,
    1,
    common[112],
    51,
    16,
    179,
    "312,1602191,3,80&318,1602191,10",
    nil,
    "str_skill_passive_name_410219",
    4,
    "icon_1602191_zhuangbei",
    "str_skill_upgrade_refine_desc_16021911",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420219] = "str_skill_passive_desc_450219",
        [423219] = "str_skill_passive_desc_453219"
      }
    },
    {
      [1] = {
        BuffID = 4202191,
        [1] = {
          value = 1,
          key = {},
          type = 2
        },
        [2] = {
          value = 4202195,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4232191,
        [1] = {
          value = 1,
          key = {},
          type = 2
        },
        [2] = {
          value = 4232195,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    98,
    1602191,
    2,
    common[113],
    102,
    32,
    359,
    nil,
    nil,
    common[57],
    3,
    common[58],
    "str_skill_upgrade_refine_desc_16021912",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420219] = "str_skill_passive_desc_450219",
        [423219] = "str_skill_passive_desc_453219",
        [3302191] = "str_skill_desc_3602191",
        [3332191] = "str_skill_desc_3632191"
      }
    },
    common[164]
  },
  {
    99,
    1602191,
    3,
    {
      {3501001, 6},
      {3204031, 20},
      {3204033, 10},
      {3203032, 10},
      {3210203, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    155,
    49,
    544,
    nil,
    nil,
    common[57],
    3,
    common[58],
    "str_skill_upgrade_refine_desc_16021913",
    {4002194},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420219] = "str_skill_passive_desc_450219",
        [423219] = "str_skill_passive_desc_453219",
        [3302191] = "str_skill_desc_3702191",
        [3332191] = "str_skill_desc_3732191"
      }
    },
    common[164]
  },
  {
    100,
    1602211,
    1,
    common[103],
    36,
    13,
    151,
    "312,1602211,3,80&318,1602211,10",
    nil,
    common[59],
    4,
    common[60],
    "str_skill_upgrade_refine_desc_16022111",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430221] = "str_skill_passive_desc_440221"
      }
    },
    common[165]
  },
  {
    101,
    1602211,
    2,
    common[104],
    73,
    27,
    302,
    nil,
    nil,
    "str_skill_name_300221",
    3,
    "icon_1602211_atkult",
    "str_skill_upgrade_refine_desc_16022112",
    {4422211},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430221] = "str_skill_passive_desc_440221",
        [320221] = "str_skill_desc_340221",
        [326221] = "str_skill_desc_346221"
      }
    },
    common[165]
  },
  {
    102,
    1602211,
    3,
    common[105],
    111,
    41,
    458,
    nil,
    nil,
    common[59],
    4,
    common[60],
    "str_skill_upgrade_refine_desc_16022113",
    {4422211, 4432211},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430221] = "str_skill_passive_desc_443221",
        [320221] = "str_skill_desc_340221",
        [326221] = "str_skill_desc_346221"
      }
    },
    common[165]
  },
  {
    103,
    1602251,
    1,
    {
      {3501001, 6},
      {3204043, 20},
      {3210303, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    60,
    14,
    211,
    "312,1602251,3,80&318,1602251,10",
    nil,
    common[61],
    4,
    common[62],
    "str_skill_upgrade_refine_desc_16022511",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430225] = "str_skill_passive_desc_440225",
        [436225] = "str_skill_passive_desc_446225"
      }
    },
    common[166]
  },
  {
    104,
    1602251,
    2,
    {
      {3501001, 6},
      {3204042, 20},
      {3204041, 10},
      {3210303, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    120,
    29,
    423,
    nil,
    nil,
    "str_skill_name_300225",
    3,
    "icon_1602251_atkult",
    "str_skill_upgrade_refine_desc_16022512",
    {442225},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430225] = "str_skill_passive_desc_440225",
        [436225] = "str_skill_passive_desc_446225",
        [320225] = "str_skill_desc_340225",
        [323225] = "str_skill_desc_343225"
      }
    },
    common[166]
  },
  {
    105,
    1602251,
    3,
    {
      {3501001, 6},
      {3204041, 20},
      {3204043, 10},
      {3204042, 10},
      {3210303, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    183,
    44,
    641,
    nil,
    nil,
    common[61],
    4,
    common[62],
    "str_skill_upgrade_refine_desc_16022513",
    {442225, 4432251},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430225] = "str_skill_passive_desc_4402253",
        [436225] = "str_skill_passive_desc_4462253",
        [320225] = "str_skill_desc_340225",
        [323225] = "str_skill_desc_343225"
      }
    },
    common[166]
  },
  {
    106,
    1601531,
    1,
    common[99],
    53,
    10,
    151,
    "312,1601531,3,80&318,1601531,10",
    nil,
    common[63],
    3,
    common[64],
    "str_skill_upgrade_refine_desc_16015311",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [330153] = "str_skill_desc_340153",
        [336153] = "str_skill_desc_340153",
        [430153] = "str_skill_passive_desc_450153",
        [433153] = "str_skill_passive_desc_453153",
        [436153] = "str_skill_passive_desc_456153"
      }
    },
    {
      [1] = {
        BuffID = 4101532,
        [1] = {
          value = 0.03,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4201532,
        [1] = {
          value = 0.03,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [3] = {
        BuffID = 4201535,
        [1] = {
          value = 0.03,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [4] = {
        BuffID = 4301533,
        [1] = {
          value = 0.015,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [5] = {
        BuffID = 4301535,
        [1] = {
          value = 0.015,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [6] = {
        BuffID = 4301537,
        [1] = {
          value = 0.015,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [7] = {
        BuffID = 4201531,
        [1] = {
          value = 6,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "layer"
          },
          type = 2,
          isShow = false
        }
      },
      [8] = {
        BuffID = 4301534,
        [1] = {
          value = 6,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "layer"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    107,
    1601531,
    2,
    common[106],
    106,
    21,
    302,
    nil,
    nil,
    "str_skill_name_2001531",
    2,
    "icon_1601531_chain",
    "str_skill_upgrade_refine_desc_16015312",
    {4501531},
    nil,
    nil,
    nil,
    {
      [1] = {
        [330153] = "str_skill_desc_340153",
        [336153] = "str_skill_desc_340153",
        [430153] = "str_skill_passive_desc_450153",
        [433153] = "str_skill_passive_desc_453153",
        [436153] = "str_skill_passive_desc_456153",
        [2001531] = "str_skill_desc_2501531",
        [2001532] = "str_skill_desc_2501532",
        [2001533] = "str_skill_desc_2501533"
      }
    },
    common[167]
  },
  {
    108,
    1601531,
    3,
    {
      {3501001, 6},
      {3204041, 20},
      {3204042, 10},
      {3204043, 10},
      {3210503, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    161,
    32,
    457,
    nil,
    nil,
    common[63],
    3,
    common[64],
    "str_skill_upgrade_refine_desc_16015313",
    {4501531, 4601531},
    nil,
    nil,
    nil,
    {
      [1] = {
        [330153] = "str_skill_desc_360153",
        [336153] = "str_skill_desc_360153",
        [430153] = "str_skill_passive_desc_450153",
        [433153] = "str_skill_passive_desc_453153",
        [436153] = "str_skill_passive_desc_456153",
        [2001531] = "str_skill_desc_2501531",
        [2001532] = "str_skill_desc_2501532",
        [2001533] = "str_skill_desc_2501533"
      }
    },
    common[167]
  },
  {
    109,
    1601551,
    1,
    common[94],
    58,
    15,
    228,
    "312,1601551,3,80&318,1601551,10",
    nil,
    "str_skill_passive_name_436155",
    4,
    "icon_1601551_zhuangbei",
    "str_skill_upgrade_refine_desc_16015511",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430155] = "str_skill_passive_desc_440153",
        [436155] = "str_skill_passive_desc_440153"
      }
    },
    {
      [1] = {
        BuffID = 41001550,
        [1] = {
          value = -0.35,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 430015500,
        [1] = {
          value = 0.65,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 41001551,
        [1] = {
          value = {
            percent = {0.65}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    110,
    1601551,
    2,
    {
      {3501001, 6},
      {3204032, 20},
      {3204031, 10},
      {3210503, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    117,
    31,
    456,
    nil,
    nil,
    common[65],
    3,
    common[66],
    "str_skill_upgrade_refine_desc_16015512",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [430155] = "str_skill_passive_desc_440153",
        [436155] = "str_skill_passive_desc_440153",
        [320155] = "str_skill_desc_350155",
        [323155] = "str_skill_desc_353155",
        [326155] = "str_skill_desc_356155"
      }
    },
    common[168]
  },
  {
    111,
    1601551,
    3,
    {
      {3501001, 6},
      {3204031, 20},
      {3204032, 10},
      {3204033, 10},
      {3210503, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    178,
    47,
    692,
    nil,
    nil,
    common[65],
    3,
    common[66],
    "str_skill_upgrade_refine_desc_16015513",
    {41001552},
    nil,
    nil,
    nil,
    {
      [1] = {
        [430155] = "str_skill_passive_desc_440153",
        [436155] = "str_skill_passive_desc_440153",
        [320155] = "str_skill_desc_360155",
        [323155] = "str_skill_desc_363155",
        [326155] = "str_skill_desc_366155"
      }
    },
    common[168]
  },
  {
    112,
    1701071,
    1,
    {
      {3801001, 1},
      {3501001, 6},
      {3204013, 20},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    47,
    17,
    224,
    "312,1701071,3,80&313,1701071,6&318,1701071,10",
    nil,
    "str_skill_name_333107",
    3,
    "icon_1701071_atkult",
    "str_skill_upgrade_refine_desc_17010711",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [336107] = "str_skill_desc_346107"
      }
    },
    common[169]
  },
  {
    113,
    1701071,
    2,
    {
      {3801001, 1},
      {3501001, 6},
      {3204012, 20},
      {3204011, 10},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    94,
    34,
    449,
    nil,
    nil,
    common[67],
    4,
    common[68],
    "str_skill_upgrade_refine_desc_17010712",
    common[124],
    nil,
    nil,
    nil,
    {
      [1] = {
        [436107] = "str_skill_passive_desc_456107",
        [336107] = "str_skill_desc_346107"
      }
    },
    common[169]
  },
  {
    114,
    1701071,
    3,
    {
      {3801001, 1},
      {3501001, 6},
      {3204011, 20},
      {3204013, 10},
      {3204012, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    143,
    51,
    681,
    nil,
    nil,
    common[67],
    4,
    common[68],
    "str_skill_upgrade_refine_desc_17010713",
    common[124],
    nil,
    nil,
    nil,
    {
      [1] = {
        [436107] = "str_skill_passive_desc_466107",
        [336107] = "str_skill_desc_346107"
      }
    },
    {
      [1] = {
        BuffID = 400107,
        [1] = {
          value = 0.25,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4001073,
        [1] = {
          value = 0.25,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 410107,
        [1] = {
          value = 4601071,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 2
        },
        [2] = {
          value = 0.15,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "hpLimit"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    115,
    1701081,
    1,
    {
      {3801001, 1},
      {3501001, 6},
      {3204023, 20},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    57,
    13,
    180,
    "312,1701081,3,80&313,1701081,6&318,1701081,10",
    nil,
    common[69],
    3,
    common[70],
    "str_skill_upgrade_refine_desc_17010811",
    nil,
    common[125]
  },
  {
    116,
    1701081,
    2,
    {
      {3801001, 1},
      {3501001, 6},
      {3204022, 20},
      {3204021, 10},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    114,
    27,
    360,
    nil,
    nil,
    common[69],
    3,
    common[70],
    "str_skill_upgrade_refine_desc_17010812",
    {456108},
    common[125],
    nil,
    nil,
    {
      [1] = {
        [336108] = "str_skill_desc_356108",
        [33610801] = "str_skill_desc_35610801"
      }
    }
  },
  {
    117,
    1701081,
    3,
    {
      {3801001, 1},
      {3501001, 6},
      {3204021, 20},
      {3204023, 10},
      {3204022, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    173,
    41,
    545,
    nil,
    nil,
    common[69],
    3,
    common[70],
    "str_skill_upgrade_refine_desc_17010813",
    {
      456108,
      4601081,
      4601082
    },
    {36610801},
    nil,
    nil,
    {
      [1] = {
        [336108] = "str_skill_desc_366108",
        [33610801] = "str_skill_desc_36610801"
      }
    }
  },
  {
    118,
    1701091,
    1,
    {
      {3801001, 1},
      {3501001, 6},
      {3204033, 20},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    60,
    13,
    186,
    "312,1701091,3,80&313,1701091,6&318,1701091,10",
    nil,
    "str_skill_name_330109",
    3,
    "icon_1701091_atkult",
    "str_skill_upgrade_refine_desc_17010911",
    common[126],
    nil,
    nil,
    nil,
    {
      [1] = {
        [330109] = "str_skill_desc_340109"
      }
    }
  },
  {
    119,
    1701091,
    2,
    {
      {3801001, 1},
      {3501001, 6},
      {3204032, 20},
      {3204031, 10},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    121,
    27,
    372,
    nil,
    nil,
    "str_skill_passive_name_433109",
    4,
    "icon_1701091_zhuangbei",
    "str_skill_upgrade_refine_desc_17010912",
    common[126],
    nil,
    nil,
    nil,
    common[170],
    common[171]
  },
  {
    120,
    1701091,
    3,
    {
      {3801001, 1},
      {3501001, 6},
      {3204031, 20},
      {3204033, 10},
      {3204032, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    184,
    41,
    563,
    nil,
    nil,
    "str_skill_name_360109",
    3,
    "icon_1701091_atkult1",
    "str_skill_upgrade_refine_desc_17010913",
    {
      4401091,
      4601091,
      4601092
    },
    {360109},
    nil,
    nil,
    common[170],
    common[171]
  },
  {
    121,
    1701101,
    1,
    {
      {3801001, 1},
      {3501001, 6},
      {3204043, 20},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    64,
    15,
    186,
    "312,1701101,3,80&313,1701101,6&318,1701101,10",
    nil,
    common[71],
    4,
    common[72],
    "str_skill_upgrade_refine_desc_17011011",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [433110] = "str_skill_passive_desc_443110"
      }
    },
    common[172]
  },
  {
    122,
    1701101,
    2,
    {
      {3801001, 1},
      {3501001, 6},
      {3204042, 20},
      {3204041, 10},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    129,
    31,
    373,
    nil,
    nil,
    common[71],
    4,
    common[72],
    "str_skill_upgrade_refine_desc_17011012",
    {4501101, 4501102},
    nil,
    nil,
    nil,
    {
      [1] = {
        [433110] = "str_skill_passive_desc_453110"
      }
    },
    common[172]
  },
  {
    123,
    1701101,
    3,
    {
      {3801001, 1},
      {3501001, 6},
      {3204041, 20},
      {3204043, 10},
      {3204042, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    196,
    47,
    565,
    nil,
    nil,
    "str_skill_name_336110",
    3,
    "icon_1701101_atkult",
    "str_skill_upgrade_refine_desc_17011013",
    {
      4601100,
      4601101,
      4601103,
      4601104
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [433110] = "str_skill_passive_desc_453110",
        [336110] = "str_skill_desc_366110"
      }
    },
    {
      [1] = {
        BuffID = 4101104,
        [1] = {
          value = 0.35,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4101104,
        [1] = {
          value = 4601102,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "buffID"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    124,
    1602301,
    1,
    {
      {3501001, 6},
      {3204023, 20},
      {3210603, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    71,
    8,
    283,
    "312,1602301,3,80&318,1602301,10",
    nil,
    "str_skill_passive_name_4102301",
    4,
    "icon_1602301_zhuangbei",
    "str_skill_upgrade_refine_desc_16023011",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4302301] = "str_skill_passive_desc_4402301",
        [4332301] = "str_skill_passive_desc_4432301",
        [4342301] = "str_skill_passive_desc_4442301",
        [4362301] = "str_skill_passive_desc_4462301"
      }
    },
    common[173]
  },
  {
    125,
    1602301,
    2,
    {
      {3501001, 6},
      {3204022, 20},
      {3204021, 10},
      {3210603, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    143,
    17,
    566,
    nil,
    nil,
    "str_skill_name_2002301",
    2,
    "icon_1602301_chain",
    "str_skill_upgrade_refine_desc_16023012",
    {4502301},
    nil,
    nil,
    nil,
    {
      [1] = {
        [4302301] = "str_skill_passive_desc_4402301",
        [4332301] = "str_skill_passive_desc_4432301",
        [4342301] = "str_skill_passive_desc_4442301",
        [4362301] = "str_skill_passive_desc_4462301",
        [2002301] = "str_skill_desc_2502301",
        [2002302] = "str_skill_desc_2502302",
        [2002303] = "str_skill_desc_2502303"
      }
    },
    common[173]
  },
  {
    126,
    1602301,
    3,
    {
      {3501001, 6},
      {3204021, 20},
      {3204023, 10},
      {3204022, 10},
      {3210603, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    217,
    27,
    859,
    nil,
    nil,
    "str_skill_name_3002302",
    3,
    "icon_1602301_atkult1",
    "str_skill_upgrade_refine_desc_16023013",
    {4602301, 4502301},
    nil,
    nil,
    nil,
    {
      [1] = {
        [4302301] = "str_skill_passive_desc_4402301",
        [4332301] = "str_skill_passive_desc_4432301",
        [4342301] = "str_skill_passive_desc_4442301",
        [4362301] = "str_skill_passive_desc_4462301",
        [2002301] = "str_skill_desc_2502301",
        [2002302] = "str_skill_desc_2502302",
        [2002303] = "str_skill_desc_2502303",
        [3002302] = "str_skill_desc_3602302"
      }
    },
    common[173]
  },
  {
    127,
    1502321,
    1,
    {
      {3501001, 3},
      {3204023, 16},
      {3210603, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    37,
    13,
    162,
    "312,1502321,3,80&318,1502321,10",
    nil,
    common[73],
    4,
    common[74],
    "str_skill_upgrade_refine_desc_15023211",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [40023211] = "str_skill_passive_desc_4402321",
        [40523211] = "str_skill_passive_desc_4452321"
      }
    },
    {
      [1] = {
        BuffID = 4002322,
        [1] = {
          value = 4002325,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4052322,
        [1] = {
          value = 4052325,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    128,
    1502321,
    2,
    {
      {3501001, 3},
      {3204022, 16},
      {3204021, 8},
      {3210603, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    74,
    27,
    325,
    nil,
    nil,
    common[73],
    4,
    common[74],
    "str_skill_upgrade_refine_desc_15023212",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [40023211] = "str_skill_passive_desc_4502321",
        [40523211] = "str_skill_passive_desc_4552321"
      }
    },
    {
      [1] = {
        BuffID = 4002322,
        [1] = {
          value = 4002326,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4052322,
        [1] = {
          value = 4052326,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    129,
    1502321,
    3,
    {
      {3501001, 3},
      {3204021, 16},
      {3204023, 8},
      {3204022, 8},
      {3210603, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    112,
    41,
    493,
    nil,
    nil,
    common[73],
    4,
    common[74],
    "str_skill_upgrade_refine_desc_15023213",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [40023211] = "str_skill_passive_desc_4602321",
        [40523211] = "str_skill_passive_desc_4652321"
      }
    },
    {
      [1] = {
        BuffID = 4002322,
        [1] = {
          value = 4002326,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4052322,
        [1] = {
          value = 4052326,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4402321,
        [1] = {
          value = 0.3,
          key = {
            TriggerType = "Active",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 2
        }
      },
      [4] = {
        BuffID = 4452321,
        [1] = {
          value = 0.3,
          key = {
            TriggerType = "Active",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 2
        }
      }
    }
  },
  {
    130,
    1602331,
    1,
    {
      {3501001, 6},
      {3204023, 20},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    61,
    13,
    264,
    "312,1602331,3,80&318,1602331,10",
    nil,
    common[75],
    4,
    common[76],
    "str_skill_upgrade_refine_desc_16023311",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4202331] = "str_skill_passive_desc_4402331"
      }
    },
    {
      [1] = {
        BuffID = 4102331,
        [1] = {
          value = 20,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "count"
          },
          type = 1
        }
      }
    }
  },
  {
    131,
    1602331,
    2,
    {
      {3501001, 6},
      {3204022, 20},
      {3204021, 10},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    122,
    26,
    529,
    nil,
    nil,
    common[75],
    4,
    common[76],
    "str_skill_upgrade_refine_desc_16023312",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4202331] = "str_skill_passive_desc_4502331"
      }
    },
    common[174]
  },
  {
    132,
    1602331,
    3,
    {
      {3501001, 6},
      {3204021, 20},
      {3204023, 10},
      {3204022, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    186,
    40,
    802,
    nil,
    nil,
    common[75],
    4,
    common[76],
    "str_skill_upgrade_refine_desc_16023313",
    common[127],
    nil,
    nil,
    nil,
    {
      [1] = {
        [4202331] = "str_skill_passive_desc_4602331"
      }
    },
    common[174]
  },
  {
    133,
    1602341,
    1,
    {
      {3501001, 6},
      {3204033, 20},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    70,
    13,
    193,
    "312,1602341,3,80&318,1602341,10",
    nil,
    "str_skill_passive_name_410234",
    4,
    "icon_1602341_zhuangbei",
    "str_skill_upgrade_refine_desc_16023411",
    nil,
    nil,
    nil,
    nil,
    common[175],
    common[176]
  },
  {
    134,
    1602341,
    2,
    {
      {3501001, 6},
      {3204032, 20},
      {3204031, 10},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    140,
    27,
    386,
    nil,
    nil,
    "str_skill_name_3002341",
    3,
    "icon_1602341_atkult",
    "str_skill_upgrade_refine_desc_16023412",
    {4502341},
    nil,
    nil,
    nil,
    common[175],
    common[176]
  },
  {
    135,
    1602341,
    3,
    {
      {3501001, 6},
      {3204031, 20},
      {3204033, 10},
      {3204032, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    212,
    42,
    585,
    nil,
    nil,
    "str_skill_name_2302341",
    2,
    "icon_1602341_chain",
    "str_skill_upgrade_refine_desc_16023413",
    {
      4502341,
      4602341,
      4602342
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102341] = "str_skill_passive_desc_440234",
        [2302341] = "str_skill_desc_2602341",
        [2302342] = "str_skill_desc_2602342",
        [2302343] = "str_skill_desc_2602343"
      }
    },
    common[176]
  },
  {
    136,
    1502351,
    1,
    {
      {3501001, 3},
      {3204023, 16},
      {3210703, 32},
      {3500001, 1600},
      {3000002, 160000}
    },
    43,
    11,
    189,
    "312,1502351,3,80&318,1502351,10",
    nil,
    common[77],
    4,
    common[78],
    "str_skill_upgrade_refine_desc_15023511",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102351] = "str_skill_passive_desc_440235"
      }
    },
    {
      [1] = {
        BuffID = 4102351,
        [1] = {
          value = 20,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "count"
          },
          type = 1
        }
      }
    }
  },
  {
    137,
    1502351,
    2,
    {
      {3501001, 3},
      {3204022, 16},
      {3204021, 8},
      {3210703, 40},
      {3500001, 2400},
      {3000002, 240000}
    },
    87,
    23,
    378,
    nil,
    nil,
    "str_skill_name_2002351",
    2,
    "icon_1502351_chain",
    "str_skill_upgrade_refine_desc_15023512",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102351] = "str_skill_passive_desc_440235",
        [2202351] = "str_skill_desc_2502351",
        [2202352] = "str_skill_desc_2502352",
        [2202353] = "str_skill_desc_2502353"
      }
    },
    common[177]
  },
  {
    138,
    1502351,
    3,
    {
      {3501001, 3},
      {3204021, 16},
      {3204023, 8},
      {3204022, 8},
      {3210703, 48},
      {3500001, 4000},
      {3000002, 400000}
    },
    131,
    36,
    573,
    nil,
    nil,
    common[77],
    4,
    common[78],
    "str_skill_upgrade_refine_desc_15023513",
    common[127],
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102351] = "str_skill_passive_desc_460235",
        [2202351] = "str_skill_desc_2502351",
        [2202352] = "str_skill_desc_2502352",
        [2202353] = "str_skill_desc_2502353"
      }
    },
    common[177]
  },
  {
    139,
    1601731,
    1,
    common[112],
    71,
    13,
    193,
    "312,1601731,3,80&318,1601731,10",
    nil,
    common[79],
    4,
    common[80],
    "str_skill_upgrade_refine_desc_16017311",
    {3401731},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420173] = "str_skill_passive_desc_440173",
        [423173] = "str_skill_passive_desc_443173"
      }
    },
    common[178]
  },
  {
    140,
    1601731,
    2,
    common[113],
    142,
    26,
    387,
    nil,
    nil,
    common[79],
    4,
    common[80],
    "str_skill_upgrade_refine_desc_16017312",
    {3401731, 3501731},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420173] = "str_skill_passive_desc_450173",
        [423173] = "str_skill_passive_desc_453173"
      }
    },
    common[178]
  },
  {
    141,
    1601731,
    3,
    {
      {3501001, 6},
      {3204031, 20},
      {3204033, 10},
      {3204032, 10},
      {3210203, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    215,
    40,
    586,
    nil,
    nil,
    common[79],
    4,
    common[80],
    "str_skill_upgrade_refine_desc_16017313",
    {
      3401731,
      3501731,
      3601731
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [420173] = "str_skill_passive_desc_460173",
        [423173] = "str_skill_passive_desc_463173"
      }
    },
    common[178]
  },
  {
    142,
    1401691,
    1,
    common[98],
    43,
    12,
    182,
    "312,1401691,3,80&318,1401691,10",
    nil,
    common[81],
    4,
    common[82],
    "str_skill_upgrade_refine_desc_14016911",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [420169] = "str_skill_passive_desc_440169"
      }
    },
    common[179]
  },
  {
    143,
    1401691,
    2,
    common[110],
    87,
    24,
    365,
    nil,
    nil,
    common[81],
    4,
    common[82],
    "str_skill_upgrade_refine_desc_14016912",
    {4501698},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420169] = "str_skill_passive_desc_440169"
      }
    },
    common[179]
  },
  {
    144,
    1401691,
    3,
    common[111],
    132,
    36,
    554,
    nil,
    nil,
    "str_skill_name_300169",
    3,
    "icon_1401691_atkult",
    "str_skill_upgrade_refine_desc_14016913",
    {4501698, 4601691},
    nil,
    nil,
    nil,
    {
      [1] = {
        [420169] = "str_skill_passive_desc_450169",
        [330169] = "str_skill_desc_360169",
        [335169] = "str_skill_desc_365169"
      }
    },
    common[179]
  },
  {
    145,
    1602371,
    1,
    {
      {3501001, 6},
      {3204013, 20},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    60,
    15,
    226,
    "312,1602371,3,80&318,1602371,10",
    nil,
    common[83],
    4,
    common[84],
    "str_skill_upgrade_refine_desc_16023711",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102371] = "str_skill_passive_desc_4402371",
        [4162371] = "str_skill_passive_desc_4462371"
      }
    },
    {
      [1] = {
        BuffID = 4102372,
        [1] = {
          value = {trapID = 8402375},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {findPosTrapId = 8402375},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {trapID = 8402375},
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = {trapID = 8402375},
          key = {
            LogicType = "Load",
            LogicIndex = 4,
            param = "set"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4162372,
        [1] = {
          value = {trapID = 8462375},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {findPosTrapId = 8462375},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {trapID = 8462375},
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = {trapID = 8462375},
          key = {
            LogicType = "Load",
            LogicIndex = 4,
            param = "set"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    146,
    1602371,
    2,
    {
      {3501001, 6},
      {3204012, 20},
      {3204011, 10},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    121,
    31,
    453,
    nil,
    nil,
    common[83],
    4,
    common[84],
    "str_skill_upgrade_refine_desc_16023712",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102371] = "str_skill_passive_desc_4502371",
        [4162371] = "str_skill_passive_desc_4562371"
      }
    },
    common[180]
  },
  {
    147,
    1602371,
    3,
    {
      {3501001, 6},
      {3204011, 20},
      {3204013, 10},
      {3204012, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    184,
    48,
    687,
    nil,
    nil,
    common[83],
    4,
    common[84],
    "str_skill_upgrade_refine_desc_16023713",
    {
      4602370,
      4602371,
      4602372,
      4602373,
      4602374
    },
    nil,
    nil,
    nil,
    {
      [1] = {
        [4102371] = "str_skill_passive_desc_4602371",
        [4162371] = "str_skill_passive_desc_4662371"
      }
    },
    common[180]
  },
  {
    148,
    1702361,
    1,
    {
      {3801001, 1},
      {3501001, 6},
      {3204013, 5},
      {3204023, 5},
      {3204033, 5},
      {3204043, 5},
      {3210703, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    70,
    13,
    244,
    "312,1702361,3,80&313,1702361,6&318,1702361,10",
    nil,
    common[85],
    4,
    common[86],
    "str_skill_upgrade_refine_desc_17023611",
    nil,
    nil,
    nil,
    nil,
    common[181],
    common[182]
  },
  {
    149,
    1702361,
    2,
    {
      {3801001, 1},
      {3501001, 6},
      {3204012, 7},
      {3204022, 7},
      {3204032, 7},
      {3204042, 7},
      {3210703, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    141,
    26,
    489,
    nil,
    nil,
    "str_skill_name_2002361",
    2,
    "icon_1702361_chain",
    "str_skill_upgrade_refine_desc_17023612",
    nil,
    nil,
    nil,
    common[128],
    common[181],
    common[182]
  },
  {
    150,
    1702361,
    3,
    {
      {3801001, 1},
      {3501001, 6},
      {3204011, 10},
      {3204021, 10},
      {3204031, 10},
      {3204041, 10},
      {3210703, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    214,
    39,
    741,
    nil,
    nil,
    common[85],
    4,
    common[86],
    "str_skill_upgrade_refine_desc_17023613",
    nil,
    nil,
    nil,
    common[128],
    {
      [1] = {
        [4102361] = "str_skill_passive_desc_4602361"
      }
    },
    {
      [1] = {
        BuffID = 4102365,
        [1] = {
          value = 0.011,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4102363,
        [1] = {
          value = 2,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "layer"
          },
          type = 2
        }
      }
    }
  },
  {
    151,
    1501761,
    1,
    common[95],
    54,
    11,
    168,
    "312,1501761,3,80&318,1501761,10",
    nil,
    "str_skill_passive_name_4101761",
    4,
    "icon_1501761_zhuangbei",
    "str_skill_upgrade_refine_desc_15017611",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4301761] = "str_skill_passive_desc_4401761",
        [4351761] = "str_skill_passive_desc_4451761"
      }
    },
    {
      [1] = {
        BuffID = 410176102,
        [1] = {
          value = 410176107,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    152,
    1501761,
    2,
    common[96],
    108,
    22,
    337,
    nil,
    nil,
    common[87],
    3,
    common[88],
    "str_skill_upgrade_refine_desc_15017612",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4301761] = "str_skill_passive_desc_4401761",
        [4351761] = "str_skill_passive_desc_4451761"
      },
      [2] = {
        [3301761] = "str_skill_desc_3501761",
        [3321761] = "str_skill_desc_3521761",
        [3351761] = "str_skill_desc_3551761"
      }
    },
    {
      [1] = {
        BuffID = 410176102,
        [1] = {
          value = 410176107,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4001761,
        [1] = {
          value = 1,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    153,
    1501761,
    3,
    common[97],
    163,
    34,
    511,
    nil,
    nil,
    common[87],
    3,
    common[88],
    "str_skill_upgrade_refine_desc_15017613",
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        [4301761] = "str_skill_passive_desc_4401761",
        [4351761] = "str_skill_passive_desc_4451761"
      },
      [2] = {
        [3301761] = "str_skill_desc_3601761",
        [3321761] = "str_skill_desc_3621761",
        [3351761] = "str_skill_desc_3651761"
      }
    },
    {
      [1] = {
        BuffID = 410176102,
        [1] = {
          value = 410176107,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4001761,
        [1] = {
          value = 1,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 420176101,
        [1] = {
          value = {
            0,
            0.15,
            9999999
          },
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "vampire"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    154,
    1601821,
    1,
    {
      {3501001, 6},
      {3204013, 20},
      {3210803, 40},
      {3500001, 2000},
      {3000002, 200000}
    },
    60,
    15,
    212,
    "312,1601821,3,80&318,1601821,10",
    nil,
    common[89],
    3,
    common[90],
    "str_skill_upgrade_refine_desc_16018211",
    {4401820},
    nil,
    nil,
    nil,
    common[183]
  },
  {
    155,
    1601821,
    2,
    {
      {3501001, 6},
      {3204012, 20},
      {3204011, 10},
      {3210803, 50},
      {3500001, 3000},
      {3000002, 300000}
    },
    120,
    31,
    425,
    nil,
    nil,
    common[89],
    3,
    common[90],
    "str_skill_upgrade_refine_desc_16018212",
    common[129],
    nil,
    {
      [3201821] = {3501821}
    },
    nil,
    common[183]
  },
  {
    156,
    1601821,
    3,
    {
      {3501001, 6},
      {3204011, 20},
      {3204013, 10},
      {3204012, 10},
      {3210803, 60},
      {3500001, 5000},
      {3000002, 500000}
    },
    182,
    47,
    644,
    nil,
    nil,
    common[89],
    3,
    common[90],
    "str_skill_upgrade_refine_desc_16018213",
    common[129],
    nil,
    {
      [3201821] = {3501821, 3601821}
    },
    nil,
    common[183]
  }
}
return config, "ID", key
