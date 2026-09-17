local this = class("world_difficulty_obj_level_shell", G_BaseConfig)
local core = G_Tables.TDWorldDifficultyObjLevelTable.GetInstance()

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
  groupid = 1,
  difficultLv = 2,
  monsterLevel = 3,
  mapid = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupid)
end

function this:_getDifficultlv(offset)
  return core:GetInt(offset, this.indexMap.difficultLv)
end

function this:_getMonsterlevel(offset)
  return core:GetInt(offset, this.indexMap.monsterLevel)
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapid)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupid = this._getGroupid,
  difficultLv = this._getDifficultlv,
  monsterLevel = this._getMonsterlevel,
  mapid = this._getMapid
}
return this
