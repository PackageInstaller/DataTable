local this = class("accessory_rarity_score_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryRarityScoreTable.GetInstance()

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
  rarity = 0,
  score_min = 1,
  score_max = 2
}

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getScore_min(offset)
  return core:GetInt(offset, this.indexMap.score_min)
end

function this:_getScore_max(offset)
  return core:GetInt(offset, this.indexMap.score_max)
end

this.keyToMethodsMap = {
  rarity = this._getRarity,
  score_min = this._getScore_min,
  score_max = this._getScore_max
}
return this
