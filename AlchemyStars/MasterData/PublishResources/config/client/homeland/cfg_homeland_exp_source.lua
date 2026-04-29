local key = {
  ID = 1,
  Name = 2,
  Params = 3
}
local config = {
  {
    1,
    "str_homeland_exp_source_1",
    {
      [1] = {
        "str_homeland_exp_source_1_1",
        20
      },
      [2] = {
        "str_homeland_exp_source_1_2",
        30
      },
      [3] = {
        "str_homeland_exp_source_1_3",
        50
      },
      [4] = {
        "str_homeland_exp_source_1_4",
        100
      }
    }
  },
  {
    2,
    "str_homeland_exp_source_2",
    {
      [1] = {
        "str_homeland_exp_source_2_1",
        20
      },
      [2] = {
        "str_homeland_exp_source_2_2",
        30
      },
      [3] = {
        "str_homeland_exp_source_2_3",
        50
      }
    }
  },
  {
    3,
    "str_homeland_exp_source_3",
    {
      [1] = {
        "str_homeland_exp_source_3_1",
        20
      },
      [2] = {
        "str_homeland_exp_source_3_2",
        30
      }
    }
  }
}
return config, "ID", key
