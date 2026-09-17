local this = class("battle_pass_reward_shell", G_BaseConfig)
local core = G_Tables.TDBattlePassRewardTable.GetInstance()

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
  teamId = 1,
  level = 2,
  commonReward = 3,
  advancedReward = 4,
  soulessenceMark = 5,
  special = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getCommonreward(offset)
  local str = core:GetVString(offset, this.indexMap.commonReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAdvancedreward(offset)
  local str = core:GetVString(offset, this.indexMap.advancedReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSoulessencemark(offset)
  return core:GetInt(offset, this.indexMap.soulessenceMark)
end

function this:_getSpecial(offset)
  return core:GetInt(offset, this.indexMap.special)
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  level = this._getLevel,
  commonReward = this._getCommonreward,
  advancedReward = this._getAdvancedreward,
  soulessenceMark = this._getSoulessencemark,
  special = this._getSpecial
}
return this
