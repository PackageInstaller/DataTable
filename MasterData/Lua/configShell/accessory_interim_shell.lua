local this = class("accessory_interim_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryInterimTable.GetInstance()

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
  accessoryid = 1,
  level = 2,
  mainAttr = 3,
  accessorysub = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAccessoryid(offset)
  return core:GetInt(offset, this.indexMap.accessoryid)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getMainattr(offset)
  return core:GetInt(offset, this.indexMap.mainAttr)
end

function this:_getAccessorysub(offset)
  local str = core:GetVString(offset, this.indexMap.accessorysub).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  accessoryid = this._getAccessoryid,
  level = this._getLevel,
  mainAttr = this._getMainattr,
  accessorysub = this._getAccessorysub
}
return this
