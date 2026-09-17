local this = class("purchase_sdk_shell", G_BaseConfig)
local core = G_Tables.TDPurchaseSdkTable.GetInstance()

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
  repeatPurchase = 2,
  rechargeCount = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItemid(offset)
  return core:GetVString(offset, this.indexMap.itemId).value
end

function this:_getRepeatpurchase(offset)
  local str = core:GetVString(offset, this.indexMap.repeatPurchase).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRechargecount(offset)
  return core:GetInt(offset, this.indexMap.rechargeCount)
end

this.keyToMethodsMap = {
  id = this._getId,
  itemId = this._getItemid,
  repeatPurchase = this._getRepeatpurchase,
  rechargeCount = this._getRechargecount
}
return this
