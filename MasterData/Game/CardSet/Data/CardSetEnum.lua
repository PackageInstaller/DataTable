local CardSetEnum = {}
CardSetEnum.eCardType = {
  None = 0,
  Scene = 1,
  Monster = 2,
  HeroBuff = 3,
  Buff = 4
}
CardSetEnum.showOrder = {
  CardSetEnum.eCardType.Scene,
  CardSetEnum.eCardType.Monster,
  CardSetEnum.eCardType.HeroBuff,
  CardSetEnum.eCardType.Buff
}
CardSetEnum.eSetType = {
  normal = 1,
  rank = 2,
  rewind = 3
}
CardSetEnum.eRightState = {
  tags = 1,
  detail4OneCard = 2,
  detail4AllCard = 3
}
CardSetEnum.eCardTive = {
  none = 0,
  postive = 1,
  mid = 2,
  negative = 3,
  max = 4
}
CardSetEnum.eCardTag = {
  AddScore = 1,
  AddScorePersent = 2,
  ReduceCost = 3,
  UseMoreTimes = 4
}
CardSetEnum.reddotType = {
  rankTask = 1,
  firstEnterTaskBlue = 2,
  bpReward = 3
}
CardSetEnum.reddotIsRedType = {
  CardSetEnum.reddotType.rankTask,
  CardSetEnum.reddotType.bpReward
}
return CardSetEnum
