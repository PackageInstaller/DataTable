local this = class("guide_condition_shell", G_BaseConfig)
local core = G_Tables.TDGuideConditionTable.GetInstance()

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
  type = 1,
  paramType = 2,
  param = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getParamtype(offset)
  return core:GetVString(offset, this.indexMap.paramType).value
end

function this:_getParam(offset)
  return core:GetVString(offset, this.indexMap.param).value
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  paramType = this._getParamtype,
  param = this._getParam
}
return this
