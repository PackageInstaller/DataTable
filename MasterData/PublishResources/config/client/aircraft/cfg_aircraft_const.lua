local key = {
  ID = 1,
  StrValue = 2,
  IntValue = 3,
  FloatValue = 4,
  ArrayValue = 5
}
local common = {
  "ui_click.prefab"
}
local config = {
  aircraft_social_check_time = {
    "aircraft_social_check_time",
    nil,
    90000
  },
  aircraft_social_open = {
    "aircraft_social_open",
    nil,
    1
  },
  AircraftTalkTexPosOffset = {
    "AircraftTalkTexPosOffset",
    nil,
    nil,
    nil,
    {
      0.7,
      1.1,
      0
    }
  },
  aircraft_social_reqing_time = {
    "aircraft_social_reqing_time",
    nil,
    8
  },
  aircraft_social_zhengchang_time = {
    "aircraft_social_zhengchang_time",
    nil,
    7
  },
  aircraft_social_lengmo_time = {
    "aircraft_social_lengmo_time",
    nil,
    6
  },
  onePetClickGaps = {
    "onePetClickGaps",
    nil,
    1500
  },
  clickEffName = {
    "clickEffName",
    common[1]
  },
  clickLoopEffName = {
    "clickLoopEffName",
    "eff_aircraft_selectactor.prefab"
  },
  clickMatAnimAssetName = {
    "clickMatAnimAssetName",
    "eff_roleclick.asset"
  },
  clickMatAnimClipName = {
    "clickMatAnimClipName",
    "eff_roleclick"
  },
  effLastName = {
    "effLastName",
    nil,
    2000
  },
  bubbleEffName = {
    "bubbleEffName",
    "eff_meme_duihua1.prefab"
  },
  AircraftWhisperSeamPetGaps = {
    "AircraftWhisperSeamPetGaps",
    nil,
    15000
  },
  TalkTexDef = {
    "TalkTexDef",
    nil,
    nil,
    18
  },
  TalkTexParam = {
    "TalkTexParam",
    nil,
    nil,
    0.045
  },
  ScaleCancelPos = {
    "ScaleCancelPos",
    nil,
    -50
  },
  LoveEffName = {
    "LoveEffName",
    common[1]
  },
  LvUpEffName = {
    "LvUpEffName",
    "ui_click_01.prefab"
  },
  aircraft_social_talk_txt_interval = {
    "aircraft_social_talk_txt_interval",
    nil,
    5000
  },
  aircraft_social_talk_stay_time = {
    "aircraft_social_talk_stay_time",
    nil,
    5000
  },
  aircraft_pet_ceiling_0 = {
    "aircraft_pet_ceiling_0",
    nil,
    25
  },
  aircraft_pet_ceiling_1 = {
    "aircraft_pet_ceiling_1",
    nil,
    25
  },
  aircraft_pet_ceiling_2 = {
    "aircraft_pet_ceiling_2",
    nil,
    25
  },
  aircraft_show_pet_distance = {
    "aircraft_show_pet_distance",
    nil,
    nil,
    -60
  }
}
return config, "ID", key
