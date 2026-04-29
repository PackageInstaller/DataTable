local key = {
  ID = 1,
  PictureName = 2,
  Desc = 3,
  MinAmbient = 4,
  MaxAmbient = 5
}
local config = {
  {
    1,
    "home_jiaju_pin01",
    "str_aircraft_quality_1",
    0,
    1500
  },
  {
    2,
    "home_jiaju_pin02",
    "str_aircraft_quality_2",
    1501,
    3000
  },
  {
    3,
    "home_jiaju_pin07",
    "str_aircraft_quality_3",
    3001,
    4500
  },
  {
    4,
    "home_jiaju_pin03",
    "str_aircraft_quality_4",
    4501,
    6000
  },
  {
    5,
    "home_jiaju_pin04",
    "str_aircraft_quality_5",
    6001,
    8000
  },
  {
    6,
    "home_jiaju_pin05",
    "str_aircraft_quality_6",
    8001,
    10000
  },
  {
    7,
    "home_jiaju_pin06",
    "str_aircraft_quality_7",
    10001,
    20000
  }
}
return config, "ID", key
