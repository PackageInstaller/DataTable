local this = class("journey_point_reward_shell", G_BaseConfig)
local core = G_Tables.TDJourneyPointRewardTable.GetInstance()

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
  point = 1,
  isBigReward = 2,
  reward = 3,
  rewardShow = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPoint(offset)
  return core:GetInt(offset, this.indexMap.point)
end

function this:_getIsbigreward(offset)
  return core:GetInt(offset, this.indexMap.isBigReward)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  point = this._getPoint,
  isBigReward = this._getIsbigreward,
  reward = this._getReward,
  rewardShow = this._getRewardshow
}
return this
