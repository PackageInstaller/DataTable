local this = class("mount_speed_shell", G_BaseConfig)
local core = G_Tables.TDMountSpeedTable.GetInstance()

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
  weight = 1,
  min = 2,
  max = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getMin(offset)
  return core:GetInt(offset, this.indexMap.min)
end

function this:_getMax(offset)
  return core:GetInt(offset, this.indexMap.max)
end

this.keyToMethodsMap = {
  id = this._getId,
  weight = this._getWeight,
  min = this._getMin,
  max = this._getMax
}
return this
