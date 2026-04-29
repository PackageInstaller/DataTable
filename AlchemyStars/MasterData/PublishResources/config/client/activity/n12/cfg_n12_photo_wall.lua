local key = {
  Name = 1,
  Describe = 2,
  Icon = 3,
  LockIcon = 4,
  Size = 5,
  BtnSize = 6,
  BtnOffset = 7,
  RedPos = 8,
  Surprised = 9
}
local common = {
  "n12_shouji_polt1",
  "str_n12_photo_name_1",
  "str_n12_photo_describe_1",
  "n12_shouji_polt2",
  "n12_shouji_polt2_lock",
  "str_n12_photo_name_2",
  "str_n12_photo_describe_2",
  "n12_shouji_polt3",
  "n12_shouji_polt3_lock",
  "str_n12_photo_name_3",
  "str_n12_photo_describe_3",
  "n12_shouji_polt4",
  "n12_shouji_polt4_lock",
  "str_n12_photo_name_4",
  "str_n12_photo_describe_4",
  "n12_shouji_polt5",
  "n12_shouji_polt5_lock",
  "str_n12_photo_name_5",
  "str_n12_photo_describe_5",
  "n12_shouji_polt6",
  "n12_shouji_polt6_lock",
  "str_n12_photo_name_6",
  "str_n12_photo_describe_6",
  {257, 548},
  {0, 0},
  {-10, -180},
  {573, 253},
  {-35, -20},
  {500, 280},
  {500, 250},
  {-20, -35},
  {365, 449},
  {-40, -40},
  {689, 537},
  {-675, -30}
}
local config = {
  [50150101] = {
    common[2],
    common[3],
    common[1],
    nil,
    common[24],
    common[24],
    common[25],
    common[26]
  },
  [50150201] = {
    common[6],
    common[7],
    common[4],
    common[5],
    common[27],
    common[27],
    common[25],
    common[28]
  },
  [50150301] = {
    common[10],
    common[11],
    common[8],
    common[9],
    common[29],
    common[30],
    common[25],
    common[31]
  },
  [50150401] = {
    common[14],
    common[15],
    common[12],
    common[13],
    {350, 380},
    {300, 478},
    common[25],
    {-160, -60},
    1
  },
  [50150501] = {
    common[18],
    common[19],
    common[16],
    common[17],
    common[32],
    common[32],
    common[25],
    common[33]
  },
  [50150601] = {
    common[22],
    common[23],
    common[20],
    common[21],
    common[34],
    common[34],
    common[25],
    common[35]
  },
  [150150101] = {
    common[2],
    common[3],
    common[1],
    nil,
    common[24],
    common[24],
    common[25],
    common[26]
  },
  [150150201] = {
    common[6],
    common[7],
    common[4],
    common[5],
    common[27],
    common[27],
    common[25],
    common[28]
  },
  [150150301] = {
    common[10],
    common[11],
    common[8],
    common[9],
    common[29],
    common[30],
    common[25],
    common[31]
  },
  [150150401] = {
    common[14],
    common[15],
    common[12],
    common[13],
    {505, 478},
    {395, 400},
    {-40, 0},
    {-160, -65},
    1
  },
  [150150501] = {
    common[18],
    common[19],
    common[16],
    common[17],
    common[32],
    common[32],
    common[25],
    common[33]
  },
  [150150601] = {
    common[22],
    common[23],
    common[20],
    common[21],
    common[34],
    common[34],
    common[25],
    common[35]
  }
}
return config, "ID", key
