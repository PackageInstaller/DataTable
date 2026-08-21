local key = {ID = 1, PhaseParam = 2}
local config = {
  {
    1,
    {
      {
        [1] = {Type = "Anim", Param = "Lottery"},
        [2] = {Type = "Audio", Param = 2498},
        [3] = {Type = "Effect", Param = 3781},
        [4] = {Type = "Effect", Param = 3764},
        [5] = {Type = "Wait", Param = 3000},
        [6] = {Type = "Effect", Param = 3765},
        [7] = {Type = "Wait", Param = 200},
        [8] = {Type = "Hit", Param = "Hit"},
        [9] = {Type = "Wait", Param = 500},
        [10] = {Type = "Effect", Param = 3751}
      }
    }
  },
  {
    2,
    {
      {
        [1] = {Type = "Anim", Param = "AtkChain"},
        [2] = {Type = "Audio", Param = 2497},
        [3] = {Type = "Effect", Param = 3711},
        [4] = {Type = "Effect", Param = 3754},
        [5] = {Type = "Wait", Param = 1700},
        [6] = {Type = "Hit", Param = "Hit"},
        [7] = {Type = "Effect", Param = 3755},
        [8] = {Type = "Wait", Param = 500},
        [9] = {Type = "Effect", Param = 3750}
      }
    }
  }
}
return config, "ID", key
