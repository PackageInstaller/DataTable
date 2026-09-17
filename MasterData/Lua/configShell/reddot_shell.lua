local this = class("reddot_shell", G_BaseConfig)
local core = G_Tables.TDReddotTable.GetInstance()

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
  parentId = 2,
  path = 3,
  type = 4,
  position = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getParentid(offset)
  return core:GetInt(offset, this.indexMap.parentId)
end

function this:_getPath(offset)
  return core:GetVString(offset, this.indexMap.path).value
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getPosition(offset)
  return core:GetInt(offset, this.indexMap.position)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  parentId = this._getParentid,
  path = this._getPath,
  type = this._getType,
  position = this._getPosition
}
return this
