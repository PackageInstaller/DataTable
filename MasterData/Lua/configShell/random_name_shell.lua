local this = class("random_name_shell", G_BaseConfig)
local core = G_Tables.TDRandomNameTable.GetInstance()

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
  nameWords = 1,
  type = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getNamewords(offset)
  local langStr = G_TableMgrIns:GetLangStr("random_name", core:GetVString(offset, this.indexMap.nameWords))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "nameWords")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

this.keyToMethodsMap = {
  id = this._getId,
  nameWords = this._getNamewords,
  type = this._getType
}
return this
