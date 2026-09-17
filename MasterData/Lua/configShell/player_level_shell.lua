local this = class("player_level_shell", G_BaseConfig)
local core = G_Tables.TDPlayerLevelTable.GetInstance()

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
  exp = 1,
  stamina = 2,
  reward = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getStamina(offset)
  return core:GetInt(offset, this.indexMap.stamina)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  exp = this._getExp,
  stamina = this._getStamina,
  reward = this._getReward
}
return this
