local this = class("home_exchange_item_shell", G_BaseConfig)
local core = G_Tables.TDHomeExchangeItemTable.GetInstance()

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
  itemId = 1,
  type = 2,
  price = 3,
  Tag = 4,
  bonusRate = 5,
  sortord = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItemid(offset)
  return core:GetInt(offset, this.indexMap.itemId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getPrice(offset)
  return core:GetInt(offset, this.indexMap.price)
end

function this:_getTag(offset)
  local str = core:GetVString(offset, this.indexMap.Tag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBonusrate(offset)
  return core:GetInt(offset, this.indexMap.bonusRate)
end

function this:_getSortord(offset)
  return core:GetInt(offset, this.indexMap.sortord)
end

this.keyToMethodsMap = {
  id = this._getId,
  itemId = this._getItemid,
  type = this._getType,
  price = this._getPrice,
  Tag = this._getTag,
  bonusRate = this._getBonusrate,
  sortord = this._getSortord
}
return this
