local this = class("dungeon_entrust_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustTable.GetInstance()

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
  subName = 1,
  name = 2,
  groupId = 3,
  sortId = 4,
  dungeonId = 5,
  mainReward = 6,
  rewardShow = 7,
  challengeReward = 8,
  starRewardShow1 = 9,
  starRewardShow2 = 10,
  starRewardShow3 = 11,
  taskShow = 12,
  taskUnlock = 13,
  level = 14,
  dungeonTarget = 15,
  stamina = 16
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSubname(offset)
  return core:GetVString(offset, this.indexMap.subName).value
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getMainreward(offset)
  local str = core:GetVString(offset, this.indexMap.mainReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
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
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTaskunlock(offset)
  local str = core:GetVString(offset, this.indexMap.taskUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getDungeontarget(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust", core:GetVString(offset, this.indexMap.dungeonTarget))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dungeonTarget")
end

function this:_getStamina(offset)
  return core:GetInt(offset, this.indexMap.stamina)
end

this.keyToMethodsMap = {
  id = this._getId,
  subName = this._getSubname,
  name = this._getName,
  groupId = this._getGroupid,
  sortId = this._getSortid,
  dungeonId = this._getDungeonid,
  mainReward = this._getMainreward,
  rewardShow = this._getRewardshow,
  challengeReward = this._getChallengereward,
  starRewardShow1 = this._getStarrewardshow1,
  starRewardShow2 = this._getStarrewardshow2,
  starRewardShow3 = this._getStarrewardshow3,
  taskShow = this._getTaskshow,
  taskUnlock = this._getTaskunlock,
  level = this._getLevel,
  dungeonTarget = this._getDungeontarget,
  stamina = this._getStamina
}
return this
