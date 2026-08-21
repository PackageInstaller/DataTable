local key = {
  ID = 1,
  Exp = 2,
  TalePetBuffId = 3,
  NormalPetBuffId = 4,
  BuffName = 5,
  BuffIcon = 6,
  TalePetBuffDes = 7,
  NormalPetBuffDes1 = 8
}
local common = {
  "str_tale_pet_buff_name",
  "chuanshuo_buff"
}
local config = {
  {
    1,
    0,
    {
      1701000,
      1702000,
      1704000
    },
    {1704000},
    common[1],
    common[2],
    "str_tale_pet_buff_des0",
    "str_tale_pet_other_buff_des0"
  },
  {
    2,
    60,
    {
      1701001,
      1702001,
      1704001
    },
    {1703001, 1704001},
    common[1],
    common[2],
    "str_tale_pet_buff_des1",
    "str_tale_pet_other_buff_des1"
  },
  {
    3,
    120,
    {
      1701002,
      1702002,
      1704002
    },
    {1703002, 1704002},
    common[1],
    common[2],
    "str_tale_pet_buff_des2",
    "str_tale_pet_other_buff_des2"
  },
  {
    4,
    200,
    {
      1701003,
      1702003,
      1704003,
      1705001
    },
    {1703003, 1704003},
    common[1],
    common[2],
    "str_tale_pet_buff_des3",
    "str_tale_pet_other_buff_des3"
  },
  {
    5,
    280,
    {
      1701004,
      1702004,
      1704004,
      1705001
    },
    {1703004, 1704004},
    common[1],
    common[2],
    "str_tale_pet_buff_des4",
    "str_tale_pet_other_buff_des4"
  },
  {
    6,
    360,
    {
      1701005,
      1702005,
      1704005,
      1705001,
      1706001
    },
    {1703005, 1704005},
    common[1],
    common[2],
    "str_tale_pet_buff_des5",
    "str_tale_pet_other_buff_des5"
  }
}
return config, "ID", key
