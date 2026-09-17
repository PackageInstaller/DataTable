local this = class("dungeon_material_shell", G_BaseConfig)
local core = G_Tables.TDDungeonMaterialTable.GetInstance()

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
  type = 2,
  diff = 3,
  dungeonId = 4,
  showCondition = 5,
  unlock = 6,
  stamina = 7,
  challengeReward = 8,
  rewardShow = 9,
  starRewardShow1 = 10,
  starRewardShow2 = 11,
  starRewardShow3 = 12,
  level = 13,
  pic = 14,
  iconPath = 15,
  icon = 16,
  bossIcon = 17,
  diffColor = 18,
  artName = 19,
  nameColor = 20,
  multBack = 21,
  multPic = 22,
  recruitPic = 23
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_material", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getDiff(offset)
  return core:GetInt(offset, this.indexMap.diff)
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getShowcondition(offset)
  local str = core:GetVString(offset, this.indexMap.showCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getStamina(offset)
  return core:GetInt(offset, this.indexMap.stamina)
end

function this:_getChallengereward(offset)
  local str = core:GetVString(offset, this.indexMap.challengeReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
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

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconpath(offset)
  return core:GetInt(offset, this.indexMap.iconPath)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

function this:_getBossicon(offset)
  local str = core:GetVString(offset, this.indexMap.bossIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDiffcolor(offset)
  return core:GetVString(offset, this.indexMap.diffColor).value
end

function this:_getArtname(offset)
  return core:GetVString(offset, this.indexMap.artName).value
end

function this:_getNamecolor(offset)
  return core:GetVString(offset, this.indexMap.nameColor).value
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
  type = this._getType,
  diff = this._getDiff,
  dungeonId = this._getDungeonid,
  showCondition = this._getShowcondition,
  unlock = this._getUnlock,
  stamina = this._getStamina,
  challengeReward = this._getChallengereward,
  rewardShow = this._getRewardshow,
  starRewardShow1 = this._getStarrewardshow1,
  starRewardShow2 = this._getStarrewardshow2,
  starRewardShow3 = this._getStarrewardshow3,
  level = this._getLevel,
  pic = this._getPic,
  iconPath = this._getIconpath,
  icon = this._getIcon,
  bossIcon = this._getBossicon,
  diffColor = this._getDiffcolor,
  artName = this._getArtname,
  nameColor = this._getNamecolor,
  multBack = this._getMultback,
  multPic = this._getMultpic,
  recruitPic = this._getRecruitpic
}
return this
