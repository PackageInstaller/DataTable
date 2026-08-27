local HomeEnum = {}
HomeEnum.eHomeState = {
  None = 0,
  Normal = 1,
  ShowHero = 2,
  Hided = 3,
  Covered = 4
}
HomeEnum.eHomeTogType = {
  HumanResource = 1,
  ControlCenter = 2,
  Infrastructure = 3
}
HomeEnum.eHomeTogTypeOrder = {
  [1] = HomeEnum.eHomeTogType.HumanResource,
  [2] = HomeEnum.eHomeTogType.ControlCenter,
  [3] = HomeEnum.eHomeTogType.Infrastructure
}
HomeEnum.eChangeBtnType = {HeroData = 1, Oasis = 2}
HomeEnum.eAutoShwoCommand = {
  Pay = 0,
  Singin = 1,
  NoviceSign = 2,
  GameNotice = 3,
  SectorActivity = 4,
  LoginPupup = 5,
  ChipGift = 6,
  Comeback = 7,
  ActivitySignInMiniGame = 8,
  EventAngelaGift = 9,
  SaveMoney = 10,
  MonthCard = 11,
  FlipCard = 12,
  EventLadderGift = 13,
  DormFightBeInvited = 101
}
return HomeEnum
