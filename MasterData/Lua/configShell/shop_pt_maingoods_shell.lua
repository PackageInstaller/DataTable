local this = class("shop_pt_maingoods_shell", G_BaseConfig)
local core = G_Tables.TDShopPtMaingoodsTable.GetInstance()

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
  showId = 0,
  shopGroupId = 1,
  goodsId = 2,
  shopId = 3,
  mainGoodspic = 4,
  mainGoodstype = 5
}

function this:_getShowid(offset)
  return core:GetInt(offset, this.indexMap.showId)
end

function this:_getShopgroupid(offset)
  return core:GetInt(offset, this.indexMap.shopGroupId)
end

function this:_getGoodsid(offset)
  return core:GetInt(offset, this.indexMap.goodsId)
end

function this:_getShopid(offset)
  return core:GetInt(offset, this.indexMap.shopId)
end

function this:_getMaingoodspic(offset)
  return core:GetVString(offset, this.indexMap.mainGoodspic).value
end

function this:_getMaingoodstype(offset)
  return core:GetInt(offset, this.indexMap.mainGoodstype)
end

this.keyToMethodsMap = {
  showId = this._getShowid,
  shopGroupId = this._getShopgroupid,
  goodsId = this._getGoodsid,
  shopId = this._getShopid,
  mainGoodspic = this._getMaingoodspic,
  mainGoodstype = this._getMaingoodstype
}
return this
