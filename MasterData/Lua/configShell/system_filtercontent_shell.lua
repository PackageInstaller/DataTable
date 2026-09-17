local this = class("system_filtercontent_shell", G_BaseConfig)
local core = G_Tables.TDSystemFiltercontentTable.GetInstance()

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
  filterContent = 1,
  EnumId = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFiltercontent(offset)
  local langStr = G_TableMgrIns:GetLangStr("system_filtercontent", core:GetVString(offset, this.indexMap.filterContent))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "filterContent")
end

function this:_getEnumid(offset)
  return core:GetInt(offset, this.indexMap.EnumId)
end

this.keyToMethodsMap = {
  id = this._getId,
  filterContent = this._getFiltercontent,
  EnumId = this._getEnumid
}
return this
