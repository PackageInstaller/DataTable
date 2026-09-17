local this = class("media_pack_shell", G_BaseConfig)
local core = G_Tables.TDMediaPackTable.GetInstance()

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
  mediaPackName = 1,
  vfxPrefab = 2,
  vfxHide = 3,
  vfxTime = 4,
  vfxMissle = 5,
  sfxName = 6,
  sfxName3P = 7,
  sfxConfig = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMediapackname(offset)
  return core:GetVString(offset, this.indexMap.mediaPackName).value
end

function this:_getVfxprefab(offset)
  local str = core:GetVString(offset, this.indexMap.vfxPrefab).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getVfxhide(offset)
  return core:GetBool(offset, this.indexMap.vfxHide)
end

function this:_getVfxtime(offset)
  return core:GetInt(offset, this.indexMap.vfxTime)
end

function this:_getVfxmissle(offset)
  return core:GetBool(offset, this.indexMap.vfxMissle)
end

function this:_getSfxname(offset)
  return core:GetVString(offset, this.indexMap.sfxName).value
end

function this:_getSfxname3p(offset)
  return core:GetVString(offset, this.indexMap.sfxName3P).value
end

function this:_getSfxconfig(offset)
  local str = core:GetVString(offset, this.indexMap.sfxConfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  mediaPackName = this._getMediapackname,
  vfxPrefab = this._getVfxprefab,
  vfxHide = this._getVfxhide,
  vfxTime = this._getVfxtime,
  vfxMissle = this._getVfxmissle,
  sfxName = this._getSfxname,
  sfxName3P = this._getSfxname3p,
  sfxConfig = this._getSfxconfig
}
return this
