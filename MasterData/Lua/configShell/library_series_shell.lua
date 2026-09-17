local this = class("library_series_shell", G_BaseConfig)
local core = G_Tables.TDLibrarySeriesTable.GetInstance()

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
  icon = 2,
  category = 3,
  bg = 4,
  intro = 5,
  subId = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("library_series", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCategory(offset)
  local str = core:GetVString(offset, this.indexMap.category).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBg(offset)
  return core:GetInt(offset, this.indexMap.bg)
end

function this:_getIntro(offset)
  local langStr = G_TableMgrIns:GetLangStr("library_series", core:GetVString(offset, this.indexMap.intro))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "intro")
end

function this:_getSubid(offset)
  local str = core:GetVString(offset, this.indexMap.subId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  icon = this._getIcon,
  category = this._getCategory,
  bg = this._getBg,
  intro = this._getIntro,
  subId = this._getSubid
}
return this
