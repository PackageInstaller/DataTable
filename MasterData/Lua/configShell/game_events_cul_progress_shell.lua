local this = class("game_events_cul_progress_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulProgressTable.GetInstance()

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
  Id = 0,
  progressId = 1,
  level = 2,
  systemId = 3,
  condition = 4,
  effect = 5,
  costPoint = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getProgressid(offset)
  return core:GetInt(offset, this.indexMap.progressId)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCostpoint(offset)
  return core:GetInt(offset, this.indexMap.costPoint)
end

this.keyToMethodsMap = {
  Id = this._getId,
  progressId = this._getProgressid,
  level = this._getLevel,
  systemId = this._getSystemid,
  condition = this._getCondition,
  effect = this._getEffect,
  costPoint = this._getCostpoint
}
return this
