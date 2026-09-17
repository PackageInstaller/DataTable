local this = class("gacha_up_reward_shell", G_BaseConfig)
local core = G_Tables.TDGachaUpRewardTable.GetInstance()

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
  upRewardId = 1,
  upCount = 2,
  reward = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getUprewardid(offset)
  return core:GetInt(offset, this.indexMap.upRewardId)
end

function this:_getUpcount(offset)
  return core:GetInt(offset, this.indexMap.upCount)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  upRewardId = this._getUprewardid,
  upCount = this._getUpcount,
  reward = this._getReward
}
return this
