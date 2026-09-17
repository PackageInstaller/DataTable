local this = class("accessory_sub_parameter_shell", G_BaseConfig)
local core = G_Tables.TDAccessorySubParameterTable.GetInstance()

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
  groupId = 1,
  sort = 2,
  type = 3,
  parameter = 4,
  minValue = 5,
  maxValue = 6,
  quality = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getParameter(offset)
  return core:GetInt(offset, this.indexMap.parameter)
end

function this:_getMinvalue(offset)
  return core:GetInt(offset, this.indexMap.minValue)
end

function this:_getMaxvalue(offset)
  return core:GetInt(offset, this.indexMap.maxValue)
end

function this:_getQuality(offset)
  return core:GetInt(offset, this.indexMap.quality)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  sort = this._getSort,
  type = this._getType,
  parameter = this._getParameter,
  minValue = this._getMinvalue,
  maxValue = this._getMaxvalue,
  quality = this._getQuality
}
return this
