local this = class("fish_group_shell", G_BaseConfig)
local core = G_Tables.TDFishGroupTable.GetInstance()

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
  fishGroup = 1,
  fishId = 2,
  weight = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFishgroup(offset)
  return core:GetInt(offset, this.indexMap.fishGroup)
end

function this:_getFishid(offset)
  return core:GetInt(offset, this.indexMap.fishId)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

this.keyToMethodsMap = {
  id = this._getId,
  fishGroup = this._getFishgroup,
  fishId = this._getFishid,
  weight = this._getWeight
}
return this
