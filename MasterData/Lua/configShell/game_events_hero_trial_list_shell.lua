local this = class("game_events_hero_trial_list_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsHeroTrialListTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, trainTaskId = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTraintaskid(offset)
  return core:GetInt(offset, this.indexMap.trainTaskId)
end

this.keyToMethodsMap = {
  id = this._getId,
  trainTaskId = this._getTraintaskid
}
return this
