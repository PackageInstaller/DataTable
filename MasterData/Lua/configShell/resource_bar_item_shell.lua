local this = class("resource_bar_item_shell", G_BaseConfig)
local core = G_Tables.TDResourceBarItemTable.GetInstance()

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
  resourceType = 1,
  resourceID = 2,
  icon = 3,
  numType = 4,
  isAddSign = 5,
  system = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getResourcetype(offset)
  return core:GetInt(offset, this.indexMap.resourceType)
end

function this:_getResourceid(offset)
  return core:GetInt(offset, this.indexMap.resourceID)
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.icon).value
end

function this:_getNumtype(offset)
  return core:GetInt(offset, this.indexMap.numType)
end

function this:_getIsaddsign(offset)
  return core:GetInt(offset, this.indexMap.isAddSign)
end

function this:_getSystem(offset)
  return core:GetInt(offset, this.indexMap.system)
end

this.keyToMethodsMap = {
  id = this._getId,
  resourceType = this._getResourcetype,
  resourceID = this._getResourceid,
  icon = this._getIcon,
  numType = this._getNumtype,
  isAddSign = this._getIsaddsign,
  system = this._getSystem
}
return this
