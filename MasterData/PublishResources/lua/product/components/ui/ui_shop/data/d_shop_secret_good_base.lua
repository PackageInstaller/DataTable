_class("DShopSecretGoodBase", Object)
DShopSecretGoodBase = DShopSecretGoodBase

function DShopSecretGoodBase:Constructor(goodinfo, goodconfig)
  self.discount = 0
end

function DShopSecretGoodBase:Refresh(goodinfo, goodconfig)
  self.goodId = goodinfo.goods_id
  self.cfg = goodconfig
  if goodconfig == nil then
    Log.error("err DShopSecretGoodBase  goodConfig is nil, goodsId = " .. self.goodId)
  end
  if self.cfg[ConfigKey.ConfigKey_IsAddBagNum] and self.cfg[ConfigKey.ConfigKey_IsAddBagNum] > 0 then
    local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(goodconfig[ConfigKey.ConfigKey_ItemId])
    self.remainNum = math.max(self.cfg[ConfigKey.ConfigKey_SaleNum] - (haveCount + goodinfo.selled_num), 0)
  else
    self.remainNum = self.cfg[ConfigKey.ConfigKey_SaleNum] - goodinfo.selled_num
  end
  self.discount = self.cfg and self.cfg[ConfigKey.ConfigKey_Discount] or 0
  self.saleMaxNum = self.cfg[ConfigKey.ConfigKey_SaleNum]
end

function DShopSecretGoodBase:GetGoodId()
  return self.goodId
end

function DShopSecretGoodBase:GetRemainCount()
  return self.remainNum
end

function DShopSecretGoodBase:GetDiscount()
  return self.discount
end

function DShopSecretGoodBase:GetSubTabType()
end

function DShopSecretGoodBase:GetRemainTotalCount()
  return 1
end

function DShopSecretGoodBase:ShowRemain()
  return false
end

function DShopSecretGoodBase:GetItemId()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_ItemId] or self.localCfg and self.localCfg.ItemId or 0
end

function DShopSecretGoodBase:IsPet()
  local itemId = self:GetItemId()
  return Cfg.cfg_pet[itemId] ~= nil
end

function DShopSecretGoodBase:IsBattlePass()
  return self.cfg[ConfigKey.ConfigKey_BattleType] ~= nil
end

function DShopSecretGoodBase:GetBattlePassType()
  return self.cfg[ConfigKey.ConfigKey_BattleType]
end

function DShopSecretGoodBase:GetConvertType()
  if self:IsBattlePass() then
    return self.cfg[ConfigKey.ConfigKey_ConvertType]
  end
  return nil
end

function DShopSecretGoodBase:GetConvertPrice()
  if self:IsBattlePass() then
    return self.cfg[ConfigKey.ConfigKey_ConvertPrice]
  end
  return nil
end

function DShopSecretGoodBase:GetItemCount()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_ItemCount] or self.localCfg and self.localCfg.ItemCount or 0
end

function DShopSecretGoodBase:GetSaleType()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_SaleType] or self.localCfg and self.localCfg.SaleType or 0
end

function DShopSecretGoodBase:GetOriginalSalePrice()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_RawPrice]
end

function DShopSecretGoodBase:GetSalePrice()
  local singlePrice = self:GetOriginalSalePrice()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_NowPrice] or singlePrice
end

function DShopSecretGoodBase:GetSaleTag()
  return 0
end

function DShopSecretGoodBase:ShowSaleTag()
  return false
end

function DShopSecretGoodBase:IsUnLimit()
  return self.saleMaxNum == SpecialNum.MysteryGoodsUnlimitedNum
end

function DShopSecretGoodBase:AddBagNum()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_IsAddBagNum]
end
