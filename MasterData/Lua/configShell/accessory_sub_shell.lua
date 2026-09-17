local this = class("accessory_sub_shell", G_BaseConfig)
local core = G_Tables.TDAccessorySubTable.GetInstance()

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
  Id = 0,
  groupId = 1,
  type = 2,
  parameter = 3,
  weight = 4,
  minValue = 5,
  maxValue = 6,
  patternId = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getParameter(offset)
  return core:GetInt(offset, this.indexMap.parameter)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getMinvalue(offset)
  return core:GetInt(offset, this.indexMap.minValue)
end

function this:_getMaxvalue(offset)
  return core:GetInt(offset, this.indexMap.maxValue)
end

function this:_getPatternid(offset)
  return core:GetInt(offset, this.indexMap.patternId)
end

this.keyToMethodsMap = {
  Id = this._getId,
  groupId = this._getGroupid,
  type = this._getType,
  parameter = this._getParameter,
  weight = this._getWeight,
  minValue = this._getMinvalue,
  maxValue = this._getMaxvalue,
  patternId = this._getPatternid
}
return this
