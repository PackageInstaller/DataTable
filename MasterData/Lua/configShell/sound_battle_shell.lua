local this = class("sound_battle_shell", G_BaseConfig)
local core = G_Tables.TDSoundBattleTable.GetInstance()

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
  battleEvent = 1,
  sfxName = 2,
  sfxName3P = 3,
  sfxConfig = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBattleevent(offset)
  return core:GetInt(offset, this.indexMap.battleEvent)
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
  battleEvent = this._getBattleevent,
  sfxName = this._getSfxname,
  sfxName3P = this._getSfxname3p,
  sfxConfig = this._getSfxconfig
}
return this
