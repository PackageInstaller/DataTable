local this = class("home_exchange_order_type_shell", G_BaseConfig)
local core = G_Tables.TDHomeExchangeOrderTypeTable.GetInstance()

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
  orderTypeID = 0,
  orderTime = 1,
  orderPeriod = 2,
  orderLevel = 3,
  orderNum = 4
}

function this:_getOrdertypeid(offset)
  return core:GetInt(offset, this.indexMap.orderTypeID)
end

function this:_getOrdertime(offset)
  return core:GetInt(offset, this.indexMap.orderTime)
end

function this:_getOrderperiod(offset)
  return core:GetInt(offset, this.indexMap.orderPeriod)
end

function this:_getOrderlevel(offset)
  return core:GetInt(offset, this.indexMap.orderLevel)
end

function this:_getOrdernum(offset)
  return core:GetInt(offset, this.indexMap.orderNum)
end

this.keyToMethodsMap = {
  orderTypeID = this._getOrdertypeid,
  orderTime = this._getOrdertime,
  orderPeriod = this._getOrderperiod,
  orderLevel = this._getOrderlevel,
  orderNum = this._getOrdernum
}
return this
