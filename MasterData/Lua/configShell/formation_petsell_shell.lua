local this = class("formation_petsell_shell", G_BaseConfig)
local core = G_Tables.TDFormationPetsellTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, typeName = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("formation_petsell", core:GetVString(offset, this.indexMap.typeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "typeName")
end

this.keyToMethodsMap = {
  id = this._getId,
  typeName = this._getTypename
}
return this
