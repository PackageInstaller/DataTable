local key = {
  ID = 1,
  UnlockTime = 2,
  PetIcon = 3,
  PetName = 4,
  Text = 5,
  MovieId = 6,
  Rewards = 7
}
local config = {
  {
    1,
    "2023-01-12 05:00:00",
    "dy_nmts_tu02",
    "str_movie_anoletter_name_1",
    "str_movie_anoletter_text_1",
    104,
    {
      {3000003, 30},
      {3000297, 1},
      {5273028, 1},
      {5273029, 1}
    }
  },
  {
    2,
    "2023-01-13 05:00:00",
    "dy_nmts_tu01",
    "str_movie_anoletter_name_2",
    "str_movie_anoletter_text_2",
    105,
    {
      {3000003, 30},
      {3000298, 1},
      {5273037, 1},
      {5273038, 1}
    }
  },
  {
    3,
    "2023-01-14 05:00:00",
    "dy_nmts_tu03",
    "str_movie_anoletter_name_3",
    "str_movie_anoletter_text_3",
    106,
    {
      {3000003, 30},
      {3000299, 1},
      {5273049, 1},
      {5273050, 1}
    }
  }
}
return config, "ID", key
