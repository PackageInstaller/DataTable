local this = class("accessory_score_rule_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryScoreRuleTable.GetInstance()

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
  score_intervil_min = 0,
  score_intervil_max = 1,
  rarity_probability_0 = 2,
  score_max_0 = 3,
  rarity_probability_1 = 4,
  score_max_1 = 5,
  rarity_probability_2 = 6,
  score_max_2 = 7,
  rarity_probability_3 = 8,
  score_max_3 = 9,
  rarity_probability_4 = 10,
  score_max_4 = 11
}

function this:_getScore_intervil_min(offset)
  return core:GetInt(offset, this.indexMap.score_intervil_min)
end

function this:_getScore_intervil_max(offset)
  return core:GetInt(offset, this.indexMap.score_intervil_max)
end

function this:_getRarity_probability_0(offset)
  return core:GetInt(offset, this.indexMap.rarity_probability_0)
end

function this:_getScore_max_0(offset)
  return core:GetInt(offset, this.indexMap.score_max_0)
end

function this:_getRarity_probability_1(offset)
  return core:GetInt(offset, this.indexMap.rarity_probability_1)
end

function this:_getScore_max_1(offset)
  return core:GetInt(offset, this.indexMap.score_max_1)
end

function this:_getRarity_probability_2(offset)
  return core:GetInt(offset, this.indexMap.rarity_probability_2)
end

function this:_getScore_max_2(offset)
  return core:GetInt(offset, this.indexMap.score_max_2)
end

function this:_getRarity_probability_3(offset)
  return core:GetInt(offset, this.indexMap.rarity_probability_3)
end

function this:_getScore_max_3(offset)
  return core:GetInt(offset, this.indexMap.score_max_3)
end

function this:_getRarity_probability_4(offset)
  return core:GetInt(offset, this.indexMap.rarity_probability_4)
end

function this:_getScore_max_4(offset)
  return core:GetInt(offset, this.indexMap.score_max_4)
end

this.keyToMethodsMap = {
  score_intervil_min = this._getScore_intervil_min,
  score_intervil_max = this._getScore_intervil_max,
  rarity_probability_0 = this._getRarity_probability_0,
  score_max_0 = this._getScore_max_0,
  rarity_probability_1 = this._getRarity_probability_1,
  score_max_1 = this._getScore_max_1,
  rarity_probability_2 = this._getRarity_probability_2,
  score_max_2 = this._getScore_max_2,
  rarity_probability_3 = this._getRarity_probability_3,
  score_max_3 = this._getScore_max_3,
  rarity_probability_4 = this._getRarity_probability_4,
  score_max_4 = this._getScore_max_4
}
return this
