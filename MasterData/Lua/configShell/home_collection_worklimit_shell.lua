local this = class("home_collection_worklimit_shell", G_BaseConfig)
local core = G_Tables.TDHomeCollectionWorklimitTable.GetInstance()

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
  condition = 1,
  workLimit = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getWorklimit(offset)
  return core:GetInt(offset, this.indexMap.workLimit)
end

this.keyToMethodsMap = {
  id = this._getId,
  condition = this._getCondition,
  workLimit = this._getWorklimit
}
return this
