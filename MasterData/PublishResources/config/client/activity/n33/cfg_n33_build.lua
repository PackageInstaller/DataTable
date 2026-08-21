local key = {
  ID = 1,
  ArchitectureId = 2,
  MissionIds = 3,
  Position = 4,
  ComponentID = 5,
  Name = 6,
  Des = 7,
  BuildLockMissionId = 8,
  BuildUnLockAnimLength = 9
}
local common = {
  "str_n33_activity_architecture_name_1",
  "str_n33_activity_architecture_des_1",
  "str_n33_activity_architecture_name_2",
  "str_n33_activity_architecture_des_2",
  "str_n33_activity_architecture_name_3",
  "str_n33_activity_architecture_des_3",
  "str_n33_activity_architecture_name_4",
  "str_n33_activity_architecture_des_4",
  {-629, 171},
  {-581, -195},
  {22, 76},
  {632, 36}
}
local config = {
  {
    1,
    5011001,
    {
      5331001,
      5331002,
      5331003,
      5331004
    },
    common[9],
    111000503,
    common[1],
    common[2],
    nil,
    500
  },
  {
    2,
    5011002,
    {
      5331005,
      5331006,
      5331007,
      5331008
    },
    common[10],
    111000503,
    common[3],
    common[4],
    5331004,
    500
  },
  {
    3,
    5011003,
    {
      5331009,
      5331010,
      5331011,
      5331012
    },
    common[11],
    111000503,
    common[5],
    common[6],
    5331008,
    500
  },
  {
    4,
    5011004,
    {
      5331013,
      5331014,
      5331015,
      5331016
    },
    common[12],
    111000503,
    common[7],
    common[8],
    5331012,
    500
  },
  {
    5,
    5011001,
    {
      5332001,
      5332002,
      5332003
    },
    common[9],
    111000504,
    common[1],
    common[2],
    nil,
    500
  },
  {
    6,
    5011002,
    {
      5332004,
      5332005,
      5332006
    },
    common[10],
    111000504,
    common[3],
    common[4],
    5332003,
    500
  },
  {
    7,
    5011003,
    {
      5332007,
      5332008,
      5332009
    },
    common[11],
    111000504,
    common[5],
    common[6],
    5332006,
    500
  },
  {
    8,
    5011004,
    {
      5332010,
      5332011,
      5332012
    },
    common[12],
    111000504,
    common[7],
    common[8],
    5332009,
    500
  }
}
return config, "ID", key
