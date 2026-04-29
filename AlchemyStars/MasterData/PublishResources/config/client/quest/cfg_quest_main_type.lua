local key = {
  ID = 1,
  TypeName = 2,
  TypeNameEn = 3,
  ClientType = 4,
  Icon = 5,
  SelectIcon = 6,
  RealType = 7
}
local config = {
  {
    1,
    "str_quest_base_type_daily_with_space",
    "DAILY",
    2,
    "task_plot_tubiao2",
    "task_plot_tubiao8",
    2
  },
  {
    2,
    "str_quest_base_type_growth_with_space",
    "GROWING",
    4,
    "task_plot_tubiao4",
    "task_plot_tubiao10",
    4
  },
  {
    3,
    "str_quest_base_type_stroy_with_space",
    "PLOT",
    1,
    "task_plot_tubiao1",
    "task_plot_tubiao7",
    1
  },
  {
    4,
    "str_quest_base_type_side_with_space",
    "BRANCH",
    3,
    "task_plot_tubiao3",
    "task_plot_tubiao9",
    3
  },
  {
    5,
    "str_quest_base_type_achieve_with_space",
    "ACHIEVE",
    5,
    "task_plot_tubiao5",
    "task_plot_tubiao11",
    5
  },
  {
    6,
    "str_season_s1_quest_tab_with_space",
    "SEASON",
    10001,
    "task_plot_tubiao6",
    "task_plot_tubiao12"
  }
}
return config, "ID", key
