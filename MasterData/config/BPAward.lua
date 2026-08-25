local System = require("System.System")
local readonly = System.readonly
local BPAward = readonly({
  [0] = {
    Level = 0,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 10000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 30000
    })
  },
  [1] = {
    Level = 1,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 10000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 30000
    })
  },
  [2] = {
    Level = 2,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 10000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 30000
    })
  },
  [3] = {
    Level = 3,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 14000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 42000
    })
  },
  [4] = {
    Level = 4,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 14000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 42000
    })
  },
  [5] = {
    Level = 5,
    Exp = 1000,
    FreeAward = readonly({
      [9803] = 1
    }),
    PayAward = readonly({
      [9567] = 50,
      [9803] = 1,
      [9966] = 10
    })
  },
  [6] = {
    Level = 6,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 18000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 54000
    })
  },
  [7] = {
    Level = 7,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 18000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 54000
    })
  },
  [8] = {
    Level = 8,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 22000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 66000
    })
  },
  [9] = {
    Level = 9,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 22000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 66000
    })
  },
  [10] = {
    Level = 10,
    Exp = 1000,
    FreeAward = readonly({
      [9719] = 3
    }),
    PayAward = readonly({
      [9567] = 50,
      [9802] = 3,
      [9966] = 20
    })
  },
  [11] = {
    Level = 11,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 26000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 78000
    })
  },
  [12] = {
    Level = 12,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 26000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 78000
    })
  },
  [13] = {
    Level = 13,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 30000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 90000
    })
  },
  [14] = {
    Level = 14,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 30000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 90000
    })
  },
  [15] = {
    Level = 15,
    Exp = 1000,
    FreeAward = readonly({
      [9803] = 1
    }),
    PayAward = readonly({
      [9567] = 50,
      [9803] = 1,
      [9966] = 30
    })
  },
  [16] = {
    Level = 16,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 34000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 102000
    })
  },
  [17] = {
    Level = 17,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 34000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 102000
    })
  },
  [18] = {
    Level = 18,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 38000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 114000
    })
  },
  [19] = {
    Level = 19,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 38000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 114000
    })
  },
  [20] = {
    Level = 20,
    Exp = 1000,
    FreeAward = readonly({
      [9719] = 3
    }),
    PayAward = readonly({
      [9567] = 50,
      [9802] = 3,
      [9966] = 40
    })
  },
  [21] = {
    Level = 21,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 42000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 126000
    })
  },
  [22] = {
    Level = 22,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 42000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 126000
    })
  },
  [23] = {
    Level = 23,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 46000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 138000
    })
  },
  [24] = {
    Level = 24,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 46000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 138000
    })
  },
  [25] = {
    Level = 25,
    Exp = 1000,
    FreeAward = readonly({
      [9803] = 2
    }),
    PayAward = readonly({
      [9567] = 50,
      [9803] = 2,
      [9966] = 50
    })
  },
  [26] = {
    Level = 26,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [27] = {
    Level = 27,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [28] = {
    Level = 28,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [29] = {
    Level = 29,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [30] = {
    Level = 30,
    Exp = 1000,
    FreeAward = readonly({
      [9719] = 3
    }),
    PayAward = readonly({
      [9567] = 50,
      [9802] = 3,
      [9966] = 60
    })
  },
  [31] = {
    Level = 31,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [32] = {
    Level = 32,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [33] = {
    Level = 33,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [34] = {
    Level = 34,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [35] = {
    Level = 35,
    Exp = 1000,
    FreeAward = readonly({
      [9803] = 2
    }),
    PayAward = readonly({
      [9567] = 50,
      [9803] = 2,
      [9966] = 60
    })
  },
  [36] = {
    Level = 36,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [37] = {
    Level = 37,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [38] = {
    Level = 38,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [39] = {
    Level = 39,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [40] = {
    Level = 40,
    Exp = 1000,
    FreeAward = readonly({
      [9719] = 3
    }),
    PayAward = readonly({
      [9567] = 50,
      [9802] = 3,
      [9926] = 1
    })
  },
  [41] = {
    Level = 41,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [42] = {
    Level = 42,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [43] = {
    Level = 43,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [44] = {
    Level = 44,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [45] = {
    Level = 45,
    Exp = 1000,
    FreeAward = readonly({
      [9543] = 1
    }),
    PayAward = readonly({
      [9543] = 3,
      [9567] = 50,
      [9966] = 60
    })
  },
  [46] = {
    Level = 46,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [47] = {
    Level = 47,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [48] = {
    Level = 48,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [49] = {
    Level = 49,
    Exp = 1000,
    FreeAward = readonly({
      [10108] = 50000
    }),
    PayAward = readonly({
      [9567] = 50,
      [10108] = 150000
    })
  },
  [50] = {
    Level = 50,
    Exp = 0,
    FreeAward = readonly({
      [9522] = 100
    }),
    PayAward = readonly({
      [9522] = 300,
      [9567] = 50,
      [9966] = 60
    })
  }
})
return BPAward
