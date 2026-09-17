local this = class("common_condition_openpage_shell", G_BaseConfig)
local core = G_Tables.TDCommonConditionOpenpageTable.GetInstance()

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
  prefeb = 1,
  condition = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPrefeb(offset)
  return core:GetVString(offset, this.indexMap.prefeb).value
end

function this:_getCondition(offset)
  return core:GetVString(offset, this.indexMap.condition).value
end

this.keyToMethodsMap = {
  id = this._getId,
  prefeb = this._getPrefeb,
  condition = this._getCondition
}
return this
