require("d_shop_secret_good_base")
_class("DShopSecretExploreGood", DShopSecretGoodBase)
DShopSecretExploreGood = DShopSecretExploreGood

function DShopSecretExploreGood:Refresh(goodinfo, goodconfig)
  DShopSecretGoodBase.Refresh(self, goodinfo, goodconfig)
  if not self.cfg then
    Log.error("服务器传来的商品配置缺失 商品id：" .. tostring(self.goodId) .. " 防御..使用本地配置")
    self.localCfg = Cfg.cfg_shop_mystery_goods[self.goodId]
  end
end

function DShopSecretExploreGood:GetRemainTotalCount()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_SaleNum] or self.localCfg and self.localCfg.SaleNum or 1
end

function DShopSecretExploreGood:ShowRemain()
  return true
end

function DShopSecretExploreGood:ShowSaleTag()
  return false
end
