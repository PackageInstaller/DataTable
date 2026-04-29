local key = {
  ID = 1,
  Type = 2,
  Name = 3
}
local common = {
  "str_pet_config_btn_level",
  "str_pet_config_config_health"
}
local config = {
  {
    1,
    1,
    "str_pet_config_btn_rare_degree"
  },
  {
    2,
    2,
    common[1]
  },
  {
    3,
    3,
    "str_pet_config_btn_element"
  },
  {
    4,
    7,
    "str_pet_config_btn_intimacy"
  },
  {
    5,
    4,
    "str_pet_config_btn_attack"
  },
  {
    6,
    5,
    "str_pet_config_btn_defense"
  },
  {
    7,
    6,
    common[2]
  },
  [15] = {
    15,
    15,
    common[2]
  },
  [16] = {
    16,
    16,
    common[1]
  }
}
return config, "ID", key
