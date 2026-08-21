local key = {ID = 1, PhaseParam = 2}
local config = {
  {
    1,
    {
      {
        [1] = {Type = "Anim", Param = "AtkUlt"},
        [2] = {Type = "Audio", Param = 2416},
        [3] = {Type = "Effect", Param = 3762},
        [4] = {Type = "Effect", Param = 3745},
        [5] = {Type = "Wait", Param = 1000},
        [6] = {Type = "Effect", Param = 3763},
        [7] = {Type = "Wait", Param = 800},
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
        [2] = {Type = "Audio", Param = 2416},
        [3] = {Type = "Effect", Param = 3742},
        [4] = {Type = "Effect", Param = 3752},
        [5] = {Type = "Wait", Param = 1600},
        [6] = {Type = "Effect", Param = 3753},
        [7] = {Type = "Wait", Param = 200},
        [8] = {Type = "Hit", Param = "Hit"},
        [9] = {Type = "Wait", Param = 500},
        [10] = {Type = "Effect", Param = 3750}
      }
    }
  }
}
return config, "ID", key
