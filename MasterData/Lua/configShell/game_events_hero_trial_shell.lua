local this = class("game_events_hero_trial_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsHeroTrialTable.GetInstance()

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
  listId = 1,
  gachalist = 2,
  reward = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getListid(offset)
  local str = core:GetVString(offset, this.indexMap.listId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGachalist(offset)
  local str = core:GetVString(offset, this.indexMap.gachalist).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  listId = this._getListid,
  gachalist = this._getGachalist,
  reward = this._getReward
}
return this
