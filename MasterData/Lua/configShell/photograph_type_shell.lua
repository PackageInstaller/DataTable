local this = class("photograph_type_shell", G_BaseConfig)
local core = G_Tables.TDPhotographTypeTable.GetInstance()

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
  typeId = 1,
  sequence = 2,
  typeName = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypeid(offset)
  return core:GetInt(offset, this.indexMap.typeId)
end

function this:_getSequence(offset)
  return core:GetInt(offset, this.indexMap.sequence)
end

function this:_getTypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("photograph_type", core:GetVString(offset, this.indexMap.typeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "typeName")
end

this.keyToMethodsMap = {
  id = this._getId,
  typeId = this._getTypeid,
  sequence = this._getSequence,
  typeName = this._getTypename
}
return this
