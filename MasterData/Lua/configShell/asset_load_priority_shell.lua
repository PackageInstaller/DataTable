local this = class("asset_load_priority_shell", G_BaseConfig)
local core = G_Tables.TDAssetLoadPriorityTable.GetInstance()

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
  key = 1,
  priority = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getKey(offset)
  return core:GetVString(offset, this.indexMap.key).value
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

this.keyToMethodsMap = {
  id = this._getId,
  key = this._getKey,
  priority = this._getPriority
}
return this
