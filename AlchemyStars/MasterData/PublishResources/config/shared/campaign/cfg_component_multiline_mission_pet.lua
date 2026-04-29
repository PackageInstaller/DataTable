local key = {
  ID = 1,
  ComponentID = 2,
  PetID = 3,
  FilesID = 4,
  Rewards = 5,
  PetInfo = 6,
  HeadImg = 7,
  PetName = 8
}
local common = {
  {
    {3000002, 10000},
    {3100014, 10},
    {3400037, 5}
  }
}
local config = {
  {
    1,
    110503206,
    1,
    {2, 7},
    common[1],
    "str_n32_multiline_doc_roledesc_2",
    "n32_dzm_gq_di_dh02",
    "str_n32_multiline_doc_role_2"
  },
  {
    2,
    110503206,
    2,
    {1},
    common[1],
    "str_n32_multiline_doc_roledesc_1",
    "n32_dzm_gq_di_dh01",
    "str_n32_multiline_doc_role_1"
  },
  {
    3,
    110503206,
    3,
    {
      3,
      6,
      8
    },
    common[1],
    "str_n32_multiline_doc_roledesc_3",
    "n32_dzm_gq_di_dh03",
    "str_n32_multiline_doc_role_3"
  },
  {
    4,
    110503206,
    4,
    {4, 5},
    common[1],
    "str_n32_multiline_doc_roledesc_4",
    "n32_dzm_gq_di_dh04",
    "str_n32_multiline_doc_role_4"
  }
}
return config, "ID", key
