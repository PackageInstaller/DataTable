__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local RobotConfig = readonly({
  [1] = {
    ID = 1,
    UpperLimit = 1,
    LowerLimit = 500,
    RobotID = {20},
    RobotLevel = 80
  },
  [2] = {
    ID = 2,
    UpperLimit = 501,
    LowerLimit = 1000,
    RobotID = {19},
    RobotLevel = 78
  },
  [3] = {
    ID = 3,
    UpperLimit = 1001,
    LowerLimit = 1500,
    RobotID = {18},
    RobotLevel = 76
  },
  [4] = {
    ID = 4,
    UpperLimit = 1501,
    LowerLimit = 2000,
    RobotID = {17},
    RobotLevel = 74
  },
  [5] = {
    ID = 5,
    UpperLimit = 2001,
    LowerLimit = 2500,
    RobotID = {16},
    RobotLevel = 72
  },
  [6] = {
    ID = 6,
    UpperLimit = 2501,
    LowerLimit = 3000,
    RobotID = {15},
    RobotLevel = 70
  },
  [7] = {
    ID = 7,
    UpperLimit = 3001,
    LowerLimit = 3500,
    RobotID = {14},
    RobotLevel = 68
  },
  [8] = {
    ID = 8,
    UpperLimit = 3501,
    LowerLimit = 4000,
    RobotID = {13},
    RobotLevel = 66
  },
  [9] = {
    ID = 9,
    UpperLimit = 4001,
    LowerLimit = 4500,
    RobotID = {12},
    RobotLevel = 64
  },
  [10] = {
    ID = 10,
    UpperLimit = 4501,
    LowerLimit = 5000,
    RobotID = {11},
    RobotLevel = 62
  },
  [11] = {
    ID = 11,
    UpperLimit = 5001,
    LowerLimit = 5500,
    RobotID = {10},
    RobotLevel = 60
  },
  [12] = {
    ID = 12,
    UpperLimit = 5501,
    LowerLimit = 6000,
    RobotID = {9},
    RobotLevel = 58
  },
  [13] = {
    ID = 13,
    UpperLimit = 6001,
    LowerLimit = 6500,
    RobotID = {8},
    RobotLevel = 56
  },
  [14] = {
    ID = 14,
    UpperLimit = 6501,
    LowerLimit = 7000,
    RobotID = {7},
    RobotLevel = 54
  },
  [15] = {
    ID = 15,
    UpperLimit = 7001,
    LowerLimit = 7500,
    RobotID = {6},
    RobotLevel = 52
  },
  [16] = {
    ID = 16,
    UpperLimit = 7501,
    LowerLimit = 8000,
    RobotID = {5},
    RobotLevel = 50
  },
  [17] = {
    ID = 17,
    UpperLimit = 8001,
    LowerLimit = 8500,
    RobotID = {4},
    RobotLevel = 48
  },
  [18] = {
    ID = 18,
    UpperLimit = 8501,
    LowerLimit = 9000,
    RobotID = {3},
    RobotLevel = 46
  },
  [19] = {
    ID = 19,
    UpperLimit = 9001,
    LowerLimit = 9500,
    RobotID = {2},
    RobotLevel = 44
  },
  [20] = {
    ID = 20,
    UpperLimit = 9501,
    LowerLimit = 10000,
    RobotID = {1},
    RobotLevel = 42
  }
})
return RobotConfig
