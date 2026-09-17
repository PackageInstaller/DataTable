local this = class("rogue_turn_shell", G_BaseConfig)
local core = G_Tables.TDRogueTurnTable.GetInstance()

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
  turnId = 0,
  begintime = 1,
  endtime = 2,
  rewardGroupId = 3,
  weeklyPoint = 4
}

function this:_getTurnid(offset)
  return core:GetInt(offset, this.indexMap.turnId)
end

function this:_getBegintime(offset)
  return core:GetVString(offset, this.indexMap.begintime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endtime).value
end

function this:_getRewardgroupid(offset)
  return core:GetInt(offset, this.indexMap.rewardGroupId)
end

function this:_getWeeklypoint(offset)
  return core:GetInt(offset, this.indexMap.weeklyPoint)
end

this.keyToMethodsMap = {
  turnId = this._getTurnid,
  begintime = this._getBegintime,
  endtime = this._getEndtime,
  rewardGroupId = this._getRewardgroupid,
  weeklyPoint = this._getWeeklypoint
}
return this
