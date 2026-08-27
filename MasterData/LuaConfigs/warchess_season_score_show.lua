local warchess_season_score_show = {
  {
    intro = 323788,
    need_show = true,
    order_id = 1,
    show_type = 0,
    title = 184100
  },
  {
    id = 2,
    intro = 60459,
    need_show = true,
    order_id = 1,
    show_type = 0,
    title = 218443
  },
  {
    id = 3,
    intro = 406014,
    order_id = 1,
    show_type = 1,
    title = 207258
  },
  [101] = {
    id = 101,
    intro = 90777,
    order_id = 2,
    show_type = 0,
    title = 77830
  },
  [102] = {
    id = 102,
    intro = 444611,
    order_id = 2,
    show_type = 0,
    title = 8064
  },
  [103] = {
    id = 103,
    intro = 41219,
    order_id = 2,
    show_type = 0,
    title = 399082
  },
  [104] = {
    id = 104,
    intro = 366041,
    order_id = 2,
    show_type = 0
  },
  [105] = {
    id = 105,
    intro = 273323,
    order_id = 2,
    show_type = 0,
    title = 63912
  },
  [108] = {
    id = 108,
    intro = 490486,
    order_id = 2,
    show_type = 0,
    title = 401483
  },
  [201] = {
    id = 201,
    intro = 247343,
    title = 247149
  },
  [202] = {
    id = 202,
    intro = 163564,
    title = 67344
  },
  [203] = {
    id = 203,
    intro = 79785,
    title = 364809
  },
  [204] = {
    id = 204,
    intro = 520294,
    title = 44625
  },
  [205] = {
    id = 205,
    intro = 436515,
    title = 224430
  },
  [206] = {
    id = 206,
    intro = 352737,
    title = 512131
  },
  [207] = {
    id = 207,
    intro = 268957,
    title = 508274
  },
  [208] = {
    id = 208,
    intro = 185179,
    title = 307599
  },
  [209] = {id = 209, title = 242779},
  [210] = {
    id = 210,
    intro = 188595,
    title = 422584
  },
  [211] = {
    id = 211,
    intro = 104816,
    title = 257921
  },
  [212] = {
    id = 212,
    intro = 21037,
    title = 409356
  },
  [213] = {
    id = 213,
    intro = 461546,
    title = 219709
  },
  [214] = {
    id = 214,
    intro = 377767,
    title = 386637
  },
  [215] = {
    id = 215,
    intro = 293988,
    title = 235202
  },
  [216] = {
    id = 216,
    intro = 210209,
    title = 329855
  },
  [217] = {
    id = 217,
    intro = 126430,
    title = 363174
  },
  [218] = {
    id = 218,
    intro = 42651,
    title = 265452
  },
  [219] = {
    id = 219,
    intro = 483160,
    title = 60503
  },
  [220] = {
    id = 220,
    intro = 329690,
    title = 433356
  },
  [221] = {
    id = 221,
    intro = 245911,
    title = 75645
  },
  [222] = {
    id = 222,
    intro = 162132,
    title = 264256
  },
  [223] = {
    id = 223,
    intro = 78353,
    title = 177561
  },
  [224] = {
    id = 224,
    intro = 518862,
    title = 241537
  },
  [225] = {
    id = 225,
    intro = 435084,
    title = 52926
  },
  [226] = {
    id = 226,
    intro = 351304,
    title = 184755
  },
  [227] = {
    id = 227,
    intro = 267525,
    title = 321026
  },
  [228] = {
    id = 228,
    intro = 183746,
    title = 406079
  },
  [229] = {
    id = 229,
    intro = 99967,
    title = 439691
  },
  [230] = {
    id = 230,
    intro = 470785,
    title = 251080
  },
  [231] = {
    id = 231,
    intro = 387006,
    title = 454833
  }
}
local __default_values = {
  id = 1,
  intro = 101399,
  need_show = false,
  order_id = 3,
  show_type = 2,
  title = 130375
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_season_score_show) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  sortList = {
    1,
    2,
    3,
    101,
    102,
    103,
    104,
    105,
    108,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    212,
    213,
    214,
    215,
    216,
    217,
    218,
    219,
    220,
    221,
    222,
    223,
    224,
    225,
    226,
    227,
    228,
    229,
    230,
    231
  }
}
setmetatable(warchess_season_score_show, {__index = __rawdata})
return warchess_season_score_show
