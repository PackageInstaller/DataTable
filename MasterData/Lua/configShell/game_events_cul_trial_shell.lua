local this = class("game_events_cul_trial_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulTrialTable.GetInstance()

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
  trialId = 0,
  systemId = 1,
  phase = 2,
  condition = 3,
  ending = 4,
  trialName = 5,
  trialPic = 6,
  rankLevel = 7,
  skipRank = 8,
  skipScore = 9,
  dungeonId = 10,
  goal = 11,
  goalDes = 12,
  effect1 = 13,
  finalscore = 14,
  battleEndStory = 15
}

function this:_getTrialid(offset)
  return core:GetInt(offset, this.indexMap.trialId)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getPhase(offset)
  return core:GetInt(offset, this.indexMap.phase)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getEnding(offset)
  return core:GetInt(offset, this.indexMap.ending)
end

function this:_getTrialname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_trial", core:GetVString(offset, this.indexMap.trialName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "trialName")
end

function this:_getTrialpic(offset)
  local str = core:GetVString(offset, this.indexMap.trialPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 0)
end

function this:_getRanklevel(offset)
  return core:GetInt(offset, this.indexMap.rankLevel)
end

function this:_getSkiprank(offset)
  local str = core:GetVString(offset, this.indexMap.skipRank).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkipscore(offset)
  local str = core:GetVString(offset, this.indexMap.skipScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getGoal(offset)
  local str = core:GetVString(offset, this.indexMap.goal).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGoaldes(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("game_events_cul_trial", core:GetVString(offset, this.indexMap.goalDes))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "game_events_cul_trial")
end

function this:_getEffect1(offset)
  local str = core:GetVString(offset, this.indexMap.effect1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFinalscore(offset)
  local str = core:GetVString(offset, this.indexMap.finalscore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBattleendstory(offset)
  local str = core:GetVString(offset, this.indexMap.battleEndStory).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  trialId = this._getTrialid,
  systemId = this._getSystemid,
  phase = this._getPhase,
  condition = this._getCondition,
  ending = this._getEnding,
  trialName = this._getTrialname,
  trialPic = this._getTrialpic,
  rankLevel = this._getRanklevel,
  skipRank = this._getSkiprank,
  skipScore = this._getSkipscore,
  dungeonId = this._getDungeonid,
  goal = this._getGoal,
  goalDes = this._getGoaldes,
  effect1 = this._getEffect1,
  finalscore = this._getFinalscore,
  battleEndStory = this._getBattleendstory
}
return this
