local this = class("dungeon_crisiscrusade_shell", G_BaseConfig)
local core = G_Tables.TDDungeonCrisiscrusadeTable.GetInstance()

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
  name = 1,
  difftype = 2,
  difficulty = 3,
  recommendedlevel = 4,
  mainReward = 5,
  sortId = 6,
  entrustNpc = 7,
  introduce = 8,
  dungeonId = 9,
  rewardShow = 10,
  challengeReward = 11,
  starRewardShow1 = 12,
  starRewardShow2 = 13,
  starRewardShow3 = 14,
  taskShow = 15,
  taskUnlock = 16,
  Tag = 17,
  level = 18,
  dungeonTarget = 19,
  stamina = 20,
  contributionvalue = 21,
  percompletetime = 22
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_crisiscrusade", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDifftype(offset)
  return core:GetInt(offset, this.indexMap.difftype)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getRecommendedlevel(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_crisiscrusade", core:GetVString(offset, this.indexMap.recommendedlevel))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "recommendedlevel")
end

function this:_getMainreward(offset)
  local str = core:GetVString(offset, this.indexMap.mainReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
end

function this:_getEntrustnpc(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_crisiscrusade", core:GetVString(offset, this.indexMap.entrustNpc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "entrustNpc")
end

function this:_getIntroduce(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_crisiscrusade", core:GetVString(offset, this.indexMap.introduce))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "introduce")
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getChallengereward(offset)
  local str = core:GetVString(offset, this.indexMap.challengeReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStarrewardshow1(offset)
  local str = core:GetVString(offset, this.indexMap.starRewardShow1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getStarrewardshow2(offset)
  local str = core:GetVString(offset, this.indexMap.starRewardShow2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getStarrewardshow3(offset)
  local str = core:GetVString(offset, this.indexMap.starRewardShow3).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTaskshow(offset)
  local str = core:GetVString(offset, this.indexMap.taskShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTaskunlock(offset)
  local str = core:GetVString(offset, this.indexMap.taskUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTag(offset)
  local str = core:GetVString(offset, this.indexMap.Tag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getDungeontarget(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_crisiscrusade", core:GetVString(offset, this.indexMap.dungeonTarget))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dungeonTarget")
end

function this:_getStamina(offset)
  local str = core:GetVString(offset, this.indexMap.stamina).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getContributionvalue(offset)
  return core:GetInt(offset, this.indexMap.contributionvalue)
end

function this:_getPercompletetime(offset)
  local str = core:GetVString(offset, this.indexMap.percompletetime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  difftype = this._getDifftype,
  difficulty = this._getDifficulty,
  recommendedlevel = this._getRecommendedlevel,
  mainReward = this._getMainreward,
  sortId = this._getSortid,
  entrustNpc = this._getEntrustnpc,
  introduce = this._getIntroduce,
  dungeonId = this._getDungeonid,
  rewardShow = this._getRewardshow,
  challengeReward = this._getChallengereward,
  starRewardShow1 = this._getStarrewardshow1,
  starRewardShow2 = this._getStarrewardshow2,
  starRewardShow3 = this._getStarrewardshow3,
  taskShow = this._getTaskshow,
  taskUnlock = this._getTaskunlock,
  Tag = this._getTag,
  level = this._getLevel,
  dungeonTarget = this._getDungeontarget,
  stamina = this._getStamina,
  contributionvalue = this._getContributionvalue,
  percompletetime = this._getPercompletetime
}
return this
