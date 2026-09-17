local this = class("abbys_time_shell", G_BaseConfig)
local core = G_Tables.TDAbbysTimeTable.GetInstance()

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
  endTime = 2,
  level = 3,
  reward = 4,
  buff = 5
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

function this:_getLevel(offset)
  local str = core:GetVString(offset, this.indexMap.level).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  return core:GetInt(offset, this.indexMap.reward)
end

function this:_getBuff(offset)
  return core:GetInt(offset, this.indexMap.buff)
end

this.keyToMethodsMap = {
  id = this._getId,
  startTime = this._getStarttime,
  endTime = this._getEndtime,
  level = this._getLevel,
  reward = this._getReward,
  buff = this._getBuff
}
return this
