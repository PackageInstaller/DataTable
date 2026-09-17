local this = class("rogue_reward_shell", G_BaseConfig)
local core = G_Tables.TDRogueRewardTable.GetInstance()

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
  rewardGroupId = 1,
  difficulty = 2,
  rewardDisplay = 3,
  rewardDisplayShow = 4,
  firstPassReward = 5,
  difficultygather = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRewardgroupid(offset)
  return core:GetInt(offset, this.indexMap.rewardGroupId)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getRewarddisplay(offset)
  local str = core:GetVString(offset, this.indexMap.rewardDisplay).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRewarddisplayshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardDisplayShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFirstpassreward(offset)
  local str = core:GetVString(offset, this.indexMap.firstPassReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDifficultygather(offset)
  return core:GetInt(offset, this.indexMap.difficultygather)
end

this.keyToMethodsMap = {
  id = this._getId,
  rewardGroupId = this._getRewardgroupid,
  difficulty = this._getDifficulty,
  rewardDisplay = this._getRewarddisplay,
  rewardDisplayShow = this._getRewarddisplayshow,
  firstPassReward = this._getFirstpassreward,
  difficultygather = this._getDifficultygather
}
return this
