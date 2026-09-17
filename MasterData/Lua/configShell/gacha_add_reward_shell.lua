local this = class("gacha_add_reward_shell", G_BaseConfig)
local core = G_Tables.TDGachaAddRewardTable.GetInstance()

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
  type = 1,
  rarity = 2,
  minCount = 3,
  maxCount = 4,
  reward = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getMincount(offset)
  return core:GetInt(offset, this.indexMap.minCount)
end

function this:_getMaxcount(offset)
  return core:GetInt(offset, this.indexMap.maxCount)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  rarity = this._getRarity,
  minCount = this._getMincount,
  maxCount = this._getMaxcount,
  reward = this._getReward
}
return this
