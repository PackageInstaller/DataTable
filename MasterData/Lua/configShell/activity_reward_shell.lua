local this = class("activity_reward_shell", G_BaseConfig)
local core = G_Tables.TDActivityRewardTable.GetInstance()

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
  taskType = 1,
  requireActivity = 2,
  reward = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTasktype(offset)
  return core:GetInt(offset, this.indexMap.taskType)
end

function this:_getRequireactivity(offset)
  return core:GetInt(offset, this.indexMap.requireActivity)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  taskType = this._getTasktype,
  requireActivity = this._getRequireactivity,
  reward = this._getReward
}
return this
