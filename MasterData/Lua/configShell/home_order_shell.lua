local this = class("home_order_shell", G_BaseConfig)
local core = G_Tables.TDHomeOrderTable.GetInstance()

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
  orderType = 1,
  orderSignature = 2,
  orderName = 3,
  orderDescribe = 4,
  orderWeight = 5,
  orderUnlock = 6,
  orderNeedMaterials = 7,
  orderRelationEvent = 8,
  orderReputation = 9,
  orderPlot = 10,
  optionaLorderNeedMaterials = 11
}

function this:_getOrderid(offset)
  return core:GetInt(offset, this.indexMap.orderId)
end

function this:_getOrdertype(offset)
  return core:GetInt(offset, this.indexMap.orderType)
end

function this:_getOrdersignature(offset)
  return core:GetInt(offset, this.indexMap.orderSignature)
end

function this:_getOrdername(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_order", core:GetVString(offset, this.indexMap.orderName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "orderName")
end

function this:_getOrderdescribe(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_order", core:GetVString(offset, this.indexMap.orderDescribe))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "orderDescribe")
end

function this:_getOrderweight(offset)
  return core:GetInt(offset, this.indexMap.orderWeight)
end

function this:_getOrderunlock(offset)
  local str = core:GetVString(offset, this.indexMap.orderUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getOrderneedmaterials(offset)
  local str = core:GetVString(offset, this.indexMap.orderNeedMaterials).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOrderrelationevent(offset)
  local str = core:GetVString(offset, this.indexMap.orderRelationEvent).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOrderreputation(offset)
  return core:GetInt(offset, this.indexMap.orderReputation)
end

function this:_getOrderplot(offset)
  return core:GetInt(offset, this.indexMap.orderPlot)
end

function this:_getOptionalorderneedmaterials(offset)
  local str = core:GetVString(offset, this.indexMap.optionaLorderNeedMaterials).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  orderId = this._getOrderid,
  orderType = this._getOrdertype,
  orderSignature = this._getOrdersignature,
  orderName = this._getOrdername,
  orderDescribe = this._getOrderdescribe,
  orderWeight = this._getOrderweight,
  orderUnlock = this._getOrderunlock,
  orderNeedMaterials = this._getOrderneedmaterials,
  orderRelationEvent = this._getOrderrelationevent,
  orderReputation = this._getOrderreputation,
  orderPlot = this._getOrderplot,
  optionaLorderNeedMaterials = this._getOptionalorderneedmaterials
}
return this
