local eWarChessEnum = {}
local eWCInteractType = require("Game.WarChess.Interact.Base.eWCInteractType")
eWarChessEnum.BattleRoomTypeBoss = 4
eWarChessEnum.eWarChessState = {
  none = 0,
  init = 1,
  deploy = 2,
  play = 3,
  finish = 4
}
eWarChessEnum.eWarChessServerState = {
  GameStateWaitingStart = 0,
  GameStateNormal = 1,
  SeasonReady = 2,
  SeasonNormal = 3,
  SeasonLobby = 4
}
eWarChessEnum.eWarChessResultState = {
  none = 0,
  win = 1,
  fail = 2
}
eWarChessEnum.eWCTeamState = {
  TeamStateNone = 0,
  WaitDeploy = 4,
  Die = 8,
  WaitForm = 16,
  Ghost = 32
}
eWarChessEnum.eGridToward = {
  up = 0,
  right = 1,
  down = 2,
  left = 3
}
eWarChessEnum.eUnitCat = {grid = 1, entity = 2}
eWarChessEnum.eSystemCat = {
  none = 0,
  battle = 1,
  shop = 2,
  treash = 3,
  event = 4,
  discard = 5,
  selectAlg = 6,
  cannon = 7,
  rescue = 9,
  strategyReward = 10,
  jump = 11
}
eWarChessEnum.eSystemOpCat = {
  open = 1,
  close = 2,
  switch = 3
}
eWarChessEnum.eConditionCat = {
  checkUnitValue = 2,
  checkTurnNum = 3,
  checkPressLevel = 5,
  checkItemNumAbove = 6,
  checkIsNotHaveEntityOnGrid = 8,
  checkIsHaveEntityOnGrid = 9,
  checkIsHaveTeamInRange = 20
}
eWarChessEnum.eSystemState = {
  selectChip = 98,
  selectChip_miaosha = 99,
  discardChio = 100
}
eWarChessEnum.wcGuideMomentType = {
  EnterWCGrid = 1,
  WCDeployState = 2,
  WCBSelectChip = 3,
  WCBattleExit = 4,
  WCEventEnter = 5,
  WCEventExit = 6,
  BeforeNewWCBattle = 7,
  WCEnterPlay = 8,
  WCDynEnterPlay = 9,
  WCTipPlayOver = 10
}
eWarChessEnum.wcGuideMomentGlobal = {
  [eWarChessEnum.wcGuideMomentType.WCDeployState] = true,
  [eWarChessEnum.wcGuideMomentType.WCEnterPlay] = true,
  [eWarChessEnum.wcGuideMomentType.WCDynEnterPlay] = true,
  [eWarChessEnum.wcGuideMomentType.WCTipPlayOver] = true
}
eWarChessEnum.eEntityCat = {
  monster = 1,
  common = 2,
  cannonTube = 3,
  counter = 4,
  counterDownChest = 5
}
eWarChessEnum.eEntityShowCat = {
  common = 0,
  monster = 1,
  monster_a = 2,
  monster_b = 3,
  monster_b2 = 4,
  box = 5,
  treash = 6,
  rougeDoor = 7
}
eWarChessEnum.eTriggerType = {
  ChangeTeamHp = 13,
  ItemChange = 16,
  enemyPursueAtk = 26,
  OutsideItem = 33,
  ChangeMinHpHeroHp = 35
}
eWarChessEnum.eTriggerConditionType = {
  openSubSystem = 3,
  turnStart = 6,
  turnEnd = 7
}
eWarChessEnum.IntroInterActType = {
  [eWCInteractType.gridIntr] = true,
  [eWCInteractType.rougeDoorIntr] = true,
  [eWCInteractType.wcsSave] = true,
  [eWCInteractType.infoWithoutTeam] = true
}
eWarChessEnum.WCSpecialTriggerType = {chessJump = 1}
eWarChessEnum.WCSpecialItemType = {
  pumpkin = 1,
  start = 2,
  greenBox = 3
}
eWarChessEnum.WCSpecialItemLogicType = {
  healing
}
eWarChessEnum.eItemId = {Pumpkin = 1208}
eWarChessEnum.eWcEventId = {EatPumpkin = 110}
eWarChessEnum.WCEnviromentType = {
  None = 0,
  Rain = 1,
  Snow = 2
}
eWarChessEnum.eBriefDetailType = {
  reconnect = 0,
  normal = 1,
  season = 2
}
eWarChessEnum.eWarChessBuffShowType = {floor = 1, beforeBattle = 2}
eWarChessEnum.eWarChessBuffType = {chessMove = 31}
eWarChessEnum.eHeroBindFxType = {jumpChess = 1}
eWarChessEnum.eDynCtrl = {cleanFloorReward = 1}
return eWarChessEnum
