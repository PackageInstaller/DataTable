local key = {
  ID = 1,
  GSpeed = 2,
  BirthPos = 3,
  BaseJumpSpeed = 4,
  AccDownSpeed = 5,
  SpeedWhenAttackAtDown = 6,
  SpeedWhenAttackAtAccDown = 7,
  AirJumpSpeed = 8,
  AttckCD = 9,
  AirAttackCD = 10,
  JumpCD = 11
}
local config = {
  {
    1,
    4400,
    {-420, 0},
    1450,
    -1800,
    1500,
    1800,
    1200,
    500,
    300,
    60
  }
}
return config, "ID", key
