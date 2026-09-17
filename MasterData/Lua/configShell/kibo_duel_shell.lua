local this = class("kibo_duel_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelTable.GetInstance()

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
  dungeonId = 1,
  duelMode = 2,
  duelModeShow = 3,
  type = 4,
  worldSpawnerId = 5,
  npcIcon = 6,
  aniName = 7,
  npcInfo = 8,
  levelName = 9,
  levelTalk = 10,
  areaType = 11,
  areaRankLevel = 12,
  areaIcon = 13,
  areaLevel = 14,
  recommendLevel = 15,
  soulLinkLevel = 16,
  isAuto = 17,
  autoCondition = 18,
  isRechallenge = 19,
  potentialValue = 20,
  firstLoot = 21,
  commonReward = 22,
  challenge = 23,
  challengeReward = 24,
  challengeRewardShow = 25,
  task = 26,
  KiboNumber = 27,
  npcSummonAction = 28,
  enemy = 29,
  minimumKibo = 30,
  levelType = 31,
  kiboList = 32,
  kiboLock = 33,
  kiboLockList = 34,
  handList = 35,
  trialRole = 36,
  skillList = 37,
  skillNumber = 38,
  passiveSkillList = 39,
  passiveSkillListNumber = 40,
  skillBytesPath = 41,
  cost = 42,
  costTime = 43,
  buffTime = 44,
  time = 45,
  masterState = 46,
  summonType = 47,
  behaviortree = 48,
  param = 49,
  summoningArea = 50,
  fsm = 51,
  guideFsmPath = 52,
  defaultTime = 53,
  timePassAvailable = 54,
  mapId = 55,
  blueprintId = 56
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getDuelmode(offset)
  return core:GetInt(offset, this.indexMap.duelMode)
end

function this:_getDuelmodeshow(offset)
  return core:GetBool(offset, this.indexMap.duelModeShow)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getWorldspawnerid(offset)
  return core:GetInt(offset, this.indexMap.worldSpawnerId)
end

function this:_getNpcicon(offset)
  local str = core:GetVString(offset, this.indexMap.npcIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getAniname(offset)
  return core:GetVString(offset, this.indexMap.aniName).value
end

function this:_getNpcinfo(offset)
  local str = core:GetVString(offset, this.indexMap.npcInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLevelname(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel", core:GetVString(offset, this.indexMap.levelName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "levelName")
end

function this:_getLeveltalk(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel", core:GetVString(offset, this.indexMap.levelTalk))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "levelTalk")
end

function this:_getAreatype(offset)
  return core:GetInt(offset, this.indexMap.areaType)
end

function this:_getArearanklevel(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel", core:GetVString(offset, this.indexMap.areaRankLevel))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "areaRankLevel")
end

function this:_getAreaicon(offset)
  local str = core:GetVString(offset, this.indexMap.areaIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getArealevel(offset)
  return core:GetInt(offset, this.indexMap.areaLevel)
end

function this:_getRecommendlevel(offset)
  return core:GetInt(offset, this.indexMap.recommendLevel)
end

function this:_getSoullinklevel(offset)
  return core:GetInt(offset, this.indexMap.soulLinkLevel)
end

function this:_getIsauto(offset)
  return core:GetBool(offset, this.indexMap.isAuto)
end

function this:_getAutocondition(offset)
  local str = core:GetVString(offset, this.indexMap.autoCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsrechallenge(offset)
  return core:GetBool(offset, this.indexMap.isRechallenge)
end

function this:_getPotentialvalue(offset)
  return core:GetFloat(offset, this.indexMap.potentialValue)
end

function this:_getFirstloot(offset)
  local str = core:GetVString(offset, this.indexMap.firstLoot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCommonreward(offset)
  local str = core:GetVString(offset, this.indexMap.commonReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getChallenge(offset)
  local str = core:GetVString(offset, this.indexMap.challenge).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getChallengereward(offset)
  local str = core:GetVString(offset, this.indexMap.challengeReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getChallengerewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.challengeRewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTask(offset)
  local str = core:GetVString(offset, this.indexMap.task).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKibonumber(offset)
  return core:GetInt(offset, this.indexMap.KiboNumber)
end

function this:_getNpcsummonaction(offset)
  local str = core:GetVString(offset, this.indexMap.npcSummonAction).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getEnemy(offset)
  local str = core:GetVString(offset, this.indexMap.enemy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMinimumkibo(offset)
  return core:GetInt(offset, this.indexMap.minimumKibo)
end

function this:_getLeveltype(offset)
  return core:GetInt(offset, this.indexMap.levelType)
end

function this:_getKibolist(offset)
  local str = core:GetVString(offset, this.indexMap.kiboList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKibolock(offset)
  return core:GetInt(offset, this.indexMap.kiboLock)
end

function this:_getKibolocklist(offset)
  local str = core:GetVString(offset, this.indexMap.kiboLockList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHandlist(offset)
  local str = core:GetVString(offset, this.indexMap.handList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTrialrole(offset)
  return core:GetInt(offset, this.indexMap.trialRole)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkillnumber(offset)
  return core:GetInt(offset, this.indexMap.skillNumber)
end

function this:_getPassiveskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.passiveSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPassiveskilllistnumber(offset)
  return core:GetInt(offset, this.indexMap.passiveSkillListNumber)
end

function this:_getSkillbytespath(offset)
  local str = core:GetVString(offset, this.indexMap.skillBytesPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getCosttime(offset)
  local str = core:GetVString(offset, this.indexMap.costTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBufftime(offset)
  local str = core:GetVString(offset, this.indexMap.buffTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getMasterstate(offset)
  return core:GetInt(offset, this.indexMap.masterState)
end

function this:_getSummontype(offset)
  local str = core:GetVString(offset, this.indexMap.summonType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBehaviortree(offset)
  local str = core:GetVString(offset, this.indexMap.behaviortree).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSummoningarea(offset)
  local str = core:GetVString(offset, this.indexMap.summoningArea).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFsm(offset)
  local str = core:GetVString(offset, this.indexMap.fsm).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getGuidefsmpath(offset)
  local str = core:GetVString(offset, this.indexMap.guideFsmPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDefaulttime(offset)
  return core:GetInt(offset, this.indexMap.defaultTime)
end

function this:_getTimepassavailable(offset)
  return core:GetInt(offset, this.indexMap.timePassAvailable)
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapId)
end

function this:_getBlueprintid(offset)
  return core:GetInt(offset, this.indexMap.blueprintId)
end

this.keyToMethodsMap = {
  id = this._getId,
  dungeonId = this._getDungeonid,
  duelMode = this._getDuelmode,
  duelModeShow = this._getDuelmodeshow,
  type = this._getType,
  worldSpawnerId = this._getWorldspawnerid,
  npcIcon = this._getNpcicon,
  aniName = this._getAniname,
  npcInfo = this._getNpcinfo,
  levelName = this._getLevelname,
  levelTalk = this._getLeveltalk,
  areaType = this._getAreatype,
  areaRankLevel = this._getArearanklevel,
  areaIcon = this._getAreaicon,
  areaLevel = this._getArealevel,
  recommendLevel = this._getRecommendlevel,
  soulLinkLevel = this._getSoullinklevel,
  isAuto = this._getIsauto,
  autoCondition = this._getAutocondition,
  isRechallenge = this._getIsrechallenge,
  potentialValue = this._getPotentialvalue,
  firstLoot = this._getFirstloot,
  commonReward = this._getCommonreward,
  challenge = this._getChallenge,
  challengeReward = this._getChallengereward,
  challengeRewardShow = this._getChallengerewardshow,
  task = this._getTask,
  KiboNumber = this._getKibonumber,
  npcSummonAction = this._getNpcsummonaction,
  enemy = this._getEnemy,
  minimumKibo = this._getMinimumkibo,
  levelType = this._getLeveltype,
  kiboList = this._getKibolist,
  kiboLock = this._getKibolock,
  kiboLockList = this._getKibolocklist,
  handList = this._getHandlist,
  trialRole = this._getTrialrole,
  skillList = this._getSkilllist,
  skillNumber = this._getSkillnumber,
  passiveSkillList = this._getPassiveskilllist,
  passiveSkillListNumber = this._getPassiveskilllistnumber,
  skillBytesPath = this._getSkillbytespath,
  cost = this._getCost,
  costTime = this._getCosttime,
  buffTime = this._getBufftime,
  time = this._getTime,
  masterState = this._getMasterstate,
  summonType = this._getSummontype,
  behaviortree = this._getBehaviortree,
  param = this._getParam,
  summoningArea = this._getSummoningarea,
  fsm = this._getFsm,
  guideFsmPath = this._getGuidefsmpath,
  defaultTime = this._getDefaulttime,
  timePassAvailable = this._getTimepassavailable,
  mapId = this._getMapid,
  blueprintId = this._getBlueprintid
}
return this
