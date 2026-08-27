local shop_classification = {
  {
    icon = "Icon_recharge",
    name = 123697,
    sub_ids = {801}
  },
  {
    icon = "Icon_pack",
    id = 2,
    name = 491765,
    soldout = 1,
    sub_ids = {
      901,
      902,
      903,
      904
    }
  },
  {
    icon = "Icon_furniture",
    id = 3,
    name = 313098,
    sub_ids = {
      119,
      118,
      117,
      116,
      115,
      114,
      113,
      112,
      111,
      110,
      109,
      108,
      107,
      106,
      105,
      104,
      103,
      102,
      101
    }
  },
  {
    icon = "Icon_skin",
    id = 4,
    name = 421882,
    special_id = 702,
    sub_ids = {
      701,
      704,
      706
    }
  },
  {
    id = 5,
    name = 60812,
    sub_ids = {403}
  },
  {
    icon = "icon_vow",
    id = 6,
    name = 87120,
    sub_ids = {705}
  },
  {
    icon = "Icon_item",
    id = 7,
    sub_ids = {
      204,
      1003,
      1002,
      1004,
      206
    }
  },
  {
    icon = "Icon_souvenir",
    id = 8,
    name = 6393
  },
  {
    icon = "Icon_special",
    id = 9,
    name = 218266,
    sub_ids = {203}
  }
}
local __default_values = {
  icon = "Icon_fragments",
  id = 1,
  name = 117630,
  name_en = "",
  soldout = 0,
  special_id = 0,
  sub_ids = {1038, 1039}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(shop_classification) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  showShopDic = {
    [101] = true,
    [102] = true,
    [103] = true,
    [104] = true,
    [105] = true,
    [106] = true,
    [107] = true,
    [108] = true,
    [109] = true,
    [110] = true,
    [111] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [115] = true,
    [116] = true,
    [117] = true,
    [118] = true,
    [119] = true,
    [203] = true,
    [204] = true,
    [206] = true,
    [403] = true,
    [701] = true,
    [704] = true,
    [705] = true,
    [706] = true,
    [801] = true,
    [901] = true,
    [902] = true,
    [903] = true,
    [904] = true,
    [1002] = true,
    [1003] = true,
    [1004] = true,
    [1038] = true,
    [1039] = true
  }
}
setmetatable(shop_classification, {__index = __rawdata})
return shop_classification
