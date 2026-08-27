local eFairyEnum = {}
eFairyEnum.jumpType = {
  none = 0,
  cultivate = 1,
  lottery = 2
}
eFairyEnum.ShowFaiyType = {FairyHallScene = 1, CultivateShow = 2}
eFairyEnum.FairyCultivateState = {
  check = 1,
  upgradeStar = 2,
  recovery = 3
}
eFairyEnum.fairyQualityType = {
  s = 1,
  a = 2,
  b = 3,
  c = 4
}
eFairyEnum.Quality2Color = {
  [eFairyEnum.fairyQualityType.s] = Color.New(1, 0.4705882, 0.007843138, 1),
  [eFairyEnum.fairyQualityType.a] = Color.New(0.7411765, 0.4509804, 0.9568627, 1),
  [eFairyEnum.fairyQualityType.b] = Color.New(0.2235294, 0.6745098, 0.945098, 1),
  [eFairyEnum.fairyQualityType.c] = Color.New(0.3137255, 0.8392157, 0.4784314, 1)
}
return eFairyEnum
