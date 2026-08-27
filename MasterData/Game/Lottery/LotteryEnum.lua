local LotteryEnum = {}
LotteryEnum.eLotteryPoolLogicType = {
  NoPaid = 0,
  Paid = 1,
  SelfSelect = 2,
  fairy = 3
}
LotteryEnum.eLotteryPoolType = {NoPaid = 0, Paid = 1}
LotteryEnum.eLotteryState = {
  None = 0,
  Normal = 1,
  WaitStartShow = 2,
  LotteryAnimation = 3,
  PoolDetail = 4,
  SelectPool = 5
}
LotteryEnum.eLtrExecType = {
  Once = 1,
  Ten = 2,
  SpecialOnce = 3,
  FreeChoice = 4,
  CustomNum = 5
}
LotteryEnum.SpecialSelectHeroNum = 4
return LotteryEnum
