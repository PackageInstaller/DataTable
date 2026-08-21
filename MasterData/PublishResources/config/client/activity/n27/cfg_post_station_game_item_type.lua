local key = {
  ItemType = 1,
  Icon = 2,
  TabIconUnSelect = 3,
  TabIconSelect = 4,
  Name = 5
}
local common = {
  "n27_yz_wf_foodicon01",
  "n27_yz_wf_drinkicon01",
  "n27_yz_wf_gifticon01",
  "n27_yz_wf_clothicon01",
  "n27_yz_wf_packicon01"
}
local config = {
  {
    1,
    common[1],
    common[1],
    "n27_yz_wf_foodicon02",
    "str_n27_poststation_item_type_1"
  },
  {
    2,
    common[2],
    common[2],
    "n27_yz_wf_drinkicon02",
    "str_n27_poststation_item_type_2"
  },
  {
    3,
    common[3],
    common[3],
    "n27_yz_wf_gifticon02",
    "str_n27_poststation_item_type_3"
  },
  {
    4,
    common[4],
    common[4],
    "n27_yz_wf_clothicon02",
    "str_n27_poststation_item_type_4"
  },
  {
    5,
    common[5],
    common[5],
    "n27_yz_wf_packicon02",
    "str_n27_poststation_item_type_5"
  }
}
return config, "ItemType", key
