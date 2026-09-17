local this = class("products_multi_quality_shell", G_BaseConfig)
local core = G_Tables.TDProductsMultiQualityTable.GetInstance()

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
  productId = 1,
  productRarity = 2,
  productGroup = 3,
  needMaterial = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getProductid(offset)
  return core:GetInt(offset, this.indexMap.productId)
end

function this:_getProductrarity(offset)
  return core:GetInt(offset, this.indexMap.productRarity)
end

function this:_getProductgroup(offset)
  return core:GetInt(offset, this.indexMap.productGroup)
end

function this:_getNeedmaterial(offset)
  local str = core:GetVString(offset, this.indexMap.needMaterial).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  productId = this._getProductid,
  productRarity = this._getProductrarity,
  productGroup = this._getProductgroup,
  needMaterial = this._getNeedmaterial
}
return this
