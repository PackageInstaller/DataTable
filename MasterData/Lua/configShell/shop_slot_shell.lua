local this = class("shop_slot_shell", G_BaseConfig)
local core = G_Tables.TDShopSlotTable.GetInstance()

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
  slotId = 0,
  slotType = 1,
  slotParam = 2
}

function this:_getSlotid(offset)
  return core:GetInt(offset, this.indexMap.slotId)
end

function this:_getSlottype(offset)
  return core:GetInt(offset, this.indexMap.slotType)
end

function this:_getSlotparam(offset)
  return core:GetInt(offset, this.indexMap.slotParam)
end

this.keyToMethodsMap = {
  slotId = this._getSlotid,
  slotType = this._getSlottype,
  slotParam = this._getSlotparam
}
return this
