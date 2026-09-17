local this = class("shop_iap_shell", G_BaseConfig)
local core = G_Tables.TDShopIapTable.GetInstance()

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
  payId = 1,
  chargeNum = 2,
  chargeDouble = 3,
  item = 4,
  chargeExtra = 5,
  shopItemId = 6,
  channelId = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPayid(offset)
  return core:GetVString(offset, this.indexMap.payId).value
end

function this:_getChargenum(offset)
  return core:GetInt(offset, this.indexMap.chargeNum)
end

function this:_getChargedouble(offset)
  return core:GetBool(offset, this.indexMap.chargeDouble)
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getChargeextra(offset)
  local str = core:GetVString(offset, this.indexMap.chargeExtra).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShopitemid(offset)
  return core:GetInt(offset, this.indexMap.shopItemId)
end

function this:_getChannelid(offset)
  return core:GetVString(offset, this.indexMap.channelId).value
end

this.keyToMethodsMap = {
  id = this._getId,
  payId = this._getPayid,
  chargeNum = this._getChargenum,
  chargeDouble = this._getChargedouble,
  item = this._getItem,
  chargeExtra = this._getChargeextra,
  shopItemId = this._getShopitemid,
  channelId = this._getChannelid
}
return this
