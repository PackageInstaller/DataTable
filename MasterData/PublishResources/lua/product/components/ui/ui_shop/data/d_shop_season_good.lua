require("d_shop_secret_store_base")
_class("DShopSeasonGood", DShopSecretGoodBase)
DShopSeasonGood = DShopSeasonGood

function DShopSeasonGood:ShowRemain()
  return true
end

function DShopSeasonGood:IsUnLimit()
  return self.saleMaxNum == SpecialNum.MysteryGoodsUnlimitedNum
end

function DShopSeasonGood:GetSeasonSaleTag()
  local saleTag = self.cfg and self.cfg[ConfigKey.ConfigKey_SaleTag]
  if saleTag and saleTag == 1 then
    return 1
  end
  return 0
end

function DShopSeasonGood:GrandPrize()
  local cfg = Cfg.cfg_shop_season_goods[self.goodId]
  if cfg then
    local grandPrize = cfg.GrandPrize
    return grandPrize and grandPrize == 1
  end
  return false
end
