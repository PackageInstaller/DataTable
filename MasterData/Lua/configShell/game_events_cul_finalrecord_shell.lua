local this = class("game_events_cul_finalrecord_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulFinalrecordTable.GetInstance()

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
  rating = 0,
  activityid = 1,
  needScore = 2,
  resource = 3
}

function this:_getRating(offset)
  return core:GetInt(offset, this.indexMap.rating)
end

function this:_getActivityid(offset)
  return core:GetInt(offset, this.indexMap.activityid)
end

function this:_getNeedscore(offset)
  return core:GetInt(offset, this.indexMap.needScore)
end

function this:_getResource(offset)
  local str = core:GetVString(offset, this.indexMap.resource).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  rating = this._getRating,
  activityid = this._getActivityid,
  needScore = this._getNeedscore,
  resource = this._getResource
}
return this
