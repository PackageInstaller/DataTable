local key = {
  ID = 1,
  Tag = 2,
  Name = 3
}
local config = {
  {
    1,
    0,
    "str_player_info_head_filter_all"
  },
  {
    2,
    1,
    "str_player_info_head_filter_Q"
  },
  {
    3,
    2,
    "str_player_info_head_filter_pet"
  },
  {
    4,
    3,
    "str_player_info_head_filter_camp"
  }
}
return config, "ID", key
