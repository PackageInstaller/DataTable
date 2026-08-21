local key = {ID = 1, PhaseParam = 2}
local config = {
  {
    1,
    {
      {
        [1] = {Type = "Anim", Param = "AtkUlt"},
        [2] = {Type = "Audio", Param = 2489},
        [3] = {Type = "Effect", Param = 3730},
        [4] = {Type = "Wait", Param = 700},
        [5] = {Type = "Effect", Param = 3768},
        [6] = {Type = "Wait", Param = 1500},
        [7] = {Type = "Effect", Param = 3769},
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
        [2] = {Type = "Audio", Param = 2488},
        [3] = {Type = "Effect", Param = 3758},
        [4] = {Type = "Wait", Param = 800},
        [5] = {Type = "Effect", Param = 3759},
        [6] = {Type = "Wait", Param = 200},
        [7] = {Type = "Hit", Param = "Hit"},
        [8] = {Type = "Wait", Param = 500},
        [9] = {Type = "Effect", Param = 3750}
      }
    }
  }
}
return config, "ID", key
