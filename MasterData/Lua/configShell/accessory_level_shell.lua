local this = class("accessory_level_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryLevelTable.GetInstance()

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
  Id = 0,
  accessoryId = 1,
  rarity = 2,
  level = 3,
  slot = 4,
  item = 5,
  return_item = 6,
  unlock_entry = 7,
  smelt_point = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getAccessoryid(offset)
  return core:GetInt(offset, this.indexMap.accessoryId)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getSlot(offset)
  return core:GetInt(offset, this.indexMap.slot)
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getReturn_item(offset)
  local str = core:GetVString(offset, this.indexMap.return_item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUnlock_entry(offset)
  return core:GetInt(offset, this.indexMap.unlock_entry)
end

function this:_getSmelt_point(offset)
  return core:GetInt(offset, this.indexMap.smelt_point)
end

this.keyToMethodsMap = {
  Id = this._getId,
  accessoryId = this._getAccessoryid,
  rarity = this._getRarity,
  level = this._getLevel,
  slot = this._getSlot,
  item = this._getItem,
  return_item = this._getReturn_item,
  unlock_entry = this._getUnlock_entry,
  smelt_point = this._getSmelt_point
}
return this
