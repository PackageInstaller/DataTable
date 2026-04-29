local key = {
  ID = 1,
  BeginShowTime = 2,
  EndShowTime = 3,
  SeasonOpenTime = 4,
  PetIcon = 5,
  Title = 6,
  PopBg = 7,
  PopPetImg = 8,
  PopTitleImg = 9,
  PopTitleTxt = 10,
  PopContentTxt = 11,
  PopTimeImg = 12
}
local common = {
  "2023-10-01 00:00:00",
  "n0_xyx_shicai_di02"
}
local config = {
  {
    1,
    "2023-06-01 10:00:00",
    common[1],
    common[1],
    "exp_zjm_prev_head",
    "str_season_preview_title_01",
    "n0_xyx_bg06",
    "n0_xyx_tu05",
    common[2],
    "str_season_preview_pop_title_01",
    "str_season_preview_pop_content_01",
    common[2]
  }
}
return config, "ID", key
