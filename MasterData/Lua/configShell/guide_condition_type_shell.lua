local this = class("guide_condition_type_shell", G_BaseConfig)
local core = G_Tables.TDGuideConditionTypeTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, isMoment = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIsmoment(offset)
  return core:GetBool(offset, this.indexMap.isMoment)
end

this.keyToMethodsMap = {
  id = this._getId,
  isMoment = this._getIsmoment
}
return this
