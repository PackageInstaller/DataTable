local CareerLevelDefine = {}
CareerLevelDefine.CareerLevelType = {
  DailyChallenge = 1,
  PvpPreBuilt = 2,
  PvpDraft = 3,
  RailWay = 4
}
CareerLevelDefine.CareerLevelType2PvpType = {
  [CareerLevelDefine.CareerLevelType.PvpDraft] = PvpDefine.PvpType.Draft,
  [CareerLevelDefine.CareerLevelType.PvpPreBuilt] = PvpDefine.PvpType.PreBuilt
}
return CareerLevelDefine
