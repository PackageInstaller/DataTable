local this = class("fish_event_group_shell", G_BaseConfig)
local core = G_Tables.TDFishEventGroupTable.GetInstance()

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
  salvagingId = 2,
  weight = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getSalvagingid(offset)
  return core:GetInt(offset, this.indexMap.salvagingId)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  salvagingId = this._getSalvagingid,
  weight = this._getWeight
}
return this
