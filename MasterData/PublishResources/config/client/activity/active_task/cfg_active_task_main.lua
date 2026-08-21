local key = {
  ID = 1,
  TitleImg = 2,
  FlipBtnTxt = 3,
  MissionBtnTxt = 4,
  ComponentID = 5,
  FilpIntro = 6,
  MissionIntro = 7
}
local common = {
  "str_n32_turn_card_award_description_n37",
  "str_n32_turn_card_mission_description_n37",
  "N37_hywf_title01",
  "str_n32_turn_card_tab_title_award_n37",
  "str_n32_turn_card_tab_title_mission_n37"
}
local config = {
  {
    1,
    "N32_hywf_title01",
    "str_n32_turn_card_tab_title_award",
    "str_n32_turn_card_tab_title_mission",
    110803101,
    "str_n32_turn_card_award_description",
    "str_n32_turn_card_mission_description"
  },
  {
    2,
    common[3],
    common[4],
    common[5],
    112703101,
    common[1],
    common[2]
  },
  {
    3,
    common[3],
    common[4],
    common[5],
    555503101,
    common[1],
    common[2]
  }
}
return config, "ID", key
