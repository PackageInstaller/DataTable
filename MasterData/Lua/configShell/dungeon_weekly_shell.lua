local this = class("dungeon_weekly_shell", G_BaseConfig)
local core = G_Tables.TDDungeonWeeklyTable.GetInstance()

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
  dungeongroup = 2,
  difficulty = 3,
  recommendedlevel = 4,
  weeklyicon = 5,
  bossIcon = 6,
  bossBg = 7,
  singleBg = 8,
  sortId = 9,
  dungeonId = 10,
  rewardShow = 11,
  challengeReward = 12,
  starRewardShow1 = 13,
  starRewardShow2 = 14,
  starRewardShow3 = 15,
  taskUnlock = 16,
  stamina = 17,
  multBack = 18,
  multPic = 19,
  recruitPic = 20
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_weekly", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDungeongroup(offset)
  return core:GetInt(offset, this.indexMap.dungeongroup)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getRecommendedlevel(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_weekly", core:GetVString(offset, this.indexMap.recommendedlevel))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "recommendedlevel")
end

function this:_getWeeklyicon(offset)
  local str = core:GetVString(offset, this.indexMap.weeklyicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBossicon(offset)
  local str = core:GetVString(offset, this.indexMap.bossIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBossbg(offset)
  local str = core:GetVString(offset, this.indexMap.bossBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSinglebg(offset)
  local str = core:GetVString(offset, this.indexMap.singleBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
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

function this:_getTaskunlock(offset)
  local str = core:GetVString(offset, this.indexMap.taskUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getStamina(offset)
  local str = core:GetVString(offset, this.indexMap.stamina).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMultback(offset)
  local str = core:GetVString(offset, this.indexMap.multBack).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMultpic(offset)
  local str = core:GetVString(offset, this.indexMap.multPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRecruitpic(offset)
  local str = core:GetVString(offset, this.indexMap.recruitPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  dungeongroup = this._getDungeongroup,
  difficulty = this._getDifficulty,
  recommendedlevel = this._getRecommendedlevel,
  weeklyicon = this._getWeeklyicon,
  bossIcon = this._getBossicon,
  bossBg = this._getBossbg,
  singleBg = this._getSinglebg,
  sortId = this._getSortid,
  dungeonId = this._getDungeonid,
  rewardShow = this._getRewardshow,
  challengeReward = this._getChallengereward,
  starRewardShow1 = this._getStarrewardshow1,
  starRewardShow2 = this._getStarrewardshow2,
  starRewardShow3 = this._getStarrewardshow3,
  taskUnlock = this._getTaskunlock,
  stamina = this._getStamina,
  multBack = this._getMultback,
  multPic = this._getMultpic,
  recruitPic = this._getRecruitpic
}
return this
