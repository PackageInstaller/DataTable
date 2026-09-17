local this = class("sound_ui_shell", G_BaseConfig)
local core = G_Tables.TDSoundUiTable.GetInstance()

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
  uiEvent = 1,
  soundId = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getUievent(offset)
  return core:GetVString(offset, this.indexMap.uiEvent).value
end

function this:_getSoundid(offset)
  return core:GetInt(offset, this.indexMap.soundId)
end

this.keyToMethodsMap = {
  id = this._getId,
  uiEvent = this._getUievent,
  soundId = this._getSoundid
}
return this
