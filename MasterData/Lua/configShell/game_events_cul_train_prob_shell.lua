local this = class("game_events_cul_train_prob_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulTrainProbTable.GetInstance()

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
  trainOption = 1,
  stamina = 2,
  failWeight = 3,
  successWeight = 4,
  greatSuccessWeight = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTrainoption(offset)
  return core:GetInt(offset, this.indexMap.trainOption)
end

function this:_getStamina(offset)
  return core:GetInt(offset, this.indexMap.stamina)
end

function this:_getFailweight(offset)
  return core:GetInt(offset, this.indexMap.failWeight)
end

function this:_getSuccessweight(offset)
  return core:GetInt(offset, this.indexMap.successWeight)
end

function this:_getGreatsuccessweight(offset)
  return core:GetInt(offset, this.indexMap.greatSuccessWeight)
end

this.keyToMethodsMap = {
  id = this._getId,
  trainOption = this._getTrainoption,
  stamina = this._getStamina,
  failWeight = this._getFailweight,
  successWeight = this._getSuccessweight,
  greatSuccessWeight = this._getGreatsuccessweight
}
return this
