local key = {
  ID = 1,
  Probability = 2,
  Desc = 3,
  BreedSprite = 4,
  BreedSpriteEffect = 5,
  BreedSpriteAnim = 6,
  BreedLandEffect = 7,
  LoopInterval = 8,
  RandomValue = 9
}
local config = {
  {
    1,
    0.02,
    "str_homeland_breed_mini_probability",
    1022001,
    {
      [1] = {
        {
          "eff_jy_1022001_zhaohuan",
          2000
        },
        {
          "eff_jy_1022001_shifei_Dummy001",
          5000
        },
        {
          "eff_jy_1022001_jiaoshui",
          2700
        },
        {
          "eff_jy_1022001_xiaoshi",
          1000
        }
      }
    },
    {
      "zhaohuan",
      "shifei",
      "jiaoshui"
    },
    {
      [1] = {
        {
          "eff_jy_pt_bianhuan",
          3100
        },
        {
          "eff_jy_pt_bianhuan_01",
          2500
        },
        {
          "eff_jy_pt_bianhuan_02",
          2800
        }
      }
    },
    60,
    {1, 30}
  },
  {
    2,
    0.1,
    "str_homeland_breed_small_probability"
  },
  {
    3,
    0.3,
    "str_homeland_breed_middle_probability"
  },
  {
    4,
    1,
    "str_homeland_breed_big_probability"
  }
}
return config, "ID", key
