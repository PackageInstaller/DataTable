local key = {
  id = 1,
  title = 2,
  desc = 3,
  extra = 4,
  movie = 5
}
local common = {
  "guide_lineskillrange"
}
local config = {
  {
    1,
    "str_guide_pop_title_lineskill",
    "str_guide_pop_desc_lineskill",
    "str_guide_pop_extra_lineskill",
    "guide_lineskill"
  },
  {
    2,
    "str_guide_pop_title_moreline",
    "str_guide_pop_desc_moreline",
    "str_guide_pop_extra_moreline",
    "guide_moreline"
  },
  {
    3,
    "str_guide_pop_title_mainskill1",
    "str_guide_pop_desc_mainskill1",
    "str_guide_pop_extra_mainskill1",
    "guide_mainskill1"
  },
  {
    4,
    "str_guide_pop_title_mainskill2",
    "str_guide_pop_desc_mainskill2",
    "str_guide_pop_extra_mainskill2",
    "guide_mainskill2"
  },
  [6] = {
    6,
    "str_guide_pop_title_levelup",
    "str_guide_pop_desc_levelup",
    "str_guide_pop_extra_levelup",
    common[1]
  },
  [7] = {
    7,
    "str_guide_pop_title_lineskillrange",
    "str_guide_pop_desc_lineskillrange",
    "str_guide_pop_extra_lineskillrange",
    common[1]
  },
  [8] = {
    8,
    "str_guide_pop_title_leaderskill",
    "str_guide_pop_desc_leaderskill",
    "str_guide_pop_extra_leaderskill",
    common[1]
  },
  [9] = {
    9,
    "str_guide_pop_title_jiguan",
    "str_guide_pop_desc_jiguan",
    "str_guide_pop_extra_jiguan",
    common[1]
  },
  [10] = {
    10,
    "str_guide_pop_title_muchaoguai",
    "str_guide_pop_desc_muchaoguai",
    "str_guide_pop_extra_muchaoguai",
    common[1]
  },
  [11] = {
    11,
    "str_guide_pop_title_shenyuan",
    "str_guide_pop_desc_shenyuan",
    "str_guide_pop_extra_shenyuan",
    common[1]
  },
  [12] = {
    12,
    "str_guide_pop_title_moredamge",
    "str_guide_pop_desc_moredamge",
    "str_guide_pop_extra_moredamge",
    "guide_moredamage"
  },
  [13] = {
    13,
    "str_guide_pop_title_leveltask",
    "str_guide_pop_desc_leveltask",
    "str_guide_pop_extra_leveltask",
    common[1]
  },
  [14] = {
    14,
    "str_guide_pop_title_escape",
    "str_guide_pop_desc_escape",
    "str_guide_pop_extra_escape",
    common[1]
  },
  [15] = {
    15,
    "str_guide_pop_title_monsterinfo",
    "str_guide_pop_desc_monsterinfo",
    "str_guide_pop_extra_monsterinfo",
    "guide_monsterinfo"
  },
  [16] = {
    16,
    "str_guide_pop_title_jiguangshike",
    "str_guide_pop_desc_jiguangshike",
    "str_guide_pop_extra_jiguangshike",
    "guide_aurora"
  },
  [17] = {
    17,
    "str_guide_pop_title_jianglihuihe",
    "str_guide_pop_desc_jianglihuihe",
    "str_guide_pop_extra_jianglihuihe",
    "guide_goldcoin"
  }
}
return config, "id", key
