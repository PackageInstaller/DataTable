local WCEnum = {}
WCEnum.eRankType = {
  none = 0,
  normal = 1,
  activity = 2
}
WCEnum.eWeeklyChallengeType = {
  normal = 1,
  advance = 2,
  special = 3
}
WCEnum.eWeeklyChallengeId = {
  [WCEnum.eWeeklyChallengeType.normal] = 1501,
  [WCEnum.eWeeklyChallengeType.advance] = 1502,
  [WCEnum.eWeeklyChallengeType.special] = 1503
}
return WCEnum
