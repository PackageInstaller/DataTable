local this = class("reward_option_shell", G_BaseConfig)
local core = G_Tables.TDRewardOptionTable.GetInstance()

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
  fragmentId = 1,
  optionIndex = 2,
  step = 3,
  unlockCondition = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFragmentid(offset)
  return core:GetInt(offset, this.indexMap.fragmentId)
end

function this:_getOptionindex(offset)
  return core:GetInt(offset, this.indexMap.optionIndex)
end

function this:_getStep(offset)
  return core:GetInt(offset, this.indexMap.step)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  fragmentId = this._getFragmentid,
  optionIndex = this._getOptionindex,
  step = this._getStep,
  unlockCondition = this._getUnlockcondition
}
return this
