UIAircraftRoomFuncSpecailTag = {
  Ambient2Liking = 1,
  RoomAndRelic = 2,
  DoubleCouponStore = 3,
  DrawCouponStore = 4,
  AtomStore = 5,
  AtomDiscount = 6,
  SmeltRoomTip = 7,
  DispatchCount = 8,
  DispatchTeam = 9,
  DispatchRecoverSpeedUp = 10,
  DispatchMaxCount = 11,
  DispatchRecoverOne = 12,
  DispatchTaskMaxStr = 13,
  TapeStorage = 14,
  TapeCountdown = 15,
  TacticWorkSkill = 16,
  none = 999
}
UIAircraftRoomFunctions = {
  [AirRoomType.CentralRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_tip_ambien_ceiling",
        func = "GetAmbientLimit",
        isInt = true
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_tip_ambien_ceiling",
        func = "GetAmbientLimit",
        isInt = true
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_add_furniture_affinity",
        func = "GetAddFurnitureAmbientValue",
        isInt = false,
        isPercent = true
      }
    }
  },
  [AirRoomType.PowerRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_func_power",
        func = "GetPowerLimit",
        isInt = true
      },
      [2] = {
        name = "str_aircraft_func_firefly_recover_speed",
        func = "GetFireflyRecoverSpeed",
        isSpeed = true
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_func_power",
        func = "GetPowerLimit",
        isInt = true
      },
      [2] = {
        name = "str_aircraft_func_firefly_recover_speed",
        func = "GetFireflyRecoverSpeed",
        isSpeed = true
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_func_power",
        func = "GetPowerLimit",
        isInt = true
      },
      [2] = {
        name = "str_aircraft_func_firefly_recover_speed",
        func = "GetFireflyRecoverSpeed",
        isSpeed = true
      }
    }
  },
  [AirRoomType.MazeRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_func_MS_reset_time",
        func = "GetResetTime",
        countDown = true
      },
      [2] = {
        name = "str_aircraft_func_light_recover_speed",
        func = "GetLightSpeed"
      },
      [3] = {
        name = "str_aircraft_maze_coin_increase_to",
        func = "GetMazeCoinIncrease",
        isPercent = true
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_func_MS_reset_time",
        func = "GetResetTime",
        countDown = true
      },
      [2] = {
        name = "str_aircraft_func_light_recover_speed",
        func = "GetLightSpeed"
      },
      [3] = {
        name = "str_aircraft_maze_coin_increase_to",
        func = "GetMazeCoinIncrease",
        isPercent = true
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_func_light_recover_speed",
        func = "GetLightSpeed"
      }
    }
  },
  [AirRoomType.ResourceRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_func_double_coupon_store",
        func = "GetResCardCount",
        isInt = true,
        specialTag = UIAircraftRoomFuncSpecailTag.DoubleCouponStore
      },
      [2] = {
        name = "str_aircraft_func_double_coupon_recover",
        func = "GetResCardLeftCDTime",
        countDown = true
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_func_resource_level",
        func = "GetCoinDungeonLevel",
        isInt = true
      },
      [2] = {
        name = "str_aircraft_func_double_coupon_store",
        func = "GetResCardCount",
        isInt = true,
        specialTag = UIAircraftRoomFuncSpecailTag.DoubleCouponStore
      },
      [3] = {
        name = "str_aircraft_func_double_coupon_recover",
        func = "GetResCardLeftCDTime",
        countDown = true
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_func_double_coupon_recover",
        func = "GetResCardCD",
        isPercent = true,
        isNagative = true
      },
      [2] = {
        name = "str_aircraft_func_double_coupon_store",
        func = "GetResCardLimit"
      }
    }
  },
  [AirRoomType.PrismRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_func_phys_ceiling",
        func = "GetPhysicStorageLimit",
        isInt = true
      },
      [2] = {
        name = "str_aircraft_func_phys_recover_speed",
        func = "GetPhysicSpeed",
        isInt = false
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_func_phys_ceiling_added",
        func = "GetExPhysicLimit",
        isInt = true
      },
      [2] = {
        name = "str_aircraft_func_phys_ceiling",
        func = "GetPhysicStorageLimit",
        isInt = true
      },
      [3] = {
        name = "str_aircraft_func_phys_recover_speed",
        func = "GetPhysicSpeed",
        isInt = false
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_func_phys_ceiling",
        func = "GetPhysicStorageLimit",
        isInt = true
      },
      [2] = {
        name = "str_aircraft_func_phys_recover_speed",
        func = "GetPhysicSpeed",
        isInt = false
      }
    }
  },
  [AirRoomType.TowerRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_func_card_ceiling",
        func = "GetDrawCardCount",
        isInt = true,
        specialTag = UIAircraftRoomFuncSpecailTag.DrawCouponStore
      },
      [2] = {
        name = "str_aircraft_func_card_recover",
        func = "GetDrawCardSpeed"
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_func_card_ceiling",
        func = "GetDrawCardCount",
        isInt = true,
        specialTag = UIAircraftRoomFuncSpecailTag.DrawCouponStore
      },
      [2] = {
        name = "str_aircraft_func_card_recover",
        func = "GetDrawCardSpeed"
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_func_card_recover",
        func = "GetDrawCardSpeed"
      },
      [2] = {
        name = "str_aircraft_func_card_ceiling",
        func = "GetOutputLimit"
      }
    }
  },
  [AirRoomType.SmeltRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_atom_store",
        specialTag = UIAircraftRoomFuncSpecailTag.AtomStore
      },
      [2] = {
        name = "str_aircraft_atom_recover_speed",
        func = "GetOneSpeed"
      },
      [3] = {
        name = "str_aircraft_atom_discount",
        specialTag = UIAircraftRoomFuncSpecailTag.AtomDiscount
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_atom_store",
        specialTag = UIAircraftRoomFuncSpecailTag.AtomStore
      },
      [2] = {
        name = "str_aircraft_atom_recover_speed",
        func = "GetOneSpeed"
      },
      [3] = {
        specialTag = UIAircraftRoomFuncSpecailTag.SmeltRoomTip
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_atom_discount",
        specialTag = UIAircraftRoomFuncSpecailTag.AtomDiscount
      }
    }
  },
  [AirRoomType.DispatchRoom] = {
    roomFunc = {
      [1] = {
        name = "str_dispatch_room_dispatch_count",
        specialTag = UIAircraftRoomFuncSpecailTag.DispatchCount
      },
      [2] = {
        name = "str_dispatch_room_dispatch_recover",
        func = "GetSurplusSecond",
        countDown = true
      },
      [3] = {
        name = "str_dispatch_room_dispatch_team",
        specialTag = UIAircraftRoomFuncSpecailTag.DispatchTeam
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_dispatch_room_dispatch_max_count",
        specialTag = UIAircraftRoomFuncSpecailTag.DispatchMaxCount
      },
      [2] = {
        name = "str_dispatch_room_recover_one_dispatch",
        specialTag = UIAircraftRoomFuncSpecailTag.DispatchRecoverOne
      },
      [3] = {
        name = "str_dispatch_room_task_max_star",
        specialTag = UIAircraftRoomFuncSpecailTag.DispatchTaskMaxStr
      }
    },
    settleFunc = {
      [1] = {
        name = "str_dispatch_room_dispatch_recover_speed_up",
        specialTag = UIAircraftRoomFuncSpecailTag.DispatchRecoverSpeedUp
      }
    }
  },
  [AirRoomType.TacticRoom] = {
    roomFunc = {
      [1] = {
        name = "str_aircraft_tactic_tape_storage",
        specialTag = UIAircraftRoomFuncSpecailTag.TapeStorage
      },
      [2] = {
        name = "str_aircraft_tactic_tape_production",
        specialTag = UIAircraftRoomFuncSpecailTag.TapeCountdown
      },
      [3] = {
        name = "str_aircraft_tactic_weekly_free_make_times",
        func = "GetWeeklyFreeMakeLimit",
        isInt = true
      }
    },
    facilityFunc = {
      [1] = {
        name = "str_aircraft_tactic_tape_storage",
        specialTag = UIAircraftRoomFuncSpecailTag.TapeStorage
      },
      [2] = {
        name = "str_aircraft_tactic_tape_production",
        func = "GetCartridgeDeltaTime",
        countDown = true
      },
      [3] = {
        name = "str_aircraft_tactic_weekly_free_make_times",
        func = "GetWeeklyFreeMakeLimit",
        isInt = true
      }
    },
    settleFunc = {
      [1] = {
        name = "str_aircraft_tactic_make_speedup",
        specialTag = UIAircraftRoomFuncSpecailTag.TacticWorkSkill
      }
    }
  },
  [AirRoomType.RestRoom] = {
    roomFunc = {}
  },
  [AirRoomType.CoffeeRoom] = {
    roomFunc = {}
  },
  [AirRoomType.WaterBarRoom] = {
    roomFunc = {}
  },
  [AirRoomType.GameRoom] = {
    roomFunc = {}
  }
}
