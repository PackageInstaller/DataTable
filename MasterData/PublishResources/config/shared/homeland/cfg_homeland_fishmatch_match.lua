local key = {
  ID = 1,
  NormalChatID = 2,
  WinChatID = 3,
  SecChatID = 4,
  SecWinChatID = 5,
  CancelChatID = 6,
  NormalInteractTxt = 7,
  WinInteractTxt = 8,
  SecInteractTxt = 9,
  SecWinInteractTxt = 10,
  SecCancelTxt = 11,
  SecWinCancelTxt = 12,
  SecByeTxt = 13
}
local config = {
  [1001] = {
    1001,
    205922,
    205924,
    205923,
    205925,
    205926,
    "str_homeland_pet_interact_fishmatch_normalinteract_txt1",
    "str_homeland_pet_interact_fishmatch_wininteract_txt1",
    "str_homeland_pet_interact_fishmatch_secinteract_txt",
    "str_homeland_pet_interact_fishmatch_secwininteract_txt",
    "str_homeland_pet_interact_fishmatch_seccancelinteract_txt",
    "str_homeland_pet_interact_fishmatch_secwincancelinteract_txt",
    "str_homeland_pet_interact_fishmatch_secbye_txt"
  }
}
return config, "ID", key
