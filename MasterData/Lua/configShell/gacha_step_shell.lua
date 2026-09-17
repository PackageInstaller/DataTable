local this = class("gacha_step_shell", G_BaseConfig)
local core = G_Tables.TDGachaStepTable.GetInstance()

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
  stepId = 1,
  stepStage = 2,
  stepCount = 3,
  reward = 4,
  keyStage = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStepid(offset)
  return core:GetInt(offset, this.indexMap.stepId)
end

function this:_getStepstage(offset)
  return core:GetInt(offset, this.indexMap.stepStage)
end

function this:_getStepcount(offset)
  return core:GetInt(offset, this.indexMap.stepCount)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKeystage(offset)
  return core:GetInt(offset, this.indexMap.keyStage)
end

this.keyToMethodsMap = {
  id = this._getId,
  stepId = this._getStepid,
  stepStage = this._getStepstage,
  stepCount = this._getStepcount,
  reward = this._getReward,
  keyStage = this._getKeystage
}
return this
