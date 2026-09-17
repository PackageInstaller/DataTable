local this = class("soulessence_rank_shell", G_BaseConfig)
local core = G_Tables.TDSoulessenceRankTable.GetInstance()

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
  relatedId = 1,
  rank = 2,
  rankUpItem = 3,
  rankUpCoin = 4,
  condition = 5,
  rankLevelLimit = 6,
  rankUpAttribute = 7,
  rankUpAttributeAll = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRelatedid(offset)
  return core:GetInt(offset, this.indexMap.relatedId)
end

function this:_getRank(offset)
  return core:GetInt(offset, this.indexMap.rank)
end

function this:_getRankupitem(offset)
  local str = core:GetVString(offset, this.indexMap.rankUpItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRankupcoin(offset)
  return core:GetInt(offset, this.indexMap.rankUpCoin)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRanklevellimit(offset)
  return core:GetInt(offset, this.indexMap.rankLevelLimit)
end

function this:_getRankupattribute(offset)
  local str = core:GetVString(offset, this.indexMap.rankUpAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getRankupattributeall(offset)
  local str = core:GetVString(offset, this.indexMap.rankUpAttributeAll).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  relatedId = this._getRelatedid,
  rank = this._getRank,
  rankUpItem = this._getRankupitem,
  rankUpCoin = this._getRankupcoin,
  condition = this._getCondition,
  rankLevelLimit = this._getRanklevellimit,
  rankUpAttribute = this._getRankupattribute,
  rankUpAttributeAll = this._getRankupattributeall
}
return this
