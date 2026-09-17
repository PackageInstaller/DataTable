local this = class("seven_day_target_reward_shell", G_BaseConfig)
local core = G_Tables.TDSevenDayTargetRewardTable.GetInstance()

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
  count = 1,
  reward = 2,
  showreward = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCount(offset)
  return core:GetInt(offset, this.indexMap.count)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShowreward(offset)
  local str = core:GetVString(offset, this.indexMap.showreward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  count = this._getCount,
  reward = this._getReward,
  showreward = this._getShowreward
}
return this
