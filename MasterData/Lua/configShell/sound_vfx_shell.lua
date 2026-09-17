local this = class("sound_vfx_shell", G_BaseConfig)
local core = G_Tables.TDSoundVfxTable.GetInstance()

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
  vfxPrefab = 1,
  sfxName = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getVfxprefab(offset)
  return core:GetVString(offset, this.indexMap.vfxPrefab).value
end

function this:_getSfxname(offset)
  return core:GetVString(offset, this.indexMap.sfxName).value
end

this.keyToMethodsMap = {
  id = this._getId,
  vfxPrefab = this._getVfxprefab,
  sfxName = this._getSfxname
}
return this
