local this = class("rogue_emergencies_effectcase_shell", G_BaseConfig)
local core = G_Tables.TDRogueEmergenciesEffectcaseTable.GetInstance()

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
  effectcasetype = 1,
  effectcasepara = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEffectcasetype(offset)
  return core:GetInt(offset, this.indexMap.effectcasetype)
end

function this:_getEffectcasepara(offset)
  local str = core:GetVString(offset, this.indexMap.effectcasepara).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  effectcasetype = this._getEffectcasetype,
  effectcasepara = this._getEffectcasepara
}
return this
