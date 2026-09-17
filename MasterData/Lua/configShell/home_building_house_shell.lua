local this = class("home_building_house_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingHouseTable.GetInstance()

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
  groupId = 1,
  level = 2,
  groups = 3,
  residentMax = 4,
  residentBornTime = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getGroups(offset)
  return core:GetInt(offset, this.indexMap.groups)
end

function this:_getResidentmax(offset)
  return core:GetInt(offset, this.indexMap.residentMax)
end

function this:_getResidentborntime(offset)
  return core:GetInt(offset, this.indexMap.residentBornTime)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  level = this._getLevel,
  groups = this._getGroups,
  residentMax = this._getResidentmax,
  residentBornTime = this._getResidentborntime
}
return this
