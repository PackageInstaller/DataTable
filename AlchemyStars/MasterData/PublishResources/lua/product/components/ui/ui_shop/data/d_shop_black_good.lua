require("d_shop_secret_good_base")
_class("DShopBlackGood", DShopSecretGoodBase)
DShopBlackGood = DShopBlackGood

function DShopBlackGood:Refresh(goodinfo, goodconfig)
  DShopSecretGoodBase.Refresh(self, goodinfo, goodconfig)
  if not self.cfg then
    Log.error("服务器传来的商品配置缺失 商品id：" .. tostring(self.goodId) .. " 防御..使用本地配置")
    self.localCfg = Cfg.cfg_shop_blackmarket_goods[self.goodId]
  end
end

function DShopBlackGood:GetSaleTag()
  local saleTag = self.cfg and self.cfg[ConfigKey.ConfigKey_SaleTag] or self.localCfg and self.localCfg.SaleTag or 0
  if saleTag == 1 then
    return 1
  elseif 0 < self.discount and self.discount < 100 then
    return self.discount
  elseif saleTag == 0 then
    return 0
  end
end

function DShopBlackGood:ShowRemain()
  return false
end

function DShopBlackGood:ShowSaleTag()
  return true
end
