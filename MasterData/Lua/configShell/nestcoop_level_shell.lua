local this = class("nestcoop_level_shell", G_BaseConfig)
local core = G_Tables.TDNestcoopLevelTable.GetInstance()

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
  enemyID = 1,
  starTier = 2,
  difficulty = 3,
  EnemyLv = 4,
  recommendLv = 5,
  guarantee = 6,
  kiboDuelConfig = 7,
  environmentShow = 8,
  environmentTips = 9,
  Enemyskill = 10,
  show_skill = 11,
  show_pet_dna = 12,
  enemyPic = 13,
  enemyBackground = 14,
  introKiboEmotion = 15,
  introCameraShift = 16,
  hpPercentage = 17,
  starLinkPowered = 18,
  starLinkTimeLimit = 19,
  starlinkKiboAction = 20,
  starlinkKiboCamera = 21,
  starlinkKiboEmotion = 22,
  starlinkSuccesKiboAction = 23,
  mainReward = 24,
  RewardShow = 25,
  RewardItem = 26,
  challengeReward = 27,
  teamReward = 28,
  mvpReward = 29,
  hostReward = 30,
  kiboTower = 31,
  task = 32,
  minimumKibo = 33,
  levelType = 34,
  kiboList = 35,
  kiboLock = 36,
  kiboLockList = 37,
  handList = 38,
  trialRole = 39,
  skillList = 40,
  skillNumber = 41,
  passiveSkillList = 42,
  passiveSkillListNumber = 43,
  cost = 44,
  costTime = 45,
  time = 46,
  masterState = 47,
  summonType = 48,
  param = 49,
  fsm = 50
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEnemyid(offset)
  return core:GetInt(offset, this.indexMap.enemyID)
end

function this:_getStartier(offset)
  return core:GetInt(offset, this.indexMap.starTier)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getEnemylv(offset)
  return core:GetInt(offset, this.indexMap.EnemyLv)
end

function this:_getRecommendlv(offset)
  return core:GetInt(offset, this.indexMap.recommendLv)
end

function this:_getGuarantee(offset)
  return core:GetInt(offset, this.indexMap.guarantee)
end

function this:_getKiboduelconfig(offset)
  return core:GetInt(offset, this.indexMap.kiboDuelConfig)
end

function this:_getEnvironmentshow(offset)
  return core:GetInt(offset, this.indexMap.environmentShow)
end

function this:_getEnvironmenttips(offset)
  local langStr = G_TableMgrIns:GetLangStr("nestcoop_level", core:GetVString(offset, this.indexMap.environmentTips))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "environmentTips")
end

function this:_getEnemyskill(offset)
  local str = core:GetVString(offset, this.indexMap.Enemyskill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShow_skill(offset)
  local str = core:GetVString(offset, this.indexMap.show_skill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShow_pet_dna(offset)
  local str = core:GetVString(offset, this.indexMap.show_pet_dna).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEnemypic(offset)
  local str = core:GetVString(offset, this.indexMap.enemyPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getEnemybackground(offset)
  local str = core:GetVString(offset, this.indexMap.enemyBackground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIntrokiboemotion(offset)
  local str = core:GetVString(offset, this.indexMap.introKiboEmotion).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIntrocamerashift(offset)
  local str = core:GetVString(offset, this.indexMap.introCameraShift).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHppercentage(offset)
  return core:GetInt(offset, this.indexMap.hpPercentage)
end

function this:_getStarlinkpowered(offset)
  return core:GetInt(offset, this.indexMap.starLinkPowered)
end

function this:_getStarlinktimelimit(offset)
  return core:GetInt(offset, this.indexMap.starLinkTimeLimit)
end

function this:_getStarlinkkiboaction(offset)
  return core:GetVString(offset, this.indexMap.starlinkKiboAction).value
end

function this:_getStarlinkkibocamera(offset)
  return core:GetInt(offset, this.indexMap.starlinkKiboCamera)
end

function this:_getStarlinkkiboemotion(offset)
  return core:GetInt(offset, this.indexMap.starlinkKiboEmotion)
end

function this:_getStarlinksucceskiboaction(offset)
  return core:GetVString(offset, this.indexMap.starlinkSuccesKiboAction).value
end

function this:_getMainreward(offset)
  local str = core:GetVString(offset, this.indexMap.mainReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.RewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewarditem(offset)
  local str = core:GetVString(offset, this.indexMap.RewardItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getChallengereward(offset)
  local str = core:GetVString(offset, this.indexMap.challengeReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTeamreward(offset)
  local str = core:GetVString(offset, this.indexMap.teamReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMvpreward(offset)
  local str = core:GetVString(offset, this.indexMap.mvpReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHostreward(offset)
  local str = core:GetVString(offset, this.indexMap.hostReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKibotower(offset)
  local str = core:GetVString(offset, this.indexMap.kiboTower).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTask(offset)
  local str = core:GetVString(offset, this.indexMap.task).value
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

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getCosttime(offset)
  local str = core:GetVString(offset, this.indexMap.costTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
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

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFsm(offset)
  local str = core:GetVString(offset, this.indexMap.fsm).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  enemyID = this._getEnemyid,
  starTier = this._getStartier,
  difficulty = this._getDifficulty,
  EnemyLv = this._getEnemylv,
  recommendLv = this._getRecommendlv,
  guarantee = this._getGuarantee,
  kiboDuelConfig = this._getKiboduelconfig,
  environmentShow = this._getEnvironmentshow,
  environmentTips = this._getEnvironmenttips,
  Enemyskill = this._getEnemyskill,
  show_skill = this._getShow_skill,
  show_pet_dna = this._getShow_pet_dna,
  enemyPic = this._getEnemypic,
  enemyBackground = this._getEnemybackground,
  introKiboEmotion = this._getIntrokiboemotion,
  introCameraShift = this._getIntrocamerashift,
  hpPercentage = this._getHppercentage,
  starLinkPowered = this._getStarlinkpowered,
  starLinkTimeLimit = this._getStarlinktimelimit,
  starlinkKiboAction = this._getStarlinkkiboaction,
  starlinkKiboCamera = this._getStarlinkkibocamera,
  starlinkKiboEmotion = this._getStarlinkkiboemotion,
  starlinkSuccesKiboAction = this._getStarlinksucceskiboaction,
  mainReward = this._getMainreward,
  RewardShow = this._getRewardshow,
  RewardItem = this._getRewarditem,
  challengeReward = this._getChallengereward,
  teamReward = this._getTeamreward,
  mvpReward = this._getMvpreward,
  hostReward = this._getHostreward,
  kiboTower = this._getKibotower,
  task = this._getTask,
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
  cost = this._getCost,
  costTime = this._getCosttime,
  time = this._getTime,
  masterState = this._getMasterstate,
  summonType = this._getSummontype,
  param = this._getParam,
  fsm = this._getFsm
}
return this
