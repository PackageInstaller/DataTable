local this = class("home_item_model_shell", G_BaseConfig)
local core = G_Tables.TDHomeItemModelTable.GetInstance()

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
  itemType = 1,
  itemId = 2,
  dropPath = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItemtype(offset)
  return core:GetInt(offset, this.indexMap.itemType)
end

function this:_getItemid(offset)
  return core:GetInt(offset, this.indexMap.itemId)
end

function this:_getDroppath(offset)
  local str = core:GetVString(offset, this.indexMap.dropPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  itemType = this._getItemtype,
  itemId = this._getItemid,
  dropPath = this._getDroppath
}
return this
