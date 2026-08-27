local ChipEnum = {}
ChipEnum.eChipInfluenceType = {
  AllHero = 101,
  Career = 102,
  Camp = 103,
  Row = 104,
  HeroId = 105,
  EnemyAllHero = 601,
  EnemyCareer = 602,
  EnemyCamp = 603,
  EnemyRow = 604,
  EnemyHeroId = 605,
  DynPlayer = 701,
  DynEnemy = 801,
  PlayerConsume = 901
}
ChipEnum.eChipSelectState = {StateNone = 0, StateSelected = 1}
ChipEnum.eChipShowState = {
  NoneState = 0,
  NewState = 1,
  UpState = 2
}
ChipEnum.eChipType = {
  Normal = 1,
  Consume = 2,
  Buff = 3,
  WarChessBuff = 4,
  Rain = 5
}
return ChipEnum
