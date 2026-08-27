local GuideEnum = {}
GuideEnum.StepType = {
  LargeDialog = 0,
  Operate = 1,
  Avg = 2,
  Code = 3,
  HeroSmallTalk = 4,
  Highlight = 5,
  AvgStory = 6,
  MultiPicture = 7
}
GuideEnum.GuideType = {NormalGuide = 0, TipsGuide = 1}
GuideEnum.TipsGuideType = {Normal = 0, Code = 1}
GuideEnum.TriggerGuideCondition = {
  FuncUnlock = 1,
  HasItem = 2,
  SectorStage = 3,
  HeroLevelGreater = 4,
  InExploration = 5,
  BattleBenchHasRole = 6,
  ActivityExist = 7,
  AnyAthCanSign = 8
}
GuideEnum.GuideFeature = {None = 0, ItemDetail = 1}
GuideEnum.TipsGuideShowType = {
  Arrow = 1,
  Area = 2,
  Fx = 3
}
GuideEnum.SpecialGuideShowType = {
  None = 0,
  SlideGuide = 1,
  HandClick = 2
}
return GuideEnum
