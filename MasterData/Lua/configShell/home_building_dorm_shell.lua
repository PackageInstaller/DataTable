local this = class("home_building_dorm_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingDormTable.GetInstance()

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
  checkInMax = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getCheckinmax(offset)
  return core:GetInt(offset, this.indexMap.checkInMax)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  checkInMax = this._getCheckinmax
}
return this
