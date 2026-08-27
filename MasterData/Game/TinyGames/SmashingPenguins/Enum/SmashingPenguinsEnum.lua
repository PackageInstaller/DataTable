local SmashingPenguinsEnum = {}
SmashingPenguinsEnum.eCharacterAnimState = {Cry = 1, Roll = 2}
SmashingPenguinsEnum.eGameState = {
  Init = 0,
  GameReady = 1,
  GameStart = 2,
  PrepareToFly = 3,
  Fly = 4,
  CharacterDie = 5,
  GameEnd = 6
}
return SmashingPenguinsEnum
