local this = class("home_collection_time_shell", G_BaseConfig)
local core = G_Tables.TDHomeCollectionTimeTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, time = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

this.keyToMethodsMap = {
  id = this._getId,
  time = this._getTime
}
return this
