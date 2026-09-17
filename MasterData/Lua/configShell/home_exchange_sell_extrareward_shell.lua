local this = class("home_exchange_sell_extrareward_shell", G_BaseConfig)
local core = G_Tables.TDHomeExchangeSellExtrarewardTable.GetInstance()

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
  RewardLevel = 0,
  SellNum = 1,
  ItemReward = 2,
  YieldIncreases = 3,
  RewardIcon = 4,
  TiTiIcon = 5
}

function this:_getRewardlevel(offset)
  return core:GetInt(offset, this.indexMap.RewardLevel)
end

function this:_getSellnum(offset)
  return core:GetInt(offset, this.indexMap.SellNum)
end

function this:_getItemreward(offset)
  local str = core:GetVString(offset, this.indexMap.ItemReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getYieldincreases(offset)
  return core:GetInt(offset, this.indexMap.YieldIncreases)
end

function this:_getRewardicon(offset)
  local str = core:GetVString(offset, this.indexMap.RewardIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTitiicon(offset)
  local str = core:GetVString(offset, this.indexMap.TiTiIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  RewardLevel = this._getRewardlevel,
  SellNum = this._getSellnum,
  ItemReward = this._getItemreward,
  YieldIncreases = this._getYieldincreases,
  RewardIcon = this._getRewardicon,
  TiTiIcon = this._getTitiicon
}
return this
