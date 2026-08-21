local key = {
  ID = 1,
  BigTypeName = 2,
  BigTypeNameSpace = 3,
  Icon = 4,
  Icon1 = 5,
  Icon2 = 6,
  BigTypeEnum = 7
}
local common = {
  "task_achieve_tubiao2",
  "task_achieve_tubiao1"
}
local config = {
  {
    1,
    "str_quest_base_achieve_pandect",
    "str_quest_base_achieve_pandect_space",
    common[1],
    common[2],
    common[1],
    1
  },
  {
    2,
    "str_quest_base_achieve_type_100",
    "str_quest_base_achieve_type_100_space",
    "task_achieve_tubiao13",
    common[2],
    common[1],
    100
  },
  {
    3,
    "str_quest_base_achieve_type_200",
    "str_quest_base_achieve_type_200_space",
    "task_achieve_tubiao14",
    "task_achieve_tubiao3",
    "task_achieve_tubiao4",
    200
  },
  {
    4,
    "str_quest_base_achieve_type_406",
    "str_quest_base_achieve_type_406_space",
    "task_achieve_tubiao15",
    "task_achieve_tubiao5",
    "task_achieve_tubiao6",
    406
  },
  {
    5,
    "str_quest_base_achieve_type_401",
    "str_quest_base_achieve_type_401_space",
    "task_achieve_tubiao17",
    "task_achieve_tubiao9",
    "task_achieve_tubiao10",
    401
  },
  {
    6,
    "str_quest_base_achieve_type_501",
    "str_quest_base_achieve_type_501_space",
    "task_achieve_tubiao16",
    "task_achieve_tubiao7",
    "task_achieve_tubiao8",
    501
  },
  {
    7,
    "str_quest_base_achieve_type_407",
    "str_quest_base_achieve_type_407_space",
    "task_achieve_tubiao18",
    "task_achieve_tubiao11",
    "task_achieve_tubiao12",
    407
  }
}
return config, "ID", key
