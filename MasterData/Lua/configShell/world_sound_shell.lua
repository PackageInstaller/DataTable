local this = class("world_sound_shell", G_BaseConfig)
local core = G_Tables.TDWorldSoundTable.GetInstance()

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
  layerId = 1,
  walk = 2,
  run = 3,
  fall = 4,
  highFall = 5,
  dodge = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLayerid(offset)
  return core:GetInt(offset, this.indexMap.layerId)
end

function this:_getWalk(offset)
  return core:GetVString(offset, this.indexMap.walk).value
end

function this:_getRun(offset)
  return core:GetVString(offset, this.indexMap.run).value
end

function this:_getFall(offset)
  return core:GetVString(offset, this.indexMap.fall).value
end

function this:_getHighfall(offset)
  return core:GetVString(offset, this.indexMap.highFall).value
end

function this:_getDodge(offset)
  return core:GetVString(offset, this.indexMap.dodge).value
end

this.keyToMethodsMap = {
  id = this._getId,
  layerId = this._getLayerid,
  walk = this._getWalk,
  run = this._getRun,
  fall = this._getFall,
  highFall = this._getHighfall,
  dodge = this._getDodge
}
return this
