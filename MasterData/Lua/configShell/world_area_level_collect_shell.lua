local this = class("world_area_level_collect_shell", G_BaseConfig)
local core = G_Tables.TDWorldAreaLevelCollectTable.GetInstance()

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
  name = 1,
  areaName = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getAreaname(offset)
  return core:GetVString(offset, this.indexMap.areaName).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  areaName = this._getAreaname
}
return this
