local ExplorationEnum = {}
ExplorationEnum.eRoomType = {
  deploy = -1,
  start = 0,
  boss = 1,
  empty = 2,
  enemy = 3,
  item = 4,
  store = 5,
  elite = 6,
  challenge = 7,
  eventroom = 8,
  recovery = 9,
  chip = 10,
  story = 11,
  aidroom = 12,
  partfusion = 15,
  curse = 18,
  eventShop = 19,
  canNotSee = 100
}
ExplorationEnum.eRoomLogicType = {
  none = 0,
  battle = 1,
  chip = 2,
  store = 3,
  treasure = 4,
  event = 5,
  excustom = 6,
  canNotSee = 100
}
ExplorationEnum.eMapLogic = {
  Default = 1,
  TowerDefence = 3,
  Light = 4,
  Guard = 5,
  Brotato = 6
}
ExplorationEnum.eRoomTypeState = {
  None = 0,
  Complete = 1,
  CurrentStay = 2,
  AbleChoose = 3,
  UnReachable = 4,
  CantMove = 5
}
ExplorationEnum.eTrackLineType = {
  NormalYTrack = 0,
  NormalETrack = 1,
  ReverseETrack = 2,
  SingleTrack = 3,
  EndTrack = 4
}
ExplorationEnum.eTrackLineState = {
  Normal = 0,
  Pass = 1,
  Auto = 2
}
ExplorationEnum.LineAutoModeColor = Color.white
ExplorationEnum.eEpSceneState = {
  None = 0,
  InTimeline = 1,
  InEpScene = 2,
  InBattleScene = 3
}
ExplorationEnum.eEpCamControlState = {
  None = 0,
  Exploration = 1,
  Battle = 2
}
ExplorationEnum.eHeroHpPercent = 10000
ExplorationEnum.eEventRoomType = {Recovery = 1, Event = 2}
ExplorationEnum.eEventRoomChoiceType = {
  Normal = 1,
  Random = 2,
  Upgrade = 3,
  Jump = 4,
  Assist = 5,
  AssistEx = 6
}
ExplorationEnum.eChoiceConditionType = {
  NotRequired = 0,
  Required = 1,
  NotRequiredAtLeastOne = 2
}
ExplorationEnum.eChoiceDeductType = {Item = 1, Buff = 2}
ExplorationEnum.eResetRoomType = {
  Duplicate = 1,
  Mix = 2,
  reconstitution = 3
}
ExplorationEnum.ePlayerClientState = {
  OutSideRoom = 1,
  Entering = 2,
  InRoom = 3,
  Exiting = 4
}
ExplorationEnum.exRoomType = {None = 0, AvgRoom = 1}
ExplorationEnum.eExitRoomCompleteType = {
  EventRoom = 1,
  BattleToEp = 2,
  StoreRoom = 3,
  TreasureRoom = 4,
  OutsideSelectChip = 5,
  DiscardChip = 6,
  ResetRoom = 7,
  JumpRoomComplete = 8,
  SupportRoom = 9,
  TaskSelect = 10,
  SelectDebuff = 11,
  ExRoom = 12
}
ExplorationEnum.eAutoEpSwitchType = {
  None = 0,
  EpWindow = 1,
  Battle = 2
}
ExplorationEnum.eAutoEventChoiceType = {
  AllRoleHpLess = 1,
  OneRoleHpLess = 2,
  HasItemCount = 3,
  RoleAvgHpLess = 4,
  RoleAvgHpGreate = 5
}
ExplorationEnum.eAutoTitleType = {
  Normal = 0,
  SelectRoom = 1,
  ExitRoom = 2,
  UpgradeChip = 3,
  DiscardChip = 4,
  BuyChip = 5,
  GiveupChip = 6,
  SelectChip = 7,
  UpgradeChipLimit = 8,
  EventSupport = 9
}
ExplorationEnum.EnemyRoleType = {
  monster = 1,
  neutral = 2,
  player = 3,
  towerSumMonster = 4,
  templateMonster = 5
}
ExplorationEnum.eCampFetterCoolDownType = {
  None = 0,
  Once = 1,
  NextFloor = 2,
  AfterNBattle = 3,
  AfterNRoom = 4
}
ExplorationEnum.eCampFetterActiveSkillType = {
  FullfillChipList = 1,
  SwitchChip2Orange = 2,
  FreedomRoomChoice = 3,
  CallStoreRoom = 4,
  OweMoney = 5
}
ExplorationEnum.eCampFetterUsableConditon = {
  ep = 1,
  epChipSelect = 2,
  epBattleDeploy = 3,
  epCouldSelectNextRoom = 4
}
ExplorationEnum.eCampFetterCDType = {
  none = 0,
  totalEp = 1,
  nextFoor = 2,
  afterBattle = 3,
  afterMoveRoom = 4
}
ExplorationEnum.eBuffLogicId = {
  buyChipLimitNum = 19,
  selectChipRefreshNum = 20,
  sealChipScale = 23,
  couldLeonMoney = 26,
  freeSelectRoom = 27
}
ExplorationEnum.eDifficultType = {Normal = 1, Hard = 2}
ExplorationEnum.UnReachableAlpha = 0.2
ExplorationEnum.epGuideMomentType = {
  ReayBattle = 1,
  BeforeNewEpBattle = 2,
  BattleUltFull = 3,
  StartBattleDelay = 4,
  FailBattleRestart = 5,
  AfterRoleDead = 6,
  BattleSelectChip = 7,
  EnterEpEventRoom = 8,
  InEpOutsideRoom = 9,
  BattleDeployState = 10
}
ExplorationEnum.epScoreStatisticsType = {NormalStatistics = 1, TowerStatistics = 2}
ExplorationEnum.epGamblebenefitTagType = {
  Buff = 1,
  Debuff = 2,
  Normal = 3
}
ExplorationEnum.eResidentStoreType = {
  none = 0,
  weeklychallenge = 1,
  towerDefine = 2
}
ExplorationEnum.eSkillAdapterType = {
  None = 0,
  Ban = 1,
  Replace = 2
}
ExplorationEnum.SpecGameTypeAdapter = {
  None = 0,
  TD = 1,
  Recommend = 2,
  OfficialSupport = 3
}
ExplorationEnum.eRoomTag = {
  None = 0,
  MoveStop = 1,
  Brittle = 2,
  Wormhole = 3
}
return ExplorationEnum
