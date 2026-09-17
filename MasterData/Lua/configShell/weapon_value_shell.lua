local this = class("weapon_value_shell", G_BaseConfig)
local core = G_Tables.TDWeaponValueTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, baseAttribute = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBaseattribute(offset)
  local str = core:GetVString(offset, this.indexMap.baseAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  baseAttribute = this._getBaseattribute
}
return this
