local System = require("System.System")
local readonly = System.readonly
local MockDataConfig = readonly({
  [1] = {
    MockID = 1,
    MockName = "模拟1",
    BattleID = 8709,
    StageID = 35129,
    Hp = 9999,
    MaxHp = 9999,
    Awakers = {
      15595,
      15585,
      15569,
      15570
    },
    Relics = {13782},
    Levels = {
      60,
      60,
      60,
      60
    },
    Potencies = {
      15,
      15,
      15,
      15
    },
    SkillLevels = {
      6,
      6,
      6,
      6,
      6,
      6
    },
    BreakLevels = {
      5,
      5,
      5,
      5
    }
  },
  [2] = {
    MockID = 2,
    MockName = "模拟2",
    BattleID = 8709,
    StageID = 8128,
    Hp = 9999,
    MaxHp = 9999,
    Awakers = {
      15595,
      15585,
      15569,
      15570
    },
    Relics = {13896, 13901},
    Levels = {
      1,
      1,
      1,
      1
    },
    Potencies = {
      15,
      15,
      15,
      15
    },
    SkillLevels = {
      1,
      1,
      1,
      1
    },
    BreakLevels = {
      0,
      0,
      0,
      0
    },
    Weapons = {
      9644,
      9577,
      9881,
      9588
    },
    Trinket1 = {
      10103,
      10115,
      9655,
      9554,
      10102,
      9627
    },
    Trinket2 = {
      9576,
      9731,
      9648,
      9509,
      9665,
      9952
    },
    Trinket3 = {
      9894,
      9894,
      9894,
      9894,
      9797,
      9879
    },
    Trinket4 = {
      9867,
      10059,
      10029,
      10110,
      9893,
      9872
    }
  }
})
return MockDataConfig
