local this = class("playable_type_shell", G_BaseConfig)
local core = G_Tables.TDPlayableTypeTable.GetInstance()

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
  isForbidFly = 2,
  isForbidMount = 3,
  canRestart = 4,
  range = 5,
  always = 6,
  bgm = 7,
  endBgm = 8,
  cost = 9,
  trackType = 10,
  isForbidSpeedCheck = 11,
  guide_interact = 12,
  functionMutexId = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIsforbidfly(offset)
  return core:GetInt(offset, this.indexMap.isForbidFly)
end

function this:_getIsforbidmount(offset)
  return core:GetInt(offset, this.indexMap.isForbidMount)
end

function this:_getCanrestart(offset)
  return core:GetInt(offset, this.indexMap.canRestart)
end

function this:_getRange(offset)
  return core:GetFloat(offset, this.indexMap.range)
end

function this:_getAlways(offset)
  return core:GetInt(offset, this.indexMap.always)
end

function this:_getBgm(offset)
  return core:GetVString(offset, this.indexMap.bgm).value
end

function this:_getEndbgm(offset)
  local str = core:GetVString(offset, this.indexMap.endBgm).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTracktype(offset)
  return core:GetInt(offset, this.indexMap.trackType)
end

function this:_getIsforbidspeedcheck(offset)
  return core:GetInt(offset, this.indexMap.isForbidSpeedCheck)
end

function this:_getGuide_interact(offset)
  return core:GetInt(offset, this.indexMap.guide_interact)
end

function this:_getFunctionmutexid(offset)
  return core:GetInt(offset, this.indexMap.functionMutexId)
end

this.keyToMethodsMap = {
  id = this._getId,
  condition = this._getCondition,
  isForbidFly = this._getIsforbidfly,
  isForbidMount = this._getIsforbidmount,
  canRestart = this._getCanrestart,
  range = this._getRange,
  always = this._getAlways,
  bgm = this._getBgm,
  endBgm = this._getEndbgm,
  cost = this._getCost,
  trackType = this._getTracktype,
  isForbidSpeedCheck = this._getIsforbidspeedcheck,
  guide_interact = this._getGuide_interact,
  functionMutexId = this._getFunctionmutexid
}
return this
