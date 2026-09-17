local this = class("world_monster_ai_map_shell", G_BaseConfig)
local core = G_Tables.TDWorldMonsterAiMapTable.GetInstance()

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
  unitId = 1,
  stateEnum = 2,
  behavTreeId = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getStateenum(offset)
  return core:GetVString(offset, this.indexMap.stateEnum).value
end

function this:_getBehavtreeid(offset)
  return core:GetInt(offset, this.indexMap.behavTreeId)
end

this.keyToMethodsMap = {
  id = this._getId,
  unitId = this._getUnitid,
  stateEnum = this._getStateenum,
  behavTreeId = this._getBehavtreeid
}
return this
