local key = {
  ID = 1,
  PetID = 2,
  TaskGroupID = 3,
  Flavor = 4,
  LetterID = 5,
  AwardID = 6,
  PetImg = 7,
  FoodImg = 8,
  ReplyTxt = 9,
  HeadImg_s = 10,
  HeadImg_b = 11
}
local common = {
  {
    {3000003, 50},
    {3030002, 1}
  },
  {
    {3000003, 50},
    {3100014, 5}
  },
  {
    {3000003, 50},
    {3400038, 2}
  }
}
local config = {
  {
    1,
    1601841,
    1,
    {
      1,
      2,
      3
    },
    1,
    common[1],
    "N27_qrj_lihui06",
    "N27_qrj_chocolate06",
    "str_n27_valentine_y_letter_reply_1",
    "N27_qrj_tx_small06",
    "N27_qrj_tx_big06"
  },
  {
    2,
    1501851,
    2,
    {
      4,
      5,
      6
    },
    2,
    common[2],
    "N27_qrj_lihui07",
    "N27_qrj_chocolate07",
    "str_n27_valentine_y_letter_reply_2",
    "N27_qrj_tx_small07",
    "N27_qrj_tx_big07"
  },
  {
    3,
    1600381,
    3,
    {
      7,
      8,
      9
    },
    3,
    common[3],
    "N27_qrj_lihui01",
    "N27_qrj_chocolate01",
    "str_n27_valentine_y_letter_reply_3",
    "N27_qrj_tx_small01",
    "N27_qrj_tx_big01"
  },
  {
    4,
    1600271,
    4,
    {
      10,
      11,
      12
    },
    4,
    common[1],
    "N27_qrj_lihui02",
    "N27_qrj_chocolate02",
    "str_n27_valentine_y_letter_reply_4",
    "N27_qrj_tx_small02",
    "N27_qrj_tx_big02"
  },
  {
    5,
    1601531,
    5,
    {
      13,
      14,
      15
    },
    5,
    {
      {3000003, 50},
      {3500001, 200}
    },
    "N27_qrj_lihui04",
    "N27_qrj_chocolate04",
    "str_n27_valentine_y_letter_reply_5",
    "N27_qrj_tx_small04",
    "N27_qrj_tx_big04"
  },
  {
    6,
    1601161,
    6,
    {
      16,
      17,
      18
    },
    6,
    common[2],
    "N27_qrj_lihui05",
    "N27_qrj_chocolate05",
    "str_n27_valentine_y_letter_reply_6",
    "N27_qrj_tx_small05",
    "N27_qrj_tx_big05"
  },
  {
    7,
    1601731,
    7,
    {
      19,
      20,
      21
    },
    7,
    common[3],
    "N27_qrj_lihui03",
    "N27_qrj_chocolate03",
    "str_n27_valentine_y_letter_reply_7",
    "N27_qrj_tx_small03",
    "N27_qrj_tx_big03"
  }
}
return config, "ID", key
