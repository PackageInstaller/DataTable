local key = {
  Polt = 1,
  Icon = 2,
  Title = 3,
  Content = 4,
  Visibility = 5,
  Weather = 6,
  WindSpeed = 7,
  Temperature = 8
}
local config = {
  [50230101] = {
    {1, 1},
    "n15_draw_story_101",
    "str_n15_polt_title_1",
    "str_n15_polt_content_1",
    "str_n15_visibility_1",
    "str_n15_weather_1",
    "str_n15_windSpeed_1",
    "str_n15_temperature_1"
  },
  [50230201] = {
    {1, 2},
    "n15_draw_story_201",
    "str_n15_polt_title_2",
    "str_n15_polt_content_2",
    "str_n15_visibility_2",
    "str_n15_weather_2",
    "str_n15_windSpeed_2",
    "str_n15_temperature_2"
  },
  [50230301] = {
    {1, 3},
    "n15_draw_story_401",
    "str_n15_polt_title_3",
    "str_n15_polt_content_3",
    "str_n15_visibility_3",
    "str_n15_weather_3",
    "str_n15_windSpeed_3",
    "str_n15_temperature_3"
  },
  [50230401] = {
    {1, 4},
    "n15_draw_story_301",
    "str_n15_polt_title_4",
    "str_n15_polt_content_4",
    "str_n15_visibility_4",
    "str_n15_weather_4",
    "str_n15_windSpeed_4",
    "str_n15_temperature_4"
  },
  [50230501] = {
    {1, 5},
    "n15_draw_story_601",
    "str_n15_polt_title_5",
    "str_n15_polt_content_5",
    "str_n15_visibility_5",
    "str_n15_weather_5",
    "str_n15_windSpeed_5",
    "str_n15_temperature_5"
  },
  [50230601] = {
    {1, 6},
    "n15_draw_story_501",
    "str_n15_polt_title_6",
    "str_n15_polt_content_6",
    "str_n15_visibility_6",
    "str_n15_weather_6",
    "str_n15_windSpeed_6",
    "str_n15_temperature_6"
  }
}
return config, "ID", key
