local this = class("home_labor_train_exp_shell", G_BaseConfig)
local core = G_Tables.TDHomeLaborTrainExpTable.GetInstance()

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
  score_range = 1,
  rarity_exp = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getScore_range(offset)
  local str = core:GetVString(offset, this.indexMap.score_range).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRarity_exp(offset)
  local str = core:GetVString(offset, this.indexMap.rarity_exp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  score_range = this._getScore_range,
  rarity_exp = this._getRarity_exp
}
return this
