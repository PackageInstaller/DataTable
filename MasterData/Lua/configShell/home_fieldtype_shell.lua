local this = class("home_fieldtype_shell", G_BaseConfig)
local core = G_Tables.TDHomeFieldtypeTable.GetInstance()

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
  typeName = 1,
  homeBuildingId = 2,
  waterMax = 3,
  waterTime = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypename(offset)
  return core:GetVString(offset, this.indexMap.typeName).value
end

function this:_getHomebuildingid(offset)
  return core:GetInt(offset, this.indexMap.homeBuildingId)
end

function this:_getWatermax(offset)
  return core:GetInt(offset, this.indexMap.waterMax)
end

function this:_getWatertime(offset)
  return core:GetInt(offset, this.indexMap.waterTime)
end

this.keyToMethodsMap = {
  id = this._getId,
  typeName = this._getTypename,
  homeBuildingId = this._getHomebuildingid,
  waterMax = this._getWatermax,
  waterTime = this._getWatertime
}
return this
