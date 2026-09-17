local this = class("home_order_type_shell", G_BaseConfig)
local core = G_Tables.TDHomeOrderTypeTable.GetInstance()

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
  orderId = 0,
  orderName = 1,
  orderMonday = 2,
  orderThursday = 3,
  orderRefresh = 4
}

function this:_getOrderid(offset)
  return core:GetInt(offset, this.indexMap.orderId)
end

function this:_getOrdername(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_order_type", core:GetVString(offset, this.indexMap.orderName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "orderName")
end

function this:_getOrdermonday(offset)
  return core:GetInt(offset, this.indexMap.orderMonday)
end

function this:_getOrderthursday(offset)
  return core:GetInt(offset, this.indexMap.orderThursday)
end

function this:_getOrderrefresh(offset)
  return core:GetBool(offset, this.indexMap.orderRefresh)
end

this.keyToMethodsMap = {
  orderId = this._getOrderid,
  orderName = this._getOrdername,
  orderMonday = this._getOrdermonday,
  orderThursday = this._getOrderthursday,
  orderRefresh = this._getOrderrefresh
}
return this
