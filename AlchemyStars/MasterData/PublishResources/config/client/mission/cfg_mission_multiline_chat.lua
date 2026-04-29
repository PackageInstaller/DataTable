local key = {
  ID = 1,
  StartTalk = 2,
  DetailsDrawing = 3,
  DetailsHead = 4,
  ChatOutDesc = 5,
  ChatTitle = 6,
  Background = 7,
  Place = 8,
  PlaceDescribe = 9,
  ChatDescribe = 10
}
local common = {
  "n32_dzm_gq_cj01",
  "n32_dzm_gq_bj01",
  "n32_dzm_gq_cj03",
  "n32_dzm_gq_di_lh03",
  "n32_dzm_gq_bj03",
  "n32_dzm_gq_di_lh04",
  "str_n32_multiline_dialogue_bigplace_9",
  "str_n32_multiline_dialogue_smallplace_9"
}
local config = {
  [5321017] = {
    5321017,
    54010101,
    common[1],
    "n32_dzm_gq_di_lh01",
    "str_n32_multiline_dialogue_chat_outdesc_1",
    "str_n32_multiline_dialogue_chat_title_1",
    common[2],
    "str_n32_multiline_dialogue_bigplace_1",
    "str_n32_multiline_dialogue_smallplace_1",
    "str_n32_multiline_dialogue_chat_indesc_1"
  },
  [5321018] = {
    5321018,
    54010201,
    common[1],
    "n32_dzm_gq_di_lh02",
    "str_n32_multiline_dialogue_chat_outdesc_2",
    "str_n32_multiline_dialogue_chat_title_2",
    common[2],
    "str_n32_multiline_dialogue_bigplace_2",
    "str_n32_multiline_dialogue_smallplace_2",
    "str_n32_multiline_dialogue_chat_indesc_2"
  },
  [5321019] = {
    5321019,
    54010301,
    common[3],
    common[4],
    "str_n32_multiline_dialogue_chat_outdesc_3",
    "str_n32_multiline_dialogue_chat_title_3",
    common[5],
    "str_n32_multiline_dialogue_bigplace_3",
    "str_n32_multiline_dialogue_smallplace_3",
    "str_n32_multiline_dialogue_chat_indesc_3"
  },
  [5321020] = {
    5321020,
    54020101,
    common[3],
    common[6],
    "str_n32_multiline_dialogue_chat_outdesc_4",
    "str_n32_multiline_dialogue_chat_title_4",
    common[5],
    "str_n32_multiline_dialogue_bigplace_4",
    "str_n32_multiline_dialogue_smallplace_4",
    "str_n32_multiline_dialogue_chat_indesc_4"
  },
  [5321021] = {
    5321021,
    54020201,
    common[3],
    common[6],
    "str_n32_multiline_dialogue_chat_outdesc_5",
    "str_n32_multiline_dialogue_chat_title_5",
    common[5],
    "str_n32_multiline_dialogue_bigplace_5",
    "str_n32_multiline_dialogue_smallplace_5",
    "str_n32_multiline_dialogue_chat_indesc_5"
  },
  [5321022] = {
    5321022,
    54020301,
    common[3],
    "n32_dzm_gq_di_lh06",
    "str_n32_multiline_dialogue_chat_outdesc_6",
    "str_n32_multiline_dialogue_chat_title_6",
    common[5],
    common[7],
    common[8],
    "str_n32_multiline_dialogue_chat_indesc_6"
  },
  [5321023] = {
    5321023,
    54030101,
    "n32_dzm_gq_cj02",
    "n32_dzm_gq_di_lh05",
    "str_n32_multiline_dialogue_chat_outdesc_7",
    "str_n32_multiline_dialogue_chat_title_7",
    "n32_dzm_gq_bj02",
    "str_n32_multiline_dialogue_bigplace_7",
    "str_n32_multiline_dialogue_smallplace_7",
    "str_n32_multiline_dialogue_chat_indesc_7"
  },
  [5321024] = {
    5321024,
    54030201,
    common[3],
    common[4],
    "str_n32_multiline_dialogue_chat_outdesc_8",
    "str_n32_multiline_dialogue_chat_title_8",
    common[5],
    common[7],
    common[8],
    "str_n32_multiline_dialogue_chat_indesc_8"
  }
}
return config, "ID", key
