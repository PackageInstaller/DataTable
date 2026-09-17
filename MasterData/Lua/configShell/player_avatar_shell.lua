local this = class("player_avatar_shell", G_BaseConfig)
local core = G_Tables.TDPlayerAvatarTable.GetInstance()

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
  heroid = 1,
  prefab_path = 2,
  playable_path = 3,
  animate_template_path = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroid)
end

function this:_getPrefab_path(offset)
  return core:GetVString(offset, this.indexMap.prefab_path).value
end

function this:_getPlayable_path(offset)
  return core:GetVString(offset, this.indexMap.playable_path).value
end

function this:_getAnimate_template_path(offset)
  return core:GetVString(offset, this.indexMap.animate_template_path).value
end

this.keyToMethodsMap = {
  id = this._getId,
  heroid = this._getHeroid,
  prefab_path = this._getPrefab_path,
  playable_path = this._getPlayable_path,
  animate_template_path = this._getAnimate_template_path
}
return this
