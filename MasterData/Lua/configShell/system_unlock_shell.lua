local this = class("system_unlock_shell", G_BaseConfig)
local core = G_Tables.TDSystemUnlockTable.GetInstance()

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
  unlockCondi = 2,
  homeUnlock = 3,
  lockTips = 4,
  gmCloseTips = 5,
  unlockTips = 6,
  buttonShow = 7,
  icon = 8,
  targetParam = 9,
  dungeon = 10,
  resourceBar = 11,
  upOneLevel = 12,
  param = 13,
  filterConfig = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("system_unlock", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnlockcondi(offset)
  return core:GetVString(offset, this.indexMap.unlockCondi).value
end

function this:_getHomeunlock(offset)
  return core:GetInt(offset, this.indexMap.homeUnlock)
end

function this:_getLocktips(offset)
  local langStr = G_TableMgrIns:GetLangStr("system_unlock", core:GetVString(offset, this.indexMap.lockTips))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "lockTips")
end

function this:_getGmclosetips(offset)
  local langStr = G_TableMgrIns:GetLangStr("system_unlock", core:GetVString(offset, this.indexMap.gmCloseTips))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "gmCloseTips")
end

function this:_getUnlocktips(offset)
  return core:GetVString(offset, this.indexMap.unlockTips).value
end

function this:_getButtonshow(offset)
  return core:GetInt(offset, this.indexMap.buttonShow)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTargetparam(offset)
  local str = core:GetVString(offset, this.indexMap.targetParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDungeon(offset)
  return core:GetInt(offset, this.indexMap.dungeon)
end

function this:_getResourcebar(offset)
  local str = core:GetVString(offset, this.indexMap.resourceBar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUponelevel(offset)
  return core:GetInt(offset, this.indexMap.upOneLevel)
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getFilterconfig(offset)
  return core:GetInt(offset, this.indexMap.filterConfig)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  unlockCondi = this._getUnlockcondi,
  homeUnlock = this._getHomeunlock,
  lockTips = this._getLocktips,
  gmCloseTips = this._getGmclosetips,
  unlockTips = this._getUnlocktips,
  buttonShow = this._getButtonshow,
  icon = this._getIcon,
  targetParam = this._getTargetparam,
  dungeon = this._getDungeon,
  resourceBar = this._getResourcebar,
  upOneLevel = this._getUponelevel,
  param = this._getParam,
  filterConfig = this._getFilterconfig
}
return this
