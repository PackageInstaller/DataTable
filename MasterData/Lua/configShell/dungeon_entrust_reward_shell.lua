local this = class("dungeon_entrust_reward_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustRewardTable.GetInstance()

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
  starNum = 1,
  reward = 2,
  dungeonEntrustType = 3,
  dungeonEntrustGroup = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStarnum(offset)
  return core:GetInt(offset, this.indexMap.starNum)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDungeonentrusttype(offset)
  return core:GetInt(offset, this.indexMap.dungeonEntrustType)
end

function this:_getDungeonentrustgroup(offset)
  return core:GetInt(offset, this.indexMap.dungeonEntrustGroup)
end

this.keyToMethodsMap = {
  id = this._getId,
  starNum = this._getStarnum,
  reward = this._getReward,
  dungeonEntrustType = this._getDungeonentrusttype,
  dungeonEntrustGroup = this._getDungeonentrustgroup
}
return this
