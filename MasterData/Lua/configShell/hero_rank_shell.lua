local this = class("hero_rank_shell", G_BaseConfig)
local core = G_Tables.TDHeroRankTable.GetInstance()

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
  heroId = 1,
  rank = 2,
  rankBreakthroughItem = 3,
  rankBreakthroughCoin = 4,
  condition = 5,
  rankLevelLimit = 6,
  attribute = 7,
  skill = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getRank(offset)
  return core:GetInt(offset, this.indexMap.rank)
end

function this:_getRankbreakthroughitem(offset)
  local str = core:GetVString(offset, this.indexMap.rankBreakthroughItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRankbreakthroughcoin(offset)
  return core:GetInt(offset, this.indexMap.rankBreakthroughCoin)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRanklevellimit(offset)
  return core:GetInt(offset, this.indexMap.rankLevelLimit)
end

function this:_getAttribute(offset)
  local str = core:GetVString(offset, this.indexMap.attribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getSkill(offset)
  local str = core:GetVString(offset, this.indexMap.skill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  rank = this._getRank,
  rankBreakthroughItem = this._getRankbreakthroughitem,
  rankBreakthroughCoin = this._getRankbreakthroughcoin,
  condition = this._getCondition,
  rankLevelLimit = this._getRanklevellimit,
  attribute = this._getAttribute,
  skill = this._getSkill
}
return this
