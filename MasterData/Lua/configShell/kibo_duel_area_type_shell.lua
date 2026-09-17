local this = class("kibo_duel_area_type_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelAreaTypeTable.GetInstance()

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
  name = 1,
  currencyId = 2,
  uiIcon = 3,
  mapIcon = 4,
  kiboCenterCameraParam = 5,
  area = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_area_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCurrencyid(offset)
  return core:GetInt(offset, this.indexMap.currencyId)
end

function this:_getUiicon(offset)
  local str = core:GetVString(offset, this.indexMap.uiIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMapicon(offset)
  local str = core:GetVString(offset, this.indexMap.mapIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getKibocentercameraparam(offset)
  local str = core:GetVString(offset, this.indexMap.kiboCenterCameraParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getArea(offset)
  local str = core:GetVString(offset, this.indexMap.area).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  name = this._getName,
  currencyId = this._getCurrencyid,
  uiIcon = this._getUiicon,
  mapIcon = this._getMapicon,
  kiboCenterCameraParam = this._getKibocentercameraparam,
  area = this._getArea
}
return this
