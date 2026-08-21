local key = {
  ID = 1,
  ScaleSpeed = 2,
  MaxScale = 3,
  MinScale = 4,
  MinimapScale = 5,
  DefaultScale = 6,
  MapSize = 7,
  MapBackgroundSize = 8,
  MapMinPos = 9,
  MapMaxPos = 10,
  IconClickeRange = 11,
  FocusSpeed = 12,
  MapTexture = 13,
  MapBackgroundTexture = 14
}
local config = {
  {
    1,
    1500,
    1000,
    400,
    700,
    750,
    {4096000, 4096000},
    {2540000, 1440000},
    {
      200000,
      0,
      180000
    },
    {
      -200000,
      0,
      -220000
    },
    80000,
    500000,
    "homeland_map",
    "n17_daditu_bg"
  }
}
return config, "ID", key
