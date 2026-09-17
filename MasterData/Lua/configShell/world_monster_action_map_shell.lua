local this = class("world_monster_action_map_shell", G_BaseConfig)
local core = G_Tables.TDWorldMonsterActionMapTable.GetInstance()

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
  worldActId = 3,
  openRootMotion = 4
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

function this:_getWorldactid(offset)
  return core:GetInt(offset, this.indexMap.worldActId)
end

function this:_getOpenrootmotion(offset)
  return core:GetInt(offset, this.indexMap.openRootMotion)
end

this.keyToMethodsMap = {
  id = this._getId,
  unitId = this._getUnitid,
  stateEnum = this._getStateenum,
  worldActId = this._getWorldactid,
  openRootMotion = this._getOpenrootmotion
}
return this
