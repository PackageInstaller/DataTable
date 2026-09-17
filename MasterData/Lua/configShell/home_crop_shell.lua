local this = class("home_crop_shell", G_BaseConfig)
local core = G_Tables.TDHomeCropTable.GetInstance()

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
  path = 1,
  density = 2,
  posList = 3,
  phaseName = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPath(offset)
  local str = core:GetVString(offset, this.indexMap.path).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDensity(offset)
  return core:GetFloat(offset, this.indexMap.density)
end

function this:_getPoslist(offset)
  local str = core:GetVString(offset, this.indexMap.posList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPhasename(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_crop", core:GetVString(offset, this.indexMap.phaseName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "phaseName")
end

this.keyToMethodsMap = {
  id = this._getId,
  path = this._getPath,
  density = this._getDensity,
  posList = this._getPoslist,
  phaseName = this._getPhasename
}
return this
