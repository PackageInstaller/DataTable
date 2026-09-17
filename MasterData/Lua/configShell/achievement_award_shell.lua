local this = class("achievement_award_shell", G_BaseConfig)
local core = G_Tables.TDAchievementAwardTable.GetInstance()

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
  achiPoint = 1,
  reward = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAchipoint(offset)
  return core:GetInt(offset, this.indexMap.achiPoint)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  achiPoint = this._getAchipoint,
  reward = this._getReward
}
return this
