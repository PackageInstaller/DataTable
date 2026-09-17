local this = class("kibo_duel_competition_reward_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelCompetitionRewardTable.GetInstance()

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
  ID = 0,
  name = 1,
  numIcon = 2,
  condition = 3,
  reward = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.ID)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_competition_reward", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getNumicon(offset)
  local str = core:GetVString(offset, this.indexMap.numIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  ID = this._getId,
  name = this._getName,
  numIcon = this._getNumicon,
  condition = this._getCondition,
  reward = this._getReward
}
return this
