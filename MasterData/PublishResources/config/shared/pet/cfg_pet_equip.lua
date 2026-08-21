local key = {
  ID = 1,
  PetID = 2,
  Level = 3,
  NeedItem = 4,
  Attack = 5,
  Defence = 6,
  Health = 7,
  Hit = 8,
  Doge = 9,
  Crit = 10,
  CritHurt = 11,
  IsParamImprove = 12,
  PropertyRestraint = 13,
  elementParam = 14
}
local common = {
  {
    {3500001, 100}
  },
  {
    {3210301, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210301, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210302, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210302, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210303, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210303, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210303, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210303, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    {3210501, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210501, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210502, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210502, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210503, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210503, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210503, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210503, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    {3210701, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210701, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210702, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210702, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210703, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210703, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210703, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210703, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    {3210701, 4},
    {3500001, 300},
    {3000002, 10000}
  },
  {
    {3210701, 8},
    {3500001, 600},
    {3000002, 20000}
  },
  {
    {3210702, 4},
    {3500001, 400},
    {3000002, 20000}
  },
  {
    {3210702, 4},
    {3500001, 400},
    {3000002, 30000}
  },
  {
    {3210702, 8},
    {3500001, 800},
    {3000002, 50000}
  },
  {
    {3210703, 4},
    {3500001, 500},
    {3000002, 50000}
  },
  {
    {3210703, 4},
    {3500001, 500},
    {3000002, 60000}
  },
  {
    {3210703, 4},
    {3500001, 500},
    {3000002, 80000}
  },
  {
    {3210703, 8},
    {3500001, 1200},
    {3000002, 150000}
  },
  {
    {3210101, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210101, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210102, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210102, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210103, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210103, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210103, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210103, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    {3210401, 4},
    {3500001, 300},
    {3000002, 10000}
  },
  {
    {3210401, 8},
    {3500001, 600},
    {3000002, 20000}
  },
  {
    {3210402, 4},
    {3500001, 400},
    {3000002, 20000}
  },
  {
    {3210402, 4},
    {3500001, 400},
    {3000002, 30000}
  },
  {
    {3210402, 8},
    {3500001, 800},
    {3000002, 50000}
  },
  {
    {3210403, 4},
    {3500001, 500},
    {3000002, 50000}
  },
  {
    {3210403, 4},
    {3500001, 500},
    {3000002, 60000}
  },
  {
    {3210403, 4},
    {3500001, 500},
    {3000002, 80000}
  },
  {
    {3210403, 8},
    {3500001, 1200},
    {3000002, 150000}
  },
  {
    {3210601, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210601, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210602, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210602, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210603, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210603, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210603, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210603, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    {3210401, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210401, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210402, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210402, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210403, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210403, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210403, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210403, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    {3210501, 4},
    {3500001, 300},
    {3000002, 10000}
  },
  {
    {3210501, 8},
    {3500001, 600},
    {3000002, 20000}
  },
  {
    {3210502, 4},
    {3500001, 400},
    {3000002, 20000}
  },
  {
    {3210502, 4},
    {3500001, 400},
    {3000002, 30000}
  },
  {
    {3210502, 8},
    {3500001, 800},
    {3000002, 50000}
  },
  {
    {3210503, 4},
    {3500001, 500},
    {3000002, 50000}
  },
  {
    {3210503, 4},
    {3500001, 500},
    {3000002, 60000}
  },
  {
    {3210503, 4},
    {3500001, 500},
    {3000002, 80000}
  },
  {
    {3210503, 8},
    {3500001, 1200},
    {3000002, 150000}
  },
  {
    {3210201, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210201, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210202, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210202, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210203, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210203, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210203, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210203, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    {3210101, 4},
    {3500001, 300},
    {3000002, 10000}
  },
  {
    {3210101, 8},
    {3500001, 600},
    {3000002, 20000}
  },
  {
    {3210102, 4},
    {3500001, 400},
    {3000002, 20000}
  },
  {
    {3210102, 4},
    {3500001, 400},
    {3000002, 30000}
  },
  {
    {3210102, 8},
    {3500001, 800},
    {3000002, 50000}
  },
  {
    {3210103, 4},
    {3500001, 500},
    {3000002, 50000}
  },
  {
    {3210103, 4},
    {3500001, 500},
    {3000002, 60000}
  },
  {
    {3210103, 4},
    {3500001, 500},
    {3000002, 80000}
  },
  {
    {3210103, 8},
    {3500001, 1200},
    {3000002, 150000}
  },
  {
    {3210201, 4},
    {3500001, 300},
    {3000002, 10000}
  },
  {
    {3210201, 8},
    {3500001, 600},
    {3000002, 20000}
  },
  {
    {3210202, 4},
    {3500001, 400},
    {3000002, 20000}
  },
  {
    {3210202, 4},
    {3500001, 400},
    {3000002, 30000}
  },
  {
    {3210202, 8},
    {3500001, 800},
    {3000002, 50000}
  },
  {
    {3210203, 4},
    {3500001, 500},
    {3000002, 50000}
  },
  {
    {3210203, 4},
    {3500001, 500},
    {3000002, 60000}
  },
  {
    {3210203, 4},
    {3500001, 500},
    {3000002, 80000}
  },
  {
    {3210203, 8},
    {3500001, 1200},
    {3000002, 150000}
  },
  {
    {3210301, 4},
    {3500001, 300},
    {3000002, 10000}
  },
  {
    {3210301, 8},
    {3500001, 600},
    {3000002, 20000}
  },
  {
    {3210302, 4},
    {3500001, 400},
    {3000002, 20000}
  },
  {
    {3210302, 4},
    {3500001, 400},
    {3000002, 30000}
  },
  {
    {3210302, 8},
    {3500001, 800},
    {3000002, 50000}
  },
  {
    {3210303, 4},
    {3500001, 500},
    {3000002, 50000}
  },
  {
    {3210303, 4},
    {3500001, 500},
    {3000002, 60000}
  },
  {
    {3210303, 4},
    {3500001, 500},
    {3000002, 80000}
  },
  {
    {3210303, 8},
    {3500001, 1200},
    {3000002, 150000}
  },
  {
    {3210601, 4},
    {3500001, 300},
    {3000002, 10000}
  },
  {
    {3210601, 8},
    {3500001, 600},
    {3000002, 20000}
  },
  {
    {3210602, 4},
    {3500001, 400},
    {3000002, 20000}
  },
  {
    {3210602, 4},
    {3500001, 400},
    {3000002, 30000}
  },
  {
    {3210602, 8},
    {3500001, 800},
    {3000002, 50000}
  },
  {
    {3210603, 4},
    {3500001, 500},
    {3000002, 50000}
  },
  {
    {3210603, 4},
    {3500001, 500},
    {3000002, 60000}
  },
  {
    {3210603, 4},
    {3500001, 500},
    {3000002, 80000}
  },
  {
    {3210603, 8},
    {3500001, 1200},
    {3000002, 150000}
  },
  {
    {3210801, 5},
    {3500001, 400},
    {3000002, 10000}
  },
  {
    {3210801, 10},
    {3500001, 800},
    {3000002, 20000}
  },
  {
    {3210802, 5},
    {3500001, 500},
    {3000002, 30000}
  },
  {
    {3210802, 10},
    {3500001, 1000},
    {3000002, 50000}
  },
  {
    {3210803, 5},
    {3500001, 600},
    {3000002, 60000}
  },
  {
    {3210803, 5},
    {3500001, 600},
    {3000002, 80000}
  },
  {
    {3210803, 5},
    {3500001, 600},
    {3000002, 100000}
  },
  {
    {3210803, 10},
    {3500001, 1500},
    {3000002, 200000}
  },
  {
    [1] = {
      BuffID = 4100011,
      [1] = {
        value = 0.4,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410001,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100011,
      [1] = {
        value = 0.6,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410001,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100011,
      [1] = {
        value = 0.8,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410001,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410002,
      [1] = {
        value = 110002,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.1},
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 1.1,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.7,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100021,
      [1] = {
        value = 110002,
        key = {
          LogicType = "Exec",
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.1},
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410002,
      [1] = {
        value = 1100021,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.3},
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 1.3,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.7,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100021,
      [1] = {
        value = 1100021,
        key = {
          LogicType = "Exec",
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.3},
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410002,
      [1] = {
        value = 1100022,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.4},
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 1.4,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100021,
      [1] = {
        value = 1100022,
        key = {
          LogicType = "Exec",
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {1.4},
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410004,
      [1] = {
        value = 0.05,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410004,
      [1] = {
        value = 0.1,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410004,
      [1] = {
        value = 0.15,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100051,
      [1] = {
        value = {percent = 0.4},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [3] = {
        value = {percent = 0.4},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100051,
      [1] = {
        value = {percent = 0.6},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
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
        value = {percent = 0.6},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.6,
        key = {},
        type = 2
      },
      [5] = {
        value = {percent = 0.6},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [6] = {
        value = 0.6,
        key = {},
        type = 2
      },
      [7] = {
        value = {percent = 0.6},
        key = {
          LogicType = "Load",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [8] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100051,
      [1] = {
        value = {percent = 0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [3] = {
        value = {percent = 0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [5] = {
        value = {percent = 0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [6] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [7] = {
        value = {percent = 0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [8] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410006,
      [1] = {
        value = 0.002,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100062,
      [1] = {
        value = 0.002,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          param = "maxAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410006,
      [1] = {
        value = 0.003,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100062,
      [1] = {
        value = 0.003,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          param = "maxAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410006,
      [1] = {
        value = 0.004,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100062,
      [1] = {
        value = 0.004,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {
          LogicType = "Exec",
          param = "maxAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410007,
      [1] = {
        value = 4100071,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4100071,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100070,
      [1] = {
        value = 4100071,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4100071,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410007,
      [1] = {
        value = 4100072,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4100072,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.35,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100070,
      [1] = {
        value = 4100072,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4100072,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.35,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410007,
      [1] = {
        value = 4100073,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4100073,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.5,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100070,
      [1] = {
        value = 4100073,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4100073,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 310008,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 310008,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 310008,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 56,
      [1] = {
        value = 600011,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 56,
      [1] = {
        value = 600021,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 56,
      [1] = {
        value = 600031,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410010,
      [1] = {
        value = 600010,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410010,
      [1] = {
        value = 6000101,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410010,
      [1] = {
        value = 6000102,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100111,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Load",
          param = "addDamageByStamp"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410011,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430011,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100111,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Load",
          param = "addDamageByStamp"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410011,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430011,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100111,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Load",
          param = "addDamageByStamp"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410011,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430011,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410012,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410012,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410012,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410013,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Exec",
          param = "recoverPersent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410013,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
          param = "recoverPersent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410013,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Exec",
          param = "recoverPersent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410014,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430014,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410014,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430014,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410014,
      [1] = {
        value = 0.05,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430014,
      [1] = {
        value = 0.05,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 96023,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 96025,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 96023,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 96025,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 96023,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 96025,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410018,
      [1] = {
        value = {
          0.4,
          0.26,
          0.13
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
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420018,
      [1] = {
        value = {
          0.4,
          0.26,
          0.13
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
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410018,
      [1] = {
        value = {
          0.6,
          0.4,
          0.2
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
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420018,
      [1] = {
        value = {
          0.6,
          0.4,
          0.2
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
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410018,
      [1] = {
        value = {
          0.8,
          0.52,
          0.26
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
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420018,
      [1] = {
        value = {
          0.8,
          0.52,
          0.26
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
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410019,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410019,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410019,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410021,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          param = "changeValue"
        },
        type = 2
      },
      [2] = {
        value = 0.2,
        key = {
          LogicType = "Deactive",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420021,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Load",
          param = "changeValue"
        },
        type = 2
      },
      [2] = {
        value = 0.1,
        key = {
          LogicType = "Deactive",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410021,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Load",
          param = "changeValue"
        },
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {
          LogicType = "Deactive",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420021,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Load",
          param = "changeValue"
        },
        type = 2
      },
      [2] = {
        value = 0.15,
        key = {
          LogicType = "Deactive",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410021,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Load",
          param = "changeValue"
        },
        type = 2
      },
      [2] = {
        value = 0.4,
        key = {
          LogicType = "Deactive",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420021,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          param = "changeValue"
        },
        type = 2
      },
      [2] = {
        value = 0.2,
        key = {
          LogicType = "Deactive",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410022,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410022,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410022,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100231,
      [1] = {
        value = 0.05,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430023,
      [1] = {
        value = 0.05,
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
      BuffID = 4100231,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430023,
      [1] = {
        value = 0.1,
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
      BuffID = 4100231,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430023,
      [1] = {
        value = 0.15,
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
      BuffID = 15002415,
      [1] = {
        value = 110024,
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
    }
  },
  {
    [1] = {
      BuffID = 15002415,
      [1] = {
        value = 1100241,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 15002415,
      [1] = {
        value = 1100242,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410025,
      [1] = {
        value = 400125,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410025,
      [1] = {
        value = 400225,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410025,
      [1] = {
        value = 400325,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 112,
      [1] = {
        value = 111,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.008,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 112,
      [1] = {
        value = 4000262,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.01,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 112,
      [1] = {
        value = 4000263,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.012,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100274,
      [1] = {
        value = {0.01},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.01,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100274,
      [1] = {
        value = {0.015},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.015,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100274,
      [1] = {
        value = {0.02},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410028,
      [1] = {
        value = 0.005,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420028,
      [1] = {
        value = 0.005,
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
    [1] = {
      BuffID = 410028,
      [1] = {
        value = 0.008,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420028,
      [1] = {
        value = 0.008,
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
    [1] = {
      BuffID = 410028,
      [1] = {
        value = 0.012,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420028,
      [1] = {
        value = 0.012,
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
    [1] = {
      BuffID = 430029,
      [1] = {
        value = 9,
        key = {
          LogicType = "Exec",
          param = "newGridCount"
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 450029,
      [1] = {
        value = 9,
        key = {
          LogicType = "Exec",
          param = "newGridCount"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 430029,
      [1] = {
        value = 8,
        key = {
          LogicType = "Exec",
          param = "newGridCount"
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 450029,
      [1] = {
        value = 8,
        key = {
          LogicType = "Exec",
          param = "newGridCount"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 430029,
      [1] = {
        value = 7,
        key = {
          LogicType = "Exec",
          param = "newGridCount"
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 450029,
      [1] = {
        value = 7,
        key = {
          LogicType = "Exec",
          param = "newGridCount"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4100301,
      [1] = {
        value = -0.02,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410030,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100301,
      [1] = {
        value = -0.03,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410030,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100301,
      [1] = {
        value = -0.04,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410030,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 310032,
      [1] = {
        value = {crit = 1.4, critProb = 0.15},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 310032,
      [1] = {
        value = {crit = 1.6, critProb = 0.15},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
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
  },
  {
    [1] = {
      BuffID = 310032,
      [1] = {
        value = {crit = 1.8, critProb = 0.15},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410033,
      [1] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          paramIndex = 2,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.01,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430033,
      [1] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          param = "addPercentPerLayer",
          paramIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [5] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410033,
      [1] = {
        value = 0.013,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.013,
        key = {
          LogicType = "Exec",
          paramIndex = 2,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.013,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.013,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430033,
      [1] = {
        value = 0.013,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.013,
        key = {
          LogicType = "Exec",
          param = "addPercentPerLayer",
          paramIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.026,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.013,
        key = {},
        type = 2
      },
      [5] = {
        value = 0.026,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410033,
      [1] = {
        value = 0.016,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.016,
        key = {
          LogicType = "Exec",
          paramIndex = 2,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.016,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.016,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430033,
      [1] = {
        value = 0.016,
        key = {
          LogicType = "Exec",
          paramIndex = 1,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.016,
        key = {
          LogicType = "Exec",
          param = "addPercentPerLayer",
          paramIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.032,
        key = {
          LogicType = "Exec",
          paramIndex = 3,
          param = "addPercentPerLayer"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.016,
        key = {},
        type = 2
      },
      [5] = {
        value = 0.032,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400035,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 400135,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400035,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 400135,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400035,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 400135,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410036,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        LogicIndex = 2
      }
    },
    [2] = {
      BuffID = 420036,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        LogicIndex = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410036,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        LogicIndex = 2
      }
    },
    [2] = {
      BuffID = 420036,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        LogicIndex = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410036,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        LogicIndex = 2
      }
    },
    [2] = {
      BuffID = 420036,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        LogicIndex = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410038,
      [1] = {
        value = 4100381,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [3] = {
        value = 4100382,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420038,
      [1] = {
        value = 4200381,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [3] = {
        value = 4200382,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410038,
      [1] = {
        value = 4100383,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 4100384,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420038,
      [1] = {
        value = 4200383,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 4200384,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410038,
      [1] = {
        value = 4100385,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [3] = {
        value = 4100386,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420038,
      [1] = {
        value = 4200385,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [3] = {
        value = 4200386,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100401,
      [1] = {
        value = 0.12,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 3
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100401,
      [1] = {
        value = 0.15,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 3
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100401,
      [1] = {
        value = 0.18,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 3
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410041,
      [1] = {
        value = 0.04,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420041,
      [1] = {
        value = 0.04,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [3] = {
      BuffID = 430041,
      [1] = {
        value = 4300411,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410041,
      [1] = {
        value = 0.06,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420041,
      [1] = {
        value = 0.06,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [3] = {
      BuffID = 430041,
      [1] = {
        value = 4300412,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410041,
      [1] = {
        value = 0.08,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420041,
      [1] = {
        value = 0.08,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [3] = {
      BuffID = 430041,
      [1] = {
        value = 4300413,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410044,
      [1] = {
        value = 4100441,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430044,
      [1] = {
        value = 4300441,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      },
      [3] = {
        value = 4300441,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410044,
      [1] = {
        value = 4100442,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430044,
      [1] = {
        value = 4300442,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      },
      [3] = {
        value = 4300442,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410044,
      [1] = {
        value = 4100443,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.05,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430044,
      [1] = {
        value = 4300443,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.05,
        key = {},
        type = 2
      },
      [3] = {
        value = 4300443,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "buffID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410046,
      [1] = {
        value = 4100461,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.005,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410046,
      [1] = {
        value = 4100462,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.01,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410046,
      [1] = {
        value = 4100463,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.015,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410047,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Load",
          param = "AttributePer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410047,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          param = "AttributePer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410047,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Load",
          param = "AttributePer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410048,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300481,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410048,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300481,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410048,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300481,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410049,
      [1] = {
        value = 0.3,
        key = {LogicType = "Load", param = "critProb"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410049,
      [1] = {
        value = 0.4,
        key = {LogicType = "Load", param = "critProb"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410049,
      [1] = {
        value = 0.55,
        key = {LogicType = "Load", param = "critProb"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100501,
      [1] = {
        value = {1.5},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100502,
      [1] = {
        value = {1.5},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100501,
      [1] = {
        value = {1.6},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100502,
      [1] = {
        value = {1.6},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100501,
      [1] = {
        value = {1.7},
        key = {LogicType = "Load", param = "percent"},
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
      BuffID = 4100502,
      [1] = {
        value = {1.7},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410051,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410051,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410051,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100521,
      [1] = {
        value = 0.3,
        key = {LogicType = "Load", param = "prob"},
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
      BuffID = 4100522,
      [1] = {
        value = 0.3,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100521,
      [1] = {
        value = 0.4,
        key = {LogicType = "Load", param = "prob"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100522,
      [1] = {
        value = 0.4,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100521,
      [1] = {
        value = 0.55,
        key = {LogicType = "Load", param = "prob"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.55,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100522,
      [1] = {
        value = 0.55,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      },
      [2] = {
        value = 0.55,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410053,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410053,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410053,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100741,
      [1] = {
        value = {2.7},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100742,
      [1] = {
        value = {2.7},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100741,
      [1] = {
        value = {2.8},
        key = {LogicType = "Load", param = "percent"},
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
      BuffID = 4100742,
      [1] = {
        value = {2.8},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100741,
      [1] = {
        value = {2.9},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100742,
      [1] = {
        value = {2.9},
        key = {LogicType = "Load", param = "percent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100582,
      [1] = {
        value = {310058},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 1,
        isShow = false
      },
      [2] = {
        value = 1,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 4130582,
      [1] = {
        value = {313058},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 1,
        isShow = false
      },
      [2] = {
        value = 1,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4100582,
      [1] = {
        value = {3100582},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 1,
        isShow = false
      },
      [2] = {
        value = 1.5,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 4130582,
      [1] = {
        value = {3130582},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 1,
        isShow = false
      },
      [2] = {
        value = 1.5,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4100582,
      [1] = {
        value = {3100583},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 1,
        isShow = false
      },
      [2] = {
        value = 2,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 4130582,
      [1] = {
        value = {3130583},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 1,
        isShow = false
      },
      [2] = {
        value = 2,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4100162,
      [1] = {
        value = 0.025,
        key = {
          LogicType = "Exec",
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 410016,
      [1] = {
        value = 0.025,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100162,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 410016,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100162,
      [1] = {
        value = 0.035,
        key = {
          LogicType = "Exec",
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 410016,
      [1] = {
        value = 0.035,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100542,
      [1] = {
        value = {310054},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4300542,
      [1] = {
        value = {330054},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100542,
      [1] = {
        value = {3100542},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
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
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4300542,
      [1] = {
        value = {3300542},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
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
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100542,
      [1] = {
        value = {3100543},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4300542,
      [1] = {
        value = {3300543},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 40871,
      [1] = {
        value = 408711,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 40872,
      [1] = {
        value = 408721,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 40876,
      [1] = {
        value = 408761,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 40874,
      [1] = {
        value = 408741,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    },
    [5] = {
      BuffID = 40875,
      [1] = {
        value = 408751,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 40877,
      [1] = {
        value = 408771,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 40871,
      [1] = {
        value = 408712,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
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
      BuffID = 40872,
      [1] = {
        value = 408722,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
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
    [3] = {
      BuffID = 40876,
      [1] = {
        value = 408762,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
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
    [4] = {
      BuffID = 40874,
      [1] = {
        value = 408742,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
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
    [5] = {
      BuffID = 40875,
      [1] = {
        value = 408752,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
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
    [6] = {
      BuffID = 40877,
      [1] = {
        value = 408772,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
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
  },
  {
    [1] = {
      BuffID = 40871,
      [1] = {
        value = 408713,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 40872,
      [1] = {
        value = 408723,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 40876,
      [1] = {
        value = 408763,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 40874,
      [1] = {
        value = 408743,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [5] = {
      BuffID = 40875,
      [1] = {
        value = 408753,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 40877,
      [1] = {
        value = 408773,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410073,
      [1] = {
        value = -0.6,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "damagePercent"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410073,
      [1] = {
        value = -0.4,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "damagePercent"
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
  },
  {
    [1] = {
      BuffID = 410073,
      [1] = {
        value = -0.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "damagePercent"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4110042,
      [1] = {
        value = -0.65,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.35,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4110042,
      [1] = {
        value = -0.5,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4110042,
      [1] = {
        value = -0.35,
        key = {
          LogicType = "Active",
          param = "changeValue"
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
      BuffID = 4100761,
      [1] = {
        value = {0.25},
        key = {
          LogicType = "Load",
          param = "scopeTargetTypeParam"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410076,
      [1] = {
        value = 0.25,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100761,
      [1] = {
        value = {0.4},
        key = {
          LogicType = "Load",
          param = "scopeTargetTypeParam"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410076,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100761,
      [1] = {
        value = {0.6},
        key = {
          LogicType = "Load",
          param = "scopeTargetTypeParam"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410076,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410078,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300781,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410078,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300781,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410078,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300781,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 36960,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 36961,
      [1] = {
        value = 0.04,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 36963,
      [1] = {
        value = 0.02,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 36966,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 36960,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 36961,
      [1] = {
        value = 0.06,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 36963,
      [1] = {
        value = 0.03,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 36966,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 36960,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 36961,
      [1] = {
        value = 0.08,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 36963,
      [1] = {
        value = 0.04,
        key = {LogicType = "Load", param = "mul"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 36966,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4100591,
      [1] = {
        field = "LayerCount",
        value = 2,
        type = 2,
        isShow = false
      },
      [2] = {
        value = 2,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 420059,
      [1] = {
        field = "LayerCount",
        value = 2,
        type = 2,
        isShow = false
      },
      [2] = {
        value = 2,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4100591,
      [1] = {
        field = "LayerCount",
        value = 3,
        type = 2,
        isShow = false
      },
      [2] = {
        value = 3,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 420059,
      [1] = {
        field = "LayerCount",
        value = 3,
        type = 2,
        isShow = false
      },
      [2] = {
        value = 3,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4100591,
      [1] = {
        field = "LayerCount",
        value = 4,
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 420059,
      [1] = {
        field = "LayerCount",
        value = 4,
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410080,
      [1] = {
        value = 210801,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "skillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410080,
      [1] = {
        value = 210802,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "skillId"
        },
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
      BuffID = 410080,
      [1] = {
        value = 210803,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "skillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410082,
      [1] = {
        value = 0.4,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410082,
      [1] = {
        value = 0.6,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410082,
      [1] = {
        value = 0.8,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410045,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "maxPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410045,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "maxPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410045,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "maxPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100571,
      [1] = {
        value = {0.1, 0.01},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "AttributePerList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100571,
      [1] = {
        value = {0.1, 0.01},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "AttributePerList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.01,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100571,
      [1] = {
        value = {0.2, 0.02},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "AttributePerList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100571,
      [1] = {
        value = {0.2, 0.02},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "AttributePerList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100571,
      [1] = {
        value = {0.3, 0.03},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "AttributePerList"
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
      BuffID = 4100571,
      [1] = {
        value = {0.3, 0.03},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "AttributePerList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100682,
      [1] = {
        value = 0.1,
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
      BuffID = 4100682,
      [1] = {
        value = 0.15,
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
      BuffID = 4100682,
      [1] = {
        value = 0.2,
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
      BuffID = 791001,
      [1] = {
        value = 0.1,
        key = {LogicType = "Active", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 791002,
      [1] = {
        value = 0.1,
        key = {LogicType = "Active", param = "percent"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 791001,
      [1] = {
        value = 0.15,
        key = {LogicType = "Active", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 791002,
      [1] = {
        value = 0.15,
        key = {LogicType = "Active", param = "percent"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 791001,
      [1] = {
        value = 0.2,
        key = {LogicType = "Active", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 791002,
      [1] = {
        value = 0.2,
        key = {LogicType = "Active", param = "percent"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410081,
      [1] = {
        value = {buffID = 4100811},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {buffID = 4100811},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.01,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430081,
      [1] = {
        value = {
          buffID = 4100811,
          buffCountParam = {
            scopeTargetType = 1,
            scopeType = 8,
            scopeCenterType = 1,
            scopeParam = 2
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.01,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410081,
      [1] = {
        value = {buffID = 4100812},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {buffID = 4100812},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430081,
      [1] = {
        value = {
          buffID = 4100812,
          buffCountParam = {
            scopeTargetType = 1,
            scopeType = 8,
            scopeCenterType = 1,
            scopeParam = 2
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410081,
      [1] = {
        value = {buffID = 4100813},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {buffID = 4100813},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430081,
      [1] = {
        value = {
          buffID = 4100813,
          buffCountParam = {
            scopeTargetType = 1,
            scopeType = 8,
            scopeCenterType = 1,
            scopeParam = 2
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410083,
      [1] = {
        value = 0.3,
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
      BuffID = 410083,
      [1] = {
        value = 0.5,
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
      BuffID = 410083,
      [1] = {
        value = 0.7,
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
      BuffID = 4100851,
      [1] = {
        value = {
          0.85,
          0.7,
          0.55,
          0.4,
          0.25,
          0.1
        },
        key = {LogicType = "Exec", param = "HPPercent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      },
      [3] = {
        value = {
          0.1,
          0.2,
          0.3,
          0.4,
          0.5,
          0.6
        },
        key = {LogicType = "Exec", param = "promote"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4100851,
      [1] = {
        value = {
          0.88,
          0.76,
          0.64,
          0.52,
          0.4,
          0.28,
          0.16,
          0.04
        },
        key = {LogicType = "Exec", param = "HPPercent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.12,
        key = {},
        type = 2
      },
      [3] = {
        value = {
          0.1,
          0.2,
          0.3,
          0.4,
          0.5,
          0.6,
          0.7,
          0.8
        },
        key = {LogicType = "Exec", param = "promote"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4100851,
      [1] = {
        value = {
          0.91,
          0.82,
          0.73,
          0.64,
          0.55,
          0.46,
          0.37,
          0.28,
          0.19,
          0.1,
          0.01
        },
        key = {LogicType = "Exec", param = "HPPercent"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.09,
        key = {},
        type = 2
      },
      [3] = {
        value = {
          0.1,
          0.2,
          0.3,
          0.4,
          0.5,
          0.6,
          0.7,
          0.8,
          0.9,
          1,
          1.1
        },
        key = {LogicType = "Exec", param = "promote"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4100861,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Load",
          param = "AttributePer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100861,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Load",
          param = "AttributePer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100861,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Load",
          param = "AttributePer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100911,
      [1] = {
        value = -0.02,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4100912,
      [1] = {
        value = -0.02,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 410091,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430091,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100911,
      [1] = {
        value = -0.03,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4100912,
      [1] = {
        value = -0.03,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 410091,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430091,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100911,
      [1] = {
        value = -0.04,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4100912,
      [1] = {
        value = -0.04,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 410091,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430091,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410070,
      [1] = {
        value = 0.4,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 420070,
      [1] = {
        value = 0.4,
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
      BuffID = 410070,
      [1] = {
        value = 0.5,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 420070,
      [1] = {
        value = 0.5,
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
      BuffID = 410070,
      [1] = {
        value = 0.6,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 420070,
      [1] = {
        value = 0.6,
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
      BuffID = 410075,
      [1] = {
        value = 0.2,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410075,
      [1] = {
        value = 0.4,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410075,
      [1] = {
        value = 0.55,
        key = {LogicType = "Load", param = "prob"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410084,
      [1] = {
        value = 4100841,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420084,
      [1] = {
        value = 4200841,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410084,
      [1] = {
        value = 4100842,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420084,
      [1] = {
        value = 4200842,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410084,
      [1] = {
        value = 4100843,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420084,
      [1] = {
        value = 4200843,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100088,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 410088,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 420088,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430088,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100088,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 410088,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 420088,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430088,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100088,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 410088,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 420088,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430088,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410090,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300901,
      [1] = {
        value = 0.02,
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
    [1] = {
      BuffID = 410090,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300901,
      [1] = {
        value = 0.03,
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
    [1] = {
      BuffID = 410090,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4300901,
      [1] = {
        value = 0.04,
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
    [1] = {
      BuffID = 410092,
      [1] = {
        value = 0.015,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420092,
      [1] = {
        value = 0.015,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410092,
      [1] = {
        value = 0.02,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420092,
      [1] = {
        value = 0.02,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410092,
      [1] = {
        value = 0.025,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420092,
      [1] = {
        value = 0.025,
        key = {LogicType = "Exec", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410060,
      [1] = {
        value = 110060,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420060,
      [1] = {
        value = 110060,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410060,
      [1] = {
        value = 110061,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "attackSkillId"
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
      BuffID = 420060,
      [1] = {
        value = 110061,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410060,
      [1] = {
        value = 110062,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420060,
      [1] = {
        value = 110062,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410064,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 310064,
      [1] = {
        value = 0.15,
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
      BuffID = 320064,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 316064,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [5] = {
      BuffID = 326064,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [6] = {
      BuffID = 4100643,
      [1] = {
        value = 0.15,
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
      BuffID = 410064,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 310064,
      [1] = {
        value = 0.2,
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
      BuffID = 320064,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 316064,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [5] = {
      BuffID = 326064,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [6] = {
      BuffID = 4100643,
      [1] = {
        value = 0.2,
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
      BuffID = 410064,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 310064,
      [1] = {
        value = 0.25,
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
      BuffID = 320064,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 316064,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [5] = {
      BuffID = 326064,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [6] = {
      BuffID = 4100643,
      [1] = {
        value = 0.25,
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
      BuffID = 410089,
      [1] = {
        value = 0.02,
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
      BuffID = 410089,
      [1] = {
        value = 0.03,
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
      BuffID = 410089,
      [1] = {
        value = 0.04,
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
      BuffID = 410103,
      [1] = {
        value = {
          [2001031] = 20010311,
          [2001032] = 20010321,
          [2001033] = 20010331,
          [2201031] = 22010311,
          [2201032] = 22010321,
          [2201033] = 22010331
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410103,
      [1] = {
        value = {
          [2001031] = 20010312,
          [2001032] = 20010322,
          [2001033] = 20010332,
          [2201031] = 22010312,
          [2201032] = 22010322,
          [2201033] = 22010332
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "param"
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
  },
  {
    [1] = {
      BuffID = 410103,
      [1] = {
        value = {
          [2001031] = 20010313,
          [2001032] = 20010323,
          [2001033] = 20010333,
          [2201031] = 22010313,
          [2201032] = 22010323,
          [2201033] = 22010333
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410087,
      [1] = {
        value = {
          conductRate = {
            [1] = 0.5
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {
          conductRate = {
            [1] = 0.5
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          conductRate = {
            [1] = 0.5
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {
          conductRate = {
            [1] = 0.5,
            [2] = 0.25
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {
          conductRate = {
            [1] = 0.5,
            [2] = 0.25
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 5,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [6] = {
        value = {
          conductRate = {
            [1] = 0.5,
            [2] = 0.25
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 6,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [7] = {
        value = 1,
        key = {},
        type = 1
      },
      [8] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410087,
      [1] = {
        value = {
          conductRate = {
            [1] = 0.7
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {
          conductRate = {
            [1] = 0.7
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          conductRate = {
            [1] = 0.7
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 5,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [6] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 6,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [7] = {
        value = 1,
        key = {},
        type = 1
      },
      [8] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410087,
      [1] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 4,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 5,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [6] = {
        value = {
          conductRate = {
            [1] = 0.7,
            [2] = 0.49
          }
        },
        key = {
          LogicType = "Load",
          LogicIndex = 6,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [7] = {
        value = 2,
        key = {},
        type = 1
      },
      [8] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410101,
      [1] = {
        value = {
          25,
          18.75,
          12.5,
          6.25
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "distanceRateMap"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.25,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410101,
      [1] = {
        value = {
          30,
          22.5,
          15,
          7.5
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "distanceRateMap"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410101,
      [1] = {
        value = {
          40,
          30,
          20,
          10
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "distanceRateMap"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410102,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101021,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301021,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
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
      BuffID = 410102,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101021,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301021,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
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
      BuffID = 410102,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101021,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301021,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
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
      BuffID = 410099,
      [1] = {
        value = 110099,
        key = {
          LogicType = "Active",
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410099,
      [1] = {
        value = 1100991,
        key = {
          LogicType = "Active",
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
  },
  {
    [1] = {
      BuffID = 410099,
      [1] = {
        value = 1100992,
        key = {
          LogicType = "Active",
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410100,
      [1] = {
        value = 4101001,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101003,
      [1] = {
        value = 4101001,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301001,
      [1] = {
        value = 4301001,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430100,
      [1] = {
        value = 4301001,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410100,
      [1] = {
        value = 41010012,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
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
      BuffID = 4101003,
      [1] = {
        value = 41010012,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
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
    [3] = {
      BuffID = 4301001,
      [1] = {
        value = 43010012,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
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
    [4] = {
      BuffID = 430100,
      [1] = {
        value = 43010012,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
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
  },
  {
    [1] = {
      BuffID = 410100,
      [1] = {
        value = 41010013,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101003,
      [1] = {
        value = 41010013,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301001,
      [1] = {
        value = 43010013,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 430100,
      [1] = {
        value = 43010013,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100931,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.6},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100932,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.6},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100931,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100932,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100931,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.25,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100932,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "compareParam"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.25,
        key = {},
        type = 2
      },
      [4] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100981,
      [1] = {
        value = 0.02,
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
      BuffID = 4100981,
      [1] = {
        value = 0.03,
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
      BuffID = 4100981,
      [1] = {
        value = 0.04,
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
      BuffID = 410062,
      [1] = {
        value = 0.3,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100621,
      [1] = {
        value = 0.3,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430062,
      [1] = {
        value = 0.15,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410062,
      [1] = {
        value = 0.4,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100621,
      [1] = {
        value = 0.4,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430062,
      [1] = {
        value = 0.2,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410062,
      [1] = {
        value = 0.5,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100621,
      [1] = {
        value = 0.5,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430062,
      [1] = {
        value = 0.25,
        key = {LogicType = "Active", param = "defPercent"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 14009511,
      [1] = {
        value = 0.02,
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
      BuffID = 14009511,
      [1] = {
        value = 0.03,
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
      BuffID = 14009511,
      [1] = {
        value = 0.04,
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
      BuffID = 4100941,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410094,
      [1] = {
        value = -0.01,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4100941,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410094,
      [1] = {
        value = -0.02,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4100941,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410094,
      [1] = {
        value = -0.03,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4100964,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4200964,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4200961,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100964,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4200964,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4200964,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100964,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4200964,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4200961,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100971,
      [1] = {
        value = 0.5,
        key = {},
        type = 2
      },
      [2] = {
        value = -0.5,
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
    [1] = {
      BuffID = 4100971,
      [1] = {
        value = 0.53,
        key = {},
        type = 2
      },
      [2] = {
        value = -0.47,
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
    [1] = {
      BuffID = 4100971,
      [1] = {
        value = 0.56,
        key = {},
        type = 2
      },
      [2] = {
        value = -0.44,
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
    [1] = {
      BuffID = 410056,
      [1] = {
        value = 0.02,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410056,
      [1] = {
        value = 0.03,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410056,
      [1] = {
        value = 0.04,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101041,
      [1] = {
        value = {
          1,
          0.04,
          9999999
        },
        key = {
          LogicType = "Exec",
          param = "vampire",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101042,
      [1] = {
        value = {
          1,
          0.04,
          9999999
        },
        key = {
          LogicType = "Exec",
          param = "vampire",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101041,
      [1] = {
        value = {
          1,
          0.06,
          9999999
        },
        key = {
          LogicType = "Exec",
          param = "vampire",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101042,
      [1] = {
        value = {
          1,
          0.06,
          9999999
        },
        key = {
          LogicType = "Exec",
          param = "vampire",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101041,
      [1] = {
        value = {
          1,
          0.08,
          9999999
        },
        key = {
          LogicType = "Exec",
          param = "vampire",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101042,
      [1] = {
        value = {
          1,
          0.08,
          9999999
        },
        key = {
          LogicType = "Exec",
          param = "vampire",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101051,
      [1] = {
        value = 4101051,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201051,
      [1] = {
        value = 4101051,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301051,
      [1] = {
        value = 4301051,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101051,
      [1] = {
        value = 4101052,
        key = {LogicType = "Exec", param = "skillID"},
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
      BuffID = 4201051,
      [1] = {
        value = 4101052,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301051,
      [1] = {
        value = 4301052,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101051,
      [1] = {
        value = 4101053,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201051,
      [1] = {
        value = 4101053,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301051,
      [1] = {
        value = 4301053,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 41007112,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 41007112,
      [1] = {
        value = 0.05,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 41007112,
      [1] = {
        value = 0.07,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410067,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430067,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410067,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430067,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410067,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430067,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101112,
      [1] = {
        value = 160111101,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
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
      BuffID = 430111,
      [1] = {
        value = 160111101,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
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
    [3] = {
      BuffID = 4161111,
      [1] = {
        value = 160111101,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
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
      BuffID = 436111,
      [1] = {
        value = 160111101,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101112,
      [1] = {
        value = 160111103,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430111,
      [1] = {
        value = 160111103,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4161111,
      [1] = {
        value = 160111103,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 436111,
      [1] = {
        value = 160111103,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101112,
      [1] = {
        value = 160111106,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
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
      BuffID = 430111,
      [1] = {
        value = 160111106,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
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
    [3] = {
      BuffID = 4161111,
      [1] = {
        value = 160111106,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
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
    [4] = {
      BuffID = 436111,
      [1] = {
        value = 160111106,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "trapID"
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
  },
  {
    [1] = {
      BuffID = 4201122,
      [1] = {
        value = 4201121,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4301121,
      [1] = {
        value = 4201121,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4221122,
      [1] = {
        value = 4201121,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4321121,
      [1] = {
        value = 4201121,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 4
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4201122,
      [1] = {
        value = 4201122,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
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
      BuffID = 4301121,
      [1] = {
        value = 4201122,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 3
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
    [3] = {
      BuffID = 4221122,
      [1] = {
        value = 4201122,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 2
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
    [4] = {
      BuffID = 4321121,
      [1] = {
        value = 4201122,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 4
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
  },
  {
    [1] = {
      BuffID = 4201122,
      [1] = {
        value = 4201123,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4301121,
      [1] = {
        value = 4201123,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4221122,
      [1] = {
        value = 4201123,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4321121,
      [1] = {
        value = 4201123,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 4
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410113,
      [1] = {
        value = 0.8,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101131,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4201131,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410113,
      [1] = {
        value = 1,
        key = {LogicType = "Load", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101131,
      [1] = {
        value = 1,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4201131,
      [1] = {
        value = 1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410114,
      [1] = {
        value = {
          0,
          0.1,
          9999999
        },
        key = {LogicType = "Exec", param = "vampire"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410114,
      [1] = {
        value = {
          0,
          0.12,
          9999999
        },
        key = {LogicType = "Exec", param = "vampire"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.12,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410114,
      [1] = {
        value = {
          0,
          0.15,
          9999999
        },
        key = {LogicType = "Exec", param = "vampire"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400115,
      [1] = {
        value = 0.005,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301153,
      [1] = {
        value = 4301151,
        key = {LogicType = "Load", param = "skillID"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400115,
      [1] = {
        value = 0.006,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301153,
      [1] = {
        value = 4301152,
        key = {LogicType = "Load", param = "skillID"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400115,
      [1] = {
        value = 0.008,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301153,
      [1] = {
        value = 4301153,
        key = {LogicType = "Load", param = "skillID"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410116,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 43011621,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Active",
          param = "oneLayerValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4001162,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          param = "oneLayerValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410116,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 43011621,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          param = "oneLayerValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4001162,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          param = "oneLayerValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410116,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 43011621,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          param = "oneLayerValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4001162,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          param = "oneLayerValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410127,
      [1] = {
        value = 4101271,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430127,
      [1] = {
        value = 4101271,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410127,
      [1] = {
        value = 4101272,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
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
      BuffID = 430127,
      [1] = {
        value = 4101272,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
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
  },
  {
    [1] = {
      BuffID = 410127,
      [1] = {
        value = 4101273,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430127,
      [1] = {
        value = 4101273,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400117,
      [1] = {
        value = 0.002,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301172,
      [1] = {
        value = 0.002,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 400117,
      [1] = {
        value = 0.003,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301172,
      [1] = {
        value = 0.003,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 400117,
      [1] = {
        value = 0.004,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301172,
      [1] = {
        value = 0.004,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101192,
      [1] = {
        value = 0.003,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101192,
      [1] = {
        value = 0.004,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101192,
      [1] = {
        value = 0.005,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101221,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101221,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101221,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Exec",
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101212,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430121,
      [1] = {
        value = 0.04,
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
      BuffID = 4101212,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430121,
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
      BuffID = 4101212,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          param = "oneLayerValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430121,
      [1] = {
        value = 0.08,
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
      BuffID = 4100653,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100653,
      [1] = {
        value = 0.12,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4100653,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101266,
      [1] = {
        value = 4101262,
        key = {LogicType = "Load", param = "buffID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.7,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101266,
      [1] = {
        value = 4101263,
        key = {LogicType = "Load", param = "buffID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101266,
      [1] = {
        value = 4101264,
        key = {LogicType = "Load", param = "buffID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4105513,
      [1] = {
        value = 0.012,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4205511,
      [1] = {
        value = 0.012,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4105513,
      [1] = {
        value = 0.016,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4205511,
      [1] = {
        value = 0.016,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4105513,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4205511,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410015,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Load",
          param = "distanceDamageParam",
          LogicIndex = 1
        },
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100151,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Load",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410015,
      [1] = {
        value = 0.09,
        key = {
          LogicType = "Load",
          param = "distanceDamageParam",
          LogicIndex = 1
        },
        type = 2
      },
      [2] = {
        value = 0.045,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100151,
      [1] = {
        value = 0.045,
        key = {
          LogicType = "Load",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410015,
      [1] = {
        value = 0.12,
        key = {
          LogicType = "Load",
          param = "distanceDamageParam",
          LogicIndex = 1
        },
        type = 2
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4100151,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Load",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410123,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430123,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4301231,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          LogicIndex = 3,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410123,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430123,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4301231,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 3,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410123,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 430123,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4301231,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 3,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 460129111,
      [1] = {
        value = 0.06,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 460129131,
      [1] = {
        value = 0.06,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    },
    [3] = {
      BuffID = 460129110,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.09,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 460129130,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.09,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 460129111,
      [1] = {
        value = 0.08,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 460129131,
      [1] = {
        value = 0.08,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    },
    [3] = {
      BuffID = 460129110,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.12,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 460129130,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.12,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 460129111,
      [1] = {
        value = 0.1,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 460129131,
      [1] = {
        value = 0.1,
        key = {LogicType = "Exec", param = "percent"},
        type = 2
      }
    },
    [3] = {
      BuffID = 460129110,
      [1] = {
        value = 0.1,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 460129130,
      [1] = {
        value = 0.1,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101201,
      [1] = {
        value = 0.05,
        key = {LogicType = "Active", param = "mulValue"},
        type = 3
      }
    }
  },
  {
    [1] = {
      BuffID = 4101201,
      [1] = {
        value = 0.1,
        key = {LogicType = "Active", param = "mulValue"},
        type = 3
      }
    }
  },
  {
    [1] = {
      BuffID = 4101201,
      [1] = {
        value = 0.15,
        key = {LogicType = "Active", param = "mulValue"},
        type = 3
      }
    }
  },
  {
    [1] = {
      BuffID = 4101311,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Load",
          param = "AttributePer",
          LogicIndex = 1
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101311,
      [1] = {
        value = 0.18,
        key = {
          LogicType = "Load",
          param = "AttributePer",
          LogicIndex = 1
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101311,
      [1] = {
        value = 0.21,
        key = {
          LogicType = "Load",
          param = "AttributePer",
          LogicIndex = 1
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410132,
      [1] = {
        value = 0.15,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410132,
      [1] = {
        value = 0.18,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410132,
      [1] = {
        value = 0.21,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410133,
      [1] = {
        value = 0.006,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percentAdd"
        },
        type = 2
      },
      [2] = {
        value = 0.003,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430133,
      [1] = {
        value = 0.003,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "splashRate"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410133,
      [1] = {
        value = 0.009,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percentAdd"
        },
        type = 2
      },
      [2] = {
        value = 0.0045,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430133,
      [1] = {
        value = 0.0045,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "splashRate"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410133,
      [1] = {
        value = 0.012,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percentAdd"
        },
        type = 2
      },
      [2] = {
        value = 0.006,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430133,
      [1] = {
        value = 0.006,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "splashRate"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101344,
      [1] = {
        value = 0.015,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101344,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101344,
      [1] = {
        value = 0.025,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410135,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430135,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.08,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410135,
      [1] = {
        value = 0.12,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
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
      BuffID = 430135,
      [1] = {
        value = 0.12,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
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
  },
  {
    [1] = {
      BuffID = 410135,
      [1] = {
        value = 0.16,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.16,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 430135,
      [1] = {
        value = 0.16,
        key = {
          LogicType = "Active",
          param = "changeValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.16,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4001361,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101362,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4001361,
      [1] = {
        value = 0.05,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101362,
      [1] = {
        value = 0.05,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4001361,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101362,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410137,
      [1] = {
        value = 0.3,
        key = {LogicType = "Load", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101371,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410137,
      [1] = {
        value = 0.4,
        key = {LogicType = "Load", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101371,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410137,
      [1] = {
        value = 0.5,
        key = {LogicType = "Load", param = "percent"},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101371,
      [1] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101383,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Exec",
          param = "shieldPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101383,
      [1] = {
        value = 0.09,
        key = {
          LogicType = "Exec",
          param = "shieldPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101383,
      [1] = {
        value = 0.12,
        key = {
          LogicType = "Exec",
          param = "shieldPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101391,
      [1] = {
        value = 0.025,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.0125,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410139,
      [1] = {
        value = {
          0,
          0.025,
          0.05,
          0.075,
          0.1,
          0.125,
          0.15,
          0.175
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "ratesByDis"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 430139,
      [1] = {
        value = {
          0,
          0.0125,
          0.025,
          0.0375,
          0.05,
          0.0625,
          0.075,
          0.0875
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "ratesByDis"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101391,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.015,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410139,
      [1] = {
        value = {
          0,
          0.03,
          0.06,
          0.09,
          0.12,
          0.15,
          0.18,
          0.21
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "ratesByDis"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 430139,
      [1] = {
        value = {
          0,
          0.015,
          0.03,
          0.045,
          0.06,
          0.075,
          0.09,
          0.105
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "ratesByDis"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101391,
      [1] = {
        value = 0.035,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.0175,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410139,
      [1] = {
        value = {
          0,
          0.035,
          0.07,
          0.105,
          0.14,
          0.175,
          0.21,
          0.245
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "ratesByDis"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 430139,
      [1] = {
        value = {
          0,
          0.0175,
          0.035,
          0.0525,
          0.07,
          0.0875,
          0.105,
          0.1225
        },
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "ratesByDis"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410140,
      [1] = {
        value = 4101401,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4101402,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 4101403,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410140,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.06,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410140,
      [1] = {
        value = 4111401,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4111402,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 4111403,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410140,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.05,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.07,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410140,
      [1] = {
        value = 4121401,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 4121402,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 4121403,
        key = {
          LogicType = "Load",
          param = "buffID",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410140,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.06,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.08,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101413,
      [1] = {
        value = 41014111,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.015,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201412,
      [1] = {
        value = 41014111,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.015,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301411,
      [1] = {
        value = 43014111,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.015,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4301413,
      [1] = {
        value = 43014111,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.015,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101413,
      [1] = {
        value = 41014112,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201412,
      [1] = {
        value = 41014112,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301411,
      [1] = {
        value = 43014112,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4301413,
      [1] = {
        value = 43014112,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.9,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101413,
      [1] = {
        value = 41014113,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.025,
        key = {},
        type = 2
      },
      [3] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201412,
      [1] = {
        value = 41014113,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.025,
        key = {},
        type = 2
      },
      [3] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4301411,
      [1] = {
        value = 43014113,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.025,
        key = {},
        type = 2
      },
      [3] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4301413,
      [1] = {
        value = 43014113,
        key = {
          LogicType = "Exec",
          param = "skillID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.025,
        key = {},
        type = 2
      },
      [3] = {
        value = 1.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101421,
      [1] = {
        value = {
          0.03,
          0.027,
          0.024,
          0.021,
          0.018,
          0.015,
          0.012,
          0.009,
          0.006,
          0.003,
          0
        },
        key = {LogicType = "Active", param = "promote"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201421,
      [1] = {
        value = {
          0.03,
          0.027,
          0.024,
          0.021,
          0.018,
          0.015,
          0.012,
          0.009,
          0.006,
          0.003,
          0
        },
        key = {LogicType = "Active", param = "promote"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101421,
      [1] = {
        value = {
          0.05,
          0.045,
          0.04,
          0.035,
          0.03,
          0.025,
          0.02,
          0.015,
          0.01,
          0.005,
          0
        },
        key = {LogicType = "Active", param = "promote"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.05,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201421,
      [1] = {
        value = {
          0.05,
          0.045,
          0.04,
          0.035,
          0.03,
          0.025,
          0.02,
          0.015,
          0.01,
          0.005,
          0
        },
        key = {LogicType = "Active", param = "promote"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.05,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101421,
      [1] = {
        value = {
          0.35,
          0.315,
          0.28,
          0.245,
          0.21,
          0.175,
          0.14,
          0.105,
          0.07,
          0.035,
          0
        },
        key = {LogicType = "Active", param = "promote"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.35,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201421,
      [1] = {
        value = {
          0.35,
          0.315,
          0.28,
          0.245,
          0.21,
          0.175,
          0.14,
          0.105,
          0.07,
          0.035,
          0
        },
        key = {LogicType = "Active", param = "promote"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.35,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101431,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201431,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4101432,
      [1] = {
        value = 40014311,
        key = {LogicType = "Exec", param = "skillID"},
        isShow = false,
        type = 2
      }
    },
    [4] = {
      BuffID = 4201433,
      [1] = {
        value = 40014311,
        key = {LogicType = "Exec", param = "skillID"},
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101431,
      [1] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201431,
      [1] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4101432,
      [1] = {
        value = 40014312,
        key = {LogicType = "Exec", param = "skillID"},
        isShow = false,
        type = 2
      }
    },
    [4] = {
      BuffID = 4201433,
      [1] = {
        value = 40014312,
        key = {LogicType = "Exec", param = "skillID"},
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101431,
      [1] = {
        value = 1.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4201431,
      [1] = {
        value = 1.6,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4101432,
      [1] = {
        value = 40014313,
        key = {LogicType = "Exec", param = "skillID"},
        isShow = false,
        type = 2
      }
    },
    [4] = {
      BuffID = 4201433,
      [1] = {
        value = 40014313,
        key = {LogicType = "Exec", param = "skillID"},
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101443,
      [1] = {
        value = 0.01,
        key = {
          LogicType = "Active",
          param = "mul",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101441,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 420144,
      [1] = {
        value = 4201441,
        key = {
          LogicType = "Exec",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 430144,
      [1] = {
        value = 4301441,
        key = {
          LogicType = "Exec",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101443,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Active",
          param = "mul",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101441,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 420144,
      [1] = {
        value = 4201442,
        key = {
          LogicType = "Exec",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 430144,
      [1] = {
        value = 4301442,
        key = {
          LogicType = "Exec",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101443,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Active",
          param = "mul",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101441,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 420144,
      [1] = {
        value = 4201443,
        key = {
          LogicType = "Exec",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 430144,
      [1] = {
        value = 4301443,
        key = {
          LogicType = "Exec",
          param = "buffID",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101451,
      [1] = {
        value = {3101451},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4131451,
      [1] = {
        value = {3131451},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4201451,
      [1] = {
        value = {3201451},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4231451,
      [1] = {
        value = {3231451},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [5] = {
      BuffID = 4301451,
      [1] = {
        value = {3301451},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 4331451,
      [1] = {
        value = {3331451},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101451,
      [1] = {
        value = {3101452},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4131451,
      [1] = {
        value = {3131452},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4201451,
      [1] = {
        value = {3201452},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4231451,
      [1] = {
        value = {3231452},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [5] = {
      BuffID = 4301451,
      [1] = {
        value = {3301452},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 4331451,
      [1] = {
        value = {3331452},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.9,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101451,
      [1] = {
        value = {3101453},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4131451,
      [1] = {
        value = {3131453},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4201451,
      [1] = {
        value = {3201453},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4231451,
      [1] = {
        value = {3231453},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [5] = {
      BuffID = 4301451,
      [1] = {
        value = {3301453},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 4331451,
      [1] = {
        value = {3331453},
        key = {LogicType = "Load", param = "skillList"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4001463,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Load",
          param = "oneLayerAddMulValue"
        },
        type = 2
      },
      [2] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4001461,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4001463,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Load",
          param = "oneLayerAddMulValue"
        },
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4001461,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4001463,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Load",
          param = "oneLayerAddMulValue"
        },
        type = 2
      },
      [2] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4001461,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101473,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          {4101474, 2},
          {4101475, 80}
        },
        key = {
          LogicType = "Exec",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301471,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          {4001471, 27},
          {4001472, 27},
          {4001473, 26},
          {4301474, 20}
        },
        key = {
          LogicType = "Exec",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301475,
      [1] = {
        value = {
          {4001471, 27},
          {4001472, 27},
          {4001473, 26},
          {4301474, 20}
        },
        key = {
          LogicType = "Load",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101473,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          {4101474, 30},
          {4101475, 70}
        },
        key = {
          LogicType = "Exec",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301471,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          {4001471, 24},
          {4001472, 23},
          {4001473, 23},
          {4301474, 30}
        },
        key = {
          LogicType = "Exec",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301475,
      [1] = {
        value = {
          {4001471, 24},
          {4001472, 23},
          {4001473, 23},
          {4301474, 30}
        },
        key = {
          LogicType = "Load",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101473,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          {4101474, 40},
          {4101475, 60}
        },
        key = {
          LogicType = "Exec",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301471,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          {4001471, 20},
          {4001472, 20},
          {4001473, 20},
          {4301474, 40}
        },
        key = {
          LogicType = "Exec",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301475,
      [1] = {
        value = {
          {4001471, 20},
          {4001472, 20},
          {4001473, 20},
          {4301474, 40}
        },
        key = {
          LogicType = "Load",
          param = "randomBuffIDs",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101481,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Load",
          param = "mulValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410148,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101481,
      [1] = {
        value = 0.12,
        key = {
          LogicType = "Load",
          param = "mulValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410148,
      [1] = {
        value = 0.12,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101481,
      [1] = {
        value = 0.16,
        key = {
          LogicType = "Load",
          param = "mulValue",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 410148,
      [1] = {
        value = 0.16,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410149,
      [1] = {
        value = {
          [2001491] = 20014911,
          [2001492] = 20014921,
          [2001493] = 20014931
        },
        key = {LogicType = "Load", param = "param"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410149,
      [1] = {
        value = {
          [2001491] = 20014912,
          [2001492] = 20014922,
          [2001493] = 20014932
        },
        key = {LogicType = "Load", param = "param"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410149,
      [1] = {
        value = {
          [2001491] = 20014913,
          [2001492] = 20014923,
          [2001493] = 20014933
        },
        key = {LogicType = "Load", param = "param"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101502,
      [1] = {
        value = -0.021,
        key = {LogicType = "Load", param = "mulValue"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 2,
        key = {LogicType = "Load", param = "maxValue"},
        isShow = false,
        type = 2
      },
      [3] = {
        value = 42015011,
        key = {
          LogicType = "Load",
          param = "skillID",
          LogicIndex = 2
        },
        isShow = false,
        type = 2
      }
    },
    [2] = {
      BuffID = 4101501,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101502,
      [1] = {
        value = -0.041,
        key = {LogicType = "Load", param = "mulValue"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 4,
        key = {LogicType = "Load", param = "maxValue"},
        isShow = false,
        type = 2
      },
      [3] = {
        value = 42015011,
        key = {
          LogicType = "Load",
          param = "skillID",
          LogicIndex = 2
        },
        isShow = false,
        type = 2
      }
    },
    [2] = {
      BuffID = 4101501,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.05,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101502,
      [1] = {
        value = -0.061,
        key = {LogicType = "Load", param = "mulValue"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 6,
        key = {LogicType = "Load", param = "maxValue"},
        isShow = false,
        type = 2
      },
      [3] = {
        value = 42015011,
        key = {
          LogicType = "Load",
          param = "skillID",
          LogicIndex = 2
        },
        isShow = false,
        type = 2
      }
    },
    [2] = {
      BuffID = 4101501,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.07,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101512,
      [1] = {
        value = -0.001,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 410151,
      [1] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101512,
      [1] = {
        value = -0.002,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 410151,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101512,
      [1] = {
        value = -0.003,
        key = {LogicType = "Active", param = "mulValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 410151,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410152,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420152,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 430152,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.01,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410152,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420152,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 430152,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410152,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420152,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 430152,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          param = "reduceRatePerSan"
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
        value = -0.7,
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
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 41001551,
      [1] = {
        value = {
          percent = {0.3}
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
  },
  {
    [1] = {
      BuffID = 41001550,
      [1] = {
        value = -0.6,
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
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 41001551,
      [1] = {
        value = {
          percent = {0.4}
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
  },
  {
    [1] = {
      BuffID = 41001550,
      [1] = {
        value = -0.5,
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
        value = 0.5,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 41001551,
      [1] = {
        value = {
          percent = {0.5}
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
  },
  {
    [1] = {
      BuffID = 4101541,
      [1] = {
        value = 0.005,
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
      BuffID = 4101541,
      [1] = {
        value = 0.01,
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
      BuffID = 4101541,
      [1] = {
        value = 0.015,
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
      BuffID = 4101532,
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
    [2] = {
      BuffID = 4201532,
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
    [3] = {
      BuffID = 4201535,
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
    [4] = {
      BuffID = 4301533,
      [1] = {
        value = 0.0075,
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
        value = 0.0075,
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
        value = 0.0075,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101532,
      [1] = {
        value = 0.02,
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
        value = 0.02,
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
        value = 0.02,
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
        value = 0.01,
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
        value = 0.01,
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
        value = 0.01,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101532,
      [1] = {
        value = 0.025,
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
        value = 0.025,
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
        value = 0.025,
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
        value = 0.0125,
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
        value = 0.0125,
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
        value = 0.0125,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerAddMulValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410156,
      [1] = {
        value = 3101561,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 403156,
      [1] = {
        value = 3031561,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 400156,
      [1] = {
        value = 1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410156,
      [1] = {
        value = 3101562,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 403156,
      [1] = {
        value = 3031562,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 400156,
      [1] = {
        value = 1.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410156,
      [1] = {
        value = 3101563,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 403156,
      [1] = {
        value = 3031563,
        key = {LogicType = "Load", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 400156,
      [1] = {
        value = 1.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101574,
      [1] = {
        value = 0.0072,
        key = {
          LogicType = "Load",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101572,
      [1] = {
        value = 0.0072,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4101573,
      [1] = {
        value = 0.005,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101574,
      [1] = {
        value = 0.0143,
        key = {
          LogicType = "Load",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101572,
      [1] = {
        value = 0.0143,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4101573,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101574,
      [1] = {
        value = 0.0215,
        key = {
          LogicType = "Load",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4101572,
      [1] = {
        value = 0.0215,
        key = {
          LogicType = "Exec",
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4101573,
      [1] = {
        value = 0.015,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410158,
      [1] = {
        value = 10,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "maxSingleTargetAddLayer"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410158,
      [1] = {
        value = 20,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "maxSingleTargetAddLayer"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410158,
      [1] = {
        value = 30,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "maxSingleTargetAddLayer"
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101591,
      [1] = {
        value = -0.5,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101591,
      [1] = {
        value = -0.47,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.53,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101591,
      [1] = {
        value = -0.44,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.56,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 40016002,
      [1] = {
        value = 0.5,
        key = {
          LogicType = "Exec",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 40016003,
      [1] = {
        value = 40016004,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 40016012,
      [1] = {
        value = 40016005,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 40016001,
      [1] = {
        value = 1.5,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 40016002,
      [1] = {
        value = 1,
        key = {
          LogicType = "Exec",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 40016003,
      [1] = {
        value = 40016006,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 40016012,
      [1] = {
        value = 40016007,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 40016001,
      [1] = {
        value = 2,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 40016002,
      [1] = {
        value = 1.5,
        key = {
          LogicType = "Exec",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 40016003,
      [1] = {
        value = 40016008,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 40016012,
      [1] = {
        value = 40016009,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 40016001,
      [1] = {
        value = 2.5,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 40016103,
      [1] = {
        value = 0.05,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.05,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 40016103,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 40016103,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Active",
          param = "changeValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410162,
      [1] = {
        value = 0.05,
        key = {LogicType = "Exec", param = "extraProb"},
        type = 2
      },
      [2] = {
        value = 0.01,
        key = {LogicType = "Exec", param = "fullProb"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410162,
      [1] = {
        value = 0.1,
        key = {LogicType = "Exec", param = "extraProb"},
        type = 2
      },
      [2] = {
        value = 0.01,
        key = {LogicType = "Exec", param = "fullProb"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410162,
      [1] = {
        value = 0.2,
        key = {LogicType = "Exec", param = "extraProb"},
        type = 2
      },
      [2] = {
        value = 0.01,
        key = {LogicType = "Exec", param = "fullProb"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400165,
      [1] = {
        value = {
          percent = {0.15}
        },
        key = {LogicType = "Load", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4001651,
      [1] = {
        value = 0.15,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400165,
      [1] = {
        value = {
          percent = {0.2}
        },
        key = {LogicType = "Load", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4001651,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 400165,
      [1] = {
        value = {
          percent = {0.25}
        },
        key = {LogicType = "Load", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4001651,
      [1] = {
        value = 0.25,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410164,
      [1] = {
        value = 4101641,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410164,
      [1] = {
        value = 4101642,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410164,
      [1] = {
        value = 4101643,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.25,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101661,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101665,
      [1] = {
        value = 41016611,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301662,
      [1] = {
        value = 43016611,
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
      BuffID = 4101661,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101665,
      [1] = {
        value = 41016612,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301662,
      [1] = {
        value = 43016612,
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
      BuffID = 4101661,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101665,
      [1] = {
        value = 41016613,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301662,
      [1] = {
        value = 43016613,
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
      BuffID = 4101671,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4111671,
      [1] = {
        value = 0.6,
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
    [1] = {
      BuffID = 4101671,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4111671,
      [1] = {
        value = 0.8,
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
    [1] = {
      BuffID = 4101671,
      [1] = {
        value = 1,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4111671,
      [1] = {
        value = 1,
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
    [1] = {
      BuffID = 4001681,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101681,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Load",
          param = "shieldPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4001681,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101681,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Load",
          param = "shieldPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4001681,
      [1] = {
        value = 1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101681,
      [1] = {
        value = 1,
        key = {
          LogicType = "Load",
          param = "shieldPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101713,
      [1] = {
        value = {
          formulaID = 138,
          damageMulMin138 = 1.2,
          damageMulMax138 = 1.5
        },
        key = {LogicType = "Active", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301713,
      [1] = {
        value = {
          formulaID = 138,
          damageMulMin138 = 1.2,
          damageMulMax138 = 1.5
        },
        key = {LogicType = "Active", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4101711,
      [1] = {
        value = 1.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101713,
      [1] = {
        value = {
          formulaID = 138,
          damageMulMin138 = 1.2,
          damageMulMax138 = 1.8
        },
        key = {LogicType = "Active", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301713,
      [1] = {
        value = {
          formulaID = 138,
          damageMulMin138 = 1.2,
          damageMulMax138 = 1.8
        },
        key = {LogicType = "Active", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4101711,
      [1] = {
        value = 1.8,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101713,
      [1] = {
        value = {
          formulaID = 138,
          damageMulMin138 = 1.2,
          damageMulMax138 = 2.1
        },
        key = {LogicType = "Active", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301713,
      [1] = {
        value = {
          formulaID = 138,
          damageMulMin138 = 1.2,
          damageMulMax138 = 2.1
        },
        key = {LogicType = "Active", param = "set"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4101711,
      [1] = {
        value = 2.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410170,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          0,
          0.04,
          0.08,
          0.12,
          0.16,
          0.2,
          0.24,
          0.28,
          0.32,
          0.36,
          0.4,
          0.44,
          0.48
        },
        key = {LogicType = "Active", param = "ratesByDis"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420170,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          0,
          0.04,
          0.08,
          0.12,
          0.16,
          0.2,
          0.24,
          0.28,
          0.32,
          0.36,
          0.4,
          0.44,
          0.48
        },
        key = {LogicType = "Active", param = "ratesByDis"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410170,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          0,
          0.06,
          0.12,
          0.18,
          0.24,
          0.3,
          0.36,
          0.42,
          0.48,
          0.54,
          0.6,
          0.66,
          0.72
        },
        key = {LogicType = "Active", param = "ratesByDis"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420170,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          0,
          0.06,
          0.12,
          0.18,
          0.24,
          0.3,
          0.36,
          0.42,
          0.48,
          0.54,
          0.6,
          0.66,
          0.72
        },
        key = {LogicType = "Active", param = "ratesByDis"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410170,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          0,
          0.08,
          0.16,
          0.24,
          0.32,
          0.4,
          0.48,
          0.56,
          0.64,
          0.72,
          0.8,
          0.88,
          0.96
        },
        key = {LogicType = "Active", param = "ratesByDis"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 420170,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          0,
          0.08,
          0.16,
          0.24,
          0.32,
          0.4,
          0.48,
          0.56,
          0.64,
          0.72,
          0.8,
          0.88,
          0.96
        },
        key = {LogicType = "Active", param = "ratesByDis"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101691,
      [1] = {
        value = 0.15,
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
        value = 0.05,
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
      BuffID = 4101691,
      [1] = {
        value = 0.2,
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
        value = 0.1,
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
      BuffID = 4101691,
      [1] = {
        value = 0.25,
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
        value = 0.15,
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
      BuffID = 4101721,
      [1] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101722,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Load",
          param = "shieldPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101721,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101722,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Load",
          param = "shieldPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101721,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101722,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Load",
          param = "shieldPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101731,
      [1] = {
        value = 4001731,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101731,
      [1] = {
        value = 4001732,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
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
  },
  {
    [1] = {
      BuffID = 4101731,
      [1] = {
        value = 4001733,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.7,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101753,
      [1] = {
        value = {
          [2001751] = 20017511,
          [2001752] = 20017512,
          [2001753] = 20017513
        },
        key = {LogicType = "Active", param = "param"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101753,
      [1] = {
        value = {
          [2001751] = 20017521,
          [2001752] = 20017522,
          [2001753] = 20017523
        },
        key = {LogicType = "Active", param = "param"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.45,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101753,
      [1] = {
        value = {
          [2001751] = 20017531,
          [2001752] = 20017532,
          [2001753] = 20017533
        },
        key = {LogicType = "Active", param = "param"},
        isShow = false,
        type = 2
      },
      [2] = {
        value = 0.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410176102,
      [1] = {
        value = 410176106,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 8,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410176102,
      [1] = {
        value = 410176105,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 7,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410176102,
      [1] = {
        value = 410176104,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 6,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410177,
      [1] = {
        value = 8,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 4101771,
      [1] = {
        value = 8,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 3
        },
        type = 1,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410177,
      [1] = {
        value = 7,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 4101771,
      [1] = {
        value = 7,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 3
        },
        type = 1,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410177,
      [1] = {
        value = 6,
        key = {},
        type = 1
      }
    },
    [2] = {
      BuffID = 4101771,
      [1] = {
        value = 6,
        key = {
          TriggerType = "Exec",
          TriggerIndex = 2,
          TriggerParamIndex = 3
        },
        type = 1,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 41017811,
      [1] = {
        value = 11017814,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 41017812,
      [1] = {
        value = 11017815,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 41017813,
      [1] = {
        value = 11017816,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 41017811,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 41017811,
      [1] = {
        value = 11017817,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 41017812,
      [1] = {
        value = 11017818,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 41017813,
      [1] = {
        value = 11017819,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 41017811,
      [1] = {
        value = 0.23,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 41017811,
      [1] = {
        value = 110178110,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 41017812,
      [1] = {
        value = 110178111,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 41017813,
      [1] = {
        value = 110178112,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 41017811,
      [1] = {
        value = 0.26,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101801,
      [1] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101802,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "defaultParam"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101801,
      [1] = {
        value = 0.06,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101802,
      [1] = {
        value = 0.06,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "defaultParam"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101801,
      [1] = {
        value = 0.08,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101802,
      [1] = {
        value = 0.08,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "defaultParam"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4001820,
      [1] = {
        value = 1.5,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {1.5}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {1.5}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4001820,
      [1] = {
        value = 2,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {2}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {2}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4001820,
      [1] = {
        value = 2.5,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {2.5}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {2.5}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101811,
      [1] = {
        value = 30018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4131811,
      [1] = {
        value = 30018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4161811,
      [1] = {
        value = 30018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4101812,
      [1] = {
        value = 30018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "extraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [5] = {
      BuffID = 4201811,
      [1] = {
        value = 32018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [6] = {
      BuffID = 4231811,
      [1] = {
        value = 32018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [7] = {
      BuffID = 4261811,
      [1] = {
        value = 32018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [8] = {
      BuffID = 4101813,
      [1] = {
        value = 30018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "extraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [9] = {
      BuffID = 4301811,
      [1] = {
        value = 33018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [10] = {
      BuffID = 4331811,
      [1] = {
        value = 33018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [11] = {
      BuffID = 4361811,
      [1] = {
        value = 33018112,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [12] = {
      BuffID = 41001811,
      [1] = {
        value = 8,
        key = {},
        type = 1
      },
      [2] = {
        value = {30018112},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [13] = {
      BuffID = 41001812,
      [1] = {
        value = 8,
        key = {},
        type = 1
      },
      [2] = {
        value = {32018112},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [14] = {
      BuffID = 41001813,
      [1] = {
        value = 8,
        key = {},
        type = 1
      },
      [2] = {
        value = {33018112},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [15] = {
      BuffID = 4131812,
      [1] = {
        value = 30018112,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [16] = {
      BuffID = 4231812,
      [1] = {
        value = 32018112,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [17] = {
      BuffID = 4331812,
      [1] = {
        value = 33018112,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [18] = {
      BuffID = 40018100,
      [1] = {
        value = 8,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101811,
      [1] = {
        value = 300181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4131811,
      [1] = {
        value = 300181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4161811,
      [1] = {
        value = 300181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4101812,
      [1] = {
        value = 300181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "extraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [5] = {
      BuffID = 4201811,
      [1] = {
        value = 320181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [6] = {
      BuffID = 4231811,
      [1] = {
        value = 320181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [7] = {
      BuffID = 4261811,
      [1] = {
        value = 320181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [8] = {
      BuffID = 4101813,
      [1] = {
        value = 300181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "extraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [9] = {
      BuffID = 4301811,
      [1] = {
        value = 330181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [10] = {
      BuffID = 4331811,
      [1] = {
        value = 330181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [11] = {
      BuffID = 4361811,
      [1] = {
        value = 330181121,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [12] = {
      BuffID = 41001811,
      [1] = {
        value = 7,
        key = {},
        type = 1
      },
      [2] = {
        value = {300181121},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [13] = {
      BuffID = 41001812,
      [1] = {
        value = 7,
        key = {},
        type = 1
      },
      [2] = {
        value = {320181121},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [14] = {
      BuffID = 41001813,
      [1] = {
        value = 7,
        key = {},
        type = 1
      },
      [2] = {
        value = {330181121},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [15] = {
      BuffID = 4131812,
      [1] = {
        value = 300181121,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [16] = {
      BuffID = 4231812,
      [1] = {
        value = 320181121,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [17] = {
      BuffID = 4331812,
      [1] = {
        value = 330181121,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [18] = {
      BuffID = 40018100,
      [1] = {
        value = 7,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101811,
      [1] = {
        value = 300181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4131811,
      [1] = {
        value = 300181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4161811,
      [1] = {
        value = 300181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4101812,
      [1] = {
        value = 300181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "extraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [5] = {
      BuffID = 4201811,
      [1] = {
        value = 320181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [6] = {
      BuffID = 4231811,
      [1] = {
        value = 320181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [7] = {
      BuffID = 4261811,
      [1] = {
        value = 320181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [8] = {
      BuffID = 4101813,
      [1] = {
        value = 300181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "extraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [9] = {
      BuffID = 4301811,
      [1] = {
        value = 330181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [10] = {
      BuffID = 4331811,
      [1] = {
        value = 330181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [11] = {
      BuffID = 4361811,
      [1] = {
        value = 330181122,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [12] = {
      BuffID = 41001811,
      [1] = {
        value = 6,
        key = {},
        type = 1
      },
      [2] = {
        value = {300181122},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [13] = {
      BuffID = 41001812,
      [1] = {
        value = 6,
        key = {},
        type = 1
      },
      [2] = {
        value = {320181122},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [14] = {
      BuffID = 41001813,
      [1] = {
        value = 6,
        key = {},
        type = 1
      },
      [2] = {
        value = {330181122},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      }
    },
    [15] = {
      BuffID = 4131812,
      [1] = {
        value = 300181122,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [16] = {
      BuffID = 4231812,
      [1] = {
        value = 320181122,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [17] = {
      BuffID = 4331812,
      [1] = {
        value = 330181122,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "checkExtraSkillID"
        },
        type = 2,
        isShow = false
      }
    },
    [18] = {
      BuffID = 40018100,
      [1] = {
        value = 6,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101832,
      [1] = {
        value = 0.5,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301831,
      [1] = {
        value = 0.5,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101832,
      [1] = {
        value = 0.55,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301831,
      [1] = {
        value = 0.55,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101832,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    },
    [2] = {
      BuffID = 4301831,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101841,
      [1] = {
        value = 1,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [3] = {
        value = 4001841,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301841,
      [1] = {
        value = 1,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [3] = {
        value = 4301841,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
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
      BuffID = 4101841,
      [1] = {
        value = 1,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 4001842,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301841,
      [1] = {
        value = 1,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 4301842,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
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
      BuffID = 4101841,
      [1] = {
        value = 1.5,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 4001843,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4301841,
      [1] = {
        value = 1.5,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [3] = {
        value = 4301843,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
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
      BuffID = 4101850,
      [1] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101851,
      [1] = {
        value = 3101851,
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
      BuffID = 4161851,
      [1] = {
        value = 3101851,
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
      BuffID = 4101850,
      [1] = {
        value = 1.05,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101851,
      [1] = {
        value = 3101852,
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
      BuffID = 4161851,
      [1] = {
        value = 3101852,
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
      BuffID = 4101850,
      [1] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101851,
      [1] = {
        value = 3101853,
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
      BuffID = 4161851,
      [1] = {
        value = 3101853,
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
      BuffID = 4101861,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101862,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301865,
      [1] = {
        value = 0.6,
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
    [1] = {
      BuffID = 4101861,
      [1] = {
        value = 0.9,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101862,
      [1] = {
        value = 0.9,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301865,
      [1] = {
        value = 0.9,
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
    [1] = {
      BuffID = 4101861,
      [1] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4101862,
      [1] = {
        value = 1.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4301865,
      [1] = {
        value = 1.2,
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
    [1] = {
      BuffID = 40018912,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "multiValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 40018912,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "multiValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 40018912,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.4,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "multiValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101901,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 41019010,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "maxPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101901,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 41019010,
      [1] = {
        value = 0.8,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "maxPercent"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4101901,
      [1] = {
        value = 1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 41019010,
      [1] = {
        value = 1,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "maxPercent"
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
        value = 0.3,
        key = {},
        type = 2
      },
      [2] = {
        value = 1101931,
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
    [1] = {
      BuffID = 4101931,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 1101932,
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
    [1] = {
      BuffID = 4101931,
      [1] = {
        value = 0.5,
        key = {},
        type = 2
      },
      [2] = {
        value = 1101933,
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
    [1] = {
      BuffID = 4101911,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.00286,
        key = {
          LogicType = "Active",
          param = "promotePercent"
        },
        isShow = false,
        type = 2
      },
      [3] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          param = "maxSkillFinal"
        },
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101911,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.00429,
        key = {
          LogicType = "Active",
          param = "promotePercent"
        },
        isShow = false,
        type = 2
      },
      [3] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          param = "maxSkillFinal"
        },
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101911,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.00572,
        key = {
          LogicType = "Active",
          param = "promotePercent"
        },
        isShow = false,
        type = 2
      },
      [3] = {
        value = 0.4,
        key = {
          LogicType = "Active",
          param = "maxSkillFinal"
        },
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101922,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.01,
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
      BuffID = 4101922,
      [1] = {
        value = 0.015,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.015,
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
      BuffID = 4101922,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.02,
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
      BuffID = 4101992,
      [1] = {
        value = 2,
        key = {},
        type = 2
      },
      [2] = {
        value = 1,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101992,
      [1] = {
        value = 2.2,
        key = {},
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4101992,
      [1] = {
        value = 2.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 1.4,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "changeValue"
        },
        isShow = false,
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410200,
      [1] = {
        value = 0.25,
        key = {},
        type = 2
      },
      [2] = {
        value = {0.25},
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
      BuffID = 410200,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      },
      [2] = {
        value = {0.3},
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
      BuffID = 410200,
      [1] = {
        value = 0.35,
        key = {},
        type = 2
      },
      [2] = {
        value = {0.35},
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
      BuffID = 410201,
      [1] = {
        value = 0.04,
        key = {LogicType = "Active", param = "baseValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420201,
      [1] = {
        value = 0.04,
        key = {LogicType = "Active", param = "baseValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410201,
      [1] = {
        value = 0.06,
        key = {LogicType = "Active", param = "baseValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420201,
      [1] = {
        value = 0.06,
        key = {LogicType = "Active", param = "baseValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410201,
      [1] = {
        value = 0.09,
        key = {LogicType = "Active", param = "baseValue"},
        type = 2
      }
    },
    [2] = {
      BuffID = 420201,
      [1] = {
        value = 0.09,
        key = {LogicType = "Active", param = "baseValue"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102021,
      [1] = {
        value = 0.01,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [3] = {
        value = 1,
        key = {},
        type = 2
      },
      [4] = {
        value = 1102021,
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
      BuffID = 4102021,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [3] = {
        value = 2,
        key = {},
        type = 2
      },
      [4] = {
        value = 1102022,
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
      BuffID = 4102021,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      },
      [3] = {
        value = 3,
        key = {},
        type = 2
      },
      [4] = {
        value = 1102023,
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
      BuffID = 4102031,
      [1] = {
        value = 0.5,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102033,
      [1] = {
        value = 0.5,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "shieldPercent"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4102034,
      [1] = {
        value = 0.5,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "shieldPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102031,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102033,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "shieldPercent"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4102034,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "shieldPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102031,
      [1] = {
        value = 0.7,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102033,
      [1] = {
        value = 0.7,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "shieldPercent"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4102034,
      [1] = {
        value = 0.7,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "shieldPercent"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 43002043,
      [1] = {
        value = 1,
        key = {},
        type = 2
      },
      [2] = {
        value = 0,
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
    [1] = {
      BuffID = 43002043,
      [1] = {
        value = 1.06,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.06,
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
    [1] = {
      BuffID = 43002043,
      [1] = {
        value = 1.12,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.12,
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
    [1] = {
      BuffID = 4102053,
      [1] = {
        value = 0.24,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.24,
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
      BuffID = 4102053,
      [1] = {
        value = 0.27,
        key = {},
        type = 2
      },
      [2] = {
        value = 0.27,
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
      BuffID = 41002061,
      [1] = {
        value = {3002062},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 41002062,
      [1] = {
        value = {3202062},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 41002063,
      [1] = {
        value = {3302062},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
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
      BuffID = 41002061,
      [1] = {
        value = {30020622},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 41002062,
      [1] = {
        value = {32020622},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 41002063,
      [1] = {
        value = {33020622},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 41002061,
      [1] = {
        value = {30020623},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 41002062,
      [1] = {
        value = {32020623},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 41002063,
      [1] = {
        value = {33020623},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "skillList"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102071,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102073,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "perLayer"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4162073,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "perLayer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102071,
      [1] = {
        value = 0.35,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102073,
      [1] = {
        value = 0.35,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "perLayer"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4162073,
      [1] = {
        value = 0.35,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "perLayer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102071,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102073,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "perLayer"
        },
        type = 2
      }
    },
    [3] = {
      BuffID = 4162073,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "perLayer"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410208,
      [1] = {
        value = 4002083,
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "buffID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.5,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102083,
      [1] = {
        value = 4002083,
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
      BuffID = 410208,
      [1] = {
        value = 4002084,
        key = {LogicType = "Load", param = "buffID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102083,
      [1] = {
        value = 4002084,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 410208,
      [1] = {
        value = 4002085,
        key = {LogicType = "Load", param = "buffID"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 2.1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102083,
      [1] = {
        value = 4002085,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102091,
      [1] = {
        value = 4102091,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4202091,
      [1] = {
        value = 4202091,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4102090,
      [1] = {
        value = 0.1,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4202090,
      [1] = {
        value = 0.1,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102091,
      [1] = {
        value = 4102092,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4202091,
      [1] = {
        value = 4202092,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4102090,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4202090,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102091,
      [1] = {
        value = 4102093,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4202091,
      [1] = {
        value = 4202093,
        key = {LogicType = "Exec", param = "skillID"},
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4102090,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4202090,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410210,
      [1] = {
        value = {0.12},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.06},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.12,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410210,
      [1] = {
        value = {0.18},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.09},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.18,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410210,
      [1] = {
        value = {0.24},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.12},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "percent"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = 0.24,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102121,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4302121,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4102122,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4302122,
      [1] = {
        value = 0.02,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.02,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102121,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4302121,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4102122,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4302122,
      [1] = {
        value = 0.03,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.03,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102121,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4302121,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4102122,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4302122,
      [1] = {
        value = 0.04,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.04,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102112,
      [1] = {
        value = 0.15,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.15,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102112,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102112,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "mulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.25,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410213,
      [1] = {
        value = 36,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 4102132,
      [1] = {
        value = 36,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    },
    [3] = {
      BuffID = 420213,
      [1] = {
        value = 36,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410213,
      [1] = {
        value = 25,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 4102132,
      [1] = {
        value = 25,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    },
    [3] = {
      BuffID = 420213,
      [1] = {
        value = 25,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410213,
      [1] = {
        value = 16,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    },
    [2] = {
      BuffID = 4102132,
      [1] = {
        value = 16,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    },
    [3] = {
      BuffID = 420213,
      [1] = {
        value = 16,
        key = {
          TriggerType = "Active",
          TriggerIndex = 2,
          TriggerParamIndex = 2
        },
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101870,
      [1] = {
        value = {crit = 1.15},
        key = {LogicType = "Load", param = "set"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.15,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101870,
      [1] = {
        value = {crit = 1.3},
        key = {LogicType = "Load", param = "set"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.3,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 4101870,
      [1] = {
        value = {crit = 1.45},
        key = {LogicType = "Load", param = "set"},
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.45,
        key = {},
        type = 1
      }
    }
  },
  {
    [1] = {
      BuffID = 410188,
      [1] = {
        value = 1101881,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420188,
      [1] = {
        value = 1201881,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430188,
      [1] = {
        value = 1201881,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410188,
      [1] = {
        value = 1101882,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420188,
      [1] = {
        value = 1201882,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430188,
      [1] = {
        value = 1201882,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410188,
      [1] = {
        value = 1101883,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 420188,
      [1] = {
        value = 1201883,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.6,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 430188,
      [1] = {
        value = 1201883,
        key = {
          LogicType = "Active",
          LogicIndex = 2,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.6,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 200221,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "damagePercent"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4002141,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 200221,
      [1] = {
        value = 0.25,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "damagePercent"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4002141,
      [1] = {
        value = 0.25,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 200221,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "damagePercent"
        },
        type = 2,
        isShow = false
      }
    },
    [2] = {
      BuffID = 4002141,
      [1] = {
        value = 0.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102151,
      [1] = {
        value = 1102151,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.45,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4202150,
      [1] = {
        value = 1202151,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.45,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102151,
      [1] = {
        value = 1102152,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4202150,
      [1] = {
        value = 1202152,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.5,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102151,
      [1] = {
        value = 1102153,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.55,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4202150,
      [1] = {
        value = 1202153,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "attackSkillId"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.55,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410216,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410216,
      [1] = {
        value = 0.13,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410216,
      [1] = {
        value = 0.16,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102191,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 4002191,
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
      BuffID = 4202191,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 4202191,
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
      BuffID = 4132191,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 4032191,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4232191,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      },
      [2] = {
        value = 4232191,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102191,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      },
      [2] = {
        value = 4002192,
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
      BuffID = 4202191,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      },
      [2] = {
        value = 4202192,
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
      BuffID = 4132191,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      },
      [2] = {
        value = 4032192,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4232191,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      },
      [2] = {
        value = 4232192,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102191,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [2] = {
        value = 4002193,
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
      BuffID = 4202191,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [2] = {
        value = 4202193,
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
      BuffID = 4132191,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [2] = {
        value = 4032193,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4232191,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [2] = {
        value = 4232193,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102201,
      [1] = {
        value = 0.1,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {0.1}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {0.2}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102201,
      [1] = {
        value = 0.15,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {0.15}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {0.3}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102201,
      [1] = {
        value = 0.2,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {0.2}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {0.4}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
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
        value = 0.02,
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
        value = 0.02,
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
      BuffID = 4102212,
      [1] = {
        value = 0.03,
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
        value = 0.03,
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
      BuffID = 4102212,
      [1] = {
        value = 0.04,
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
        value = 0.04,
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
      BuffID = 4102232,
      [1] = {
        value = 0.7,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {0.7}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {1.05}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {
          percent = {0.7}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102232,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {0.8}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {1.2}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {
          percent = {0.8}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102232,
      [1] = {
        value = 0.9,
        key = {},
        type = 2
      },
      [2] = {
        value = {
          percent = {0.9}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {
          percent = {1.35}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {
          percent = {0.9}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102242,
      [1] = {
        value = 0.004,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102242,
      [1] = {
        value = 0.006,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "oneLayerValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102242,
      [1] = {
        value = 0.008,
        key = {
          LogicType = "Exec",
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
        value = {0.8},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.4},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {0.4},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = 0.8,
        key = {},
        type = 2
      },
      [6] = {
        value = {0.4},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      },
      [7] = {
        value = {0.4},
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
      BuffID = 4102254,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102254,
      [1] = {
        value = {1.2},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.6},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {1.2},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {0.6},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = 1.2,
        key = {},
        type = 2
      },
      [6] = {
        value = {0.6},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      },
      [7] = {
        value = {0.6},
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
      BuffID = 4102254,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4102253,
      [1] = {
        value = 41022521,
        key = {LogicType = "Load", param = "buffID"},
        type = 2
      },
      [2] = {
        value = 41022521,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102254,
      [1] = {
        value = {1.6},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 1
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {1.6},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          param = "splashPercent",
          LogicIndex = 2
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = 1.6,
        key = {},
        type = 2
      },
      [6] = {
        value = {0.8},
        key = {
          LogicType = "Load",
          param = "percent",
          LogicIndex = 3
        },
        type = 2,
        isShow = false
      },
      [7] = {
        value = {0.8},
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
      BuffID = 4102254,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4102253,
      [1] = {
        value = 41022522,
        key = {LogicType = "Load", param = "buffID"},
        type = 2
      },
      [2] = {
        value = 41022522,
        key = {LogicType = "Exec", param = "buffID"},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 410227113,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410227108,
      [1] = {
        value = 0.4,
        key = {
          LogicType = "Exec",
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
      BuffID = 410227113,
      [1] = {
        value = 0.5,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410227108,
      [1] = {
        value = 0.5,
        key = {
          LogicType = "Exec",
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
      BuffID = 410227113,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 410227108,
      [1] = {
        value = 0.6,
        key = {
          LogicType = "Exec",
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
      BuffID = 4102281,
      [1] = {
        value = {
          [2002281] = 20022811,
          [2002282] = 20022821
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.1,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4202281,
      [1] = {
        value = {
          [2002281] = 20022811,
          [2002282] = 20022821,
          [2002283] = 20022831
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
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
      BuffID = 4102281,
      [1] = {
        value = {
          [2002281] = 20022812,
          [2002282] = 20022822
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4202281,
      [1] = {
        value = {
          [2002281] = 20022812,
          [2002282] = 20022822,
          [2002283] = 20022832
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.2,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102281,
      [1] = {
        value = {
          [2002281] = 20022813,
          [2002282] = 20022823
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.3,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4202281,
      [1] = {
        value = {
          [2002281] = 20022813,
          [2002282] = 20022823,
          [2002283] = 20022833
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 1.3,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102292,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102291,
      [1] = {
        value = {
          [14] = {percent = 0.4, formulaID = 166}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "replaceBuffFormulaTable"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102292,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102291,
      [1] = {
        value = {
          [14] = {percent = 0.6, formulaID = 166}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "replaceBuffFormulaTable"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102292,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102291,
      [1] = {
        value = {
          [14] = {percent = 0.8, formulaID = 166}
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "replaceBuffFormulaTable"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102301,
      [1] = {
        value = 4102301,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102302,
      [1] = {
        value = 4102301,
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
        value = 4102301,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4162302,
      [1] = {
        value = 4102301,
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
        value = 4302301,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 4302304,
      [1] = {
        value = 4302301,
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
        value = 4302301,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.2,
        key = {},
        type = 2
      }
    },
    [8] = {
      BuffID = 4302306,
      [1] = {
        value = 4302301,
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
      BuffID = 4102301,
      [1] = {
        value = 4102302,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.23,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102302,
      [1] = {
        value = 4102302,
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
        value = 4102302,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.23,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4162302,
      [1] = {
        value = 4102302,
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
        value = 4302302,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.23,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 4302304,
      [1] = {
        value = 4302302,
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
        value = 4302302,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.23,
        key = {},
        type = 2
      }
    },
    [8] = {
      BuffID = 4302306,
      [1] = {
        value = 4302302,
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
      BuffID = 4102301,
      [1] = {
        value = 4102303,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.26,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102302,
      [1] = {
        value = 4102303,
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
        value = 4102303,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.26,
        key = {},
        type = 2
      }
    },
    [4] = {
      BuffID = 4162302,
      [1] = {
        value = 4102303,
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
        value = 4302303,
        key = {
          LogicType = "Exec",
          LogicIndex = 1,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.26,
        key = {},
        type = 2
      }
    },
    [6] = {
      BuffID = 4302304,
      [1] = {
        value = 4302303,
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
        value = 4302303,
        key = {
          LogicType = "Exec",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.26,
        key = {},
        type = 2
      }
    },
    [8] = {
      BuffID = 4302306,
      [1] = {
        value = 4302303,
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
      BuffID = 4102314,
      [1] = {
        value = 0.02,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102310,
      [1] = {
        value = -0.02,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = -0.02,
        key = {
          LogicType = "Unload",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4162310,
      [1] = {
        value = -0.02,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = -0.02,
        key = {
          LogicType = "Unload",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102314,
      [1] = {
        value = 0.025,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102310,
      [1] = {
        value = -0.025,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = -0.025,
        key = {
          LogicType = "Unload",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4162310,
      [1] = {
        value = -0.025,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = -0.025,
        key = {
          LogicType = "Unload",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4102314,
      [1] = {
        value = 0.03,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4102310,
      [1] = {
        value = -0.03,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = -0.03,
        key = {
          LogicType = "Unload",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    },
    [3] = {
      BuffID = 4162310,
      [1] = {
        value = -0.03,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = -0.03,
        key = {
          LogicType = "Unload",
          LogicIndex = 2,
          param = "oneLayerAddMulValue"
        },
        type = 2,
        isShow = false
      }
    }
  },
  {
    [1] = {
      BuffID = 4002321,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4052321,
      [1] = {
        value = 0.4,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4002322,
      [1] = {
        value = 4002321,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4052322,
      [1] = {
        value = 4052321,
        key = {
          LogicType = "Load",
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
      BuffID = 4002321,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4052321,
      [1] = {
        value = 0.6,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4002322,
      [1] = {
        value = 4002322,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4052322,
      [1] = {
        value = 4052322,
        key = {
          LogicType = "Load",
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
      BuffID = 4002321,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [2] = {
      BuffID = 4052321,
      [1] = {
        value = 0.8,
        key = {},
        type = 2
      }
    },
    [3] = {
      BuffID = 4002322,
      [1] = {
        value = 4002323,
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "skillID"
        },
        type = 2,
        isShow = false
      }
    },
    [4] = {
      BuffID = 4052322,
      [1] = {
        value = 4052323,
        key = {
          LogicType = "Load",
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
        value = 12,
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
      BuffID = 4102331,
      [1] = {
        value = 14,
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
      BuffID = 4102331,
      [1] = {
        value = 16,
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
      BuffID = 4102341,
      [1] = {
        value = 12,
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
      BuffID = 4102341,
      [1] = {
        value = 14,
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
      BuffID = 4102341,
      [1] = {
        value = 16,
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
        value = 12,
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
        value = 14,
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
        value = 16,
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
      BuffID = 4102365,
      [1] = {
        value = 0.003,
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
      BuffID = 4102365,
      [1] = {
        value = 0.005,
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
      BuffID = 4102365,
      [1] = {
        value = 0.007,
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
        value = 0.7,
        key = {},
        type = 2
      },
      [2] = {
        value = {trapID = 8002371},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {findPosTrapId = 8002371},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8002371},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {trapID = 8002371},
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
        value = 0.7,
        key = {},
        type = 2
      },
      [2] = {
        value = {trapID = 8062371},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {findPosTrapId = 8062371},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8062371},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {trapID = 8062371},
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
      BuffID = 4102372,
      [1] = {
        value = 0.9,
        key = {},
        type = 2
      },
      [2] = {
        value = {trapID = 8002372},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {findPosTrapId = 8002372},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8002372},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {trapID = 8002372},
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
        value = 0.9,
        key = {},
        type = 2
      },
      [2] = {
        value = {trapID = 8062372},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {findPosTrapId = 8062372},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8062372},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {trapID = 8062372},
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
      BuffID = 4102372,
      [1] = {
        value = 1.1,
        key = {},
        type = 2
      },
      [2] = {
        value = {trapID = 8002373},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {findPosTrapId = 8002373},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8002373},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {trapID = 8002373},
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
        value = 1.1,
        key = {},
        type = 2
      },
      [2] = {
        value = {trapID = 8062373},
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [3] = {
        value = {findPosTrapId = 8062373},
        key = {
          LogicType = "Load",
          LogicIndex = 2,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [4] = {
        value = {trapID = 8062373},
        key = {
          LogicType = "Load",
          LogicIndex = 3,
          param = "set"
        },
        type = 2,
        isShow = false
      },
      [5] = {
        value = {trapID = 8062373},
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
      BuffID = 4102385,
      [1] = {
        value = {
          [2002381] = 2102381
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.14,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102385,
      [1] = {
        value = {
          [2002381] = 2102382
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.16,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102385,
      [1] = {
        value = {
          [2002381] = 2102383
        },
        key = {
          LogicType = "Load",
          LogicIndex = 1,
          param = "param"
        },
        type = 2,
        isShow = false
      },
      [2] = {
        value = 0.18,
        key = {},
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102413,
      [1] = {
        value = 0.1,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102413,
      [1] = {
        value = 0.2,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  },
  {
    [1] = {
      BuffID = 4102413,
      [1] = {
        value = 0.3,
        key = {
          LogicType = "Active",
          LogicIndex = 1,
          param = "changeValue"
        },
        type = 2
      }
    }
  }
}
local config = {
  {
    1,
    1600011,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[129]
  },
  {
    2,
    1600011,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[129]
  },
  {
    3,
    1600011,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[130]
  },
  {
    4,
    1600011,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[130]
  },
  {
    5,
    1600011,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[130]
  },
  {
    6,
    1600011,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[131]
  },
  {
    7,
    1600011,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[131]
  },
  {
    8,
    1600011,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[131]
  },
  {
    9,
    1600011,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[131]
  },
  {
    10,
    1600011,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100011,
        [1] = {
          value = 1,
          key = {LogicType = "Load", param = "mulValue"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 410001,
        [1] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    11,
    1600021,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[132]
  },
  {
    12,
    1600021,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[132]
  },
  {
    13,
    1600021,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[133]
  },
  {
    14,
    1600021,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[133]
  },
  {
    15,
    1600021,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[133]
  },
  {
    16,
    1600021,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[134]
  },
  {
    17,
    1600021,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[134]
  },
  {
    18,
    1600021,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[134]
  },
  {
    19,
    1600021,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[134]
  },
  {
    20,
    1600021,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410002,
        [1] = {
          value = 1100023,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {1.6},
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "percent"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 1.6,
          key = {},
          type = 2
        },
        [4] = {
          value = 0.8,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100021,
        [1] = {
          value = 1100023,
          key = {
            LogicType = "Exec",
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {1.6},
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "percent"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    21,
    1600031,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    0,
    0.03
  },
  {
    22,
    1600031,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    23,
    1600031,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    24,
    1600031,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    25,
    1600031,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    26,
    1600031,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    27,
    1600031,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    28,
    1600031,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    29,
    1600031,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    30,
    1600031,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    31,
    1600041,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[135]
  },
  {
    32,
    1600041,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[135]
  },
  {
    33,
    1600041,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[136]
  },
  {
    34,
    1600041,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[136]
  },
  {
    35,
    1600041,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[136]
  },
  {
    36,
    1600041,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[137]
  },
  {
    37,
    1600041,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[137]
  },
  {
    38,
    1600041,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[137]
  },
  {
    39,
    1600041,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[137]
  },
  {
    40,
    1600041,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410004,
        [1] = {
          value = 0.2,
          key = {LogicType = "Active", param = "mulValue"},
          type = 2
        }
      }
    }
  },
  {
    41,
    1600051,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[138]
  },
  {
    42,
    1600051,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[138]
  },
  {
    43,
    1600051,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[139]
  },
  {
    44,
    1600051,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[139]
  },
  {
    45,
    1600051,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[139]
  },
  {
    46,
    1600051,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[140]
  },
  {
    47,
    1600051,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[140]
  },
  {
    48,
    1600051,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[140]
  },
  {
    49,
    1600051,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[140]
  },
  {
    50,
    1600051,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100051,
        [1] = {
          value = {percent = 1},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        },
        [3] = {
          value = {percent = 1},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = 1,
          key = {},
          type = 2
        },
        [5] = {
          value = {percent = 1},
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [6] = {
          value = 1,
          key = {},
          type = 2
        },
        [7] = {
          value = {percent = 1},
          key = {
            LogicType = "Load",
            LogicIndex = 4,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [8] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    51,
    1600061,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[141]
  },
  {
    52,
    1600061,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[141]
  },
  {
    53,
    1600061,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[142]
  },
  {
    54,
    1600061,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[142]
  },
  {
    55,
    1600061,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[142]
  },
  {
    56,
    1600061,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[143]
  },
  {
    57,
    1600061,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[143]
  },
  {
    58,
    1600061,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[143]
  },
  {
    59,
    1600061,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[143]
  },
  {
    60,
    1600061,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410006,
        [1] = {
          value = 0.005,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100062,
        [1] = {
          value = 0.005,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.1,
          key = {
            LogicType = "Exec",
            param = "maxAddMulValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    61,
    1400071,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[144]
  },
  {
    62,
    1400071,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[144]
  },
  {
    63,
    1400071,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[145]
  },
  {
    64,
    1400071,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[145]
  },
  {
    65,
    1400071,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[145]
  },
  {
    66,
    1400071,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[146]
  },
  {
    67,
    1400071,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[146]
  },
  {
    68,
    1400071,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[146]
  },
  {
    69,
    1400071,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[146]
  },
  {
    70,
    1400071,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410007,
        [1] = {
          value = 4100074,
          key = {
            LogicType = "Load",
            param = "buffID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 4100074,
          key = {
            LogicType = "Load",
            param = "buffID",
            LogicIndex = 2
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.7,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100070,
        [1] = {
          value = 4100074,
          key = {
            LogicType = "Load",
            param = "buffID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 4100074,
          key = {
            LogicType = "Load",
            param = "buffID",
            LogicIndex = 2
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.7,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    71,
    1400081,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[147]
  },
  {
    72,
    1400081,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[147]
  },
  {
    73,
    1400081,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[148]
  },
  {
    74,
    1400081,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[148]
  },
  {
    75,
    1400081,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[148]
  },
  {
    76,
    1400081,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[149]
  },
  {
    77,
    1400081,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[149]
  },
  {
    78,
    1400081,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[149]
  },
  {
    79,
    1400081,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[149]
  },
  {
    80,
    1400081,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 310008,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    81,
    1500091,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[150]
  },
  {
    82,
    1500091,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[150]
  },
  {
    83,
    1500091,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[151]
  },
  {
    84,
    1500091,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[151]
  },
  {
    85,
    1500091,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[151]
  },
  {
    86,
    1500091,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[152]
  },
  {
    87,
    1500091,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[152]
  },
  {
    88,
    1500091,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[152]
  },
  {
    89,
    1500091,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[152]
  },
  {
    90,
    1500091,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 56,
        [1] = {
          value = 600041,
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
    91,
    1600101,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[153]
  },
  {
    92,
    1600101,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[153]
  },
  {
    93,
    1600101,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[154]
  },
  {
    94,
    1600101,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[154]
  },
  {
    95,
    1600101,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[154]
  },
  {
    96,
    1600101,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[155]
  },
  {
    97,
    1600101,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[155]
  },
  {
    98,
    1600101,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[155]
  },
  {
    99,
    1600101,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[155]
  },
  {
    100,
    1600101,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410010,
        [1] = {
          value = 6000103,
          key = {LogicType = "Exec", param = "skillID"},
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
    101,
    1600111,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[156]
  },
  {
    102,
    1600111,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[156]
  },
  {
    103,
    1600111,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[157]
  },
  {
    104,
    1600111,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[157]
  },
  {
    105,
    1600111,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[157]
  },
  {
    106,
    1600111,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[158]
  },
  {
    107,
    1600111,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[158]
  },
  {
    108,
    1600111,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[158]
  },
  {
    109,
    1600111,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[158]
  },
  {
    110,
    1600111,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100111,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Load",
            param = "addDamageByStamp"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 410011,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 430011,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    111,
    1500121,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[159]
  },
  {
    112,
    1500121,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[159]
  },
  {
    113,
    1500121,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[160]
  },
  {
    114,
    1500121,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[160]
  },
  {
    115,
    1500121,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[160]
  },
  {
    116,
    1500121,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[161]
  },
  {
    117,
    1500121,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[161]
  },
  {
    118,
    1500121,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[161]
  },
  {
    119,
    1500121,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[161]
  },
  {
    120,
    1500121,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410012,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    121,
    1500131,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[162]
  },
  {
    122,
    1500131,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[162]
  },
  {
    123,
    1500131,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[163]
  },
  {
    124,
    1500131,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[163]
  },
  {
    125,
    1500131,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[163]
  },
  {
    126,
    1500131,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[164]
  },
  {
    127,
    1500131,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[164]
  },
  {
    128,
    1500131,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[164]
  },
  {
    129,
    1500131,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[164]
  },
  {
    130,
    1500131,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410013,
        [1] = {
          value = 0.3,
          key = {
            LogicType = "Exec",
            param = "recoverPersent"
          },
          type = 2
        }
      }
    }
  },
  {
    131,
    1600141,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[165]
  },
  {
    132,
    1600141,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[165]
  },
  {
    133,
    1600141,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[166]
  },
  {
    134,
    1600141,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[166]
  },
  {
    135,
    1600141,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[166]
  },
  {
    136,
    1600141,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[167]
  },
  {
    137,
    1600141,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[167]
  },
  {
    138,
    1600141,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[167]
  },
  {
    139,
    1600141,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[167]
  },
  {
    140,
    1600141,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410014,
        [1] = {
          value = 0.06,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 430014,
        [1] = {
          value = 0.06,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    141,
    1400171,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[168]
  },
  {
    142,
    1400171,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[168]
  },
  {
    143,
    1400171,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[169]
  },
  {
    144,
    1400171,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[169]
  },
  {
    145,
    1400171,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[169]
  },
  {
    146,
    1400171,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[170]
  },
  {
    147,
    1400171,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[170]
  },
  {
    148,
    1400171,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[170]
  },
  {
    149,
    1400171,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[170]
  },
  {
    150,
    1400171,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 96023,
        [1] = {
          value = 1,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 96025,
        [1] = {
          value = 1,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2
        }
      }
    }
  },
  {
    151,
    1500181,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[171]
  },
  {
    152,
    1500181,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[171]
  },
  {
    153,
    1500181,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[172]
  },
  {
    154,
    1500181,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[172]
  },
  {
    155,
    1500181,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[172]
  },
  {
    156,
    1500181,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[173]
  },
  {
    157,
    1500181,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[173]
  },
  {
    158,
    1500181,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[173]
  },
  {
    159,
    1500181,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[173]
  },
  {
    160,
    1500181,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410018,
        [1] = {
          value = {
            1,
            0.66,
            0.33
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
          value = 1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420018,
        [1] = {
          value = {
            1,
            0.66,
            0.33
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
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    161,
    1600191,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[174]
  },
  {
    162,
    1600191,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[174]
  },
  {
    163,
    1600191,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[175]
  },
  {
    164,
    1600191,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[175]
  },
  {
    165,
    1600191,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[175]
  },
  {
    166,
    1600191,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[176]
  },
  {
    167,
    1600191,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[176]
  },
  {
    168,
    1600191,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[176]
  },
  {
    169,
    1600191,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[176]
  },
  {
    170,
    1600191,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410019,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "mulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    171,
    1500201,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    172,
    1500201,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    173,
    1500201,
    4,
    {
      {3210701, 5},
      {3500001, 500},
      {3000002, 30000}
    },
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    174,
    1500201,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    175,
    1500201,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    176,
    1500201,
    7,
    {
      {3210702, 5},
      {3500001, 600},
      {3000002, 60000}
    },
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    177,
    1500201,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    178,
    1500201,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    179,
    1500201,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    180,
    1500201,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    181,
    1500211,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[177]
  },
  {
    182,
    1500211,
    2,
    common[68],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[177]
  },
  {
    183,
    1500211,
    3,
    common[69],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[178]
  },
  {
    184,
    1500211,
    4,
    common[70],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[178]
  },
  {
    185,
    1500211,
    5,
    common[71],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[178]
  },
  {
    186,
    1500211,
    6,
    common[72],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[179]
  },
  {
    187,
    1500211,
    7,
    common[73],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[179]
  },
  {
    188,
    1500211,
    8,
    common[74],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[179]
  },
  {
    189,
    1500211,
    9,
    common[75],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[179]
  },
  {
    190,
    1500211,
    10,
    common[76],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410021,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Load",
            param = "changeValue"
          },
          type = 2
        },
        [2] = {
          value = 0.5,
          key = {
            LogicType = "Deactive",
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 420021,
        [1] = {
          value = 0.25,
          key = {
            LogicType = "Load",
            param = "changeValue"
          },
          type = 2
        },
        [2] = {
          value = 0.25,
          key = {
            LogicType = "Deactive",
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    191,
    1300221,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[180]
  },
  {
    192,
    1300221,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[180]
  },
  {
    193,
    1300221,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[181]
  },
  {
    194,
    1300221,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[181]
  },
  {
    195,
    1300221,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[181]
  },
  {
    196,
    1300221,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[182]
  },
  {
    197,
    1300221,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[182]
  },
  {
    198,
    1300221,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[182]
  },
  {
    199,
    1300221,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[182]
  },
  {
    200,
    1300221,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410022,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    201,
    1600231,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[183]
  },
  {
    202,
    1600231,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[183]
  },
  {
    203,
    1600231,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[184]
  },
  {
    204,
    1600231,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[184]
  },
  {
    205,
    1600231,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[184]
  },
  {
    206,
    1600231,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[185]
  },
  {
    207,
    1600231,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[185]
  },
  {
    208,
    1600231,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[185]
  },
  {
    209,
    1600231,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[185]
  },
  {
    210,
    1600231,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100231,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 430023,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    211,
    1500241,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[186]
  },
  {
    212,
    1500241,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[186]
  },
  {
    213,
    1500241,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[187]
  },
  {
    214,
    1500241,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[187]
  },
  {
    215,
    1500241,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[187]
  },
  {
    216,
    1500241,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[188]
  },
  {
    217,
    1500241,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[188]
  },
  {
    218,
    1500241,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[188]
  },
  {
    219,
    1500241,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[188]
  },
  {
    220,
    1500241,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 15002415,
        [1] = {
          value = 1100243,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
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
    221,
    1600251,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[189]
  },
  {
    222,
    1600251,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[189]
  },
  {
    223,
    1600251,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[190]
  },
  {
    224,
    1600251,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[190]
  },
  {
    225,
    1600251,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[190]
  },
  {
    226,
    1600251,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[191]
  },
  {
    227,
    1600251,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[191]
  },
  {
    228,
    1600251,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[191]
  },
  {
    229,
    1600251,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[191]
  },
  {
    230,
    1600251,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410025,
        [1] = {
          value = 400425,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    231,
    1600261,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[192]
  },
  {
    232,
    1600261,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[192]
  },
  {
    233,
    1600261,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[193]
  },
  {
    234,
    1600261,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[193]
  },
  {
    235,
    1600261,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[193]
  },
  {
    236,
    1600261,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[194]
  },
  {
    237,
    1600261,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[194]
  },
  {
    238,
    1600261,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[194]
  },
  {
    239,
    1600261,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[194]
  },
  {
    240,
    1600261,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 112,
        [1] = {
          value = 4000264,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.015,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    241,
    1600271,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[195]
  },
  {
    242,
    1600271,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[195]
  },
  {
    243,
    1600271,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[196]
  },
  {
    244,
    1600271,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[196]
  },
  {
    245,
    1600271,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[196]
  },
  {
    246,
    1600271,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[197]
  },
  {
    247,
    1600271,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[197]
  },
  {
    248,
    1600271,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[197]
  },
  {
    249,
    1600271,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[197]
  },
  {
    250,
    1600271,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100274,
        [1] = {
          value = {0.025},
          key = {LogicType = "Load", param = "percent"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.025,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    251,
    1600281,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[198]
  },
  {
    252,
    1600281,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[198]
  },
  {
    253,
    1600281,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[199]
  },
  {
    254,
    1600281,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[199]
  },
  {
    255,
    1600281,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[199]
  },
  {
    256,
    1600281,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[200]
  },
  {
    257,
    1600281,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[200]
  },
  {
    258,
    1600281,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[200]
  },
  {
    259,
    1600281,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[200]
  },
  {
    260,
    1600281,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410028,
        [1] = {
          value = 0.015,
          key = {LogicType = "Exec", param = "mulValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 420028,
        [1] = {
          value = 0.015,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "mulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    261,
    1600291,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[201]
  },
  {
    262,
    1600291,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[201]
  },
  {
    263,
    1600291,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[202]
  },
  {
    264,
    1600291,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[202]
  },
  {
    265,
    1600291,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[202]
  },
  {
    266,
    1600291,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[203]
  },
  {
    267,
    1600291,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[203]
  },
  {
    268,
    1600291,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[203]
  },
  {
    269,
    1600291,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[203]
  },
  {
    270,
    1600291,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 430029,
        [1] = {
          value = 6,
          key = {
            LogicType = "Exec",
            param = "newGridCount"
          },
          type = 1
        }
      },
      [2] = {
        BuffID = 450029,
        [1] = {
          value = 6,
          key = {
            LogicType = "Exec",
            param = "newGridCount"
          },
          type = 1
        }
      }
    }
  },
  {
    271,
    1600301,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[204]
  },
  {
    272,
    1600301,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[204]
  },
  {
    273,
    1600301,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[205]
  },
  {
    274,
    1600301,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[205]
  },
  {
    275,
    1600301,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[205]
  },
  {
    276,
    1600301,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[206]
  },
  {
    277,
    1600301,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[206]
  },
  {
    278,
    1600301,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[206]
  },
  {
    279,
    1600301,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[206]
  },
  {
    280,
    1600301,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100301,
        [1] = {
          value = -0.05,
          key = {LogicType = "Load", param = "mul"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 410030,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    281,
    1500311,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    0,
    0.03
  },
  {
    282,
    1500311,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    283,
    1500311,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    284,
    1500311,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    285,
    1500311,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    286,
    1500311,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    287,
    1500311,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    288,
    1500311,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    289,
    1500311,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    290,
    1500311,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    291,
    1400321,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[207]
  },
  {
    292,
    1400321,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[207]
  },
  {
    293,
    1400321,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[208]
  },
  {
    294,
    1400321,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[208]
  },
  {
    295,
    1400321,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[208]
  },
  {
    296,
    1400321,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[209]
  },
  {
    297,
    1400321,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[209]
  },
  {
    298,
    1400321,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[209]
  },
  {
    299,
    1400321,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[209]
  },
  {
    300,
    1400321,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 310032,
        [1] = {
          value = {crit = 2, critProb = 0.15},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    301,
    1500331,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[210]
  },
  {
    302,
    1500331,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[210]
  },
  {
    303,
    1500331,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[211]
  },
  {
    304,
    1500331,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[211]
  },
  {
    305,
    1500331,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[211]
  },
  {
    306,
    1500331,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[212]
  },
  {
    307,
    1500331,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[212]
  },
  {
    308,
    1500331,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[212]
  },
  {
    309,
    1500331,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[212]
  },
  {
    310,
    1500331,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410033,
        [1] = {
          value = 0.02,
          key = {
            LogicType = "Exec",
            paramIndex = 1,
            param = "addPercentPerLayer"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.02,
          key = {
            LogicType = "Exec",
            paramIndex = 2,
            param = "addPercentPerLayer"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.02,
          key = {
            LogicType = "Exec",
            paramIndex = 3,
            param = "addPercentPerLayer"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = 0.02,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 430033,
        [1] = {
          value = 0.02,
          key = {
            LogicType = "Exec",
            paramIndex = 1,
            param = "addPercentPerLayer"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.02,
          key = {
            LogicType = "Exec",
            param = "addPercentPerLayer",
            paramIndex = 2
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.04,
          key = {
            LogicType = "Exec",
            paramIndex = 3,
            param = "addPercentPerLayer"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = 0.02,
          key = {},
          type = 2
        },
        [5] = {
          value = 0.04,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    311,
    1500341,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    0,
    0.03
  },
  {
    312,
    1500341,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    313,
    1500341,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    314,
    1500341,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    315,
    1500341,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    316,
    1500341,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    317,
    1500341,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    318,
    1500341,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    319,
    1500341,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    320,
    1500341,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    321,
    1400351,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[213]
  },
  {
    322,
    1400351,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[213]
  },
  {
    323,
    1400351,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[214]
  },
  {
    324,
    1400351,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[214]
  },
  {
    325,
    1400351,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[214]
  },
  {
    326,
    1400351,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[215]
  },
  {
    327,
    1400351,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[215]
  },
  {
    328,
    1400351,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[215]
  },
  {
    329,
    1400351,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[215]
  },
  {
    330,
    1400351,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 400035,
        [1] = {
          value = 0.4,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 400135,
        [1] = {
          value = 0.4,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    331,
    1500361,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[216]
  },
  {
    332,
    1500361,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[216]
  },
  {
    333,
    1500361,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[217]
  },
  {
    334,
    1500361,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[217]
  },
  {
    335,
    1500361,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[217]
  },
  {
    336,
    1500361,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[218]
  },
  {
    337,
    1500361,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[218]
  },
  {
    338,
    1500361,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[218]
  },
  {
    339,
    1500361,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[218]
  },
  {
    340,
    1500361,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410036,
        [1] = {
          value = 1,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "percent"
          },
          type = 2,
          LogicIndex = 2
        }
      },
      [2] = {
        BuffID = 420036,
        [1] = {
          value = 1,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "percent"
          },
          type = 2,
          LogicIndex = 2
        }
      }
    }
  },
  {
    341,
    1600381,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[219]
  },
  {
    342,
    1600381,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[219]
  },
  {
    343,
    1600381,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[220]
  },
  {
    344,
    1600381,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[220]
  },
  {
    345,
    1600381,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[220]
  },
  {
    346,
    1600381,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[221]
  },
  {
    347,
    1600381,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[221]
  },
  {
    348,
    1600381,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[221]
  },
  {
    349,
    1600381,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[221]
  },
  {
    350,
    1600381,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410038,
        [1] = {
          value = 4100387,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.5,
          key = {},
          type = 2
        },
        [3] = {
          value = 4100388,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = 0.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420038,
        [1] = {
          value = 4200387,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.5,
          key = {},
          type = 2
        },
        [3] = {
          value = 4200388,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = 0.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    351,
    1400401,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[222]
  },
  {
    352,
    1400401,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[222]
  },
  {
    353,
    1400401,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[223]
  },
  {
    354,
    1400401,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[223]
  },
  {
    355,
    1400401,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[223]
  },
  {
    356,
    1400401,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[224]
  },
  {
    357,
    1400401,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[224]
  },
  {
    358,
    1400401,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[224]
  },
  {
    359,
    1400401,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[224]
  },
  {
    360,
    1400401,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100401,
        [1] = {
          value = 0.2,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 2,
            TriggerParamIndex = 3
          },
          type = 2
        }
      }
    }
  },
  {
    361,
    1400411,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[225]
  },
  {
    362,
    1400411,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[225]
  },
  {
    363,
    1400411,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[226]
  },
  {
    364,
    1400411,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[226]
  },
  {
    365,
    1400411,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[226]
  },
  {
    366,
    1400411,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[227]
  },
  {
    367,
    1400411,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[227]
  },
  {
    368,
    1400411,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[227]
  },
  {
    369,
    1400411,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[227]
  },
  {
    370,
    1400411,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410041,
        [1] = {
          value = 0.1,
          key = {LogicType = "Active", param = "mulValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 420041,
        [1] = {
          value = 0.1,
          key = {LogicType = "Active", param = "mulValue"},
          type = 2
        }
      },
      [3] = {
        BuffID = 430041,
        [1] = {
          value = 4300414,
          key = {LogicType = "Load", param = "skillID"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    371,
    1400441,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[228]
  },
  {
    372,
    1400441,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[228]
  },
  {
    373,
    1400441,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[229]
  },
  {
    374,
    1400441,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[229]
  },
  {
    375,
    1400441,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[229]
  },
  {
    376,
    1400441,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[230]
  },
  {
    377,
    1400441,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[230]
  },
  {
    378,
    1400441,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[230]
  },
  {
    379,
    1400441,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[230]
  },
  {
    380,
    1400441,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410044,
        [1] = {
          value = 4100444,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.06,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 430044,
        [1] = {
          value = 4300444,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.06,
          key = {},
          type = 2
        },
        [3] = {
          value = 4300444,
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
    381,
    1300461,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[231]
  },
  {
    382,
    1300461,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[231]
  },
  {
    383,
    1300461,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[232]
  },
  {
    384,
    1300461,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[232]
  },
  {
    385,
    1300461,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[232]
  },
  {
    386,
    1300461,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[233]
  },
  {
    387,
    1300461,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[233]
  },
  {
    388,
    1300461,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[233]
  },
  {
    389,
    1300461,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[233]
  },
  {
    390,
    1300461,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410046,
        [1] = {
          value = 4100464,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.02,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    391,
    1300471,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[234]
  },
  {
    392,
    1300471,
    2,
    common[68],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[234]
  },
  {
    393,
    1300471,
    3,
    common[69],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[235]
  },
  {
    394,
    1300471,
    4,
    common[70],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[235]
  },
  {
    395,
    1300471,
    5,
    common[71],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[235]
  },
  {
    396,
    1300471,
    6,
    common[72],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[236]
  },
  {
    397,
    1300471,
    7,
    common[73],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[236]
  },
  {
    398,
    1300471,
    8,
    common[74],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[236]
  },
  {
    399,
    1300471,
    9,
    common[75],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[236]
  },
  {
    400,
    1300471,
    10,
    common[76],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410047,
        [1] = {
          value = 0.4,
          key = {
            LogicType = "Load",
            param = "AttributePer"
          },
          type = 2
        }
      }
    }
  },
  {
    401,
    1400481,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[237]
  },
  {
    402,
    1400481,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[237]
  },
  {
    403,
    1400481,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[238]
  },
  {
    404,
    1400481,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[238]
  },
  {
    405,
    1400481,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[238]
  },
  {
    406,
    1400481,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[239]
  },
  {
    407,
    1400481,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[239]
  },
  {
    408,
    1400481,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[239]
  },
  {
    409,
    1400481,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[239]
  },
  {
    410,
    1400481,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410048,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4300481,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    411,
    1300491,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[240]
  },
  {
    412,
    1300491,
    2,
    common[94],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[240]
  },
  {
    413,
    1300491,
    3,
    common[95],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[241]
  },
  {
    414,
    1300491,
    4,
    common[96],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[241]
  },
  {
    415,
    1300491,
    5,
    common[97],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[241]
  },
  {
    416,
    1300491,
    6,
    common[98],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[242]
  },
  {
    417,
    1300491,
    7,
    common[99],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[242]
  },
  {
    418,
    1300491,
    8,
    common[100],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[242]
  },
  {
    419,
    1300491,
    9,
    common[101],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[242]
  },
  {
    420,
    1300491,
    10,
    common[102],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410049,
        [1] = {
          value = 0.7,
          key = {LogicType = "Load", param = "critProb"},
          type = 2
        }
      }
    }
  },
  {
    421,
    1200501,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[243]
  },
  {
    422,
    1200501,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[243]
  },
  {
    423,
    1200501,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[244]
  },
  {
    424,
    1200501,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[244]
  },
  {
    425,
    1200501,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[244]
  },
  {
    426,
    1200501,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[245]
  },
  {
    427,
    1200501,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[245]
  },
  {
    428,
    1200501,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[245]
  },
  {
    429,
    1200501,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[245]
  },
  {
    430,
    1200501,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100501,
        [1] = {
          value = {1.8},
          key = {LogicType = "Load", param = "percent"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.4,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100502,
        [1] = {
          value = {1.8},
          key = {LogicType = "Load", param = "percent"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.4,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    431,
    1300511,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[246]
  },
  {
    432,
    1300511,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[246]
  },
  {
    433,
    1300511,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[247]
  },
  {
    434,
    1300511,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[247]
  },
  {
    435,
    1300511,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[247]
  },
  {
    436,
    1300511,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[248]
  },
  {
    437,
    1300511,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[248]
  },
  {
    438,
    1300511,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[248]
  },
  {
    439,
    1300511,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[248]
  },
  {
    440,
    1300511,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410051,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    441,
    1300521,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[249]
  },
  {
    442,
    1300521,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[249]
  },
  {
    443,
    1300521,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[250]
  },
  {
    444,
    1300521,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[250]
  },
  {
    445,
    1300521,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[250]
  },
  {
    446,
    1300521,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[251]
  },
  {
    447,
    1300521,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[251]
  },
  {
    448,
    1300521,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[251]
  },
  {
    449,
    1300521,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[251]
  },
  {
    450,
    1300521,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100521,
        [1] = {
          value = 0.7,
          key = {LogicType = "Load", param = "prob"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.7,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100522,
        [1] = {
          value = 0.7,
          key = {LogicType = "Load", param = "prob"},
          type = 2
        },
        [2] = {
          value = 0.7,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    451,
    1300531,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[252]
  },
  {
    452,
    1300531,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[252]
  },
  {
    453,
    1300531,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[253]
  },
  {
    454,
    1300531,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[253]
  },
  {
    455,
    1300531,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[253]
  },
  {
    456,
    1300531,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[254]
  },
  {
    457,
    1300531,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[254]
  },
  {
    458,
    1300531,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[254]
  },
  {
    459,
    1300531,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[254]
  },
  {
    460,
    1300531,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410053,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Active",
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    461,
    1300741,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[255]
  },
  {
    462,
    1300741,
    2,
    common[68],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[255]
  },
  {
    463,
    1300741,
    3,
    common[69],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[256]
  },
  {
    464,
    1300741,
    4,
    common[70],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[256]
  },
  {
    465,
    1300741,
    5,
    common[71],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[256]
  },
  {
    466,
    1300741,
    6,
    common[72],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[257]
  },
  {
    467,
    1300741,
    7,
    common[73],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[257]
  },
  {
    468,
    1300741,
    8,
    common[74],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[257]
  },
  {
    469,
    1300741,
    9,
    common[75],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[257]
  },
  {
    470,
    1300741,
    10,
    common[76],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100741,
        [1] = {
          value = {3},
          key = {LogicType = "Load", param = "percent"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100742,
        [1] = {
          value = {3},
          key = {LogicType = "Load", param = "percent"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    471,
    1300581,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[258]
  },
  {
    472,
    1300581,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[258]
  },
  {
    473,
    1300581,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[259]
  },
  {
    474,
    1300581,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[259]
  },
  {
    475,
    1300581,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[259]
  },
  {
    476,
    1300581,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[260]
  },
  {
    477,
    1300581,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[260]
  },
  {
    478,
    1300581,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[260]
  },
  {
    479,
    1300581,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[260]
  },
  {
    480,
    1300581,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100582,
        [1] = {
          value = {3100584},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 1,
          isShow = false
        },
        [2] = {
          value = 3,
          key = {},
          type = 1
        }
      },
      [2] = {
        BuffID = 4130582,
        [1] = {
          value = {3130584},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 1,
          isShow = false
        },
        [2] = {
          value = 3,
          key = {},
          type = 1
        }
      }
    }
  },
  {
    481,
    1400161,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[261]
  },
  {
    482,
    1400161,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[261]
  },
  {
    483,
    1400161,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[262]
  },
  {
    484,
    1400161,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[262]
  },
  {
    485,
    1400161,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[262]
  },
  {
    486,
    1400161,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[263]
  },
  {
    487,
    1400161,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[263]
  },
  {
    488,
    1400161,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[263]
  },
  {
    489,
    1400161,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[263]
  },
  {
    490,
    1400161,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100162,
        [1] = {
          value = 0.04,
          key = {
            LogicType = "Exec",
            param = "oneLayerValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 410016,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    491,
    1400541,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[264]
  },
  {
    492,
    1400541,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[264]
  },
  {
    493,
    1400541,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[265]
  },
  {
    494,
    1400541,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[265]
  },
  {
    495,
    1400541,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[265]
  },
  {
    496,
    1400541,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[266]
  },
  {
    497,
    1400541,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[266]
  },
  {
    498,
    1400541,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[266]
  },
  {
    499,
    1400541,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[266]
  },
  {
    500,
    1400541,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100542,
        [1] = {
          value = {3100544},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.2,
          key = {},
          type = 2
        },
        [3] = {
          value = 0.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4300542,
        [1] = {
          value = {3300544},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.2,
          key = {},
          type = 2
        },
        [3] = {
          value = 0.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    501,
    1400611,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[267]
  },
  {
    502,
    1400611,
    2,
    common[68],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[267]
  },
  {
    503,
    1400611,
    3,
    common[69],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[268]
  },
  {
    504,
    1400611,
    4,
    common[70],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[268]
  },
  {
    505,
    1400611,
    5,
    common[71],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[268]
  },
  {
    506,
    1400611,
    6,
    common[72],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[269]
  },
  {
    507,
    1400611,
    7,
    common[73],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[269]
  },
  {
    508,
    1400611,
    8,
    common[74],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[269]
  },
  {
    509,
    1400611,
    9,
    common[75],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[269]
  },
  {
    510,
    1400611,
    10,
    common[76],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 40871,
        [1] = {
          value = 408714,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.08,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 40872,
        [1] = {
          value = 408724,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.08,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 40876,
        [1] = {
          value = 408764,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.08,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 40874,
        [1] = {
          value = 408744,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.08,
          key = {},
          type = 2
        }
      },
      [5] = {
        BuffID = 40875,
        [1] = {
          value = 408754,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.08,
          key = {},
          type = 2
        }
      },
      [6] = {
        BuffID = 40877,
        [1] = {
          value = 408774,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.08,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    511,
    1400731,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[270]
  },
  {
    512,
    1400731,
    2,
    common[94],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[270]
  },
  {
    513,
    1400731,
    3,
    common[95],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[271]
  },
  {
    514,
    1400731,
    4,
    common[96],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[271]
  },
  {
    515,
    1400731,
    5,
    common[97],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[271]
  },
  {
    516,
    1400731,
    6,
    common[98],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[272]
  },
  {
    517,
    1400731,
    7,
    common[99],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[272]
  },
  {
    518,
    1400731,
    8,
    common[100],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[272]
  },
  {
    519,
    1400731,
    9,
    common[101],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[272]
  },
  {
    520,
    1400731,
    10,
    common[102],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410073,
        [1] = {
          value = 0,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "damagePercent"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    521,
    1500421,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[273]
  },
  {
    522,
    1500421,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[273]
  },
  {
    523,
    1500421,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[274]
  },
  {
    524,
    1500421,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[274]
  },
  {
    525,
    1500421,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[274]
  },
  {
    526,
    1500421,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[275]
  },
  {
    527,
    1500421,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[275]
  },
  {
    528,
    1500421,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[275]
  },
  {
    529,
    1500421,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[275]
  },
  {
    530,
    1500421,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4110042,
        [1] = {
          value = -0.2,
          key = {
            LogicType = "Active",
            param = "changeValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.8,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    531,
    1500761,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[276]
  },
  {
    532,
    1500761,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[276]
  },
  {
    533,
    1500761,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[277]
  },
  {
    534,
    1500761,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[277]
  },
  {
    535,
    1500761,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[277]
  },
  {
    536,
    1500761,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[278]
  },
  {
    537,
    1500761,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[278]
  },
  {
    538,
    1500761,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[278]
  },
  {
    539,
    1500761,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[278]
  },
  {
    540,
    1500761,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100761,
        [1] = {
          value = {0.8},
          key = {
            LogicType = "Load",
            param = "scopeTargetTypeParam"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 410076,
        [1] = {
          value = 0.8,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    541,
    1500781,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[279]
  },
  {
    542,
    1500781,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[279]
  },
  {
    543,
    1500781,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[280]
  },
  {
    544,
    1500781,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[280]
  },
  {
    545,
    1500781,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[280]
  },
  {
    546,
    1500781,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[281]
  },
  {
    547,
    1500781,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[281]
  },
  {
    548,
    1500781,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[281]
  },
  {
    549,
    1500781,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[281]
  },
  {
    550,
    1500781,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410078,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            param = "changeValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4300781,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    551,
    1600771,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[282]
  },
  {
    552,
    1600771,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[282]
  },
  {
    553,
    1600771,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[283]
  },
  {
    554,
    1600771,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[283]
  },
  {
    555,
    1600771,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[283]
  },
  {
    556,
    1600771,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[284]
  },
  {
    557,
    1600771,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[284]
  },
  {
    558,
    1600771,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[284]
  },
  {
    559,
    1600771,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[284]
  },
  {
    560,
    1600771,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 36960,
        [1] = {
          value = 0.1,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 36961,
        [1] = {
          value = 0.1,
          key = {LogicType = "Load", param = "mul"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 36963,
        [1] = {
          value = 0.05,
          key = {LogicType = "Load", param = "mul"},
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 36966,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    561,
    1300591,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[285]
  },
  {
    562,
    1300591,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[285]
  },
  {
    563,
    1300591,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[286]
  },
  {
    564,
    1300591,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[286]
  },
  {
    565,
    1300591,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[286]
  },
  {
    566,
    1300591,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[287]
  },
  {
    567,
    1300591,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[287]
  },
  {
    568,
    1300591,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[287]
  },
  {
    569,
    1300591,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[287]
  },
  {
    570,
    1300591,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100591,
        [1] = {
          field = "LayerCount",
          value = 5,
          type = 2,
          isShow = false
        },
        [2] = {
          value = 5,
          key = {},
          type = 1
        }
      },
      [2] = {
        BuffID = 420059,
        [1] = {
          field = "LayerCount",
          value = 5,
          type = 2,
          isShow = false
        },
        [2] = {
          value = 5,
          key = {},
          type = 1
        }
      }
    }
  },
  {
    571,
    1300801,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[288]
  },
  {
    572,
    1300801,
    2,
    common[68],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[288]
  },
  {
    573,
    1300801,
    3,
    common[69],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[289]
  },
  {
    574,
    1300801,
    4,
    common[70],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[289]
  },
  {
    575,
    1300801,
    5,
    common[71],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[289]
  },
  {
    576,
    1300801,
    6,
    common[72],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[290]
  },
  {
    577,
    1300801,
    7,
    common[73],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[290]
  },
  {
    578,
    1300801,
    8,
    common[74],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[290]
  },
  {
    579,
    1300801,
    9,
    common[75],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[290]
  },
  {
    580,
    1300801,
    10,
    common[76],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410080,
        [1] = {
          value = 210804,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "skillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    581,
    1300821,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[291]
  },
  {
    582,
    1300821,
    2,
    common[103],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[291]
  },
  {
    583,
    1300821,
    3,
    common[104],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[292]
  },
  {
    584,
    1300821,
    4,
    common[105],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[292]
  },
  {
    585,
    1300821,
    5,
    common[106],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[292]
  },
  {
    586,
    1300821,
    6,
    common[107],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[293]
  },
  {
    587,
    1300821,
    7,
    common[108],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[293]
  },
  {
    588,
    1300821,
    8,
    common[109],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[293]
  },
  {
    589,
    1300821,
    9,
    common[110],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[293]
  },
  {
    590,
    1300821,
    10,
    common[111],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410082,
        [1] = {
          value = 1,
          key = {LogicType = "Load", param = "prob"},
          type = 2
        }
      }
    }
  },
  {
    591,
    1400451,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[294]
  },
  {
    592,
    1400451,
    2,
    common[112],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[294]
  },
  {
    593,
    1400451,
    3,
    common[113],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[295]
  },
  {
    594,
    1400451,
    4,
    common[114],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[295]
  },
  {
    595,
    1400451,
    5,
    common[115],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[295]
  },
  {
    596,
    1400451,
    6,
    common[116],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[296]
  },
  {
    597,
    1400451,
    7,
    common[117],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[296]
  },
  {
    598,
    1400451,
    8,
    common[118],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[296]
  },
  {
    599,
    1400451,
    9,
    common[119],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[296]
  },
  {
    600,
    1400451,
    10,
    common[120],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410045,
        [1] = {
          value = 0.25,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "maxPercent"
          },
          type = 2
        }
      }
    }
  },
  {
    601,
    1400571,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[297]
  },
  {
    602,
    1400571,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[297]
  },
  {
    603,
    1400571,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[298]
  },
  {
    604,
    1400571,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[298]
  },
  {
    605,
    1400571,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[298]
  },
  {
    606,
    1400571,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[299]
  },
  {
    607,
    1400571,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[299]
  },
  {
    608,
    1400571,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[299]
  },
  {
    609,
    1400571,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[299]
  },
  {
    610,
    1400571,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100571,
        [1] = {
          value = {0.4, 0.04},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "AttributePerList"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.4,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100571,
        [1] = {
          value = {0.4, 0.04},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "AttributePerList"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.04,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    611,
    1400681,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[300]
  },
  {
    612,
    1400681,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[300]
  },
  {
    613,
    1400681,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[301]
  },
  {
    614,
    1400681,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[301]
  },
  {
    615,
    1400681,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[301]
  },
  {
    616,
    1400681,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[302]
  },
  {
    617,
    1400681,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[302]
  },
  {
    618,
    1400681,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[302]
  },
  {
    619,
    1400681,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[302]
  },
  {
    620,
    1400681,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100682,
        [1] = {
          value = 0.25,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    621,
    1400791,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[303]
  },
  {
    622,
    1400791,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[303]
  },
  {
    623,
    1400791,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[304]
  },
  {
    624,
    1400791,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[304]
  },
  {
    625,
    1400791,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[304]
  },
  {
    626,
    1400791,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[305]
  },
  {
    627,
    1400791,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[305]
  },
  {
    628,
    1400791,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[305]
  },
  {
    629,
    1400791,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[305]
  },
  {
    630,
    1400791,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 791001,
        [1] = {
          value = 0.3,
          key = {LogicType = "Active", param = "percent"},
          type = 2
        }
      },
      [2] = {
        BuffID = 791002,
        [1] = {
          value = 0.3,
          key = {LogicType = "Active", param = "percent"},
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    631,
    1400811,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[306]
  },
  {
    632,
    1400811,
    2,
    common[43],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[306]
  },
  {
    633,
    1400811,
    3,
    common[44],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[307]
  },
  {
    634,
    1400811,
    4,
    common[45],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[307]
  },
  {
    635,
    1400811,
    5,
    common[46],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[307]
  },
  {
    636,
    1400811,
    6,
    common[47],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[308]
  },
  {
    637,
    1400811,
    7,
    common[48],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[308]
  },
  {
    638,
    1400811,
    8,
    common[49],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[308]
  },
  {
    639,
    1400811,
    9,
    common[50],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[308]
  },
  {
    640,
    1400811,
    10,
    common[51],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410081,
        [1] = {
          value = {buffID = 4100814},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {buffID = 4100814},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.04,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 430081,
        [1] = {
          value = {
            buffID = 4100814,
            buffCountParam = {
              scopeTargetType = 1,
              scopeType = 8,
              scopeCenterType = 1,
              scopeParam = 2
            }
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.04,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    641,
    1400831,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[309]
  },
  {
    642,
    1400831,
    2,
    common[68],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[309]
  },
  {
    643,
    1400831,
    3,
    common[69],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[310]
  },
  {
    644,
    1400831,
    4,
    common[70],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[310]
  },
  {
    645,
    1400831,
    5,
    common[71],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[310]
  },
  {
    646,
    1400831,
    6,
    common[72],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[311]
  },
  {
    647,
    1400831,
    7,
    common[73],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[311]
  },
  {
    648,
    1400831,
    8,
    common[74],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[311]
  },
  {
    649,
    1400831,
    9,
    common[75],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[311]
  },
  {
    650,
    1400831,
    10,
    common[76],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410083,
        [1] = {
          value = 0.9,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 2
        }
      }
    }
  },
  {
    651,
    1400851,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[312]
  },
  {
    652,
    1400851,
    2,
    common[94],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[312]
  },
  {
    653,
    1400851,
    3,
    common[95],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[313]
  },
  {
    654,
    1400851,
    4,
    common[96],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[313]
  },
  {
    655,
    1400851,
    5,
    common[97],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[313]
  },
  {
    656,
    1400851,
    6,
    common[98],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[314]
  },
  {
    657,
    1400851,
    7,
    common[99],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[314]
  },
  {
    658,
    1400851,
    8,
    common[100],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[314]
  },
  {
    659,
    1400851,
    9,
    common[101],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[314]
  },
  {
    660,
    1400851,
    10,
    common[102],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100851,
        [1] = {
          value = {
            0.94,
            0.88,
            0.82,
            0.76,
            0.7,
            0.64,
            0.58,
            0.52,
            0.46,
            0.4,
            0.34,
            0.28,
            0.22,
            0.16,
            0.1,
            0.04
          },
          key = {LogicType = "Exec", param = "HPPercent"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.06,
          key = {},
          type = 2
        },
        [3] = {
          value = {
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1,
            1.1,
            1.2,
            1.3,
            1.4,
            1.5,
            1.6
          },
          key = {LogicType = "Exec", param = "promote"},
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    661,
    1400861,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[315]
  },
  {
    662,
    1400861,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[315]
  },
  {
    663,
    1400861,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[316]
  },
  {
    664,
    1400861,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[316]
  },
  {
    665,
    1400861,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[316]
  },
  {
    666,
    1400861,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[317]
  },
  {
    667,
    1400861,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[317]
  },
  {
    668,
    1400861,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[317]
  },
  {
    669,
    1400861,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[317]
  },
  {
    670,
    1400861,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100861,
        [1] = {
          value = 1,
          key = {
            LogicType = "Load",
            param = "AttributePer"
          },
          type = 2
        }
      }
    }
  },
  {
    671,
    1400911,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[318]
  },
  {
    672,
    1400911,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[318]
  },
  {
    673,
    1400911,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[319]
  },
  {
    674,
    1400911,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[319]
  },
  {
    675,
    1400911,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[319]
  },
  {
    676,
    1400911,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[320]
  },
  {
    677,
    1400911,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[320]
  },
  {
    678,
    1400911,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[320]
  },
  {
    679,
    1400911,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[320]
  },
  {
    680,
    1400911,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100911,
        [1] = {
          value = -0.05,
          key = {LogicType = "Load", param = "mulValue"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4100912,
        [1] = {
          value = -0.05,
          key = {LogicType = "Load", param = "mulValue"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 410091,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 430091,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    681,
    1500701,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[321]
  },
  {
    682,
    1500701,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[321]
  },
  {
    683,
    1500701,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[322]
  },
  {
    684,
    1500701,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[322]
  },
  {
    685,
    1500701,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[322]
  },
  {
    686,
    1500701,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[323]
  },
  {
    687,
    1500701,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[323]
  },
  {
    688,
    1500701,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[323]
  },
  {
    689,
    1500701,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[323]
  },
  {
    690,
    1500701,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410070,
        [1] = {
          value = 0.75,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 420070,
        [1] = {
          value = 0.75,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 2
        }
      }
    }
  },
  {
    691,
    1500751,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[324]
  },
  {
    692,
    1500751,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[324]
  },
  {
    693,
    1500751,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[325]
  },
  {
    694,
    1500751,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[325]
  },
  {
    695,
    1500751,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[325]
  },
  {
    696,
    1500751,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[326]
  },
  {
    697,
    1500751,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[326]
  },
  {
    698,
    1500751,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[326]
  },
  {
    699,
    1500751,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[326]
  },
  {
    700,
    1500751,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410075,
        [1] = {
          value = 0.7,
          key = {LogicType = "Load", param = "prob"},
          type = 2
        }
      }
    }
  },
  {
    701,
    1500841,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[327]
  },
  {
    702,
    1500841,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[327]
  },
  {
    703,
    1500841,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[328]
  },
  {
    704,
    1500841,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[328]
  },
  {
    705,
    1500841,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[328]
  },
  {
    706,
    1500841,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[329]
  },
  {
    707,
    1500841,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[329]
  },
  {
    708,
    1500841,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[329]
  },
  {
    709,
    1500841,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[329]
  },
  {
    710,
    1500841,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410084,
        [1] = {
          value = 4100844,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420084,
        [1] = {
          value = 4200844,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    711,
    1500881,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[330]
  },
  {
    712,
    1500881,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[330]
  },
  {
    713,
    1500881,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[331]
  },
  {
    714,
    1500881,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[331]
  },
  {
    715,
    1500881,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[331]
  },
  {
    716,
    1500881,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[332]
  },
  {
    717,
    1500881,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[332]
  },
  {
    718,
    1500881,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[332]
  },
  {
    719,
    1500881,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[332]
  },
  {
    720,
    1500881,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100088,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 410088,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 420088,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 430088,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    721,
    1500901,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[333]
  },
  {
    722,
    1500901,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[333]
  },
  {
    723,
    1500901,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[334]
  },
  {
    724,
    1500901,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[334]
  },
  {
    725,
    1500901,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[334]
  },
  {
    726,
    1500901,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[335]
  },
  {
    727,
    1500901,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[335]
  },
  {
    728,
    1500901,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[335]
  },
  {
    729,
    1500901,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[335]
  },
  {
    730,
    1500901,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410090,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4300901,
        [1] = {
          value = 0.05,
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
    731,
    1500921,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[336]
  },
  {
    732,
    1500921,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[336]
  },
  {
    733,
    1500921,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[337]
  },
  {
    734,
    1500921,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[337]
  },
  {
    735,
    1500921,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[337]
  },
  {
    736,
    1500921,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[338]
  },
  {
    737,
    1500921,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[338]
  },
  {
    738,
    1500921,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[338]
  },
  {
    739,
    1500921,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[338]
  },
  {
    740,
    1500921,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410092,
        [1] = {
          value = 0.03,
          key = {LogicType = "Exec", param = "mulValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 420092,
        [1] = {
          value = 0.03,
          key = {LogicType = "Exec", param = "mulValue"},
          type = 2
        }
      }
    }
  },
  {
    741,
    1600601,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[339]
  },
  {
    742,
    1600601,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[339]
  },
  {
    743,
    1600601,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[340]
  },
  {
    744,
    1600601,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[340]
  },
  {
    745,
    1600601,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[340]
  },
  {
    746,
    1600601,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[341]
  },
  {
    747,
    1600601,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[341]
  },
  {
    748,
    1600601,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[341]
  },
  {
    749,
    1600601,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[341]
  },
  {
    750,
    1600601,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410060,
        [1] = {
          value = 110063,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420060,
        [1] = {
          value = 110063,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    751,
    1600641,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[342]
  },
  {
    752,
    1600641,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[342]
  },
  {
    753,
    1600641,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[343]
  },
  {
    754,
    1600641,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[343]
  },
  {
    755,
    1600641,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[343]
  },
  {
    756,
    1600641,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[344]
  },
  {
    757,
    1600641,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[344]
  },
  {
    758,
    1600641,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[344]
  },
  {
    759,
    1600641,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[344]
  },
  {
    760,
    1600641,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410064,
        [1] = {
          value = 0.3,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 310064,
        [1] = {
          value = 0.3,
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
        BuffID = 320064,
        [1] = {
          value = 0.3,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 316064,
        [1] = {
          value = 0.3,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2,
          isShow = false
        }
      },
      [5] = {
        BuffID = 326064,
        [1] = {
          value = 0.3,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2,
          isShow = false
        }
      },
      [6] = {
        BuffID = 4100643,
        [1] = {
          value = 0.3,
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
    761,
    1600891,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[345]
  },
  {
    762,
    1600891,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[345]
  },
  {
    763,
    1600891,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[346]
  },
  {
    764,
    1600891,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[346]
  },
  {
    765,
    1600891,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[346]
  },
  {
    766,
    1600891,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[347]
  },
  {
    767,
    1600891,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[347]
  },
  {
    768,
    1600891,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[347]
  },
  {
    769,
    1600891,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[347]
  },
  {
    770,
    1600891,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410089,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    771,
    1601031,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[348]
  },
  {
    772,
    1601031,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[348]
  },
  {
    773,
    1601031,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[349]
  },
  {
    774,
    1601031,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[349]
  },
  {
    775,
    1601031,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[349]
  },
  {
    776,
    1601031,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[350]
  },
  {
    777,
    1601031,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[350]
  },
  {
    778,
    1601031,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[350]
  },
  {
    779,
    1601031,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[350]
  },
  {
    780,
    1601031,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410103,
        [1] = {
          value = {
            [2001031] = 20010314,
            [2001032] = 20010324,
            [2001033] = 20010334,
            [2201031] = 22010314,
            [2201032] = 22010324,
            [2201033] = 22010334
          },
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "param"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    781,
    1500871,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[351]
  },
  {
    782,
    1500871,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[351]
  },
  {
    783,
    1500871,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[352]
  },
  {
    784,
    1500871,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[352]
  },
  {
    785,
    1500871,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[352]
  },
  {
    786,
    1500871,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[353]
  },
  {
    787,
    1500871,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[353]
  },
  {
    788,
    1500871,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[353]
  },
  {
    789,
    1500871,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[353]
  },
  {
    790,
    1500871,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410087,
        [1] = {
          value = {
            conductRate = {
              [1] = 1,
              [2] = 1
            }
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {
            conductRate = {
              [1] = 1,
              [2] = 1
            }
          },
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {
            conductRate = {
              [1] = 1,
              [2] = 1
            }
          },
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = {
            conductRate = {
              [1] = 1,
              [2] = 1
            }
          },
          key = {
            LogicType = "Load",
            LogicIndex = 4,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [5] = {
          value = {
            conductRate = {
              [1] = 1,
              [2] = 1
            }
          },
          key = {
            LogicType = "Load",
            LogicIndex = 5,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [6] = {
          value = {
            conductRate = {
              [1] = 1,
              [2] = 1
            }
          },
          key = {
            LogicType = "Load",
            LogicIndex = 6,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [7] = {
          value = 2,
          key = {},
          type = 1
        },
        [8] = {
          value = 0,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    791,
    1401011,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[354]
  },
  {
    792,
    1401011,
    2,
    common[68],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[354]
  },
  {
    793,
    1401011,
    3,
    common[69],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[355]
  },
  {
    794,
    1401011,
    4,
    common[70],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[355]
  },
  {
    795,
    1401011,
    5,
    common[71],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[355]
  },
  {
    796,
    1401011,
    6,
    common[72],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[356]
  },
  {
    797,
    1401011,
    7,
    common[73],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[356]
  },
  {
    798,
    1401011,
    8,
    common[74],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[356]
  },
  {
    799,
    1401011,
    9,
    common[75],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[356]
  },
  {
    800,
    1401011,
    10,
    common[76],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410101,
        [1] = {
          value = {
            50,
            37.5,
            25,
            12.5
          },
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "distanceRateMap"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    801,
    1401021,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[357]
  },
  {
    802,
    1401021,
    2,
    common[94],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[357]
  },
  {
    803,
    1401021,
    3,
    common[95],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[358]
  },
  {
    804,
    1401021,
    4,
    common[96],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[358]
  },
  {
    805,
    1401021,
    5,
    common[97],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[358]
  },
  {
    806,
    1401021,
    6,
    common[98],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[359]
  },
  {
    807,
    1401021,
    7,
    common[99],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[359]
  },
  {
    808,
    1401021,
    8,
    common[100],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[359]
  },
  {
    809,
    1401021,
    9,
    common[101],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[359]
  },
  {
    810,
    1401021,
    10,
    common[102],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410102,
        [1] = {
          value = 0.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101021,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4301021,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Exec",
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
    811,
    1500991,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[360]
  },
  {
    812,
    1500991,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[360]
  },
  {
    813,
    1500991,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[361]
  },
  {
    814,
    1500991,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[361]
  },
  {
    815,
    1500991,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[361]
  },
  {
    816,
    1500991,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[362]
  },
  {
    817,
    1500991,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[362]
  },
  {
    818,
    1500991,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[362]
  },
  {
    819,
    1500991,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[362]
  },
  {
    820,
    1500991,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410099,
        [1] = {
          value = 1100993,
          key = {
            LogicType = "Active",
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    821,
    1501001,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[363]
  },
  {
    822,
    1501001,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[363]
  },
  {
    823,
    1501001,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[364]
  },
  {
    824,
    1501001,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[364]
  },
  {
    825,
    1501001,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[364]
  },
  {
    826,
    1501001,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[365]
  },
  {
    827,
    1501001,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[365]
  },
  {
    828,
    1501001,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[365]
  },
  {
    829,
    1501001,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[365]
  },
  {
    830,
    1501001,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410100,
        [1] = {
          value = 41010014,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101003,
        [1] = {
          value = 41010014,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4301001,
        [1] = {
          value = 43010014,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 430100,
        [1] = {
          value = 43010014,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    831,
    1600931,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[366]
  },
  {
    832,
    1600931,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[366]
  },
  {
    833,
    1600931,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[367]
  },
  {
    834,
    1600931,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[367]
  },
  {
    835,
    1600931,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[367]
  },
  {
    836,
    1600931,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[368]
  },
  {
    837,
    1600931,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[368]
  },
  {
    838,
    1600931,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[368]
  },
  {
    839,
    1600931,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[368]
  },
  {
    840,
    1600931,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
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
          value = {1},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.3,
          key = {},
          type = 2
        },
        [4] = {
          value = 1,
          key = {},
          type = 2
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
          value = {1},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.3,
          key = {},
          type = 2
        },
        [4] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    841,
    1500981,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[369]
  },
  {
    842,
    1500981,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[369]
  },
  {
    843,
    1500981,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[370]
  },
  {
    844,
    1500981,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[370]
  },
  {
    845,
    1500981,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[370]
  },
  {
    846,
    1500981,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[371]
  },
  {
    847,
    1500981,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[371]
  },
  {
    848,
    1500981,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[371]
  },
  {
    849,
    1500981,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[371]
  },
  {
    850,
    1500981,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100981,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    851,
    1400621,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[372]
  },
  {
    852,
    1400621,
    2,
    common[103],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[372]
  },
  {
    853,
    1400621,
    3,
    common[104],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[373]
  },
  {
    854,
    1400621,
    4,
    common[105],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[373]
  },
  {
    855,
    1400621,
    5,
    common[106],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[373]
  },
  {
    856,
    1400621,
    6,
    common[107],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[374]
  },
  {
    857,
    1400621,
    7,
    common[108],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[374]
  },
  {
    858,
    1400621,
    8,
    common[109],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[374]
  },
  {
    859,
    1400621,
    9,
    common[110],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[374]
  },
  {
    860,
    1400621,
    10,
    common[111],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410062,
        [1] = {
          value = 0.6,
          key = {LogicType = "Active", param = "defPercent"},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100621,
        [1] = {
          value = 0.6,
          key = {LogicType = "Active", param = "defPercent"},
          type = 2
        },
        [2] = {
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 430062,
        [1] = {
          value = 0.3,
          key = {LogicType = "Active", param = "defPercent"},
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    861,
    1400951,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[375]
  },
  {
    862,
    1400951,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[375]
  },
  {
    863,
    1400951,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[376]
  },
  {
    864,
    1400951,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[376]
  },
  {
    865,
    1400951,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[376]
  },
  {
    866,
    1400951,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[377]
  },
  {
    867,
    1400951,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[377]
  },
  {
    868,
    1400951,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[377]
  },
  {
    869,
    1400951,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[377]
  },
  {
    870,
    1400951,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 14009511,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    871,
    1300941,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[378]
  },
  {
    872,
    1300941,
    2,
    common[103],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[378]
  },
  {
    873,
    1300941,
    3,
    common[104],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[379]
  },
  {
    874,
    1300941,
    4,
    common[105],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[379]
  },
  {
    875,
    1300941,
    5,
    common[106],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[379]
  },
  {
    876,
    1300941,
    6,
    common[107],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[380]
  },
  {
    877,
    1300941,
    7,
    common[108],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[380]
  },
  {
    878,
    1300941,
    8,
    common[109],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[380]
  },
  {
    879,
    1300941,
    9,
    common[110],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[380]
  },
  {
    880,
    1300941,
    10,
    common[111],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100941,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 410094,
        [1] = {
          value = -0.04,
          key = {LogicType = "Load", param = "mulValue"},
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    881,
    1600961,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[381]
  },
  {
    882,
    1600961,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[381]
  },
  {
    883,
    1600961,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[382]
  },
  {
    884,
    1600961,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[382]
  },
  {
    885,
    1600961,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[382]
  },
  {
    886,
    1600961,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[383]
  },
  {
    887,
    1600961,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[383]
  },
  {
    888,
    1600961,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[383]
  },
  {
    889,
    1600961,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[383]
  },
  {
    890,
    1600961,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100964,
        [1] = {
          value = 0.12,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4200964,
        [1] = {
          value = 0.12,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [3] = {
        BuffID = 4200961,
        [1] = {
          value = 0.12,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    891,
    1500971,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[384]
  },
  {
    892,
    1500971,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[384]
  },
  {
    893,
    1500971,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[385]
  },
  {
    894,
    1500971,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[385]
  },
  {
    895,
    1500971,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[385]
  },
  {
    896,
    1500971,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[386]
  },
  {
    897,
    1500971,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[386]
  },
  {
    898,
    1500971,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[386]
  },
  {
    899,
    1500971,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[386]
  },
  {
    900,
    1500971,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100971,
        [1] = {
          value = 0.6,
          key = {},
          type = 2
        },
        [2] = {
          value = -0.4,
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
    901,
    1500561,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[387]
  },
  {
    902,
    1500561,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[387]
  },
  {
    903,
    1500561,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[388]
  },
  {
    904,
    1500561,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[388]
  },
  {
    905,
    1500561,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[388]
  },
  {
    906,
    1500561,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[389]
  },
  {
    907,
    1500561,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[389]
  },
  {
    908,
    1500561,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[389]
  },
  {
    909,
    1500561,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[389]
  },
  {
    910,
    1500561,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410056,
        [1] = {
          value = 0.05,
          key = {LogicType = "Exec", param = "percent"},
          type = 2
        }
      }
    }
  },
  {
    911,
    1701071,
    1,
    common[1],
    25,
    5,
    50,
    0,
    0,
    0,
    0,
    0,
    0.03
  },
  {
    912,
    1701071,
    2,
    common[18],
    50,
    10,
    100,
    0,
    0,
    0,
    0,
    0,
    0.06
  },
  {
    913,
    1701071,
    3,
    common[19],
    75,
    15,
    150,
    0,
    0,
    0,
    0,
    0,
    0.09
  },
  {
    914,
    1701071,
    4,
    common[20],
    100,
    20,
    210,
    0,
    0,
    0,
    0,
    0,
    0.12
  },
  {
    915,
    1701071,
    5,
    common[20],
    130,
    30,
    270,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    916,
    1701071,
    6,
    common[21],
    160,
    40,
    350,
    0,
    0,
    0,
    0,
    0,
    0.18
  },
  {
    917,
    1701071,
    7,
    common[22],
    190,
    50,
    430,
    0,
    0,
    0,
    0,
    0,
    0.21
  },
  {
    918,
    1701071,
    8,
    common[23],
    220,
    60,
    530,
    0,
    0,
    0,
    0,
    0,
    0.24
  },
  {
    919,
    1701071,
    9,
    common[24],
    260,
    75,
    630,
    0,
    0,
    0,
    0,
    0,
    0.27
  },
  {
    920,
    1701071,
    10,
    common[25],
    300,
    90,
    780,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    921,
    1701081,
    1,
    common[1],
    25,
    5,
    50,
    0,
    0,
    0,
    0,
    0,
    0.03
  },
  {
    922,
    1701081,
    2,
    common[18],
    50,
    10,
    100,
    0,
    0,
    0,
    0,
    0,
    0.06
  },
  {
    923,
    1701081,
    3,
    common[19],
    75,
    15,
    150,
    0,
    0,
    0,
    0,
    0,
    0.09
  },
  {
    924,
    1701081,
    4,
    common[20],
    100,
    20,
    210,
    0,
    0,
    0,
    0,
    0,
    0.12
  },
  {
    925,
    1701081,
    5,
    common[20],
    130,
    30,
    270,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    926,
    1701081,
    6,
    common[21],
    160,
    40,
    350,
    0,
    0,
    0,
    0,
    0,
    0.18
  },
  {
    927,
    1701081,
    7,
    common[22],
    190,
    50,
    430,
    0,
    0,
    0,
    0,
    0,
    0.21
  },
  {
    928,
    1701081,
    8,
    common[23],
    220,
    60,
    530,
    0,
    0,
    0,
    0,
    0,
    0.24
  },
  {
    929,
    1701081,
    9,
    common[24],
    260,
    75,
    630,
    0,
    0,
    0,
    0,
    0,
    0.27
  },
  {
    930,
    1701081,
    10,
    common[25],
    300,
    90,
    780,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    931,
    1701091,
    1,
    common[1],
    25,
    5,
    50,
    0,
    0,
    0,
    0,
    0,
    0.03
  },
  {
    932,
    1701091,
    2,
    common[18],
    50,
    10,
    100,
    0,
    0,
    0,
    0,
    0,
    0.06
  },
  {
    933,
    1701091,
    3,
    common[19],
    75,
    15,
    150,
    0,
    0,
    0,
    0,
    0,
    0.09
  },
  {
    934,
    1701091,
    4,
    common[20],
    100,
    20,
    210,
    0,
    0,
    0,
    0,
    0,
    0.12
  },
  {
    935,
    1701091,
    5,
    common[20],
    130,
    30,
    270,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    936,
    1701091,
    6,
    common[21],
    160,
    40,
    350,
    0,
    0,
    0,
    0,
    0,
    0.18
  },
  {
    937,
    1701091,
    7,
    common[22],
    190,
    50,
    430,
    0,
    0,
    0,
    0,
    0,
    0.21
  },
  {
    938,
    1701091,
    8,
    common[23],
    220,
    60,
    530,
    0,
    0,
    0,
    0,
    0,
    0.24
  },
  {
    939,
    1701091,
    9,
    common[24],
    260,
    75,
    630,
    0,
    0,
    0,
    0,
    0,
    0.27
  },
  {
    940,
    1701091,
    10,
    common[25],
    300,
    90,
    780,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    941,
    1701101,
    1,
    common[1],
    25,
    5,
    50,
    0,
    0,
    0,
    0,
    0,
    0.03
  },
  {
    942,
    1701101,
    2,
    common[18],
    50,
    10,
    100,
    0,
    0,
    0,
    0,
    0,
    0.06
  },
  {
    943,
    1701101,
    3,
    common[19],
    75,
    15,
    150,
    0,
    0,
    0,
    0,
    0,
    0.09
  },
  {
    944,
    1701101,
    4,
    common[20],
    100,
    20,
    210,
    0,
    0,
    0,
    0,
    0,
    0.12
  },
  {
    945,
    1701101,
    5,
    common[20],
    130,
    30,
    270,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    946,
    1701101,
    6,
    common[21],
    160,
    40,
    350,
    0,
    0,
    0,
    0,
    0,
    0.18
  },
  {
    947,
    1701101,
    7,
    common[22],
    190,
    50,
    430,
    0,
    0,
    0,
    0,
    0,
    0.21
  },
  {
    948,
    1701101,
    8,
    common[23],
    220,
    60,
    530,
    0,
    0,
    0,
    0,
    0,
    0.24
  },
  {
    949,
    1701101,
    9,
    common[24],
    260,
    75,
    630,
    0,
    0,
    0,
    0,
    0,
    0.27
  },
  {
    950,
    1701101,
    10,
    common[25],
    300,
    90,
    780,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    951,
    1501041,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[390]
  },
  {
    952,
    1501041,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[390]
  },
  {
    953,
    1501041,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[391]
  },
  {
    954,
    1501041,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[391]
  },
  {
    955,
    1501041,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[391]
  },
  {
    956,
    1501041,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[392]
  },
  {
    957,
    1501041,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[392]
  },
  {
    958,
    1501041,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[392]
  },
  {
    959,
    1501041,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[392]
  },
  {
    960,
    1501041,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101041,
        [1] = {
          value = {
            1,
            0.1,
            9999999
          },
          key = {
            LogicType = "Exec",
            param = "vampire",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101042,
        [1] = {
          value = {
            1,
            0.1,
            9999999
          },
          key = {
            LogicType = "Exec",
            param = "vampire",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    961,
    1601051,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[393]
  },
  {
    962,
    1601051,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[393]
  },
  {
    963,
    1601051,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[394]
  },
  {
    964,
    1601051,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[394]
  },
  {
    965,
    1601051,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[394]
  },
  {
    966,
    1601051,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[395]
  },
  {
    967,
    1601051,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[395]
  },
  {
    968,
    1601051,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[395]
  },
  {
    969,
    1601051,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[395]
  },
  {
    970,
    1601051,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101051,
        [1] = {
          value = 4101054,
          key = {LogicType = "Exec", param = "skillID"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4201051,
        [1] = {
          value = 4101054,
          key = {LogicType = "Exec", param = "skillID"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4301051,
        [1] = {
          value = 4301054,
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
    }
  },
  {
    971,
    1500711,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[396]
  },
  {
    972,
    1500711,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[396]
  },
  {
    973,
    1500711,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[397]
  },
  {
    974,
    1500711,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[397]
  },
  {
    975,
    1500711,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[397]
  },
  {
    976,
    1500711,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[398]
  },
  {
    977,
    1500711,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[398]
  },
  {
    978,
    1500711,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[398]
  },
  {
    979,
    1500711,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[398]
  },
  {
    980,
    1500711,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 41007112,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    981,
    1400671,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[399]
  },
  {
    982,
    1400671,
    2,
    common[103],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[399]
  },
  {
    983,
    1400671,
    3,
    common[104],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[400]
  },
  {
    984,
    1400671,
    4,
    common[105],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[400]
  },
  {
    985,
    1400671,
    5,
    common[106],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[400]
  },
  {
    986,
    1400671,
    6,
    common[107],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[401]
  },
  {
    987,
    1400671,
    7,
    common[108],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[401]
  },
  {
    988,
    1400671,
    8,
    common[109],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[401]
  },
  {
    989,
    1400671,
    9,
    common[110],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[401]
  },
  {
    990,
    1400671,
    10,
    common[111],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410067,
        [1] = {
          value = 0.25,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "mulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 430067,
        [1] = {
          value = 0.5,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "mulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    991,
    1601111,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[402]
  },
  {
    992,
    1601111,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[402]
  },
  {
    993,
    1601111,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[403]
  },
  {
    994,
    1601111,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[403]
  },
  {
    995,
    1601111,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[403]
  },
  {
    996,
    1601111,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[404]
  },
  {
    997,
    1601111,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[404]
  },
  {
    998,
    1601111,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[404]
  },
  {
    999,
    1601111,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[404]
  },
  {
    1000,
    1601111,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101112,
        [1] = {
          value = 160111110,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "trapID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.8,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 430111,
        [1] = {
          value = 160111110,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "trapID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.8,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4161111,
        [1] = {
          value = 160111110,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "trapID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.8,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 436111,
        [1] = {
          value = 160111110,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "trapID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.8,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1001,
    1601121,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[405]
  },
  {
    1002,
    1601121,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[405]
  },
  {
    1003,
    1601121,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[406]
  },
  {
    1004,
    1601121,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[406]
  },
  {
    1005,
    1601121,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[406]
  },
  {
    1006,
    1601121,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[407]
  },
  {
    1007,
    1601121,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[407]
  },
  {
    1008,
    1601121,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[407]
  },
  {
    1009,
    1601121,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[407]
  },
  {
    1010,
    1601121,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4201122,
        [1] = {
          value = 4201124,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4301121,
        [1] = {
          value = 4201124,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 3
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4221122,
        [1] = {
          value = 4201124,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 2
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 4321121,
        [1] = {
          value = 4201124,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 4
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1011,
    1501131,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    {
      [1] = {
        BuffID = 410113,
        [1] = {
          value = 0.6,
          key = {LogicType = "Load", param = "mulValue"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4101131,
        [1] = {
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4201131,
        [1] = {
          value = 0.6,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1012,
    1501131,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    {
      [1] = {
        BuffID = 410113,
        [1] = {
          value = 0.6,
          key = {LogicType = "Load", param = "mulValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101131,
        [1] = {
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4201131,
        [1] = {
          value = 0.6,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1013,
    1501131,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[408]
  },
  {
    1014,
    1501131,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[408]
  },
  {
    1015,
    1501131,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[408]
  },
  {
    1016,
    1501131,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[409]
  },
  {
    1017,
    1501131,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[409]
  },
  {
    1018,
    1501131,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[409]
  },
  {
    1019,
    1501131,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[409]
  },
  {
    1020,
    1501131,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410113,
        [1] = {
          value = 1.2,
          key = {LogicType = "Load", param = "mulValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101131,
        [1] = {
          value = 1.2,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4201131,
        [1] = {
          value = 1.2,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1021,
    1501141,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[410]
  },
  {
    1022,
    1501141,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[410]
  },
  {
    1023,
    1501141,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[411]
  },
  {
    1024,
    1501141,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[411]
  },
  {
    1025,
    1501141,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[411]
  },
  {
    1026,
    1501141,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[412]
  },
  {
    1027,
    1501141,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[412]
  },
  {
    1028,
    1501141,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[412]
  },
  {
    1029,
    1501141,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[412]
  },
  {
    1030,
    1501141,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410114,
        [1] = {
          value = {
            0,
            0.18,
            9999999
          },
          key = {LogicType = "Exec", param = "vampire"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.18,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1031,
    1601151,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[413]
  },
  {
    1032,
    1601151,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[413]
  },
  {
    1033,
    1601151,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[414]
  },
  {
    1034,
    1601151,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[414]
  },
  {
    1035,
    1601151,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[414]
  },
  {
    1036,
    1601151,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[415]
  },
  {
    1037,
    1601151,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[415]
  },
  {
    1038,
    1601151,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[415]
  },
  {
    1039,
    1601151,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[415]
  },
  {
    1040,
    1601151,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 400115,
        [1] = {
          value = 0.01,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4301153,
        [1] = {
          value = 4301154,
          key = {LogicType = "Load", param = "skillID"},
          type = 2
        }
      }
    }
  },
  {
    1041,
    1601161,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[416]
  },
  {
    1042,
    1601161,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[416]
  },
  {
    1043,
    1601161,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[417]
  },
  {
    1044,
    1601161,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[417]
  },
  {
    1045,
    1601161,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[417]
  },
  {
    1046,
    1601161,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[418]
  },
  {
    1047,
    1601161,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[418]
  },
  {
    1048,
    1601161,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[418]
  },
  {
    1049,
    1601161,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[418]
  },
  {
    1050,
    1601161,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410116,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            param = "changeValue",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 43011621,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            param = "oneLayerValue",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4001162,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            param = "oneLayerValue",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1051,
    1401271,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[419]
  },
  {
    1052,
    1401271,
    2,
    common[112],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[419]
  },
  {
    1053,
    1401271,
    3,
    common[113],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[420]
  },
  {
    1054,
    1401271,
    4,
    common[114],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[420]
  },
  {
    1055,
    1401271,
    5,
    common[115],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[420]
  },
  {
    1056,
    1401271,
    6,
    common[116],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[421]
  },
  {
    1057,
    1401271,
    7,
    common[117],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[421]
  },
  {
    1058,
    1401271,
    8,
    common[118],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[421]
  },
  {
    1059,
    1401271,
    9,
    common[119],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[421]
  },
  {
    1060,
    1401271,
    10,
    common[120],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410127,
        [1] = {
          value = 4101274,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 430127,
        [1] = {
          value = 4101274,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1061,
    1601171,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[422]
  },
  {
    1062,
    1601171,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[422]
  },
  {
    1063,
    1601171,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[423]
  },
  {
    1064,
    1601171,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[423]
  },
  {
    1065,
    1601171,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[423]
  },
  {
    1066,
    1601171,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[424]
  },
  {
    1067,
    1601171,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[424]
  },
  {
    1068,
    1601171,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[424]
  },
  {
    1069,
    1601171,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[424]
  },
  {
    1070,
    1601171,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 400117,
        [1] = {
          value = 0.005,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4301172,
        [1] = {
          value = 0.005,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1071,
    1601191,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[425]
  },
  {
    1072,
    1601191,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[425]
  },
  {
    1073,
    1601191,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[426]
  },
  {
    1074,
    1601191,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[426]
  },
  {
    1075,
    1601191,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[426]
  },
  {
    1076,
    1601191,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[427]
  },
  {
    1077,
    1601191,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[427]
  },
  {
    1078,
    1601191,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[427]
  },
  {
    1079,
    1601191,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[427]
  },
  {
    1080,
    1601191,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101192,
        [1] = {
          value = 0.006,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1081,
    1601221,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[428]
  },
  {
    1082,
    1601221,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[428]
  },
  {
    1083,
    1601221,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[429]
  },
  {
    1084,
    1601221,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[429]
  },
  {
    1085,
    1601221,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[429]
  },
  {
    1086,
    1601221,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[430]
  },
  {
    1087,
    1601221,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[430]
  },
  {
    1088,
    1601221,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[430]
  },
  {
    1089,
    1601221,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[430]
  },
  {
    1090,
    1601221,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101221,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Exec",
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1091,
    1601211,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[431]
  },
  {
    1092,
    1601211,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[431]
  },
  {
    1093,
    1601211,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[432]
  },
  {
    1094,
    1601211,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[432]
  },
  {
    1095,
    1601211,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[432]
  },
  {
    1096,
    1601211,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[433]
  },
  {
    1097,
    1601211,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[433]
  },
  {
    1098,
    1601211,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[433]
  },
  {
    1099,
    1601211,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[433]
  },
  {
    1100,
    1601211,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101212,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 430121,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1101,
    1300651,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[434]
  },
  {
    1102,
    1300651,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[434]
  },
  {
    1103,
    1300651,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[435]
  },
  {
    1104,
    1300651,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[435]
  },
  {
    1105,
    1300651,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[435]
  },
  {
    1106,
    1300651,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[436]
  },
  {
    1107,
    1300651,
    7,
    common[31],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[436]
  },
  {
    1108,
    1300651,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[436]
  },
  {
    1109,
    1300651,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[436]
  },
  {
    1110,
    1300651,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4100653,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1111,
    1601261,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[437]
  },
  {
    1112,
    1601261,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[437]
  },
  {
    1113,
    1601261,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[438]
  },
  {
    1114,
    1601261,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[438]
  },
  {
    1115,
    1601261,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[438]
  },
  {
    1116,
    1601261,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[439]
  },
  {
    1117,
    1601261,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[439]
  },
  {
    1118,
    1601261,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[439]
  },
  {
    1119,
    1601261,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[439]
  },
  {
    1120,
    1601261,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101266,
        [1] = {
          value = 4101265,
          key = {LogicType = "Load", param = "buffID"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1121,
    1500551,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[440]
  },
  {
    1122,
    1500551,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[440]
  },
  {
    1123,
    1500551,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[441]
  },
  {
    1124,
    1500551,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[441]
  },
  {
    1125,
    1500551,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[441]
  },
  {
    1126,
    1500551,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[442]
  },
  {
    1127,
    1500551,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[442]
  },
  {
    1128,
    1500551,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[442]
  },
  {
    1129,
    1500551,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[442]
  },
  {
    1130,
    1500551,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4105513,
        [1] = {
          value = 0.025,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4205511,
        [1] = {
          value = 0.025,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1131,
    1500151,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[443]
  },
  {
    1132,
    1500151,
    2,
    common[94],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[443]
  },
  {
    1133,
    1500151,
    3,
    common[95],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[444]
  },
  {
    1134,
    1500151,
    4,
    common[96],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[444]
  },
  {
    1135,
    1500151,
    5,
    common[97],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[444]
  },
  {
    1136,
    1500151,
    6,
    common[98],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[445]
  },
  {
    1137,
    1500151,
    7,
    common[99],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[445]
  },
  {
    1138,
    1500151,
    8,
    common[100],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[445]
  },
  {
    1139,
    1500151,
    9,
    common[101],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[445]
  },
  {
    1140,
    1500151,
    10,
    common[102],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410015,
        [1] = {
          value = 0.15,
          key = {
            LogicType = "Load",
            param = "distanceDamageParam",
            LogicIndex = 1
          },
          type = 2
        },
        [2] = {
          value = 0.075,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4100151,
        [1] = {
          value = 0.075,
          key = {
            LogicType = "Load",
            param = "changeValue",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1141,
    1601231,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[446]
  },
  {
    1142,
    1601231,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[446]
  },
  {
    1143,
    1601231,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[447]
  },
  {
    1144,
    1601231,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[447]
  },
  {
    1145,
    1601231,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[447]
  },
  {
    1146,
    1601231,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[448]
  },
  {
    1147,
    1601231,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[448]
  },
  {
    1148,
    1601231,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[448]
  },
  {
    1149,
    1601231,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[448]
  },
  {
    1150,
    1601231,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410123,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 430123,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Active",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [3] = {
        BuffID = 4301231,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            LogicIndex = 3,
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1151,
    1601291,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[449]
  },
  {
    1152,
    1601291,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[449]
  },
  {
    1153,
    1601291,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[450]
  },
  {
    1154,
    1601291,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[450]
  },
  {
    1155,
    1601291,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[450]
  },
  {
    1156,
    1601291,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[451]
  },
  {
    1157,
    1601291,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[451]
  },
  {
    1158,
    1601291,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[451]
  },
  {
    1159,
    1601291,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[451]
  },
  {
    1160,
    1601291,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 460129111,
        [1] = {
          value = 0.12,
          key = {LogicType = "Exec", param = "percent"},
          type = 2
        }
      },
      [2] = {
        BuffID = 460129131,
        [1] = {
          value = 0.12,
          key = {LogicType = "Exec", param = "percent"},
          type = 2
        }
      },
      [3] = {
        BuffID = 460129110,
        [1] = {
          value = 0.12,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.18,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 460129130,
        [1] = {
          value = 0.12,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.18,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1161,
    1601201,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[452]
  },
  {
    1162,
    1601201,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[452]
  },
  {
    1163,
    1601201,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[453]
  },
  {
    1164,
    1601201,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[453]
  },
  {
    1165,
    1601201,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[453]
  },
  {
    1166,
    1601201,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[454]
  },
  {
    1167,
    1601201,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[454]
  },
  {
    1168,
    1601201,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[454]
  },
  {
    1169,
    1601201,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[454]
  },
  {
    1170,
    1601201,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101201,
        [1] = {
          value = 0.2,
          key = {LogicType = "Active", param = "mulValue"},
          type = 3
        }
      }
    }
  },
  {
    1171,
    1601311,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[455]
  },
  {
    1172,
    1601311,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[455]
  },
  {
    1173,
    1601311,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[456]
  },
  {
    1174,
    1601311,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[456]
  },
  {
    1175,
    1601311,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[456]
  },
  {
    1176,
    1601311,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[457]
  },
  {
    1177,
    1601311,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[457]
  },
  {
    1178,
    1601311,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[457]
  },
  {
    1179,
    1601311,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[457]
  },
  {
    1180,
    1601311,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101311,
        [1] = {
          value = 0.25,
          key = {
            LogicType = "Load",
            param = "AttributePer",
            LogicIndex = 1
          },
          type = 2
        }
      }
    }
  },
  {
    1181,
    1501321,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[458]
  },
  {
    1182,
    1501321,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[458]
  },
  {
    1183,
    1501321,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[459]
  },
  {
    1184,
    1501321,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[459]
  },
  {
    1185,
    1501321,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[459]
  },
  {
    1186,
    1501321,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[460]
  },
  {
    1187,
    1501321,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[460]
  },
  {
    1188,
    1501321,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[460]
  },
  {
    1189,
    1501321,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[460]
  },
  {
    1190,
    1501321,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410132,
        [1] = {
          value = 0.25,
          key = {LogicType = "Active", param = "mulValue"},
          type = 2
        }
      }
    }
  },
  {
    1191,
    1601331,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[461]
  },
  {
    1192,
    1601331,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[461]
  },
  {
    1193,
    1601331,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[462]
  },
  {
    1194,
    1601331,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[462]
  },
  {
    1195,
    1601331,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[462]
  },
  {
    1196,
    1601331,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[463]
  },
  {
    1197,
    1601331,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[463]
  },
  {
    1198,
    1601331,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[463]
  },
  {
    1199,
    1601331,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[463]
  },
  {
    1200,
    1601331,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410133,
        [1] = {
          value = 0.015,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "percentAdd"
          },
          type = 2
        },
        [2] = {
          value = 0.0075,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 430133,
        [1] = {
          value = 0.0075,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "splashRate"
          },
          type = 2
        }
      }
    }
  },
  {
    1201,
    1601341,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[464]
  },
  {
    1202,
    1601341,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[464]
  },
  {
    1203,
    1601341,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[465]
  },
  {
    1204,
    1601341,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[465]
  },
  {
    1205,
    1601341,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[465]
  },
  {
    1206,
    1601341,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[466]
  },
  {
    1207,
    1601341,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[466]
  },
  {
    1208,
    1601341,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[466]
  },
  {
    1209,
    1601341,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[466]
  },
  {
    1210,
    1601341,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101344,
        [1] = {
          value = 0.03,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1211,
    1501351,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[467]
  },
  {
    1212,
    1501351,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[467]
  },
  {
    1213,
    1501351,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[468]
  },
  {
    1214,
    1501351,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[468]
  },
  {
    1215,
    1501351,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[468]
  },
  {
    1216,
    1501351,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[469]
  },
  {
    1217,
    1501351,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[469]
  },
  {
    1218,
    1501351,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[469]
  },
  {
    1219,
    1501351,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[469]
  },
  {
    1220,
    1501351,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410135,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Active",
            param = "changeValue",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.2,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 430135,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Active",
            param = "changeValue",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.2,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1221,
    1501361,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[470]
  },
  {
    1222,
    1501361,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[470]
  },
  {
    1223,
    1501361,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[471]
  },
  {
    1224,
    1501361,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[471]
  },
  {
    1225,
    1501361,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[471]
  },
  {
    1226,
    1501361,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[472]
  },
  {
    1227,
    1501361,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[472]
  },
  {
    1228,
    1501361,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[472]
  },
  {
    1229,
    1501361,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[472]
  },
  {
    1230,
    1501361,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4001361,
        [1] = {
          value = 0.07,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4101362,
        [1] = {
          value = 0.07,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1231,
    1401371,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[473]
  },
  {
    1232,
    1401371,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[473]
  },
  {
    1233,
    1401371,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[474]
  },
  {
    1234,
    1401371,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[474]
  },
  {
    1235,
    1401371,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[474]
  },
  {
    1236,
    1401371,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[475]
  },
  {
    1237,
    1401371,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[475]
  },
  {
    1238,
    1401371,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[475]
  },
  {
    1239,
    1401371,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[475]
  },
  {
    1240,
    1401371,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410137,
        [1] = {
          value = 0.666,
          key = {LogicType = "Load", param = "percent"},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101371,
        [1] = {
          value = 0.666,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1241,
    1601381,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[476]
  },
  {
    1242,
    1601381,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[476]
  },
  {
    1243,
    1601381,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[477]
  },
  {
    1244,
    1601381,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[477]
  },
  {
    1245,
    1601381,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[477]
  },
  {
    1246,
    1601381,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[478]
  },
  {
    1247,
    1601381,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[478]
  },
  {
    1248,
    1601381,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[478]
  },
  {
    1249,
    1601381,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[478]
  },
  {
    1250,
    1601381,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101383,
        [1] = {
          value = 0.15,
          key = {
            LogicType = "Exec",
            param = "shieldPercent"
          },
          type = 2
        }
      }
    }
  },
  {
    1251,
    1501391,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[479]
  },
  {
    1252,
    1501391,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[479]
  },
  {
    1253,
    1501391,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[480]
  },
  {
    1254,
    1501391,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[480]
  },
  {
    1255,
    1501391,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[480]
  },
  {
    1256,
    1501391,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[481]
  },
  {
    1257,
    1501391,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[481]
  },
  {
    1258,
    1501391,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[481]
  },
  {
    1259,
    1501391,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[481]
  },
  {
    1260,
    1501391,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101391,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.02,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 410139,
        [1] = {
          value = {
            0,
            0.04,
            0.08,
            0.12,
            0.16,
            0.2,
            0.24,
            0.28
          },
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "ratesByDis"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 430139,
        [1] = {
          value = {
            0,
            0.02,
            0.04,
            0.06,
            0.08,
            0.1,
            0.12,
            0.14
          },
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "ratesByDis"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1261,
    1601401,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[482]
  },
  {
    1262,
    1601401,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[482]
  },
  {
    1263,
    1601401,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[483]
  },
  {
    1264,
    1601401,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[483]
  },
  {
    1265,
    1601401,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[483]
  },
  {
    1266,
    1601401,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[484]
  },
  {
    1267,
    1601401,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[484]
  },
  {
    1268,
    1601401,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[484]
  },
  {
    1269,
    1601401,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[484]
  },
  {
    1270,
    1601401,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410140,
        [1] = {
          value = 4131401,
          key = {
            LogicType = "Load",
            param = "buffID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 4131402,
          key = {
            LogicType = "Load",
            param = "buffID",
            LogicIndex = 2
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 4131403,
          key = {
            LogicType = "Load",
            param = "buffID",
            LogicIndex = 3
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 410140,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.07,
          key = {},
          type = 2
        },
        [3] = {
          value = 0.1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1271,
    1601411,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[485]
  },
  {
    1272,
    1601411,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[485]
  },
  {
    1273,
    1601411,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[486]
  },
  {
    1274,
    1601411,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[486]
  },
  {
    1275,
    1601411,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[486]
  },
  {
    1276,
    1601411,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[487]
  },
  {
    1277,
    1601411,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[487]
  },
  {
    1278,
    1601411,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[487]
  },
  {
    1279,
    1601411,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[487]
  },
  {
    1280,
    1601411,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101413,
        [1] = {
          value = 41014114,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.03,
          key = {},
          type = 2
        },
        [3] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4201412,
        [1] = {
          value = 41014114,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.03,
          key = {},
          type = 2
        },
        [3] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4301411,
        [1] = {
          value = 43014114,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.03,
          key = {},
          type = 2
        },
        [3] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 4301413,
        [1] = {
          value = 43014114,
          key = {
            LogicType = "Exec",
            param = "skillID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.03,
          key = {},
          type = 2
        },
        [3] = {
          value = 1.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1281,
    1501421,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[488]
  },
  {
    1282,
    1501421,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[488]
  },
  {
    1283,
    1501421,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[489]
  },
  {
    1284,
    1501421,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[489]
  },
  {
    1285,
    1501421,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[489]
  },
  {
    1286,
    1501421,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[490]
  },
  {
    1287,
    1501421,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[490]
  },
  {
    1288,
    1501421,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[490]
  },
  {
    1289,
    1501421,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[490]
  },
  {
    1290,
    1501421,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101421,
        [1] = {
          value = {
            0.53,
            0.477,
            0.424,
            0.371,
            0.318,
            0.265,
            0.212,
            0.159,
            0.106,
            0.053,
            0
          },
          key = {LogicType = "Active", param = "promote"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 0.53,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4201421,
        [1] = {
          value = {
            0.53,
            0.477,
            0.424,
            0.371,
            0.318,
            0.265,
            0.212,
            0.159,
            0.106,
            0.053,
            0
          },
          key = {LogicType = "Active", param = "promote"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 0.53,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1291,
    1601431,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[491]
  },
  {
    1292,
    1601431,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[491]
  },
  {
    1293,
    1601431,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[492]
  },
  {
    1294,
    1601431,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[492]
  },
  {
    1295,
    1601431,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[492]
  },
  {
    1296,
    1601431,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[493]
  },
  {
    1297,
    1601431,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[493]
  },
  {
    1298,
    1601431,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[493]
  },
  {
    1299,
    1601431,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[493]
  },
  {
    1300,
    1601431,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101431,
        [1] = {
          value = 2,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4201431,
        [1] = {
          value = 2,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4101432,
        [1] = {
          value = 40014314,
          key = {LogicType = "Exec", param = "skillID"},
          isShow = false,
          type = 2
        }
      },
      [4] = {
        BuffID = 4201433,
        [1] = {
          value = 40014314,
          key = {LogicType = "Exec", param = "skillID"},
          isShow = false,
          type = 2
        }
      }
    }
  },
  {
    1301,
    1501441,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[494]
  },
  {
    1302,
    1501441,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[494]
  },
  {
    1303,
    1501441,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[495]
  },
  {
    1304,
    1501441,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[495]
  },
  {
    1305,
    1501441,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[495]
  },
  {
    1306,
    1501441,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[496]
  },
  {
    1307,
    1501441,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[496]
  },
  {
    1308,
    1501441,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[496]
  },
  {
    1309,
    1501441,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[496]
  },
  {
    1310,
    1501441,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101443,
        [1] = {
          value = 0.04,
          key = {
            LogicType = "Active",
            param = "mul",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4101441,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 420144,
        [1] = {
          value = 4201444,
          key = {
            LogicType = "Exec",
            param = "buffID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 430144,
        [1] = {
          value = 4301444,
          key = {
            LogicType = "Exec",
            param = "buffID",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1311,
    1601451,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[497]
  },
  {
    1312,
    1601451,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[497]
  },
  {
    1313,
    1601451,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[498]
  },
  {
    1314,
    1601451,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[498]
  },
  {
    1315,
    1601451,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[498]
  },
  {
    1316,
    1601451,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[499]
  },
  {
    1317,
    1601451,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[499]
  },
  {
    1318,
    1601451,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[499]
  },
  {
    1319,
    1601451,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[499]
  },
  {
    1320,
    1601451,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101451,
        [1] = {
          value = {3101454},
          key = {LogicType = "Load", param = "skillList"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4131451,
        [1] = {
          value = {3131454},
          key = {LogicType = "Load", param = "skillList"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4201451,
        [1] = {
          value = {3201454},
          key = {LogicType = "Load", param = "skillList"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 4231451,
        [1] = {
          value = {3231454},
          key = {LogicType = "Load", param = "skillList"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [5] = {
        BuffID = 4301451,
        [1] = {
          value = {3301454},
          key = {LogicType = "Load", param = "skillList"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [6] = {
        BuffID = 4331451,
        [1] = {
          value = {3331454},
          key = {LogicType = "Load", param = "skillList"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1321,
    1601461,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[500]
  },
  {
    1322,
    1601461,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[500]
  },
  {
    1323,
    1601461,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[501]
  },
  {
    1324,
    1601461,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[501]
  },
  {
    1325,
    1601461,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[501]
  },
  {
    1326,
    1601461,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[502]
  },
  {
    1327,
    1601461,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[502]
  },
  {
    1328,
    1601461,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[502]
  },
  {
    1329,
    1601461,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[502]
  },
  {
    1330,
    1601461,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4001463,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Load",
            param = "oneLayerAddMulValue"
          },
          type = 2
        },
        [2] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4001461,
        [1] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1331,
    1501471,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[503]
  },
  {
    1332,
    1501471,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[503]
  },
  {
    1333,
    1501471,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[504]
  },
  {
    1334,
    1501471,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[504]
  },
  {
    1335,
    1501471,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[504]
  },
  {
    1336,
    1501471,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[505]
  },
  {
    1337,
    1501471,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[505]
  },
  {
    1338,
    1501471,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[505]
  },
  {
    1339,
    1501471,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[505]
  },
  {
    1340,
    1501471,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101473,
        [1] = {
          value = 0.5,
          key = {},
          type = 2
        },
        [2] = {
          value = {
            {4101474, 50},
            {4101475, 50}
          },
          key = {
            LogicType = "Exec",
            param = "randomBuffIDs",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4301471,
        [1] = {
          value = 0.5,
          key = {},
          type = 2
        },
        [2] = {
          value = {
            {4001471, 17},
            {4001472, 17},
            {4001473, 16},
            {4301474, 50}
          },
          key = {
            LogicType = "Exec",
            param = "randomBuffIDs",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4301475,
        [1] = {
          value = {
            {4001471, 17},
            {4001472, 17},
            {4001473, 16},
            {4301474, 50}
          },
          key = {
            LogicType = "Load",
            param = "randomBuffIDs",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1341,
    1201631,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03
  },
  {
    1342,
    1201631,
    2,
    common[94],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    1343,
    1201631,
    3,
    common[95],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07
  },
  {
    1344,
    1201631,
    4,
    common[96],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    1345,
    1201631,
    5,
    common[97],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    1346,
    1201631,
    6,
    common[98],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15
  },
  {
    1347,
    1201631,
    7,
    common[99],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    1348,
    1201631,
    8,
    common[100],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    1349,
    1201631,
    9,
    common[101],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    1350,
    1201631,
    10,
    common[102],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3
  },
  {
    1351,
    1601481,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[506]
  },
  {
    1352,
    1601481,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[506]
  },
  {
    1353,
    1601481,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[507]
  },
  {
    1354,
    1601481,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[507]
  },
  {
    1355,
    1601481,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[507]
  },
  {
    1356,
    1601481,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[508]
  },
  {
    1357,
    1601481,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[508]
  },
  {
    1358,
    1601481,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[508]
  },
  {
    1359,
    1601481,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[508]
  },
  {
    1360,
    1601481,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101481,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Load",
            param = "mulValue",
            LogicIndex = 1
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 410148,
        [1] = {
          value = 0.2,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1361,
    1501491,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[509]
  },
  {
    1362,
    1501491,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[509]
  },
  {
    1363,
    1501491,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[510]
  },
  {
    1364,
    1501491,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[510]
  },
  {
    1365,
    1501491,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[510]
  },
  {
    1366,
    1501491,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[511]
  },
  {
    1367,
    1501491,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[511]
  },
  {
    1368,
    1501491,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[511]
  },
  {
    1369,
    1501491,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[511]
  },
  {
    1370,
    1501491,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410149,
        [1] = {
          value = {
            [2001491] = 20014914,
            [2001492] = 20014924,
            [2001493] = 20014934
          },
          key = {LogicType = "Load", param = "param"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 0.4,
          key = {},
          type = 2
        },
        [3] = {
          value = 0.1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1371,
    1601501,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[512]
  },
  {
    1372,
    1601501,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[512]
  },
  {
    1373,
    1601501,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[513]
  },
  {
    1374,
    1601501,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[513]
  },
  {
    1375,
    1601501,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[513]
  },
  {
    1376,
    1601501,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[514]
  },
  {
    1377,
    1601501,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[514]
  },
  {
    1378,
    1601501,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[514]
  },
  {
    1379,
    1601501,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[514]
  },
  {
    1380,
    1601501,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101502,
        [1] = {
          value = -0.091,
          key = {LogicType = "Load", param = "mulValue"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 9,
          key = {LogicType = "Load", param = "maxValue"},
          isShow = false,
          type = 2
        },
        [3] = {
          value = 42015011,
          key = {
            LogicType = "Load",
            param = "skillID",
            LogicIndex = 2
          },
          isShow = false,
          type = 2
        }
      },
      [2] = {
        BuffID = 4101501,
        [1] = {
          value = 0.01,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.1,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1381,
    1601511,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[515]
  },
  {
    1382,
    1601511,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[515]
  },
  {
    1383,
    1601511,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[516]
  },
  {
    1384,
    1601511,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[516]
  },
  {
    1385,
    1601511,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[516]
  },
  {
    1386,
    1601511,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[517]
  },
  {
    1387,
    1601511,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[517]
  },
  {
    1388,
    1601511,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[517]
  },
  {
    1389,
    1601511,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[517]
  },
  {
    1390,
    1601511,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101512,
        [1] = {
          value = -0.004,
          key = {LogicType = "Active", param = "mulValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 410151,
        [1] = {
          value = 0.4,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1391,
    1501521,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[518]
  },
  {
    1392,
    1501521,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[518]
  },
  {
    1393,
    1501521,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[519]
  },
  {
    1394,
    1501521,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[519]
  },
  {
    1395,
    1501521,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[519]
  },
  {
    1396,
    1501521,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[520]
  },
  {
    1397,
    1501521,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[520]
  },
  {
    1398,
    1501521,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[520]
  },
  {
    1399,
    1501521,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[520]
  },
  {
    1400,
    1501521,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410152,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.04,
          key = {
            LogicType = "Exec",
            param = "reduceRatePerSan"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 420152,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.04,
          key = {
            LogicType = "Exec",
            param = "reduceRatePerSan"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 430152,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.04,
          key = {
            LogicType = "Exec",
            param = "reduceRatePerSan"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1401,
    1601551,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[521]
  },
  {
    1402,
    1601551,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[521]
  },
  {
    1403,
    1601551,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[522]
  },
  {
    1404,
    1601551,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[522]
  },
  {
    1405,
    1601551,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[522]
  },
  {
    1406,
    1601551,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[523]
  },
  {
    1407,
    1601551,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[523]
  },
  {
    1408,
    1601551,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[523]
  },
  {
    1409,
    1601551,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[523]
  },
  {
    1410,
    1601551,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 41001550,
        [1] = {
          value = -0.4,
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
          value = 0.6,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 41001551,
        [1] = {
          value = {
            percent = {0.6}
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
    1411,
    1601541,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[524]
  },
  {
    1412,
    1601541,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[524]
  },
  {
    1413,
    1601541,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[525]
  },
  {
    1414,
    1601541,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[525]
  },
  {
    1415,
    1601541,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[525]
  },
  {
    1416,
    1601541,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[526]
  },
  {
    1417,
    1601541,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[526]
  },
  {
    1418,
    1601541,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[526]
  },
  {
    1419,
    1601541,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[526]
  },
  {
    1420,
    1601541,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101541,
        [1] = {
          value = 0.02,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1421,
    1601531,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[527]
  },
  {
    1422,
    1601531,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[527]
  },
  {
    1423,
    1601531,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[528]
  },
  {
    1424,
    1601531,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[528]
  },
  {
    1425,
    1601531,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[528]
  },
  {
    1426,
    1601531,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[529]
  },
  {
    1427,
    1601531,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[529]
  },
  {
    1428,
    1601531,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[529]
  },
  {
    1429,
    1601531,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[529]
  },
  {
    1430,
    1601531,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
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
      }
    }
  },
  {
    1431,
    1501301,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03
  },
  {
    1432,
    1501301,
    2,
    common[85],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    1433,
    1501301,
    3,
    common[86],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07
  },
  {
    1434,
    1501301,
    4,
    common[87],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    1435,
    1501301,
    5,
    common[88],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    1436,
    1501301,
    6,
    common[89],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15
  },
  {
    1437,
    1501301,
    7,
    common[90],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    1438,
    1501301,
    8,
    common[91],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    1439,
    1501301,
    9,
    common[92],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    1440,
    1501301,
    10,
    common[93],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3
  },
  {
    1441,
    1601561,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[530]
  },
  {
    1442,
    1601561,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[530]
  },
  {
    1443,
    1601561,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[531]
  },
  {
    1444,
    1601561,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[531]
  },
  {
    1445,
    1601561,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[531]
  },
  {
    1446,
    1601561,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[532]
  },
  {
    1447,
    1601561,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[532]
  },
  {
    1448,
    1601561,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[532]
  },
  {
    1449,
    1601561,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[532]
  },
  {
    1450,
    1601561,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410156,
        [1] = {
          value = 3101564,
          key = {LogicType = "Load", param = "skillID"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 403156,
        [1] = {
          value = 3031564,
          key = {LogicType = "Load", param = "skillID"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 400156,
        [1] = {
          value = 2,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1451,
    1501571,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[533]
  },
  {
    1452,
    1501571,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[533]
  },
  {
    1453,
    1501571,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[534]
  },
  {
    1454,
    1501571,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[534]
  },
  {
    1455,
    1501571,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[534]
  },
  {
    1456,
    1501571,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[535]
  },
  {
    1457,
    1501571,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[535]
  },
  {
    1458,
    1501571,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[535]
  },
  {
    1459,
    1501571,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[535]
  },
  {
    1460,
    1501571,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101574,
        [1] = {
          value = 0.0286,
          key = {
            LogicType = "Load",
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4101572,
        [1] = {
          value = 0.0286,
          key = {
            LogicType = "Exec",
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4101573,
        [1] = {
          value = 0.02,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1461,
    1601581,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[536]
  },
  {
    1462,
    1601581,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[536]
  },
  {
    1463,
    1601581,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[537]
  },
  {
    1464,
    1601581,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[537]
  },
  {
    1465,
    1601581,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[537]
  },
  {
    1466,
    1601581,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[538]
  },
  {
    1467,
    1601581,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[538]
  },
  {
    1468,
    1601581,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[538]
  },
  {
    1469,
    1601581,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[538]
  },
  {
    1470,
    1601581,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410158,
        [1] = {
          value = 40,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "maxSingleTargetAddLayer"
          },
          type = 1
        }
      }
    }
  },
  {
    1471,
    1601591,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[539]
  },
  {
    1472,
    1601591,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[539]
  },
  {
    1473,
    1601591,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[540]
  },
  {
    1474,
    1601591,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[540]
  },
  {
    1475,
    1601591,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[540]
  },
  {
    1476,
    1601591,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[541]
  },
  {
    1477,
    1601591,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[541]
  },
  {
    1478,
    1601591,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[541]
  },
  {
    1479,
    1601591,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[541]
  },
  {
    1480,
    1601591,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101591,
        [1] = {
          value = -0.4,
          key = {
            LogicType = "Active",
            param = "changeValue"
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
    1481,
    1501601,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[542]
  },
  {
    1482,
    1501601,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[542]
  },
  {
    1483,
    1501601,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[543]
  },
  {
    1484,
    1501601,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[543]
  },
  {
    1485,
    1501601,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[543]
  },
  {
    1486,
    1501601,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[544]
  },
  {
    1487,
    1501601,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[544]
  },
  {
    1488,
    1501601,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[544]
  },
  {
    1489,
    1501601,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[544]
  },
  {
    1490,
    1501601,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 40016002,
        [1] = {
          value = 2,
          key = {
            LogicType = "Exec",
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 40016003,
        [1] = {
          value = 40016010,
          key = {LogicType = "Exec", param = "buffID"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 40016012,
        [1] = {
          value = 40016011,
          key = {LogicType = "Exec", param = "buffID"},
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 40016001,
        [1] = {
          value = 3,
          key = {},
          type = 1
        }
      }
    }
  },
  {
    1491,
    1501611,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[545]
  },
  {
    1492,
    1501611,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[545]
  },
  {
    1493,
    1501611,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[546]
  },
  {
    1494,
    1501611,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[546]
  },
  {
    1495,
    1501611,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[546]
  },
  {
    1496,
    1501611,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[547]
  },
  {
    1497,
    1501611,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[547]
  },
  {
    1498,
    1501611,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[547]
  },
  {
    1499,
    1501611,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[547]
  },
  {
    1500,
    1501611,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 40016103,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Active",
            param = "changeValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.2,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1501,
    1501621,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[548]
  },
  {
    1502,
    1501621,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[548]
  },
  {
    1503,
    1501621,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[549]
  },
  {
    1504,
    1501621,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[549]
  },
  {
    1505,
    1501621,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[549]
  },
  {
    1506,
    1501621,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[550]
  },
  {
    1507,
    1501621,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[550]
  },
  {
    1508,
    1501621,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[550]
  },
  {
    1509,
    1501621,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[550]
  },
  {
    1510,
    1501621,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410162,
        [1] = {
          value = 0.3,
          key = {LogicType = "Exec", param = "extraProb"},
          type = 2
        },
        [2] = {
          value = 0.01,
          key = {LogicType = "Exec", param = "fullProb"},
          type = 2
        }
      }
    }
  },
  {
    1511,
    1501651,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[551]
  },
  {
    1512,
    1501651,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[551]
  },
  {
    1513,
    1501651,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[552]
  },
  {
    1514,
    1501651,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[552]
  },
  {
    1515,
    1501651,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[552]
  },
  {
    1516,
    1501651,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[553]
  },
  {
    1517,
    1501651,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[553]
  },
  {
    1518,
    1501651,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[553]
  },
  {
    1519,
    1501651,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[553]
  },
  {
    1520,
    1501651,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 400165,
        [1] = {
          value = {
            percent = {0.3}
          },
          key = {LogicType = "Load", param = "set"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4001651,
        [1] = {
          value = 0.3,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1521,
    1601641,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[554]
  },
  {
    1522,
    1601641,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[554]
  },
  {
    1523,
    1601641,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[555]
  },
  {
    1524,
    1601641,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[555]
  },
  {
    1525,
    1601641,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[555]
  },
  {
    1526,
    1601641,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[556]
  },
  {
    1527,
    1601641,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[556]
  },
  {
    1528,
    1601641,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[556]
  },
  {
    1529,
    1601641,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[556]
  },
  {
    1530,
    1601641,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410164,
        [1] = {
          value = 4101644,
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
      }
    }
  },
  {
    1531,
    1601661,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[557]
  },
  {
    1532,
    1601661,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[557]
  },
  {
    1533,
    1601661,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[558]
  },
  {
    1534,
    1601661,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[558]
  },
  {
    1535,
    1601661,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[558]
  },
  {
    1536,
    1601661,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[559]
  },
  {
    1537,
    1601661,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[559]
  },
  {
    1538,
    1601661,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[559]
  },
  {
    1539,
    1601661,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[559]
  },
  {
    1540,
    1601661,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101661,
        [1] = {
          value = 0.1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101665,
        [1] = {
          value = 41016614,
          key = {LogicType = "Exec", param = "buffID"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4301662,
        [1] = {
          value = 43016614,
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
    1541,
    1601671,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[560]
  },
  {
    1542,
    1601671,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[560]
  },
  {
    1543,
    1601671,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[561]
  },
  {
    1544,
    1601671,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[561]
  },
  {
    1545,
    1601671,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[561]
  },
  {
    1546,
    1601671,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[562]
  },
  {
    1547,
    1601671,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[562]
  },
  {
    1548,
    1601671,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[562]
  },
  {
    1549,
    1601671,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[562]
  },
  {
    1550,
    1601671,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101671,
        [1] = {
          value = 1.2,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "mulValue"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4111671,
        [1] = {
          value = 1.2,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "mulValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1551,
    1501681,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[563]
  },
  {
    1552,
    1501681,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[563]
  },
  {
    1553,
    1501681,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[564]
  },
  {
    1554,
    1501681,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[564]
  },
  {
    1555,
    1501681,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[564]
  },
  {
    1556,
    1501681,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[565]
  },
  {
    1557,
    1501681,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[565]
  },
  {
    1558,
    1501681,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[565]
  },
  {
    1559,
    1501681,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[565]
  },
  {
    1560,
    1501681,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4001681,
        [1] = {
          value = 1.2,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101681,
        [1] = {
          value = 1.2,
          key = {
            LogicType = "Load",
            param = "shieldPercent"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1561,
    1501711,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[566]
  },
  {
    1562,
    1501711,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[566]
  },
  {
    1563,
    1501711,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[567]
  },
  {
    1564,
    1501711,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[567]
  },
  {
    1565,
    1501711,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[567]
  },
  {
    1566,
    1501711,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[568]
  },
  {
    1567,
    1501711,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[568]
  },
  {
    1568,
    1501711,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[568]
  },
  {
    1569,
    1501711,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[568]
  },
  {
    1570,
    1501711,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101713,
        [1] = {
          value = {
            formulaID = 138,
            damageMulMin138 = 1.2,
            damageMulMax138 = 2.5
          },
          key = {LogicType = "Active", param = "set"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4301713,
        [1] = {
          value = {
            formulaID = 138,
            damageMulMin138 = 1.2,
            damageMulMax138 = 2.5
          },
          key = {LogicType = "Active", param = "set"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4101711,
        [1] = {
          value = 2.5,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1571,
    1601701,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[569]
  },
  {
    1572,
    1601701,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[569]
  },
  {
    1573,
    1601701,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[570]
  },
  {
    1574,
    1601701,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[570]
  },
  {
    1575,
    1601701,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[570]
  },
  {
    1576,
    1601701,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[571]
  },
  {
    1577,
    1601701,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[571]
  },
  {
    1578,
    1601701,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[571]
  },
  {
    1579,
    1601701,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[571]
  },
  {
    1580,
    1601701,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410170,
        [1] = {
          value = 0.1,
          key = {},
          type = 2
        },
        [2] = {
          value = {
            0,
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1.0,
            1.1,
            1.2
          },
          key = {LogicType = "Active", param = "ratesByDis"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 420170,
        [1] = {
          value = 0.1,
          key = {},
          type = 2
        },
        [2] = {
          value = {
            0,
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1.0,
            1.1,
            1.2
          },
          key = {LogicType = "Active", param = "ratesByDis"},
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1581,
    1401691,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[572]
  },
  {
    1582,
    1401691,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[572]
  },
  {
    1583,
    1401691,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[573]
  },
  {
    1584,
    1401691,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[573]
  },
  {
    1585,
    1401691,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[573]
  },
  {
    1586,
    1401691,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[574]
  },
  {
    1587,
    1401691,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[574]
  },
  {
    1588,
    1401691,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[574]
  },
  {
    1589,
    1401691,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[574]
  },
  {
    1590,
    1401691,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101691,
        [1] = {
          value = 0.3,
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
          value = 0.2,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1591,
    1601721,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[575]
  },
  {
    1592,
    1601721,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[575]
  },
  {
    1593,
    1601721,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[576]
  },
  {
    1594,
    1601721,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[576]
  },
  {
    1595,
    1601721,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[576]
  },
  {
    1596,
    1601721,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[577]
  },
  {
    1597,
    1601721,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[577]
  },
  {
    1598,
    1601721,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[577]
  },
  {
    1599,
    1601721,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[577]
  },
  {
    1600,
    1601721,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101721,
        [1] = {
          value = 0.4,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101722,
        [1] = {
          value = 0.4,
          key = {
            LogicType = "Load",
            param = "shieldPercent"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1601,
    1601731,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[578]
  },
  {
    1602,
    1601731,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[578]
  },
  {
    1603,
    1601731,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[579]
  },
  {
    1604,
    1601731,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[579]
  },
  {
    1605,
    1601731,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[579]
  },
  {
    1606,
    1601731,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[580]
  },
  {
    1607,
    1601731,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[580]
  },
  {
    1608,
    1601731,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[580]
  },
  {
    1609,
    1601731,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[580]
  },
  {
    1610,
    1601731,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101731,
        [1] = {
          value = 4001734,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.8,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1611,
    1601751,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[581]
  },
  {
    1612,
    1601751,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[581]
  },
  {
    1613,
    1601751,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[582]
  },
  {
    1614,
    1601751,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[582]
  },
  {
    1615,
    1601751,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[582]
  },
  {
    1616,
    1601751,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[583]
  },
  {
    1617,
    1601751,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[583]
  },
  {
    1618,
    1601751,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[583]
  },
  {
    1619,
    1601751,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[583]
  },
  {
    1620,
    1601751,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101753,
        [1] = {
          value = {
            [2001751] = 20017541,
            [2001752] = 20017542,
            [2001753] = 20017543
          },
          key = {LogicType = "Active", param = "param"},
          isShow = false,
          type = 2
        },
        [2] = {
          value = 0.8,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1621,
    1501761,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[584]
  },
  {
    1622,
    1501761,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[584]
  },
  {
    1623,
    1501761,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[585]
  },
  {
    1624,
    1501761,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[585]
  },
  {
    1625,
    1501761,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[585]
  },
  {
    1626,
    1501761,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[586]
  },
  {
    1627,
    1501761,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[586]
  },
  {
    1628,
    1501761,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[586]
  },
  {
    1629,
    1501761,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[586]
  },
  {
    1630,
    1501761,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410176102,
        [1] = {
          value = 410176103,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "buffID"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 5,
          key = {},
          type = 1
        }
      }
    }
  },
  {
    1631,
    1601771,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[587]
  },
  {
    1632,
    1601771,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[587]
  },
  {
    1633,
    1601771,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[588]
  },
  {
    1634,
    1601771,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[588]
  },
  {
    1635,
    1601771,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[588]
  },
  {
    1636,
    1601771,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[589]
  },
  {
    1637,
    1601771,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[589]
  },
  {
    1638,
    1601771,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[589]
  },
  {
    1639,
    1601771,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[589]
  },
  {
    1640,
    1601771,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410177,
        [1] = {
          value = 5,
          key = {},
          type = 1
        }
      },
      [2] = {
        BuffID = 4101771,
        [1] = {
          value = 5,
          key = {
            TriggerType = "Exec",
            TriggerIndex = 2,
            TriggerParamIndex = 3
          },
          type = 1,
          isShow = false
        }
      }
    }
  },
  {
    1641,
    1601781,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[590]
  },
  {
    1642,
    1601781,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[590]
  },
  {
    1643,
    1601781,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[591]
  },
  {
    1644,
    1601781,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[591]
  },
  {
    1645,
    1601781,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[591]
  },
  {
    1646,
    1601781,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[592]
  },
  {
    1647,
    1601781,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[592]
  },
  {
    1648,
    1601781,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[592]
  },
  {
    1649,
    1601781,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[592]
  },
  {
    1650,
    1601781,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 41017811,
        [1] = {
          value = 11017811,
          key = {LogicType = "Exec", param = "skillID"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 41017812,
        [1] = {
          value = 11017812,
          key = {LogicType = "Exec", param = "skillID"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 41017813,
        [1] = {
          value = 11017813,
          key = {LogicType = "Exec", param = "skillID"},
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 41017811,
        [1] = {
          value = 0.3,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1651,
    1501801,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[593]
  },
  {
    1652,
    1501801,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[593]
  },
  {
    1653,
    1501801,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[594]
  },
  {
    1654,
    1501801,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[594]
  },
  {
    1655,
    1501801,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[594]
  },
  {
    1656,
    1501801,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[595]
  },
  {
    1657,
    1501801,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[595]
  },
  {
    1658,
    1501801,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[595]
  },
  {
    1659,
    1501801,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[595]
  },
  {
    1660,
    1501801,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101801,
        [1] = {
          value = 0.1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101802,
        [1] = {
          value = 0.1,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "defaultParam"
          },
          type = 2
        }
      }
    }
  },
  {
    1661,
    1601821,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[596]
  },
  {
    1662,
    1601821,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[596]
  },
  {
    1663,
    1601821,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[597]
  },
  {
    1664,
    1601821,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[597]
  },
  {
    1665,
    1601821,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[597]
  },
  {
    1666,
    1601821,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[598]
  },
  {
    1667,
    1601821,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[598]
  },
  {
    1668,
    1601821,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[598]
  },
  {
    1669,
    1601821,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[598]
  },
  {
    1670,
    1601821,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4001820,
        [1] = {
          value = 3,
          key = {},
          type = 2
        },
        [2] = {
          value = {
            percent = {3}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {
            percent = {3}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1671,
    1601811,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[599]
  },
  {
    1672,
    1601811,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[599]
  },
  {
    1673,
    1601811,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[600]
  },
  {
    1674,
    1601811,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[600]
  },
  {
    1675,
    1601811,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[600]
  },
  {
    1676,
    1601811,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[601]
  },
  {
    1677,
    1601811,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[601]
  },
  {
    1678,
    1601811,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[601]
  },
  {
    1679,
    1601811,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[601]
  },
  {
    1680,
    1601811,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101811,
        [1] = {
          value = 4,
          key = {},
          type = 1
        },
        [2] = {
          value = 300181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4131811,
        [1] = {
          value = 300181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4161811,
        [1] = {
          value = 300181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 4101812,
        [1] = {
          value = 300181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "extraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [5] = {
        BuffID = 4201811,
        [1] = {
          value = 320181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [6] = {
        BuffID = 4231811,
        [1] = {
          value = 320181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [7] = {
        BuffID = 4261811,
        [1] = {
          value = 320181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [8] = {
        BuffID = 4101813,
        [1] = {
          value = 300181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "extraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [9] = {
        BuffID = 4301811,
        [1] = {
          value = 330181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [10] = {
        BuffID = 4331811,
        [1] = {
          value = 330181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [11] = {
        BuffID = 4361811,
        [1] = {
          value = 330181123,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [12] = {
        BuffID = 41001811,
        [1] = {
          value = 5,
          key = {},
          type = 1
        },
        [2] = {
          value = {300181123},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        }
      },
      [13] = {
        BuffID = 41001812,
        [1] = {
          value = 5,
          key = {},
          type = 1
        },
        [2] = {
          value = {320181123},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        }
      },
      [14] = {
        BuffID = 41001813,
        [1] = {
          value = 5,
          key = {},
          type = 1
        },
        [2] = {
          value = {330181123},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        }
      },
      [15] = {
        BuffID = 4131812,
        [1] = {
          value = 300181123,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [16] = {
        BuffID = 4231812,
        [1] = {
          value = 320181123,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [17] = {
        BuffID = 4331812,
        [1] = {
          value = 330181123,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "checkExtraSkillID"
          },
          type = 2,
          isShow = false
        }
      },
      [18] = {
        BuffID = 40018100,
        [1] = {
          value = 5,
          key = {},
          type = 1
        }
      }
    }
  },
  {
    1681,
    1501831,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[602]
  },
  {
    1682,
    1501831,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[602]
  },
  {
    1683,
    1501831,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[603]
  },
  {
    1684,
    1501831,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[603]
  },
  {
    1685,
    1501831,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[603]
  },
  {
    1686,
    1501831,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[604]
  },
  {
    1687,
    1501831,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[604]
  },
  {
    1688,
    1501831,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[604]
  },
  {
    1689,
    1501831,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[604]
  },
  {
    1690,
    1501831,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101832,
        [1] = {
          value = 0.65,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2
        }
      },
      [2] = {
        BuffID = 4301831,
        [1] = {
          value = 0.65,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2
        }
      }
    }
  },
  {
    1691,
    1601841,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[605]
  },
  {
    1692,
    1601841,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[605]
  },
  {
    1693,
    1601841,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[606]
  },
  {
    1694,
    1601841,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[606]
  },
  {
    1695,
    1601841,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[606]
  },
  {
    1696,
    1601841,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[607]
  },
  {
    1697,
    1601841,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[607]
  },
  {
    1698,
    1601841,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[607]
  },
  {
    1699,
    1601841,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[607]
  },
  {
    1700,
    1601841,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101841,
        [1] = {
          value = 1.5,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.4,
          key = {},
          type = 2
        },
        [3] = {
          value = 4001844,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = 0.4,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4301841,
        [1] = {
          value = 1.5,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.4,
          key = {},
          type = 2
        },
        [3] = {
          value = 4301844,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = 0.4,
          key = {
            LogicType = "Exec",
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
    1701,
    1501851,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[608]
  },
  {
    1702,
    1501851,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[608]
  },
  {
    1703,
    1501851,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[609]
  },
  {
    1704,
    1501851,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[609]
  },
  {
    1705,
    1501851,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[609]
  },
  {
    1706,
    1501851,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[610]
  },
  {
    1707,
    1501851,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[610]
  },
  {
    1708,
    1501851,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[610]
  },
  {
    1709,
    1501851,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[610]
  },
  {
    1710,
    1501851,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101850,
        [1] = {
          value = 1.35,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101851,
        [1] = {
          value = 3101854,
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
        BuffID = 4161851,
        [1] = {
          value = 3101854,
          key = {
            LogicType = "Exec",
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
    1711,
    1601861,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[611]
  },
  {
    1712,
    1601861,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[611]
  },
  {
    1713,
    1601861,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[612]
  },
  {
    1714,
    1601861,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[612]
  },
  {
    1715,
    1601861,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[612]
  },
  {
    1716,
    1601861,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[613]
  },
  {
    1717,
    1601861,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[613]
  },
  {
    1718,
    1601861,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[613]
  },
  {
    1719,
    1601861,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[613]
  },
  {
    1720,
    1601861,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101861,
        [1] = {
          value = 1.5,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4101862,
        [1] = {
          value = 1.5,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4301865,
        [1] = {
          value = 1.5,
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
    1721,
    1601891,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[614]
  },
  {
    1722,
    1601891,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[614]
  },
  {
    1723,
    1601891,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[615]
  },
  {
    1724,
    1601891,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[615]
  },
  {
    1725,
    1601891,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[615]
  },
  {
    1726,
    1601891,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[616]
  },
  {
    1727,
    1601891,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[616]
  },
  {
    1728,
    1601891,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[616]
  },
  {
    1729,
    1601891,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[616]
  },
  {
    1730,
    1601891,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 40018912,
        [1] = {
          value = 0.5,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.5,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "multiValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1731,
    1501901,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[617]
  },
  {
    1732,
    1501901,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[617]
  },
  {
    1733,
    1501901,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[618]
  },
  {
    1734,
    1501901,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[618]
  },
  {
    1735,
    1501901,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[618]
  },
  {
    1736,
    1501901,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[619]
  },
  {
    1737,
    1501901,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[619]
  },
  {
    1738,
    1501901,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[619]
  },
  {
    1739,
    1501901,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[619]
  },
  {
    1740,
    1501901,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101901,
        [1] = {
          value = 1.2,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 41019010,
        [1] = {
          value = 1.2,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "maxPercent"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1741,
    1501931,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[620]
  },
  {
    1742,
    1501931,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[620]
  },
  {
    1743,
    1501931,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[621]
  },
  {
    1744,
    1501931,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[621]
  },
  {
    1745,
    1501931,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[621]
  },
  {
    1746,
    1501931,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[622]
  },
  {
    1747,
    1501931,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[622]
  },
  {
    1748,
    1501931,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[622]
  },
  {
    1749,
    1501931,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[622]
  },
  {
    1750,
    1501931,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
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
    }
  },
  {
    1751,
    1601911,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[623]
  },
  {
    1752,
    1601911,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[623]
  },
  {
    1753,
    1601911,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[624]
  },
  {
    1754,
    1601911,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[624]
  },
  {
    1755,
    1601911,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[624]
  },
  {
    1756,
    1601911,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[625]
  },
  {
    1757,
    1601911,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[625]
  },
  {
    1758,
    1601911,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[625]
  },
  {
    1759,
    1601911,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[625]
  },
  {
    1760,
    1601911,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101911,
        [1] = {
          value = 0.5,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.00715,
          key = {
            LogicType = "Active",
            param = "promotePercent"
          },
          isShow = false,
          type = 2
        },
        [3] = {
          value = 0.5,
          key = {
            LogicType = "Active",
            param = "maxSkillFinal"
          },
          isShow = false,
          type = 2
        }
      }
    }
  },
  {
    1761,
    1601921,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[626]
  },
  {
    1762,
    1601921,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[626]
  },
  {
    1763,
    1601921,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[627]
  },
  {
    1764,
    1601921,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[627]
  },
  {
    1765,
    1601921,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[627]
  },
  {
    1766,
    1601921,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[628]
  },
  {
    1767,
    1601921,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[628]
  },
  {
    1768,
    1601921,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[628]
  },
  {
    1769,
    1601921,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    {
      [1] = {
        BuffID = 4101922,
        [1] = {
          value = 0.016,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.016,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          isShow = false,
          type = 2
        }
      }
    }
  },
  {
    1770,
    1601921,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101922,
        [1] = {
          value = 0.025,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.025,
          key = {
            LogicType = "Active",
            param = "oneLayerValue"
          },
          isShow = false,
          type = 2
        }
      }
    }
  },
  {
    1771,
    1601991,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[629]
  },
  {
    1772,
    1601991,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[629]
  },
  {
    1773,
    1601991,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[630]
  },
  {
    1774,
    1601991,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[630]
  },
  {
    1775,
    1601991,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[630]
  },
  {
    1776,
    1601991,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[631]
  },
  {
    1777,
    1601991,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[631]
  },
  {
    1778,
    1601991,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[631]
  },
  {
    1779,
    1601991,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[631]
  },
  {
    1780,
    1601991,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101992,
        [1] = {
          value = 2.7,
          key = {},
          type = 2
        },
        [2] = {
          value = 1.7,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "changeValue"
          },
          isShow = false,
          type = 2
        }
      }
    }
  },
  {
    1781,
    1502001,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[632]
  },
  {
    1782,
    1502001,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[632]
  },
  {
    1783,
    1502001,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[633]
  },
  {
    1784,
    1502001,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[633]
  },
  {
    1785,
    1502001,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[633]
  },
  {
    1786,
    1502001,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[634]
  },
  {
    1787,
    1502001,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[634]
  },
  {
    1788,
    1502001,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[634]
  },
  {
    1789,
    1502001,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[634]
  },
  {
    1790,
    1502001,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410200,
        [1] = {
          value = 0.4,
          key = {},
          type = 2
        },
        [2] = {
          value = {0.4},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1791,
    1602011,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[635]
  },
  {
    1792,
    1602011,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[635]
  },
  {
    1793,
    1602011,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[636]
  },
  {
    1794,
    1602011,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[636]
  },
  {
    1795,
    1602011,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[636]
  },
  {
    1796,
    1602011,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[637]
  },
  {
    1797,
    1602011,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[637]
  },
  {
    1798,
    1602011,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[637]
  },
  {
    1799,
    1602011,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[637]
  },
  {
    1800,
    1602011,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410201,
        [1] = {
          value = 0.12,
          key = {LogicType = "Active", param = "baseValue"},
          type = 2
        }
      },
      [2] = {
        BuffID = 420201,
        [1] = {
          value = 0.12,
          key = {LogicType = "Active", param = "baseValue"},
          type = 2
        }
      }
    }
  },
  {
    1801,
    1602021,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[638]
  },
  {
    1802,
    1602021,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[638]
  },
  {
    1803,
    1602021,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[639]
  },
  {
    1804,
    1602021,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[639]
  },
  {
    1805,
    1602021,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[639]
  },
  {
    1806,
    1602021,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[640]
  },
  {
    1807,
    1602021,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[640]
  },
  {
    1808,
    1602021,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[640]
  },
  {
    1809,
    1602021,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[640]
  },
  {
    1810,
    1602021,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102021,
        [1] = {
          value = 0.04,
          key = {},
          type = 2
        },
        [2] = {
          value = 1.5,
          key = {},
          type = 2
        },
        [3] = {
          value = 4,
          key = {},
          type = 2
        },
        [4] = {
          value = 1102024,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "attackSkillId",
            isShow = false
          },
          type = 2
        }
      }
    }
  },
  {
    1811,
    1502031,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[641]
  },
  {
    1812,
    1502031,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[641]
  },
  {
    1813,
    1502031,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[642]
  },
  {
    1814,
    1502031,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[642]
  },
  {
    1815,
    1502031,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[642]
  },
  {
    1816,
    1502031,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[643]
  },
  {
    1817,
    1502031,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[643]
  },
  {
    1818,
    1502031,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[643]
  },
  {
    1819,
    1502031,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[643]
  },
  {
    1820,
    1502031,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102031,
        [1] = {
          value = 0.8,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4102033,
        [1] = {
          value = 0.8,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "shieldPercent"
          },
          type = 2
        }
      },
      [3] = {
        BuffID = 4102034,
        [1] = {
          value = 0.8,
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "shieldPercent"
          },
          type = 2
        }
      }
    }
  },
  {
    1821,
    1602041,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[644]
  },
  {
    1822,
    1602041,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[644]
  },
  {
    1823,
    1602041,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[645]
  },
  {
    1824,
    1602041,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[645]
  },
  {
    1825,
    1602041,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[645]
  },
  {
    1826,
    1602041,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[646]
  },
  {
    1827,
    1602041,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[646]
  },
  {
    1828,
    1602041,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[646]
  },
  {
    1829,
    1602041,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[646]
  },
  {
    1830,
    1602041,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 43002043,
        [1] = {
          value = 1.18,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.18,
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
    1831,
    1502051,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    {
      [1] = {
        BuffID = 4102053,
        [1] = {
          value = 0.2,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.2,
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
    1832,
    1502051,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[647]
  },
  {
    1833,
    1502051,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[647]
  },
  {
    1834,
    1502051,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[647]
  },
  {
    1835,
    1502051,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[647]
  },
  {
    1836,
    1502051,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[648]
  },
  {
    1837,
    1502051,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[648]
  },
  {
    1838,
    1502051,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[648]
  },
  {
    1839,
    1502051,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[648]
  },
  {
    1840,
    1502051,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102053,
        [1] = {
          value = 0.3,
          key = {},
          type = 2
        },
        [2] = {
          value = 0.3,
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
    1841,
    1602061,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[649]
  },
  {
    1842,
    1602061,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[649]
  },
  {
    1843,
    1602061,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[650]
  },
  {
    1844,
    1602061,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[650]
  },
  {
    1845,
    1602061,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[650]
  },
  {
    1846,
    1602061,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[651]
  },
  {
    1847,
    1602061,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[651]
  },
  {
    1848,
    1602061,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[651]
  },
  {
    1849,
    1602061,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[651]
  },
  {
    1850,
    1602061,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 41002061,
        [1] = {
          value = {30020624},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.6,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 41002062,
        [1] = {
          value = {32020624},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.6,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 41002063,
        [1] = {
          value = {33020624},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "skillList"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.6,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1851,
    1602071,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[652]
  },
  {
    1852,
    1602071,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[652]
  },
  {
    1853,
    1602071,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[653]
  },
  {
    1854,
    1602071,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[653]
  },
  {
    1855,
    1602071,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[653]
  },
  {
    1856,
    1602071,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[654]
  },
  {
    1857,
    1602071,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[654]
  },
  {
    1858,
    1602071,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[654]
  },
  {
    1859,
    1602071,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[654]
  },
  {
    1860,
    1602071,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102071,
        [1] = {
          value = 0.45,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4102073,
        [1] = {
          value = 0.45,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "perLayer"
          },
          type = 2
        }
      },
      [3] = {
        BuffID = 4162073,
        [1] = {
          value = 0.45,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "perLayer"
          },
          type = 2
        }
      }
    }
  },
  {
    1861,
    1502081,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[655]
  },
  {
    1862,
    1502081,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[655]
  },
  {
    1863,
    1502081,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[656]
  },
  {
    1864,
    1502081,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[656]
  },
  {
    1865,
    1502081,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[656]
  },
  {
    1866,
    1502081,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[657]
  },
  {
    1867,
    1502081,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[657]
  },
  {
    1868,
    1502081,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[657]
  },
  {
    1869,
    1502081,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[657]
  },
  {
    1870,
    1502081,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410208,
        [1] = {
          value = 4002086,
          key = {LogicType = "Load", param = "buffID"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 2.4,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4102083,
        [1] = {
          value = 4002086,
          key = {LogicType = "Exec", param = "buffID"},
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    1871,
    1602091,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[658]
  },
  {
    1872,
    1602091,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[658]
  },
  {
    1873,
    1602091,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[659]
  },
  {
    1874,
    1602091,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[659]
  },
  {
    1875,
    1602091,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[659]
  },
  {
    1876,
    1602091,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[660]
  },
  {
    1877,
    1602091,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[660]
  },
  {
    1878,
    1602091,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[660]
  },
  {
    1879,
    1602091,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[660]
  },
  {
    1880,
    1602091,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102091,
        [1] = {
          value = 4102094,
          key = {LogicType = "Exec", param = "skillID"},
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4202091,
        [1] = {
          value = 4202094,
          key = {LogicType = "Exec", param = "skillID"},
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4102090,
        [1] = {
          value = 0.4,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 4202090,
        [1] = {
          value = 0.4,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1881,
    1502101,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[661]
  },
  {
    1882,
    1502101,
    2,
    common[35],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[661]
  },
  {
    1883,
    1502101,
    3,
    common[36],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[662]
  },
  {
    1884,
    1502101,
    4,
    common[37],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[662]
  },
  {
    1885,
    1502101,
    5,
    common[37],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[662]
  },
  {
    1886,
    1502101,
    6,
    common[38],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[663]
  },
  {
    1887,
    1502101,
    7,
    common[39],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[663]
  },
  {
    1888,
    1502101,
    8,
    common[40],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[663]
  },
  {
    1889,
    1502101,
    9,
    common[41],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[663]
  },
  {
    1890,
    1502101,
    10,
    common[42],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410210,
        [1] = {
          value = {0.3},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = {0.15},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "percent"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = 0.3,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1891,
    1602121,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[664]
  },
  {
    1892,
    1602121,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[664]
  },
  {
    1893,
    1602121,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[665]
  },
  {
    1894,
    1602121,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[665]
  },
  {
    1895,
    1602121,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[665]
  },
  {
    1896,
    1602121,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[666]
  },
  {
    1897,
    1602121,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[666]
  },
  {
    1898,
    1602121,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[666]
  },
  {
    1899,
    1602121,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[666]
  },
  {
    1900,
    1602121,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102121,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "mulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4302121,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "mulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4102122,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "mulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      },
      [4] = {
        BuffID = 4302122,
        [1] = {
          value = 0.05,
          key = {
            LogicType = "Exec",
            LogicIndex = 2,
            param = "mulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.05,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1901,
    1602111,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[667]
  },
  {
    1902,
    1602111,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[667]
  },
  {
    1903,
    1602111,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[668]
  },
  {
    1904,
    1602111,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[668]
  },
  {
    1905,
    1602111,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[668]
  },
  {
    1906,
    1602111,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[669]
  },
  {
    1907,
    1602111,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[669]
  },
  {
    1908,
    1602111,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[669]
  },
  {
    1909,
    1602111,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[669]
  },
  {
    1910,
    1602111,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102112,
        [1] = {
          value = 0.3,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "mulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.3,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1911,
    1502131,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[670]
  },
  {
    1912,
    1502131,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[670]
  },
  {
    1913,
    1502131,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[671]
  },
  {
    1914,
    1502131,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[671]
  },
  {
    1915,
    1502131,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[671]
  },
  {
    1916,
    1502131,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[672]
  },
  {
    1917,
    1502131,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[672]
  },
  {
    1918,
    1502131,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[672]
  },
  {
    1919,
    1502131,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[672]
  },
  {
    1920,
    1502131,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410213,
        [1] = {
          value = 9,
          key = {
            TriggerType = "Active",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 1
        }
      },
      [2] = {
        BuffID = 4102132,
        [1] = {
          value = 9,
          key = {
            TriggerType = "Active",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 1
        }
      },
      [3] = {
        BuffID = 420213,
        [1] = {
          value = 9,
          key = {
            TriggerType = "Active",
            TriggerIndex = 2,
            TriggerParamIndex = 2
          },
          type = 1
        }
      }
    }
  },
  {
    1921,
    1501871,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[673]
  },
  {
    1922,
    1501871,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[673]
  },
  {
    1923,
    1501871,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[674]
  },
  {
    1924,
    1501871,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[674]
  },
  {
    1925,
    1501871,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[674]
  },
  {
    1926,
    1501871,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[675]
  },
  {
    1927,
    1501871,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[675]
  },
  {
    1928,
    1501871,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[675]
  },
  {
    1929,
    1501871,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[675]
  },
  {
    1930,
    1501871,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4101870,
        [1] = {
          value = {crit = 1.6},
          key = {LogicType = "Load", param = "set"},
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.6,
          key = {},
          type = 1
        }
      }
    }
  },
  {
    1931,
    1601881,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[676]
  },
  {
    1932,
    1601881,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[676]
  },
  {
    1933,
    1601881,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[677]
  },
  {
    1934,
    1601881,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[677]
  },
  {
    1935,
    1601881,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[677]
  },
  {
    1936,
    1601881,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[678]
  },
  {
    1937,
    1601881,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[678]
  },
  {
    1938,
    1601881,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[678]
  },
  {
    1939,
    1601881,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[678]
  },
  {
    1940,
    1601881,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410188,
        [1] = {
          value = 1101884,
          key = {
            LogicType = "Active",
            LogicIndex = 2,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.8,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 420188,
        [1] = {
          value = 1201884,
          key = {
            LogicType = "Active",
            LogicIndex = 2,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.8,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 430188,
        [1] = {
          value = 1201884,
          key = {
            LogicType = "Active",
            LogicIndex = 2,
            param = "attackSkillId"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.8,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1941,
    1602141,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[679]
  },
  {
    1942,
    1602141,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[679]
  },
  {
    1943,
    1602141,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[680]
  },
  {
    1944,
    1602141,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[680]
  },
  {
    1945,
    1602141,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[680]
  },
  {
    1946,
    1602141,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[681]
  },
  {
    1947,
    1602141,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[681]
  },
  {
    1948,
    1602141,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[681]
  },
  {
    1949,
    1602141,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[681]
  },
  {
    1950,
    1602141,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 200221,
        [1] = {
          value = 0.35,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "damagePercent"
          },
          type = 2,
          isShow = false
        }
      },
      [2] = {
        BuffID = 4002141,
        [1] = {
          value = 0.35,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    1951,
    1502151,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[682]
  },
  {
    1952,
    1502151,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[682]
  },
  {
    1953,
    1502151,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[683]
  },
  {
    1954,
    1502151,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[683]
  },
  {
    1955,
    1502151,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[683]
  },
  {
    1956,
    1502151,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[684]
  },
  {
    1957,
    1502151,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[684]
  },
  {
    1958,
    1502151,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[684]
  },
  {
    1959,
    1502151,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[684]
  },
  {
    1960,
    1502151,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
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
          value = 1202154,
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
      }
    }
  },
  {
    1961,
    1602161,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[685]
  },
  {
    1962,
    1602161,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[685]
  },
  {
    1963,
    1602161,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[686]
  },
  {
    1964,
    1602161,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[686]
  },
  {
    1965,
    1602161,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[686]
  },
  {
    1966,
    1602161,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[687]
  },
  {
    1967,
    1602161,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[687]
  },
  {
    1968,
    1602161,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[687]
  },
  {
    1969,
    1602161,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[687]
  },
  {
    1970,
    1602161,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410216,
        [1] = {
          value = 0.2,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  },
  {
    1971,
    1602181,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03
  },
  {
    1972,
    1602181,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    1973,
    1602181,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07
  },
  {
    1974,
    1602181,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    1975,
    1602181,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    1976,
    1602181,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15
  },
  {
    1977,
    1602181,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    1978,
    1602181,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    1979,
    1602181,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    1980,
    1602181,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3
  },
  {
    1981,
    1602191,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[688]
  },
  {
    1982,
    1602191,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[688]
  },
  {
    1983,
    1602191,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[689]
  },
  {
    1984,
    1602191,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[689]
  },
  {
    1985,
    1602191,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[689]
  },
  {
    1986,
    1602191,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[690]
  },
  {
    1987,
    1602191,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[690]
  },
  {
    1988,
    1602191,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[690]
  },
  {
    1989,
    1602191,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[690]
  },
  {
    1990,
    1602191,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102191,
        [1] = {
          value = 1,
          key = {},
          type = 2
        },
        [2] = {
          value = 4002194,
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
        BuffID = 4202191,
        [1] = {
          value = 1,
          key = {},
          type = 2
        },
        [2] = {
          value = 4202194,
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
        BuffID = 4132191,
        [1] = {
          value = 1,
          key = {},
          type = 2
        },
        [2] = {
          value = 4032194,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 4232191,
        [1] = {
          value = 1,
          key = {},
          type = 2
        },
        [2] = {
          value = 4232194,
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
    1991,
    1502201,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[691]
  },
  {
    1992,
    1502201,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[691]
  },
  {
    1993,
    1502201,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[692]
  },
  {
    1994,
    1502201,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[692]
  },
  {
    1995,
    1502201,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[692]
  },
  {
    1996,
    1502201,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[693]
  },
  {
    1997,
    1502201,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[693]
  },
  {
    1998,
    1502201,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[693]
  },
  {
    1999,
    1502201,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[693]
  },
  {
    2000,
    1502201,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102201,
        [1] = {
          value = 0.25,
          key = {},
          type = 2
        },
        [2] = {
          value = {
            percent = {0.25}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {
            percent = {0.5}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    2001,
    1602211,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[694]
  },
  {
    2002,
    1602211,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[694]
  },
  {
    2003,
    1602211,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[695]
  },
  {
    2004,
    1602211,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[695]
  },
  {
    2005,
    1602211,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[695]
  },
  {
    2006,
    1602211,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[696]
  },
  {
    2007,
    1602211,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[696]
  },
  {
    2008,
    1602211,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[696]
  },
  {
    2009,
    1602211,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[696]
  },
  {
    2010,
    1602211,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102212,
        [1] = {
          value = 0.05,
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
          value = 0.05,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    2011,
    1602231,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[697]
  },
  {
    2012,
    1602231,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[697]
  },
  {
    2013,
    1602231,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[698]
  },
  {
    2014,
    1602231,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[698]
  },
  {
    2015,
    1602231,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[698]
  },
  {
    2016,
    1602231,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[699]
  },
  {
    2017,
    1602231,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[699]
  },
  {
    2018,
    1602231,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[699]
  },
  {
    2019,
    1602231,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[699]
  },
  {
    2020,
    1602231,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102232,
        [1] = {
          value = 1,
          key = {},
          type = 2
        },
        [2] = {
          value = {
            percent = {1}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {
            percent = {1.5}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = {
            percent = {1}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "set"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    2021,
    1502241,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[700]
  },
  {
    2022,
    1502241,
    2,
    common[121],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[700]
  },
  {
    2023,
    1502241,
    3,
    common[122],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[701]
  },
  {
    2024,
    1502241,
    4,
    common[123],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[701]
  },
  {
    2025,
    1502241,
    5,
    common[123],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[701]
  },
  {
    2026,
    1502241,
    6,
    common[124],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[702]
  },
  {
    2027,
    1502241,
    7,
    common[125],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[702]
  },
  {
    2028,
    1502241,
    8,
    common[126],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[702]
  },
  {
    2029,
    1502241,
    9,
    common[127],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[702]
  },
  {
    2030,
    1502241,
    10,
    common[128],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102242,
        [1] = {
          value = 0.01,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    2031,
    1602251,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[703]
  },
  {
    2032,
    1602251,
    2,
    common[2],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[703]
  },
  {
    2033,
    1602251,
    3,
    common[3],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[704]
  },
  {
    2034,
    1602251,
    4,
    common[4],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[704]
  },
  {
    2035,
    1602251,
    5,
    common[4],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[704]
  },
  {
    2036,
    1602251,
    6,
    common[5],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[705]
  },
  {
    2037,
    1602251,
    7,
    common[6],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[705]
  },
  {
    2038,
    1602251,
    8,
    common[7],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[705]
  },
  {
    2039,
    1602251,
    9,
    common[8],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[705]
  },
  {
    2040,
    1602251,
    10,
    common[9],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102254,
        [1] = {
          value = {2},
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
          value = {2},
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
          value = 2,
          key = {},
          type = 2
        },
        [6] = {
          value = {1},
          key = {
            LogicType = "Load",
            param = "percent",
            LogicIndex = 3
          },
          type = 2,
          isShow = false
        },
        [7] = {
          value = {1},
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
        BuffID = 4102254,
        [1] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4102253,
        [1] = {
          value = 41022523,
          key = {LogicType = "Load", param = "buffID"},
          type = 2
        },
        [2] = {
          value = 41022523,
          key = {LogicType = "Exec", param = "buffID"},
          type = 2
        }
      }
    }
  },
  {
    2041,
    1202261,
    1,
    common[1],
    25,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03
  },
  {
    2042,
    1202261,
    2,
    common[26],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07
  },
  {
    2043,
    1202261,
    3,
    common[27],
    50,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07
  },
  {
    2044,
    1202261,
    4,
    common[28],
    75,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11
  },
  {
    2045,
    1202261,
    5,
    common[29],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15
  },
  {
    2046,
    1202261,
    6,
    common[30],
    100,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15
  },
  {
    2047,
    1202261,
    7,
    common[31],
    140,
    50,
    400,
    0,
    0,
    0,
    0,
    0,
    0.2
  },
  {
    2048,
    1202261,
    8,
    common[32],
    180,
    60,
    500,
    0,
    0,
    0,
    0,
    0,
    0.25
  },
  {
    2049,
    1202261,
    9,
    common[33],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.3
  },
  {
    2050,
    1202261,
    10,
    common[34],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    1,
    0.3
  },
  {
    2051,
    1602271,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[706]
  },
  {
    2052,
    1602271,
    2,
    common[10],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[706]
  },
  {
    2053,
    1602271,
    3,
    common[11],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[707]
  },
  {
    2054,
    1602271,
    4,
    common[12],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[707]
  },
  {
    2055,
    1602271,
    5,
    common[12],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[707]
  },
  {
    2056,
    1602271,
    6,
    common[13],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[708]
  },
  {
    2057,
    1602271,
    7,
    common[14],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[708]
  },
  {
    2058,
    1602271,
    8,
    common[15],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[708]
  },
  {
    2059,
    1602271,
    9,
    common[16],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[708]
  },
  {
    2060,
    1602271,
    10,
    common[17],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 410227113,
        [1] = {
          value = 0.7,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 410227108,
        [1] = {
          value = 0.7,
          key = {
            LogicType = "Exec",
            LogicIndex = 1,
            param = "percent"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    2061,
    1502281,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[709]
  },
  {
    2062,
    1502281,
    2,
    common[60],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[709]
  },
  {
    2063,
    1502281,
    3,
    common[61],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[710]
  },
  {
    2064,
    1502281,
    4,
    common[62],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[710]
  },
  {
    2065,
    1502281,
    5,
    common[62],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[710]
  },
  {
    2066,
    1502281,
    6,
    common[63],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[711]
  },
  {
    2067,
    1502281,
    7,
    common[64],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[711]
  },
  {
    2068,
    1502281,
    8,
    common[65],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[711]
  },
  {
    2069,
    1502281,
    9,
    common[66],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[711]
  },
  {
    2070,
    1502281,
    10,
    common[67],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102281,
        [1] = {
          value = {
            [2002281] = 20022814,
            [2002282] = 20022824
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "param"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.4,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4202281,
        [1] = {
          value = {
            [2002281] = 20022814,
            [2002282] = 20022824,
            [2002283] = 20022834
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "param"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 1.4,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    2071,
    1602291,
    1,
    common[77],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[712]
  },
  {
    2072,
    1602291,
    2,
    common[77],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[712]
  },
  {
    2073,
    1602291,
    3,
    common[78],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[713]
  },
  {
    2074,
    1602291,
    4,
    common[79],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[713]
  },
  {
    2075,
    1602291,
    5,
    common[79],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[713]
  },
  {
    2076,
    1602291,
    6,
    common[80],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[714]
  },
  {
    2077,
    1602291,
    7,
    common[81],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[714]
  },
  {
    2078,
    1602291,
    8,
    common[82],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[714]
  },
  {
    2079,
    1602291,
    9,
    common[83],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[714]
  },
  {
    2080,
    1602291,
    10,
    common[84],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102292,
        [1] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4102291,
        [1] = {
          value = {
            [14] = {percent = 1, formulaID = 166}
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "replaceBuffFormulaTable"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    2081,
    1602301,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[715]
  },
  {
    2082,
    1602301,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[715]
  },
  {
    2083,
    1602301,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[716]
  },
  {
    2084,
    1602301,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[716]
  },
  {
    2085,
    1602301,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[716]
  },
  {
    2086,
    1602301,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[717]
  },
  {
    2087,
    1602301,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[717]
  },
  {
    2088,
    1602301,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[717]
  },
  {
    2089,
    1602301,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[717]
  },
  {
    2090,
    1602301,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102301,
        [1] = {
          value = 4102304,
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
          value = 4102304,
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
          value = 4102304,
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
          value = 4102304,
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
          value = 4302304,
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
          value = 4302304,
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
          value = 4302304,
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
          value = 4302304,
          key = {
            LogicType = "Exec",
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
    2091,
    1602311,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[718]
  },
  {
    2092,
    1602311,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[718]
  },
  {
    2093,
    1602311,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[719]
  },
  {
    2094,
    1602311,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[719]
  },
  {
    2095,
    1602311,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[719]
  },
  {
    2096,
    1602311,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[720]
  },
  {
    2097,
    1602311,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[720]
  },
  {
    2098,
    1602311,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[720]
  },
  {
    2099,
    1602311,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[720]
  },
  {
    2100,
    1602311,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102314,
        [1] = {
          value = 0.035,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4102310,
        [1] = {
          value = -0.035,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = -0.035,
          key = {
            LogicType = "Unload",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        }
      },
      [3] = {
        BuffID = 4162310,
        [1] = {
          value = -0.035,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = -0.035,
          key = {
            LogicType = "Unload",
            LogicIndex = 2,
            param = "oneLayerAddMulValue"
          },
          type = 2,
          isShow = false
        }
      }
    }
  },
  {
    2101,
    1502321,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[721]
  },
  {
    2102,
    1502321,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[721]
  },
  {
    2103,
    1502321,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[722]
  },
  {
    2104,
    1502321,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[722]
  },
  {
    2105,
    1502321,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[722]
  },
  {
    2106,
    1502321,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[723]
  },
  {
    2107,
    1502321,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[723]
  },
  {
    2108,
    1502321,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[723]
  },
  {
    2109,
    1502321,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[723]
  },
  {
    2110,
    1502321,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4002321,
        [1] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [2] = {
        BuffID = 4052321,
        [1] = {
          value = 1,
          key = {},
          type = 2
        }
      },
      [3] = {
        BuffID = 4002322,
        [1] = {
          value = 4002324,
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "skillID"
          },
          type = 2,
          isShow = false
        }
      },
      [4] = {
        BuffID = 4052322,
        [1] = {
          value = 4052324,
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
    2111,
    1602331,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[724]
  },
  {
    2112,
    1602331,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[724]
  },
  {
    2113,
    1602331,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[725]
  },
  {
    2114,
    1602331,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[725]
  },
  {
    2115,
    1602331,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[725]
  },
  {
    2116,
    1602331,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[726]
  },
  {
    2117,
    1602331,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[726]
  },
  {
    2118,
    1602331,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[726]
  },
  {
    2119,
    1602331,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[726]
  },
  {
    2120,
    1602331,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102331,
        [1] = {
          value = 18,
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
    2121,
    1602341,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[727]
  },
  {
    2122,
    1602341,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[727]
  },
  {
    2123,
    1602341,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[728]
  },
  {
    2124,
    1602341,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[728]
  },
  {
    2125,
    1602341,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[728]
  },
  {
    2126,
    1602341,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[729]
  },
  {
    2127,
    1602341,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[729]
  },
  {
    2128,
    1602341,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[729]
  },
  {
    2129,
    1602341,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[729]
  },
  {
    2130,
    1602341,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102341,
        [1] = {
          value = 18,
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
    2131,
    1502351,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[730]
  },
  {
    2132,
    1502351,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[730]
  },
  {
    2133,
    1502351,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[731]
  },
  {
    2134,
    1502351,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[731]
  },
  {
    2135,
    1502351,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[731]
  },
  {
    2136,
    1502351,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[732]
  },
  {
    2137,
    1502351,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[726]
  },
  {
    2138,
    1502351,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[732]
  },
  {
    2139,
    1502351,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[732]
  },
  {
    2140,
    1502351,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102351,
        [1] = {
          value = 18,
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
    2141,
    1702361,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0,
    common[733]
  },
  {
    2142,
    1702361,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0,
    common[733]
  },
  {
    2143,
    1702361,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0,
    common[734]
  },
  {
    2144,
    1702361,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0,
    common[734]
  },
  {
    2145,
    1702361,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0,
    common[734]
  },
  {
    2146,
    1702361,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0,
    common[735]
  },
  {
    2147,
    1702361,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0,
    common[735]
  },
  {
    2148,
    1702361,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0,
    common[735]
  },
  {
    2149,
    1702361,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0,
    common[735]
  },
  {
    2150,
    1702361,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0,
    {
      [1] = {
        BuffID = 4102365,
        [1] = {
          value = 0.009,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "oneLayerValue"
          },
          type = 2
        }
      }
    }
  },
  {
    2151,
    1602371,
    1,
    common[18],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[736]
  },
  {
    2152,
    1602371,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[736]
  },
  {
    2153,
    1602371,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[737]
  },
  {
    2154,
    1602371,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[737]
  },
  {
    2155,
    1602371,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[737]
  },
  {
    2156,
    1602371,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[738]
  },
  {
    2157,
    1602371,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[738]
  },
  {
    2158,
    1602371,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[738]
  },
  {
    2159,
    1602371,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[738]
  },
  {
    2160,
    1602371,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102372,
        [1] = {
          value = 1.3,
          key = {},
          type = 2
        },
        [2] = {
          value = {trapID = 8002374},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {findPosTrapId = 8002374},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = {trapID = 8002374},
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [5] = {
          value = {trapID = 8002374},
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
          value = 1.3,
          key = {},
          type = 2
        },
        [2] = {
          value = {trapID = 8062374},
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [3] = {
          value = {findPosTrapId = 8062374},
          key = {
            LogicType = "Load",
            LogicIndex = 2,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [4] = {
          value = {trapID = 8062374},
          key = {
            LogicType = "Load",
            LogicIndex = 3,
            param = "set"
          },
          type = 2,
          isShow = false
        },
        [5] = {
          value = {trapID = 8062374},
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
    2161,
    1602381,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[739]
  },
  {
    2162,
    1602381,
    2,
    common[18],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[739]
  },
  {
    2163,
    1602381,
    3,
    common[19],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[740]
  },
  {
    2164,
    1602381,
    4,
    common[20],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[740]
  },
  {
    2165,
    1602381,
    5,
    common[20],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[740]
  },
  {
    2166,
    1602381,
    6,
    common[21],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[741]
  },
  {
    2167,
    1602381,
    7,
    common[22],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[741]
  },
  {
    2168,
    1602381,
    8,
    common[23],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[741]
  },
  {
    2169,
    1602381,
    9,
    common[24],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[741]
  },
  {
    2170,
    1602381,
    10,
    common[25],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102385,
        [1] = {
          value = {
            [2002381] = 2102384
          },
          key = {
            LogicType = "Load",
            LogicIndex = 1,
            param = "param"
          },
          type = 2,
          isShow = false
        },
        [2] = {
          value = 0.2,
          key = {},
          type = 2
        }
      }
    }
  },
  {
    2171,
    1602411,
    1,
    common[1],
    30,
    10,
    50,
    0,
    0,
    0,
    0,
    1,
    0.03,
    common[742]
  },
  {
    2172,
    1602411,
    2,
    common[52],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    0,
    0.07,
    common[742]
  },
  {
    2173,
    1602411,
    3,
    common[53],
    60,
    20,
    100,
    0,
    0,
    0,
    0,
    1,
    0.07,
    common[743]
  },
  {
    2174,
    1602411,
    4,
    common[54],
    90,
    30,
    200,
    0,
    0,
    0,
    0,
    0,
    0.11,
    common[743]
  },
  {
    2175,
    1602411,
    5,
    common[54],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    0,
    0.15,
    common[743]
  },
  {
    2176,
    1602411,
    6,
    common[55],
    120,
    40,
    300,
    0,
    0,
    0,
    0,
    1,
    0.15,
    common[744]
  },
  {
    2177,
    1602411,
    7,
    common[56],
    170,
    55,
    450,
    0,
    0,
    0,
    0,
    0,
    0.2,
    common[744]
  },
  {
    2178,
    1602411,
    8,
    common[57],
    220,
    70,
    600,
    0,
    0,
    0,
    0,
    0,
    0.25,
    common[744]
  },
  {
    2179,
    1602411,
    9,
    common[58],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    0,
    0.3,
    common[744]
  },
  {
    2180,
    1602411,
    10,
    common[59],
    270,
    85,
    750,
    0,
    0,
    0,
    0,
    1,
    0.3,
    {
      [1] = {
        BuffID = 4102413,
        [1] = {
          value = 0.4,
          key = {
            LogicType = "Active",
            LogicIndex = 1,
            param = "changeValue"
          },
          type = 2
        }
      }
    }
  }
}
return config, "ID", key
