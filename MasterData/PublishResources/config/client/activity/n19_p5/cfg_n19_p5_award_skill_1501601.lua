local key = {ID = 1, PhaseParam = 2}
local config = {
  {
    1,
    {
      {
        [1] = {Type = "Anim", Param = "AtkUlt"},
        [2] = {Type = "Audio", Param = 2486},
        [3] = {Type = "Effect", Param = 3782},
        [4] = {Type = "Effect", Param = 3766},
        [5] = {Type = "Wait", Param = 300},
        [6] = {Type = "Effect", Param = 3767},
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
        [2] = {Type = "Audio", Param = 2485},
        [3] = {Type = "Effect", Param = 3782},
        [4] = {Type = "Effect", Param = 3756},
        [5] = {Type = "Wait", Param = 700},
        [6] = {Type = "Wait", Param = 200},
        [7] = {Type = "Hit", Param = "Hit"},
        [8] = {Type = "Wait", Param = 500},
        [9] = {Type = "Effect", Param = 3750}
      }
    }
  }
}
return config, "ID", key
