local System = require("System.System")
local readonly = System.readonly
local ShieldConfig = readonly({
  [1] = {
    ShieldSfx = 1,
    Size = 1,
    HitSfx = {14884},
    BrokenSfx = {14565}
  },
  [2] = {
    ShieldSfx = 2,
    Size = 0.7,
    BuildSfx = {14630},
    IdleSfx = {14543},
    HitSfx = {14655},
    BrokenSfx = {14850}
  },
  [3] = {
    ShieldSfx = 3,
    Size = 0.85,
    BuildSfx = {14630},
    IdleSfx = {14543},
    HitSfx = {14655},
    BrokenSfx = {14850}
  },
  [4] = {
    ShieldSfx = 4,
    Size = 1.4,
    BuildSfx = {14630},
    IdleSfx = {14543},
    HitSfx = {14655},
    BrokenSfx = {14850}
  },
  [5] = {
    ShieldSfx = 5,
    Size = 2,
    BuildSfx = {14630},
    IdleSfx = {14543},
    HitSfx = {14655},
    BrokenSfx = {14850}
  },
  [6] = {
    ShieldSfx = 6,
    Size = 3.45,
    BuildSfx = {14630},
    IdleSfx = {14543},
    HitSfx = {14655},
    BrokenSfx = {14850}
  },
  [8] = {
    ShieldSfx = 8,
    Size = 2.5,
    BuildSfx = {61541},
    IdleSfx = {61543},
    HitSfx = {61545},
    BrokenSfx = {61542}
  }
})
return ShieldConfig
