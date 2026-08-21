local key = {
  ID = 1,
  TalkType = 2,
  NextWord = 3,
  AnswerID = 4,
  OptionWord = 5,
  ChatWord = 6,
  Npc = 7
}
local common = {
  "str_n32_multiline_dialogue_npc2_chat_word",
  "str_n32_multiline_dialogue_player_chat_word3",
  "ui_story_5054_50540101_4_option_content",
  "ui_story_5054_50540101_13_option_content",
  "ui_story_5054_50540101_15_option_content",
  "ui_story_5054_50540102_7_option_content",
  "ui_story_5054_50540103_18_option_content",
  "ui_story_5054_50540103_19_option_content",
  "ui_story_5054_50540301_4_option_content"
}
local config = {
  {
    1,
    2,
    2,
    nil,
    nil,
    "str_n32_multiline_dialogue_npc1_chat_word",
    1
  },
  {
    2,
    1,
    nil,
    {3, 4},
    nil,
    nil,
    1000
  },
  {
    3,
    1,
    5,
    nil,
    "str_n32_multiline_dialogue_player_option1_title",
    "str_n32_multiline_dialogue_player_chat_word1",
    1000
  },
  {
    4,
    1,
    5,
    nil,
    "str_n32_multiline_dialogue_player_option2_title",
    "str_n32_multiline_dialogue_player_chat_word2",
    1000
  },
  {
    5,
    3,
    6,
    nil,
    nil,
    "str_n32_multiline_dialogue_comment1"
  },
  {
    6,
    2,
    7,
    nil,
    nil,
    common[1],
    2
  },
  {
    7,
    1,
    8,
    nil,
    nil,
    common[2],
    1000
  },
  {
    8,
    2,
    9,
    nil,
    nil,
    common[1],
    2
  },
  {
    9,
    1,
    nil,
    nil,
    nil,
    common[2],
    1000
  },
  [54010101] = {
    54010101,
    3,
    54010102,
    nil,
    nil,
    "ui_story_5054_50540101_1_dialog_content",
    0
  },
  [54010102] = {
    54010102,
    3,
    54010103,
    nil,
    nil,
    "ui_story_5054_50540101_2_dialog_content",
    0
  },
  [54010103] = {
    54010103,
    3,
    540101031,
    nil,
    nil,
    "ui_story_5054_50540101_3_dialog_content",
    0
  },
  [540101031] = {
    540101031,
    1,
    nil,
    {54010104},
    nil,
    nil,
    5400101
  },
  [54010104] = {
    54010104,
    1,
    54010105,
    nil,
    common[3],
    common[3],
    5400101
  },
  [54010105] = {
    54010105,
    2,
    54010106,
    nil,
    nil,
    "ui_story_5054_50540101_5_dialog_content",
    5401301
  },
  [54010106] = {
    54010106,
    2,
    54010107,
    nil,
    nil,
    "ui_story_5054_50540101_6_dialog_content",
    5401001
  },
  [54010107] = {
    54010107,
    2,
    54010108,
    nil,
    nil,
    "ui_story_5054_50540101_7_dialog_content",
    5401301
  },
  [54010108] = {
    54010108,
    2,
    54010109,
    nil,
    nil,
    "ui_story_5054_50540101_8_dialog_content",
    5401001
  },
  [54010109] = {
    54010109,
    2,
    54010110,
    nil,
    nil,
    "ui_story_5054_50540101_9_dialog_content",
    5401301
  },
  [54010110] = {
    54010110,
    2,
    54010111,
    nil,
    nil,
    "ui_story_5054_50540101_10_dialog_content",
    5401001
  },
  [54010111] = {
    54010111,
    2,
    54010112,
    nil,
    nil,
    "ui_story_5054_50540101_11_dialog_content",
    5401301
  },
  [54010112] = {
    54010112,
    2,
    540101121,
    nil,
    nil,
    "ui_story_5054_50540101_12_dialog_content",
    5401001
  },
  [540101121] = {
    540101121,
    1,
    nil,
    {54010113, 54010115},
    nil,
    nil,
    5400101
  },
  [54010113] = {
    54010113,
    1,
    54010114,
    nil,
    common[4],
    common[4],
    5400101
  },
  [54010114] = {
    54010114,
    2,
    54010119,
    nil,
    nil,
    "ui_story_5054_50540101_14_dialog_content",
    5401001
  },
  [54010115] = {
    54010115,
    1,
    54010116,
    nil,
    common[5],
    common[5],
    5400101
  },
  [54010116] = {
    54010116,
    2,
    54010117,
    nil,
    nil,
    "ui_story_5054_50540101_16_dialog_content",
    5401001
  },
  [54010117] = {
    54010117,
    2,
    54010118,
    nil,
    nil,
    "ui_story_5054_50540101_17_dialog_content",
    5401001
  },
  [54010118] = {
    54010118,
    2,
    54010119,
    nil,
    nil,
    "ui_story_5054_50540101_18_dialog_content",
    5401001
  },
  [54010119] = {
    54010119,
    2,
    54010120,
    nil,
    nil,
    "ui_story_5054_50540101_19_dialog_content",
    5401301
  },
  [54010120] = {
    54010120,
    2,
    54010121,
    nil,
    nil,
    "ui_story_5054_50540101_20_dialog_content",
    5401001
  },
  [54010121] = {
    54010121,
    2,
    54010122,
    nil,
    nil,
    "ui_story_5054_50540101_21_dialog_content",
    5401301
  },
  [54010122] = {
    54010122,
    2,
    nil,
    nil,
    nil,
    "ui_story_5054_50540101_22_dialog_content",
    5401301
  },
  [54010201] = {
    54010201,
    3,
    54010202,
    nil,
    nil,
    "ui_story_5054_50540102_1_dialog_content",
    0
  },
  [54010202] = {
    54010202,
    3,
    54010203,
    nil,
    nil,
    "ui_story_5054_50540102_2_dialog_content",
    0
  },
  [54010203] = {
    54010203,
    3,
    54010204,
    nil,
    nil,
    "ui_story_5054_50540102_3_dialog_content",
    0
  },
  [54010204] = {
    54010204,
    2,
    54010205,
    nil,
    nil,
    "ui_story_5054_50540102_4_dialog_content",
    5400601
  },
  [54010205] = {
    54010205,
    1,
    54010206,
    nil,
    nil,
    "ui_story_5054_50540102_5_dialog_content",
    5400101
  },
  [54010206] = {
    54010206,
    2,
    540102061,
    nil,
    nil,
    "ui_story_5054_50540102_6_dialog_content",
    5400601
  },
  [540102061] = {
    540102061,
    1,
    nil,
    {54010207},
    nil,
    nil,
    5400101
  },
  [54010207] = {
    54010207,
    1,
    54010208,
    nil,
    common[6],
    common[6],
    5400101
  },
  [54010208] = {
    54010208,
    3,
    54010209,
    nil,
    nil,
    "ui_story_5054_50540102_8_dialog_content",
    0
  },
  [54010209] = {
    54010209,
    1,
    54010210,
    nil,
    nil,
    "ui_story_5054_50540102_9_dialog_content",
    5400101
  },
  [54010210] = {
    54010210,
    2,
    54010211,
    nil,
    nil,
    "ui_story_5054_50540102_10_dialog_content",
    5400601
  },
  [54010211] = {
    54010211,
    1,
    54010212,
    nil,
    nil,
    "ui_story_5054_50540102_11_dialog_content",
    5400101
  },
  [54010212] = {
    54010212,
    1,
    54010213,
    nil,
    nil,
    "ui_story_5054_50540102_12_dialog_content",
    5400101
  },
  [54010213] = {
    54010213,
    1,
    54010214,
    nil,
    nil,
    "ui_story_5054_50540102_13_dialog_content",
    5400101
  },
  [54010214] = {
    54010214,
    1,
    54010215,
    nil,
    nil,
    "ui_story_5054_50540102_14_dialog_content",
    5400101
  },
  [54010215] = {
    54010215,
    2,
    54010216,
    nil,
    nil,
    "ui_story_5054_50540102_15_dialog_content",
    5400601
  },
  [54010216] = {
    54010216,
    2,
    54010217,
    nil,
    nil,
    "ui_story_5054_50540102_16_dialog_content",
    5400601
  },
  [54010217] = {
    54010217,
    2,
    54010218,
    nil,
    nil,
    "ui_story_5054_50540102_17_dialog_content",
    5401201
  },
  [54010218] = {
    54010218,
    3,
    54010219,
    nil,
    nil,
    "ui_story_5054_50540102_18_dialog_content",
    0
  },
  [54010219] = {
    54010219,
    2,
    nil,
    nil,
    nil,
    "ui_story_5054_50540102_19_dialog_content",
    5400601
  },
  [54010301] = {
    54010301,
    3,
    54010302,
    nil,
    nil,
    "ui_story_5054_50540103_1_dialog_content",
    0
  },
  [54010302] = {
    54010302,
    3,
    54010303,
    nil,
    nil,
    "ui_story_5054_50540103_2_dialog_content",
    0
  },
  [54010303] = {
    54010303,
    1,
    54010304,
    nil,
    nil,
    "ui_story_5054_50540103_3_dialog_content",
    5400101
  },
  [54010304] = {
    54010304,
    2,
    54010305,
    nil,
    nil,
    "ui_story_5054_50540103_4_dialog_content",
    5400501
  },
  [54010305] = {
    54010305,
    2,
    54010306,
    nil,
    nil,
    "ui_story_5054_50540103_5_dialog_content",
    5401401
  },
  [54010306] = {
    54010306,
    2,
    54010307,
    nil,
    nil,
    "ui_story_5054_50540103_6_dialog_content",
    5400501
  },
  [54010307] = {
    54010307,
    2,
    54010308,
    nil,
    nil,
    "ui_story_5054_50540103_7_dialog_content",
    5401401
  },
  [54010308] = {
    54010308,
    2,
    54010309,
    nil,
    nil,
    "ui_story_5054_50540103_8_dialog_content",
    5400501
  },
  [54010309] = {
    54010309,
    2,
    54010310,
    nil,
    nil,
    "ui_story_5054_50540103_9_dialog_content",
    5401401
  },
  [54010310] = {
    54010310,
    3,
    54010311,
    nil,
    nil,
    "ui_story_5054_50540103_10_dialog_content",
    0
  },
  [54010311] = {
    54010311,
    2,
    54010312,
    nil,
    nil,
    "ui_story_5054_50540103_11_dialog_content",
    5400501
  },
  [54010312] = {
    54010312,
    2,
    54010313,
    nil,
    nil,
    "ui_story_5054_50540103_12_dialog_content",
    5400501
  },
  [54010313] = {
    54010313,
    2,
    54010314,
    nil,
    nil,
    "ui_story_5054_50540103_13_dialog_content",
    5400501
  },
  [54010314] = {
    54010314,
    2,
    54010315,
    nil,
    nil,
    "ui_story_5054_50540103_14_dialog_content",
    5401401
  },
  [54010315] = {
    54010315,
    2,
    54010316,
    nil,
    nil,
    "ui_story_5054_50540103_15_dialog_content",
    5401401
  },
  [54010316] = {
    54010316,
    2,
    54010317,
    nil,
    nil,
    "ui_story_5054_50540103_16_dialog_content",
    5400501
  },
  [54010317] = {
    54010317,
    3,
    540103171,
    nil,
    nil,
    "ui_story_5054_50540103_17_dialog_content",
    0
  },
  [540103171] = {
    540103171,
    1,
    nil,
    {54010318, 54010319},
    nil,
    nil,
    5400101
  },
  [54010318] = {
    54010318,
    1,
    54010320,
    nil,
    common[7],
    common[7],
    5400101
  },
  [54010319] = {
    54010319,
    1,
    54010320,
    nil,
    common[8],
    common[8],
    5400101
  },
  [54010320] = {
    54010320,
    2,
    54010321,
    nil,
    nil,
    "ui_story_5054_50540103_20_dialog_content",
    5401401
  },
  [54010321] = {
    54010321,
    3,
    nil,
    nil,
    nil,
    "ui_story_5054_50540103_21_dialog_content",
    0
  },
  [54020101] = {
    54020101,
    3,
    54020102,
    nil,
    nil,
    "ui_story_5054_50540201_1_dialog_content",
    0
  },
  [54020102] = {
    54020102,
    3,
    54020103,
    nil,
    nil,
    "ui_story_5054_50540201_2_dialog_content",
    0
  },
  [54020103] = {
    54020103,
    2,
    54020104,
    nil,
    nil,
    "ui_story_5054_50540201_3_dialog_content",
    5400701
  },
  [54020104] = {
    54020104,
    1,
    54020105,
    nil,
    nil,
    "ui_story_5054_50540201_4_dialog_content",
    5400101
  },
  [54020105] = {
    54020105,
    2,
    54020106,
    nil,
    nil,
    "ui_story_5054_50540201_5_dialog_content",
    5400201
  },
  [54020106] = {
    54020106,
    2,
    54020107,
    nil,
    nil,
    "ui_story_5054_50540201_6_dialog_content",
    5400701
  },
  [54020107] = {
    54020107,
    2,
    54020108,
    nil,
    nil,
    "ui_story_5054_50540201_7_dialog_content",
    5400701
  },
  [54020108] = {
    54020108,
    2,
    54020109,
    nil,
    nil,
    "ui_story_5054_50540201_8_dialog_content",
    5400201
  },
  [54020109] = {
    54020109,
    2,
    54020110,
    nil,
    nil,
    "ui_story_5054_50540201_9_dialog_content",
    5400201
  },
  [54020110] = {
    54020110,
    2,
    54020111,
    nil,
    nil,
    "ui_story_5054_50540201_10_dialog_content",
    5401101
  },
  [54020111] = {
    54020111,
    2,
    54020112,
    nil,
    nil,
    "ui_story_5054_50540201_11_dialog_content",
    5400201
  },
  [54020112] = {
    54020112,
    2,
    54020113,
    nil,
    nil,
    "ui_story_5054_50540201_12_dialog_content",
    5401101
  },
  [54020113] = {
    54020113,
    2,
    54020114,
    nil,
    nil,
    "ui_story_5054_50540201_13_dialog_content",
    5400701
  },
  [54020114] = {
    54020114,
    2,
    54020115,
    nil,
    nil,
    "ui_story_5054_50540201_14_dialog_content",
    5400201
  },
  [54020115] = {
    54020115,
    3,
    54020116,
    nil,
    nil,
    "ui_story_5054_50540201_15_dialog_content",
    0
  },
  [54020116] = {
    54020116,
    2,
    54020117,
    nil,
    nil,
    "ui_story_5054_50540201_16_dialog_content",
    5400201
  },
  [54020117] = {
    54020117,
    2,
    54020118,
    nil,
    nil,
    "ui_story_5054_50540201_17_dialog_content",
    5401101
  },
  [54020118] = {
    54020118,
    2,
    54020119,
    nil,
    nil,
    "ui_story_5054_50540201_18_dialog_content",
    5400201
  },
  [54020119] = {
    54020119,
    2,
    54020120,
    nil,
    nil,
    "ui_story_5054_50540201_19_dialog_content",
    5400201
  },
  [54020120] = {
    54020120,
    2,
    54020121,
    nil,
    nil,
    "ui_story_5054_50540201_20_dialog_content",
    5401101
  },
  [54020121] = {
    54020121,
    3,
    nil,
    nil,
    nil,
    "ui_story_5054_50540201_21_dialog_content",
    0
  },
  [54020201] = {
    54020201,
    3,
    54020202,
    nil,
    nil,
    "ui_story_5054_50540202_1_dialog_content",
    0
  },
  [54020202] = {
    54020202,
    3,
    54020203,
    nil,
    nil,
    "ui_story_5054_50540202_2_dialog_content",
    0
  },
  [54020203] = {
    54020203,
    3,
    54020204,
    nil,
    nil,
    "ui_story_5054_50540202_3_dialog_content",
    0
  },
  [54020204] = {
    54020204,
    2,
    54020205,
    nil,
    nil,
    "ui_story_5054_50540202_4_dialog_content",
    5400201
  },
  [54020205] = {
    54020205,
    2,
    54020206,
    nil,
    nil,
    "ui_story_5054_50540202_5_dialog_content",
    5400501
  },
  [54020206] = {
    54020206,
    1,
    54020207,
    nil,
    nil,
    "ui_story_5054_50540202_6_dialog_content",
    5400101
  },
  [54020207] = {
    54020207,
    2,
    54020208,
    nil,
    nil,
    "ui_story_5054_50540202_7_dialog_content",
    5400201
  },
  [54020208] = {
    54020208,
    2,
    54020209,
    nil,
    nil,
    "ui_story_5054_50540202_8_dialog_content",
    5400501
  },
  [54020209] = {
    54020209,
    2,
    54020210,
    nil,
    nil,
    "ui_story_5054_50540202_9_dialog_content",
    5400501
  },
  [54020210] = {
    54020210,
    2,
    54020211,
    nil,
    nil,
    "ui_story_5054_50540202_10_dialog_content",
    5400201
  },
  [54020211] = {
    54020211,
    2,
    54020212,
    nil,
    nil,
    "ui_story_5054_50540202_11_dialog_content",
    5400501
  },
  [54020212] = {
    54020212,
    2,
    54020213,
    nil,
    nil,
    "ui_story_5054_50540202_12_dialog_content",
    5400201
  },
  [54020213] = {
    54020213,
    3,
    54020214,
    nil,
    nil,
    "ui_story_5054_50540202_13_dialog_content",
    0
  },
  [54020214] = {
    54020214,
    3,
    54020215,
    nil,
    nil,
    "ui_story_5054_50540202_14_dialog_content",
    0
  },
  [54020215] = {
    54020215,
    2,
    54020216,
    nil,
    nil,
    "ui_story_5054_50540202_15_dialog_content",
    5400201
  },
  [54020216] = {
    54020216,
    3,
    54020217,
    nil,
    nil,
    "ui_story_5054_50540202_16_dialog_content",
    0
  },
  [54020217] = {
    54020217,
    1,
    54020218,
    nil,
    nil,
    "ui_story_5054_50540202_17_dialog_content",
    5400101
  },
  [54020218] = {
    54020218,
    3,
    54020219,
    nil,
    nil,
    "ui_story_5054_50540202_18_dialog_content",
    0
  },
  [54020219] = {
    54020219,
    3,
    nil,
    nil,
    nil,
    "ui_story_5054_50540202_19_dialog_content",
    0
  },
  [54020301] = {
    54020301,
    3,
    54020302,
    nil,
    nil,
    "ui_story_5054_50540203_1_dialog_content",
    0
  },
  [54020302] = {
    54020302,
    3,
    54020303,
    nil,
    nil,
    "ui_story_5054_50540203_2_dialog_content",
    0
  },
  [54020303] = {
    54020303,
    2,
    54020304,
    nil,
    nil,
    "ui_story_5054_50540203_3_dialog_content",
    5400801
  },
  [54020304] = {
    54020304,
    3,
    54020305,
    nil,
    nil,
    "ui_story_5054_50540203_4_dialog_content",
    0
  },
  [54020305] = {
    54020305,
    1,
    54020306,
    nil,
    nil,
    "ui_story_5054_50540203_5_dialog_content",
    5400101
  },
  [54020306] = {
    54020306,
    2,
    54020307,
    nil,
    nil,
    "ui_story_5054_50540203_6_dialog_content",
    5400501
  },
  [54020307] = {
    54020307,
    3,
    54020308,
    nil,
    nil,
    "ui_story_5054_50540203_7_dialog_content",
    0
  },
  [54020308] = {
    54020308,
    2,
    54020309,
    nil,
    nil,
    "ui_story_5054_50540203_8_dialog_content",
    5400501
  },
  [54020309] = {
    54020309,
    2,
    54020310,
    nil,
    nil,
    "ui_story_5054_50540203_9_dialog_content",
    5400801
  },
  [54020310] = {
    54020310,
    3,
    54020311,
    nil,
    nil,
    "ui_story_5054_50540203_10_dialog_content",
    0
  },
  [54020311] = {
    54020311,
    2,
    54020312,
    nil,
    nil,
    "ui_story_5054_50540203_11_dialog_content",
    5400501
  },
  [54020312] = {
    54020312,
    2,
    54020313,
    nil,
    nil,
    "ui_story_5054_50540203_12_dialog_content",
    5400501
  },
  [54020313] = {
    54020313,
    2,
    54020314,
    nil,
    nil,
    "ui_story_5054_50540203_13_dialog_content",
    5400801
  },
  [54020314] = {
    54020314,
    2,
    54020315,
    nil,
    nil,
    "ui_story_5054_50540203_14_dialog_content",
    5400801
  },
  [54020315] = {
    54020315,
    3,
    54020316,
    nil,
    nil,
    "ui_story_5054_50540203_15_dialog_content",
    0
  },
  [54020316] = {
    54020316,
    2,
    54020317,
    nil,
    nil,
    "ui_story_5054_50540203_16_dialog_content",
    5400501
  },
  [54020317] = {
    54020317,
    2,
    54020318,
    nil,
    nil,
    "ui_story_5054_50540203_17_dialog_content",
    5400501
  },
  [54020318] = {
    54020318,
    3,
    nil,
    nil,
    nil,
    "ui_story_5054_50540203_18_dialog_content",
    0
  },
  [54030101] = {
    54030101,
    3,
    54030102,
    nil,
    nil,
    "ui_story_5054_50540301_1_dialog_content",
    0
  },
  [54030102] = {
    54030102,
    3,
    54030103,
    nil,
    nil,
    "ui_story_5054_50540301_2_dialog_content",
    0
  },
  [54030103] = {
    54030103,
    3,
    540301031,
    nil,
    nil,
    "ui_story_5054_50540301_3_dialog_content",
    0
  },
  [540301031] = {
    540301031,
    1,
    nil,
    {54030104},
    nil,
    nil,
    5400101
  },
  [54030104] = {
    54030104,
    1,
    54030105,
    nil,
    common[9],
    common[9],
    5400101
  },
  [54030105] = {
    54030105,
    2,
    54030106,
    nil,
    nil,
    "ui_story_5054_50540301_5_dialog_content",
    5400401
  },
  [54030106] = {
    54030106,
    2,
    54030107,
    nil,
    nil,
    "ui_story_5054_50540301_6_dialog_content",
    5400301
  },
  [54030107] = {
    54030107,
    2,
    54030108,
    nil,
    nil,
    "ui_story_5054_50540301_7_dialog_content",
    5400401
  },
  [54030108] = {
    54030108,
    2,
    54030109,
    nil,
    nil,
    "ui_story_5054_50540301_8_dialog_content",
    5400301
  },
  [54030109] = {
    54030109,
    2,
    54030110,
    nil,
    nil,
    "ui_story_5054_50540301_9_dialog_content",
    5400301
  },
  [54030110] = {
    54030110,
    2,
    54030111,
    nil,
    nil,
    "ui_story_5054_50540301_10_dialog_content",
    5400401
  },
  [54030111] = {
    54030111,
    2,
    54030112,
    nil,
    nil,
    "ui_story_5054_50540301_11_dialog_content",
    5400401
  },
  [54030112] = {
    54030112,
    2,
    54030113,
    nil,
    nil,
    "ui_story_5054_50540301_12_dialog_content",
    5400301
  },
  [54030113] = {
    54030113,
    2,
    54030114,
    nil,
    nil,
    "ui_story_5054_50540301_13_dialog_content",
    5400301
  },
  [54030114] = {
    54030114,
    1,
    54030115,
    nil,
    nil,
    "ui_story_5054_50540301_14_dialog_content",
    5400101
  },
  [54030115] = {
    54030115,
    2,
    54030116,
    nil,
    nil,
    "ui_story_5054_50540301_15_dialog_content",
    5400301
  },
  [54030116] = {
    54030116,
    3,
    nil,
    nil,
    nil,
    "ui_story_5054_50540301_16_dialog_content",
    0
  },
  [54030201] = {
    54030201,
    3,
    54030202,
    nil,
    nil,
    "ui_story_5054_50540302_1_dialog_content",
    0
  },
  [54030202] = {
    54030202,
    3,
    54030203,
    nil,
    nil,
    "ui_story_5054_50540302_2_dialog_content",
    0
  },
  [54030203] = {
    54030203,
    2,
    54030204,
    nil,
    nil,
    "ui_story_5054_50540302_3_dialog_content",
    5400801
  },
  [54030204] = {
    54030204,
    1,
    54030205,
    nil,
    nil,
    "ui_story_5054_50540302_4_dialog_content",
    5400101
  },
  [54030205] = {
    54030205,
    2,
    54030206,
    nil,
    nil,
    "ui_story_5054_50540302_5_dialog_content",
    5400801
  },
  [54030206] = {
    54030206,
    2,
    54030207,
    nil,
    nil,
    "ui_story_5054_50540302_6_dialog_content",
    5401401
  },
  [54030207] = {
    54030207,
    2,
    54030208,
    nil,
    nil,
    "ui_story_5054_50540302_7_dialog_content",
    5400801
  },
  [54030208] = {
    54030208,
    2,
    54030209,
    nil,
    nil,
    "ui_story_5054_50540302_8_dialog_content",
    5401401
  },
  [54030209] = {
    54030209,
    3,
    54030210,
    nil,
    nil,
    "ui_story_5054_50540302_9_dialog_content",
    0
  },
  [54030210] = {
    54030210,
    2,
    54030211,
    nil,
    nil,
    "ui_story_5054_50540302_10_dialog_content",
    5400801
  },
  [54030211] = {
    54030211,
    2,
    54030212,
    nil,
    nil,
    "ui_story_5054_50540302_11_dialog_content",
    5400801
  },
  [54030212] = {
    54030212,
    2,
    54030213,
    nil,
    nil,
    "ui_story_5054_50540302_12_dialog_content",
    5401401
  },
  [54030213] = {
    54030213,
    2,
    54030214,
    nil,
    nil,
    "ui_story_5054_50540302_13_dialog_content",
    5400801
  },
  [54030214] = {
    54030214,
    2,
    54030215,
    nil,
    nil,
    "ui_story_5054_50540302_14_dialog_content",
    5400801
  },
  [54030215] = {
    54030215,
    2,
    54030216,
    nil,
    nil,
    "ui_story_5054_50540302_15_dialog_content",
    5400801
  },
  [54030216] = {
    54030216,
    2,
    54030217,
    nil,
    nil,
    "ui_story_5054_50540302_16_dialog_content",
    5400801
  },
  [54030217] = {
    54030217,
    3,
    nil,
    nil,
    nil,
    "ui_story_5054_50540302_17_dialog_content",
    0
  },
  [62010101] = {
    62010101,
    2,
    62010102,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_1",
    6201171
  },
  [62010102] = {
    62010102,
    1,
    62010103,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_2",
    6202091
  },
  [62010103] = {
    62010103,
    2,
    62010104,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_3",
    6201171
  },
  [62010104] = {
    62010104,
    1,
    62010105,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_4",
    6202091
  },
  [62010105] = {
    62010105,
    2,
    62010106,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_5",
    6201171
  },
  [62010106] = {
    62010106,
    1,
    62010107,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_6",
    6202091
  },
  [62010107] = {
    62010107,
    2,
    62010108,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_7",
    6201171
  },
  [62010108] = {
    62010108,
    1,
    62010109,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_8",
    6202091
  },
  [62010109] = {
    62010109,
    2,
    62010110,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_9",
    6201171
  },
  [62010110] = {
    62010110,
    1,
    62010111,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_10",
    6202091
  },
  [62010111] = {
    62010111,
    2,
    62010112,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_11",
    6201171
  },
  [62010112] = {
    62010112,
    1,
    62010113,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_12",
    6202091
  },
  [62010113] = {
    62010113,
    2,
    62010114,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_13",
    6200611
  },
  [62010114] = {
    62010114,
    2,
    62010115,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_14",
    6200241
  },
  [62010115] = {
    62010115,
    2,
    62010116,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_15",
    6200571
  },
  [62010116] = {
    62010116,
    2,
    62010117,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_16",
    6201191
  },
  [62010117] = {
    62010117,
    2,
    62010118,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_17",
    6201171
  },
  [62010118] = {
    62010118,
    1,
    nil,
    nil,
    nil,
    "str_n34_dispatch_task_1_com_18",
    6202091
  },
  [62010201] = {
    62010201,
    1,
    62010202,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_1",
    6202091
  },
  [62010202] = {
    62010202,
    2,
    62010203,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_2",
    6201171
  },
  [62010203] = {
    62010203,
    1,
    62010204,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_3",
    6202091
  },
  [62010204] = {
    62010204,
    2,
    62010205,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_4",
    6201171
  },
  [62010205] = {
    62010205,
    2,
    62010206,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_5",
    6201171
  },
  [62010206] = {
    62010206,
    2,
    62010207,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_6",
    6200571
  },
  [62010207] = {
    62010207,
    2,
    62010208,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_7",
    6201191
  },
  [62010208] = {
    62010208,
    1,
    62010209,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_8",
    6202091
  },
  [62010209] = {
    62010209,
    2,
    62010210,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_9",
    6201171
  },
  [62010210] = {
    62010210,
    2,
    62010211,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_10",
    6200241
  },
  [62010211] = {
    62010211,
    2,
    62010212,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_11",
    6200571
  },
  [62010212] = {
    62010212,
    2,
    62010213,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_12",
    6200571
  },
  [62010213] = {
    62010213,
    1,
    62010214,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_13",
    6202091
  },
  [62010214] = {
    62010214,
    2,
    62010215,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_14",
    6200611
  },
  [62010215] = {
    62010215,
    1,
    62010216,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_15",
    6202091
  },
  [62010216] = {
    62010216,
    2,
    nil,
    nil,
    nil,
    "str_n34_dispatch_task_2_com_16",
    6201171
  },
  [62010301] = {
    62010301,
    2,
    62010302,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_1",
    6201171
  },
  [62010302] = {
    62010302,
    1,
    62010303,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_2",
    6202091
  },
  [62010303] = {
    62010303,
    2,
    62010304,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_3",
    6201171
  },
  [62010304] = {
    62010304,
    1,
    62010305,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_4",
    6202091
  },
  [62010305] = {
    62010305,
    2,
    62010306,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_5",
    6201171
  },
  [62010306] = {
    62010306,
    1,
    62010307,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_6",
    6202091
  },
  [62010307] = {
    62010307,
    2,
    62010308,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_7",
    6201171
  },
  [62010308] = {
    62010308,
    2,
    62010309,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_8",
    6200571
  },
  [62010309] = {
    62010309,
    2,
    62010310,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_9",
    6200241
  },
  [62010310] = {
    62010310,
    1,
    62010311,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_10",
    6202091
  },
  [62010311] = {
    62010311,
    2,
    62010312,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_11",
    6200611
  },
  [62010312] = {
    62010312,
    1,
    62010313,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_12",
    6202091
  },
  [62010313] = {
    62010313,
    2,
    nil,
    nil,
    nil,
    "str_n34_dispatch_task_3_com_13",
    6201171
  },
  [62010401] = {
    62010401,
    1,
    62010402,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_1",
    6202091
  },
  [62010402] = {
    62010402,
    2,
    62010403,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_2",
    6201171
  },
  [62010403] = {
    62010403,
    2,
    62010404,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_3",
    6200571
  },
  [62010404] = {
    62010404,
    2,
    62010405,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_4",
    6201171
  },
  [62010405] = {
    62010405,
    1,
    62010406,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_5",
    6202091
  },
  [62010406] = {
    62010406,
    2,
    62010407,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_6",
    6201171
  },
  [62010407] = {
    62010407,
    2,
    62010408,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_7",
    6200241
  },
  [62010408] = {
    62010408,
    2,
    62010409,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_8",
    6201191
  },
  [62010409] = {
    62010409,
    1,
    62010410,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_9",
    6202091
  },
  [62010410] = {
    62010410,
    2,
    62010411,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_10",
    6200571
  },
  [62010411] = {
    62010411,
    2,
    62010412,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_11",
    6200611
  },
  [62010412] = {
    62010412,
    1,
    62010413,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_12",
    6202091
  },
  [62010413] = {
    62010413,
    2,
    nil,
    nil,
    nil,
    "str_n34_dispatch_task_4_com_13",
    6200241
  },
  [62010501] = {
    62010501,
    2,
    62010502,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_1",
    6201171
  },
  [62010502] = {
    62010502,
    1,
    62010503,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_2",
    6202091
  },
  [62010503] = {
    62010503,
    2,
    62010504,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_3",
    6201171
  },
  [62010504] = {
    62010504,
    2,
    62010505,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_4",
    6200571
  },
  [62010505] = {
    62010505,
    1,
    62010506,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_5",
    6202091
  },
  [62010506] = {
    62010506,
    2,
    62010507,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_6",
    6201191
  },
  [62010507] = {
    62010507,
    2,
    62010508,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_7",
    6200611
  },
  [62010508] = {
    62010508,
    2,
    62010509,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_8",
    6200241
  },
  [62010509] = {
    62010509,
    2,
    62010510,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_9",
    6201191
  },
  [62010510] = {
    62010510,
    2,
    62010511,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_10",
    6201171
  },
  [62010511] = {
    62010511,
    2,
    62010512,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_11",
    6200571
  },
  [62010512] = {
    62010512,
    2,
    62010513,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_12",
    6200611
  },
  [62010513] = {
    62010513,
    2,
    62010514,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_13",
    6200241
  },
  [62010514] = {
    62010514,
    2,
    62010515,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_14",
    6201191
  },
  [62010515] = {
    62010515,
    2,
    62010516,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_15",
    6200571
  },
  [62010516] = {
    62010516,
    1,
    62010517,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_16",
    6202091
  },
  [62010517] = {
    62010517,
    2,
    nil,
    nil,
    nil,
    "str_n34_dispatch_task_5_com_17",
    6201171
  },
  [62010601] = {
    62010601,
    1,
    62010602,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_1",
    6202091
  },
  [62010602] = {
    62010602,
    1,
    62010603,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_2",
    6202091
  },
  [62010603] = {
    62010603,
    2,
    62010604,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_3",
    6200611
  },
  [62010604] = {
    62010604,
    1,
    62010605,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_4",
    6202091
  },
  [62010605] = {
    62010605,
    2,
    62010606,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_5",
    6200611
  },
  [62010606] = {
    62010606,
    1,
    62010607,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_6",
    6202091
  },
  [62010607] = {
    62010607,
    2,
    62010608,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_7",
    6201171
  },
  [62010608] = {
    62010608,
    2,
    62010609,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_8",
    6201171
  },
  [62010609] = {
    62010609,
    2,
    62010610,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_9",
    6201171
  },
  [62010610] = {
    62010610,
    2,
    62010611,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_10",
    6200611
  },
  [62010611] = {
    62010611,
    1,
    62010612,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_11",
    6202091
  },
  [62010612] = {
    62010612,
    2,
    62010613,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_12",
    6201171
  },
  [62010613] = {
    62010613,
    2,
    62010614,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_13",
    6201171
  },
  [62010614] = {
    62010614,
    2,
    62010615,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_14",
    6201171
  },
  [62010615] = {
    62010615,
    2,
    62010616,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_15",
    6200241
  },
  [62010616] = {
    62010616,
    2,
    62010617,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_16",
    6201191
  },
  [62010617] = {
    62010617,
    2,
    62010618,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_17",
    6201171
  },
  [62010618] = {
    62010618,
    1,
    nil,
    nil,
    nil,
    "str_n34_dispatch_task_6_com_18",
    6202091
  },
  [62010701] = {
    62010701,
    1,
    62010702,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_1",
    6202091
  },
  [62010702] = {
    62010702,
    2,
    62010703,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_2",
    6201171
  },
  [62010703] = {
    62010703,
    1,
    62010704,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_3",
    6202091
  },
  [62010704] = {
    62010704,
    2,
    62010705,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_4",
    6200571
  },
  [62010705] = {
    62010705,
    2,
    62010706,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_5",
    6201191
  },
  [62010706] = {
    62010706,
    2,
    62010707,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_6",
    6200571
  },
  [62010707] = {
    62010707,
    2,
    62010708,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_7",
    6201191
  },
  [62010708] = {
    62010708,
    2,
    62010709,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_8",
    6201171
  },
  [62010709] = {
    62010709,
    1,
    62010710,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_9",
    6202091
  },
  [62010710] = {
    62010710,
    2,
    62010711,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_10",
    6201171
  },
  [62010711] = {
    62010711,
    1,
    62010712,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_11",
    6202091
  },
  [62010712] = {
    62010712,
    2,
    62010713,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_12",
    6201171
  },
  [62010713] = {
    62010713,
    1,
    62010714,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_13",
    6202091
  },
  [62010714] = {
    62010714,
    2,
    62010715,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_14",
    6201171
  },
  [62010715] = {
    62010715,
    1,
    62010716,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_15",
    6202091
  },
  [62010716] = {
    62010716,
    2,
    62010717,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_16",
    6201171
  },
  [62010717] = {
    62010717,
    1,
    62010718,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_17",
    6202091
  },
  [62010718] = {
    62010718,
    2,
    62010719,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_18",
    6201171
  },
  [62010719] = {
    62010719,
    1,
    62010720,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_19",
    6202091
  },
  [62010720] = {
    62010720,
    2,
    62010721,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_20",
    6201171
  },
  [62010721] = {
    62010721,
    1,
    62010722,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_21",
    6202091
  },
  [62010722] = {
    62010722,
    2,
    nil,
    nil,
    nil,
    "str_n34_dispatch_task_7_com_22",
    6201171
  }
}
return config, "ID", key
