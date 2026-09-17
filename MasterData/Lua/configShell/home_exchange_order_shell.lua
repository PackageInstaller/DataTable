local this = class("home_exchange_order_shell", G_BaseConfig)
local core = G_Tables.TDHomeExchangeOrderTable.GetInstance()

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
  orderID = 0,
  orderName = 1,
  orderSignature = 2,
  orderLevel = 3,
  orderUnlock = 4,
  orderNeedMaterials = 5,
  orderReward = 6,
  orderReputation = 7
}

function this:_getOrderid(offset)
  return core:GetInt(offset, this.indexMap.orderID)
end

function this:_getOrdername(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_exchange_order", core:GetVString(offset, this.indexMap.orderName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "orderName")
end

function this:_getOrdersignature(offset)
  return core:GetInt(offset, this.indexMap.orderSignature)
end

function this:_getOrderlevel(offset)
  return core:GetInt(offset, this.indexMap.orderLevel)
end

function this:_getOrderunlock(offset)
  local str = core:GetVString(offset, this.indexMap.orderUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getOrderneedmaterials(offset)
  local str = core:GetVString(offset, this.indexMap.orderNeedMaterials).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOrderreward(offset)
  local str = core:GetVString(offset, this.indexMap.orderReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOrderreputation(offset)
  local str = core:GetVString(offset, this.indexMap.orderReputation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  orderID = this._getOrderid,
  orderName = this._getOrdername,
  orderSignature = this._getOrdersignature,
  orderLevel = this._getOrderlevel,
  orderUnlock = this._getOrderunlock,
  orderNeedMaterials = this._getOrderneedmaterials,
  orderReward = this._getOrderreward,
  orderReputation = this._getOrderreputation
}
return this
