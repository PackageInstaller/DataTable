_class("DShopRecommend", Object)
DShopRecommend = DShopRecommend

function DShopRecommend:Constructor(cfg, adId)
  if not cfg then
    return
  end
  self.cfg = cfg
  self:SetAdGroup(adId)
end

function DShopRecommend:GetId()
  return self.cfg and self.cfg.ID or 0
end

function DShopRecommend:GetSubTabType()
  return self.cfg and self.cfg.PageType or 0
end

function DShopRecommend:GetName()
  return self.cfg and StringTable.Get(self.cfg.TabName) or 0
end

function DShopRecommend:SetAdGroup(adId)
  self.AdGroup = Cfg.cfg_shop_recommend_ad[adId]
end

function DShopRecommend:GetAdGroup()
  return self.AdGroup
end

function DShopRecommend:GetTag()
  return self.cfg and self.cfg.TabType or nil
end
