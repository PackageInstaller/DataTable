local SmashingPenguinsConfig = {
  MinCannonDragRange = 50,
  MaxCannonDragRange = 200,
  FirePowerMultiple = 0.5,
  MaxFirePower = 70,
  MaxXPos = 500,
  MaxYPos = 2000,
  DeltaCamFloowXPos = -20,
  MinYPosShowTracker = 600,
  MinFireAngle = 10,
  MaxFireAngle = 170,
  MaxSpeed = 1000,
  MinSqrtSpeedKeepDir = 30,
  MinSqrtSpeedKeepRoll = 100,
  MinSqrtSpeedPlayCollisionAudio = 100,
  MaxLogicFrameNumKeepRoll = 40,
  MinSqrtSpeedKeepAlive = 50,
  MaxLogicFrameNumSpeedKeepAlive = 30,
  MinYPosKeepAlive = -2000,
  GravityScale = 4,
  MinXDistanceShowEntity = 1920,
  WindForce = {x = -1, y = 45},
  VelocityMultipleBeforeWind = {x = 0.2, y = 0.1},
  BombForce = {x = -45, y = 35},
  VelocityMultipleBeforeBomb = {x = 0, y = 0},
  DistanceScoreMultiple = 0.5,
  StartPosBeforeAnim = {x = 1200, y = 0},
  MainUiAnimData = {
    {
      animType = 1,
      cfg = {
        startX = 1200,
        startY = 0,
        endX = -1200,
        endY = 0,
        time = 1.5
      }
    },
    {
      animType = 2,
      cfg = {
        startX = 1200,
        startY = 0,
        dirX = -20,
        dirY = -10,
        power = 100,
        time = 3
      }
    },
    {
      animType = 2,
      cfg = {
        startX = 1200,
        startY = 800,
        dirX = -45,
        dirY = 0,
        power = 200,
        time = 3
      }
    },
    {
      animType = 2,
      cfg = {
        startX = 1200,
        startY = 45,
        dirX = -45,
        dirY = 30,
        power = 70,
        time = 4
      }
    },
    {
      animType = 2,
      cfg = {
        startX = 1200,
        startY = 0,
        dirX = -45,
        dirY = 0,
        power = 50,
        time = 4
      }
    }
  }
}
return SmashingPenguinsConfig
