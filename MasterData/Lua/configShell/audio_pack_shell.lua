local this = class("audio_pack_shell", G_BaseConfig)
local core = G_Tables.TDAudioPackTable.GetInstance()

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
  sfxName = 1,
  sfxName3P = 2,
  cd = 3,
  sfxConfig = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSfxname(offset)
  return core:GetVString(offset, this.indexMap.sfxName).value
end

function this:_getSfxname3p(offset)
  return core:GetVString(offset, this.indexMap.sfxName3P).value
end

function this:_getCd(offset)
  return core:GetInt(offset, this.indexMap.cd)
end

function this:_getSfxconfig(offset)
  local str = core:GetVString(offset, this.indexMap.sfxConfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  sfxName = this._getSfxname,
  sfxName3P = this._getSfxname3p,
  cd = this._getCd,
  sfxConfig = this._getSfxconfig
}
return this
