local this = class("playable_shell", G_BaseConfig)
local core = G_Tables.TDPlayableTable.GetInstance()

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
  position = 1,
  stepMax = 2,
  canReset = 3,
  canRestart = 4,
  statusReward = 5,
  playScore = 6,
  stepRewards = 7,
  always = 8,
  aoiRange = 9,
  type = 10,
  range = 11,
  parentID = 12,
  cost = 13,
  objectAoiRanges = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStepmax(offset)
  return core:GetInt(offset, this.indexMap.stepMax)
end

function this:_getCanreset(offset)
  return core:GetInt(offset, this.indexMap.canReset)
end

function this:_getCanrestart(offset)
  return core:GetInt(offset, this.indexMap.canRestart)
end

function this:_getStatusreward(offset)
  local str = core:GetVString(offset, this.indexMap.statusReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayscore(offset)
  local str = core:GetVString(offset, this.indexMap.playScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSteprewards(offset)
  local str = core:GetVString(offset, this.indexMap.stepRewards).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

function this:_getAlways(offset)
  return core:GetInt(offset, this.indexMap.always)
end

function this:_getAoirange(offset)
  return core:GetFloat(offset, this.indexMap.aoiRange)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getRange(offset)
  return core:GetFloat(offset, this.indexMap.range)
end

function this:_getParentid(offset)
  return core:GetInt(offset, this.indexMap.parentID)
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getObjectaoiranges(offset)
  local str = core:GetVString(offset, this.indexMap.objectAoiRanges).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  position = this._getPosition,
  stepMax = this._getStepmax,
  canReset = this._getCanreset,
  canRestart = this._getCanrestart,
  statusReward = this._getStatusreward,
  playScore = this._getPlayscore,
  stepRewards = this._getSteprewards,
  always = this._getAlways,
  aoiRange = this._getAoirange,
  type = this._getType,
  range = this._getRange,
  parentID = this._getParentid,
  cost = this._getCost,
  objectAoiRanges = this._getObjectaoiranges
}
return this
