local this = class("rogue_handbook_reward_shell", G_BaseConfig)
local core = G_Tables.TDRogueHandbookRewardTable.GetInstance()

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
  type = 1,
  numrequire = 2,
  reward = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getNumrequire(offset)
  return core:GetInt(offset, this.indexMap.numrequire)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  numrequire = this._getNumrequire,
  reward = this._getReward
}
return this
