local this = class("complain_entry_shell", G_BaseConfig)
local core = G_Tables.TDComplainEntryTable.GetInstance()

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
  entryName = 1,
  entryType = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEntryname(offset)
  local langStr = G_TableMgrIns:GetLangStr("complain_entry", core:GetVString(offset, this.indexMap.entryName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "entryName")
end

function this:_getEntrytype(offset)
  return core:GetInt(offset, this.indexMap.entryType)
end

this.keyToMethodsMap = {
  id = this._getId,
  entryName = this._getEntryname,
  entryType = this._getEntrytype
}
return this
