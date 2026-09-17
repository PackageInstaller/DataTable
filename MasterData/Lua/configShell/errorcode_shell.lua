local this = class("errorcode_shell", G_BaseConfig)
local core = G_Tables.TDErrorCodeTable.GetInstance()

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
  _desc = 2,
  type = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("errorCode", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_get_desc(offset)
  return core:GetVString(offset, this.indexMap._desc).value
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  _desc = this._get_desc,
  type = this._getType
}
return this
