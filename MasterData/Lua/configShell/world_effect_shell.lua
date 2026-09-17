local this = class("world_effect_shell", G_BaseConfig)
local core = G_Tables.TDWorldEffectTable.GetInstance()

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
  effectType = 1,
  effectPrefab = 2,
  effectLength = 3,
  reboundCount = 4,
  vfxPrefab = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEffecttype(offset)
  return core:GetInt(offset, this.indexMap.effectType)
end

function this:_getEffectprefab(offset)
  local str = core:GetVString(offset, this.indexMap.effectPrefab).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getEffectlength(offset)
  return core:GetInt(offset, this.indexMap.effectLength)
end

function this:_getReboundcount(offset)
  return core:GetInt(offset, this.indexMap.reboundCount)
end

function this:_getVfxprefab(offset)
  local str = core:GetVString(offset, this.indexMap.vfxPrefab).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  effectType = this._getEffecttype,
  effectPrefab = this._getEffectprefab,
  effectLength = this._getEffectlength,
  reboundCount = this._getReboundcount,
  vfxPrefab = this._getVfxprefab
}
return this
