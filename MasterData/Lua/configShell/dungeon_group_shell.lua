local this = class("dungeon_group_shell", G_BaseConfig)
local core = G_Tables.TDDungeonGroupTable.GetInstance()

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
  dungeonGroupName = 2,
  doorId = 3,
  diffType = 4,
  dungeonGroupOrder = 5,
  dungeonGroupTag = 6,
  dungeonSystemType = 7,
  name = 8,
  unlockCondition = 9,
  description = 10,
  showLevel = 11,
  openType = 12,
  openTypeParam = 13,
  needPower = 14,
  firstLoot = 15,
  userExp = 16,
  cameraDistance = 17,
  cameraVerticalAngle = 18,
  cameraHorizontalAngle = 19
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getDungeongroupname(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_group", core:GetVString(offset, this.indexMap.dungeonGroupName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dungeonGroupName")
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
  local langStr = G_TableMgrIns:GetLangStr("dungeon_group", core:GetVString(offset, this.indexMap.dungeonGroupTag))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dungeonGroupTag")
end

function this:_getDungeonsystemtype(offset)
  return core:GetInt(offset, this.indexMap.dungeonSystemType)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_group", core:GetVString(offset, this.indexMap.description))
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

function this:_getNeedpower(offset)
  return core:GetInt(offset, this.indexMap.needPower)
end

function this:_getFirstloot(offset)
  local str = core:GetVString(offset, this.indexMap.firstLoot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUserexp(offset)
  return core:GetInt(offset, this.indexMap.userExp)
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

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  dungeonGroupName = this._getDungeongroupname,
  doorId = this._getDoorid,
  diffType = this._getDifftype,
  dungeonGroupOrder = this._getDungeongrouporder,
  dungeonGroupTag = this._getDungeongrouptag,
  dungeonSystemType = this._getDungeonsystemtype,
  name = this._getName,
  unlockCondition = this._getUnlockcondition,
  description = this._getDescription,
  showLevel = this._getShowlevel,
  openType = this._getOpentype,
  openTypeParam = this._getOpentypeparam,
  needPower = this._getNeedpower,
  firstLoot = this._getFirstloot,
  userExp = this._getUserexp,
  cameraDistance = this._getCameradistance,
  cameraVerticalAngle = this._getCameraverticalangle,
  cameraHorizontalAngle = this._getCamerahorizontalangle
}
return this
