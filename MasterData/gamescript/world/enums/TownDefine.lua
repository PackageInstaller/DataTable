local TownDefine = {}
TownDefine.SceneEnums = System.NewEnum({MainCity = 1, CopiesPreparation = 2})
TownDefine.SortType = {
  Hp = 1,
  Power = 2,
  Will = 3,
  Level = 4,
  GetOrder = 5,
  Rare = 6,
  Favour = 7
}
TownDefine.CardSortType = {
  Rare = 1,
  Cost = 2,
  CardTypes = 3
}
TownDefine.TeamSortType = {
  Level = 1,
  Rare = 2,
  Hp = 3,
  Power = 4,
  Will = 5,
  SchoolAttr1 = 6,
  SchoolAttr2 = 7
}
TownDefine.AwakersPage = {
  List = 1,
  Detail = 2,
  Evolve = 3,
  LevelUp = 4,
  Skill = 5,
  Potency = 6,
  Record = 7
}
TownDefine.AwakerEvoleEffectType = {Skill = 1, Card = 2}
TownDefine.CopyEntranceStage = {SelectCopy = 1, Detail = 2}
TownDefine.EnterCopyPage = {
  SelectCopy = 1,
  SelectStoryLine = 2,
  StoryLineDetail = 3
}
TownDefine.RpgMoneyLevelState = {
  Locked = 1,
  Unlocked = 2,
  Passed = 3
}
TownDefine.DBGCopyLevelHardType = {Normal = 0, Hard = 1}
return TownDefine
