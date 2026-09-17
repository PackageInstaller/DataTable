local this = class("dungeon_shell", G_BaseConfig)
local core = G_Tables.TDDungeonTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  groupId = 1,
  doorId = 2,
  diffType = 3,
  dungeonGroupOrder = 4,
  dungeonGroupTag = 5,
  dungeonType = 6,
  dungeonSystemType = 7,
  enterBattle = 8,
  battleEnemy = 9,
  expandParams = 10,
  dungeonRandomAvailable = 11,
  name = 12,
  unlockCondition = 13,
  description = 14,
  showLevel = 15,
  openType = 16,
  openTypeParam = 17,
  type = 18,
  victoryCondition = 19,
  failCondition = 20,
  challenge = 21,
  challengeDes = 22,
  challengeReward = 23,
  needPower = 24,
  firstLoot = 25,
  loot = 26,
  lootShowing = 27,
  upDuration = 28,
  upTime = 29,
  upLoot = 30,
  weeklyFreeTime = 31,
  userExp = 32,
  enemy = 33,
  position = 34,
  defaultTime = 35,
  timePassAvailable = 36,
  mountAvailable = 37,
  cameraDistance = 38,
  cameraVerticalAngle = 39,
  cameraHorizontalAngle = 40,
  dungeonRandomScene = 41,
  gameplayID = 42,
  difficultIndex = 43,
  multiIndex = 44,
  levelSuppressionEnabled = 45
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getDoorid(offset)
  return core:GetInt(offset, this.indexMap.doorId)
end

function this:_getDifftype(offset)
  return core:GetInt(offset, this.indexMap.diffType)
end

function this:_getDungeongrouporder(offset)
  return core:GetInt(offset, this.indexMap.dungeonGroupOrder)
end

function this:_getDungeongrouptag(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon", core:GetVString(offset, this.indexMap.dungeonGroupTag))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dungeonGroupTag")
end

function this:_getDungeontype(offset)
  return core:GetInt(offset, this.indexMap.dungeonType)
end

function this:_getDungeonsystemtype(offset)
  return core:GetInt(offset, this.indexMap.dungeonSystemType)
end

function this:_getEnterbattle(offset)
  return core:GetInt(offset, this.indexMap.enterBattle)
end

function this:_getBattleenemy(offset)
  local str = core:GetVString(offset, this.indexMap.battleEnemy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExpandparams(offset)
  local str = core:GetVString(offset, this.indexMap.expandParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getDungeonrandomavailable(offset)
  return core:GetInt(offset, this.indexMap.dungeonRandomAvailable)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnlockcondition(offset)
  return core:GetVString(offset, this.indexMap.unlockCondition).value
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getShowlevel(offset)
  return core:GetInt(offset, this.indexMap.showLevel)
end

function this:_getOpentype(offset)
  return core:GetInt(offset, this.indexMap.openType)
end

function this:_getOpentypeparam(offset)
  local str = core:GetVString(offset, this.indexMap.openTypeParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getVictorycondition(offset)
  return core:GetVString(offset, this.indexMap.victoryCondition).value
end

function this:_getFailcondition(offset)
  return core:GetVString(offset, this.indexMap.failCondition).value
end

function this:_getChallenge(offset)
  return core:GetVString(offset, this.indexMap.challenge).value
end

function this:_getChallengedes(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("dungeon", core:GetVString(offset, this.indexMap.challengeDes))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "dungeon")
end

function this:_getChallengereward(offset)
  local str = core:GetVString(offset, this.indexMap.challengeReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNeedpower(offset)
  return core:GetInt(offset, this.indexMap.needPower)
end

function this:_getFirstloot(offset)
  local str = core:GetVString(offset, this.indexMap.firstLoot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLoot(offset)
  return core:GetInt(offset, this.indexMap.loot)
end

function this:_getLootshowing(offset)
  local str = core:GetVString(offset, this.indexMap.lootShowing).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUpduration(offset)
  local str = core:GetVString(offset, this.indexMap.upDuration).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUptime(offset)
  return core:GetInt(offset, this.indexMap.upTime)
end

function this:_getUploot(offset)
  return core:GetInt(offset, this.indexMap.upLoot)
end

function this:_getWeeklyfreetime(offset)
  return core:GetInt(offset, this.indexMap.weeklyFreeTime)
end

function this:_getUserexp(offset)
  return core:GetInt(offset, this.indexMap.userExp)
end

function this:_getEnemy(offset)
  local str = core:GetVString(offset, this.indexMap.enemy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDefaulttime(offset)
  return core:GetInt(offset, this.indexMap.defaultTime)
end

function this:_getTimepassavailable(offset)
  return core:GetInt(offset, this.indexMap.timePassAvailable)
end

function this:_getMountavailable(offset)
  return core:GetInt(offset, this.indexMap.mountAvailable)
end

function this:_getCameradistance(offset)
  return core:GetFloat(offset, this.indexMap.cameraDistance)
end

function this:_getCameraverticalangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraVerticalAngle)
end

function this:_getCamerahorizontalangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraHorizontalAngle)
end

function this:_getDungeonrandomscene(offset)
  return core:GetInt(offset, this.indexMap.dungeonRandomScene)
end

function this:_getGameplayid(offset)
  return core:GetInt(offset, this.indexMap.gameplayID)
end

function this:_getDifficultindex(offset)
  local str = core:GetVString(offset, this.indexMap.difficultIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMultiindex(offset)
  return core:GetInt(offset, this.indexMap.multiIndex)
end

function this:_getLevelsuppressionenabled(offset)
  return core:GetInt(offset, this.indexMap.levelSuppressionEnabled)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  doorId = this._getDoorid,
  diffType = this._getDifftype,
  dungeonGroupOrder = this._getDungeongrouporder,
  dungeonGroupTag = this._getDungeongrouptag,
  dungeonType = this._getDungeontype,
  dungeonSystemType = this._getDungeonsystemtype,
  enterBattle = this._getEnterbattle,
  battleEnemy = this._getBattleenemy,
  expandParams = this._getExpandparams,
  dungeonRandomAvailable = this._getDungeonrandomavailable,
  name = this._getName,
  unlockCondition = this._getUnlockcondition,
  description = this._getDescription,
  showLevel = this._getShowlevel,
  openType = this._getOpentype,
  openTypeParam = this._getOpentypeparam,
  type = this._getType,
  victoryCondition = this._getVictorycondition,
  failCondition = this._getFailcondition,
  challenge = this._getChallenge,
  challengeDes = this._getChallengedes,
  challengeReward = this._getChallengereward,
  needPower = this._getNeedpower,
  firstLoot = this._getFirstloot,
  loot = this._getLoot,
  lootShowing = this._getLootshowing,
  upDuration = this._getUpduration,
  upTime = this._getUptime,
  upLoot = this._getUploot,
  weeklyFreeTime = this._getWeeklyfreetime,
  userExp = this._getUserexp,
  enemy = this._getEnemy,
  position = this._getPosition,
  defaultTime = this._getDefaulttime,
  timePassAvailable = this._getTimepassavailable,
  mountAvailable = this._getMountavailable,
  cameraDistance = this._getCameradistance,
  cameraVerticalAngle = this._getCameraverticalangle,
  cameraHorizontalAngle = this._getCamerahorizontalangle,
  dungeonRandomScene = this._getDungeonrandomscene,
  gameplayID = this._getGameplayid,
  difficultIndex = this._getDifficultindex,
  multiIndex = this._getMultiindex,
  levelSuppressionEnabled = this._getLevelsuppressionenabled
}
return this
