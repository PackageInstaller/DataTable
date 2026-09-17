local this = class("common_timelimit_shell", G_BaseConfig)
local core = G_Tables.TDCommonTimelimitTable.GetInstance()

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
  startTime = 1,
  endTime = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStarttime(offset)
  return core:GetVString(offset, this.indexMap.startTime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endTime).value
end

this.keyToMethodsMap = {
  id = this._getId,
  startTime = this._getStarttime,
  endTime = this._getEndtime
}
return this
