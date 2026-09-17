local this = class("tower_shell", G_BaseConfig)
local core = G_Tables.TDTowerTable.GetInstance()

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
  Id = 0,
  towerName = 1,
  towerDescription = 2,
  buffGroup = 3,
  version = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getTowername(offset)
  local langStr = G_TableMgrIns:GetLangStr("tower", core:GetVString(offset, this.indexMap.towerName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "towerName")
end

function this:_getTowerdescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("tower", core:GetVString(offset, this.indexMap.towerDescription))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "towerDescription")
end

function this:_getBuffgroup(offset)
  local str = core:GetVString(offset, this.indexMap.buffGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getVersion(offset)
  return core:GetInt(offset, this.indexMap.version)
end

this.keyToMethodsMap = {
  Id = this._getId,
  towerName = this._getTowername,
  towerDescription = this._getTowerdescription,
  buffGroup = this._getBuffgroup,
  version = this._getVersion
}
return this
