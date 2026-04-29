local key = {
  Id = 1,
  Title = 2,
  Main = 3,
  Bg = 4,
  TitleOffset = 5,
  Info = 6
}
local common = {
  "n19_chuanshanjia_di3",
  {
    -800,
    293,
    556,
    526
  }
}
local config = {
  [106402503] = {
    106402503,
    "n19_chuanshanjia_tittle",
    "n19_chuanshanjia_image01",
    common[1],
    common[2],
    "str_homeland_campainenter_title_1"
  },
  [106702505] = {
    106702505,
    "n21_swimgame_tittle",
    "n19_yyqy_image01",
    common[1],
    {
      -710,
      293,
      556,
      526
    },
    "str_homeland_campainenter_title"
  },
  [106902506] = {
    106902506,
    "n23_filmgame_tittle",
    "qy_dyqy_image01",
    common[1],
    common[2],
    "str_homeland_campainenter_title_dy"
  },
  [107202505] = {
    107202505,
    "N24_dy_tittle",
    "qy_dyqy_di",
    common[1],
    common[2],
    "str_homeland_campainenter_title_2"
  }
}
return config, "Id", key
