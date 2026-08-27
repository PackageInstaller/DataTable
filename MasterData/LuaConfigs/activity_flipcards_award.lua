local __rt_1 = {
  [6003] = 3
}
local __rt_2 = {
  [1504] = 5
}
local __rt_3 = {
  [1002] = 100
}
local __rt_4 = {
  [1502] = 5
}
local __rt_5 = {
  [6003] = 1
}
local __rt_6 = {
  [1920] = 1000
}
local __rt_7 = {
  [3002] = 5
}
local __rt_8 = {
  [1920] = 1500
}
local __rt_9 = {
  [8103] = 10
}
local __rt_10 = {
  [5009] = 1
}
local activity_flipcards_award = {
  [10001] = {
    reward = {
      [400077] = 1
    }
  },
  [10002] = {
    reward = {
      [1002] = 1000
    },
    reward_id = 10002
  },
  [10003] = {reward = __rt_1, reward_id = 10003},
  [10004] = {reward_id = 10004},
  [10005] = {reward = __rt_3, reward_id = 10005},
  [10006] = {reward = __rt_4, reward_id = 10006},
  [10007] = {reward = __rt_5, reward_id = 10007},
  [10008] = {
    reward = {
      [5002] = 40
    },
    reward_id = 10008
  },
  [10009] = {
    reward = {
      [5002] = 80
    },
    reward_id = 10009
  },
  [10010] = {reward_id = 10010},
  [10011] = {reward = __rt_6, reward_id = 10011},
  [10012] = {reward = __rt_7, reward_id = 10012},
  [10013] = {reward = __rt_6, reward_id = 10013},
  [10014] = {reward = __rt_8, reward_id = 10014},
  [10015] = {
    reward = {
      [8102] = 10
    },
    reward_id = 10015
  },
  [10016] = {reward = __rt_9, reward_id = 10016},
  [10017] = {
    reward = {
      [410069] = 1
    },
    reward_id = 10017
  },
  [10018] = {
    reward = {
      [3001] = 10
    },
    reward_id = 10018
  },
  [10019] = {
    reward = {
      [721070] = 1
    },
    reward_id = 10019
  },
  [10020] = {
    reward = {
      [303708] = 1
    },
    reward_id = 10020
  },
  [10021] = {reward = __rt_10, reward_id = 10021},
  [10022] = {reward = __rt_3, reward_id = 10022},
  [10023] = {reward = __rt_7, reward_id = 10023},
  [10024] = {reward = __rt_8, reward_id = 10024},
  [10025] = {reward = __rt_5, reward_id = 10025},
  [10026] = {reward = __rt_1, reward_id = 10026},
  [10027] = {
    reward = {
      [5007] = 10
    },
    reward_id = 10027
  },
  [10028] = {
    reward = {
      [5007] = 20
    },
    reward_id = 10028
  },
  [10029] = {reward = __rt_4, reward_id = 10029},
  [10030] = {reward_id = 10030},
  [10031] = {
    reward = {
      [1504] = 10
    },
    reward_id = 10031
  },
  [10032] = {reward_id = 10032},
  [10033] = {reward = __rt_10, reward_id = 10033},
  [10034] = {reward = __rt_3, reward_id = 10034},
  [10035] = {
    reward = {
      [3002] = 2
    },
    reward_id = 10035
  },
  [10036] = {
    reward = {
      [3002] = 3
    },
    reward_id = 10036
  },
  [10037] = {
    reward = {
      [1018] = 200
    },
    reward_id = 10037
  },
  [10038] = {reward = __rt_5, reward_id = 10038},
  [10039] = {reward = __rt_1, reward_id = 10039},
  [10040] = {reward = __rt_4, reward_id = 10040},
  [10041] = {reward_id = 10041},
  [10042] = {
    reward = {
      [5010] = 1
    },
    reward_id = 10042
  },
  [10043] = {reward = __rt_9, reward_id = 10043},
  [10044] = {
    reward = {
      [8103] = 15
    },
    reward_id = 10044
  },
  [10045] = {
    reward = {
      [400087] = 1
    },
    reward_id = 10045
  },
  [10046] = {
    reward = {
      [410079] = 1
    },
    reward_id = 10046
  },
  [10047] = {
    reward = {
      [721077] = 1
    },
    reward_id = 10047
  },
  [10048] = {
    reward = {
      [301808] = 1
    },
    reward_id = 10048
  }
}
local __default_values = {reward = __rt_2, reward_id = 10001}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_flipcards_award) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_flipcards_award, {__index = __rawdata})
return activity_flipcards_award
