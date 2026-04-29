local key = {ID = 1, PhaseParam = 2}
local config = {
  {
    1,
    {
      {
        [1] = {Type = "Anim", Param = "AtkUlt"},
        [2] = {Type = "Audio", Param = 2492},
        [3] = {Type = "Effect", Param = 3770},
        [4] = {Type = "Wait", Param = 800},
        [5] = {Type = "Effect", Param = 3771},
        [6] = {Type = "Wait", Param = 200},
        [7] = {Type = "Hit", Param = "Hit"},
        [8] = {Type = "Wait", Param = 500},
        [9] = {Type = "Effect", Param = 3751}
      }
    }
  },
  {
    2,
    {
      {
        [1] = {Type = "Anim", Param = "AtkChain"},
        [2] = {Type = "Audio", Param = 2491},
        [3] = {Type = "Effect", Param = 3760},
        [4] = {Type = "Wait", Param = 2300},
        [5] = {Type = "Effect", Param = 3761},
        [6] = {Type = "Hit", Param = "Hit"},
        [7] = {Type = "Wait", Param = 200},
        [8] = {Type = "Effect", Param = 3750}
      }
    }
  }
}
return config, "ID", key
