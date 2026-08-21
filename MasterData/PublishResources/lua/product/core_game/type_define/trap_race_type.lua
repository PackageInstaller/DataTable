TrapRaceType = {
  Team = 1,
  Pet = 2,
  Monster = 3,
  All = 4,
  FilterByBuff = 5,
  FriendTeam = 6,
  EnemyTeam = 7,
  AllTeam = 8,
  ChessPet = 9,
  None = 10,
  MAX = 99
}
PvpTrapRaceType = {
  [TrapRaceType.Team] = TrapRaceType.FriendTeam,
  [TrapRaceType.Pet] = TrapRaceType.FriendTeam,
  [TrapRaceType.Monster] = TrapRaceType.EnemyTeam
}
