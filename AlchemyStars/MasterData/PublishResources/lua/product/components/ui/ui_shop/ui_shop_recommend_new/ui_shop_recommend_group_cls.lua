_class("UIShopRecommendGroupCls", Object)
UIShopRecommendGroupCls = UIShopRecommendGroupCls

function UIShopRecommendGroupCls:Constructor(group, list)
  self.group = group
  self.list = list
  self:SortList()
end

function UIShopRecommendGroupCls:SortList()
  table.sort(self.list, function(a, b)
    local cfg_a = Cfg.cfg_shop_recommend_ad[a]
    local cfg_b = Cfg.cfg_shop_recommend_ad[b]
    return cfg_a.ID < cfg_b.ID
  end)
end

function UIShopRecommendGroupCls:CheckTabType(tabType)
  for index, value in ipairs(self.list) do
    local cfg = Cfg.cfg_shop_recommend_ad[value]
    if cfg.TabType == tabType then
      return true
    end
  end
  return false
end

function UIShopRecommendGroupCls:GetName(idx)
  return Cfg.cfg_shop_recommend_ad[self.list[idx]].Name
end

function UIShopRecommendGroupCls:GroupType()
  if #self.list > 1 then
    return UIShopRecommendGroupType.Two
  else
    return UIShopRecommendGroupType.One
  end
end

function UIShopRecommendGroupCls:GetTabType(idx)
  return Cfg.cfg_shop_recommend_ad[self.list[idx]].TabType
end

function UIShopRecommendGroupCls:GetPic(idx)
  return Cfg.cfg_shop_recommend_ad[self.list[idx]].Pic
end

function UIShopRecommendGroupCls:GetID(idx)
  return self.list[idx]
end

function UIShopRecommendGroupCls:GetEffIcon()
  return nil
end

function UIShopRecommendGroupCls:GetUIType()
  local cfg = Cfg.cfg_shop_recommend_ad[self.list[1]]
  return cfg.UIType
end

function UIShopRecommendGroupCls:GetPetParams()
  local cfg = Cfg.cfg_shop_recommend_ad[self.list[1]]
  return cfg.PetParams
end

function UIShopRecommendGroupCls:GetGiftParams(idx)
  return Cfg.cfg_shop_recommend_ad[self.list[idx]].GiftParams
end

function UIShopRecommendGroupCls:GetGroupName()
  local cfg = Cfg.cfg_shop_recommend_ad[self.list[1]]
  return cfg.GroupName
end
