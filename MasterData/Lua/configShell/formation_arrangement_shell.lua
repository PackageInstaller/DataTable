local this = class("formation_arrangement_shell", G_BaseConfig)
local core = G_Tables.TDFormationArrangementTable.GetInstance()

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
  formationType = 1,
  formationParam = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFormationtype(offset)
  return core:GetInt(offset, this.indexMap.formationType)
end

function this:_getFormationparam(offset)
  local str = core:GetVString(offset, this.indexMap.formationParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  formationType = this._getFormationtype,
  formationParam = this._getFormationparam
}
return this
