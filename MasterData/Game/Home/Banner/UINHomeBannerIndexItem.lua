local UINHomeBannerIndexItem = class("UICarouselBanner", UIBaseNode)

function UINHomeBannerIndexItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHomeBannerIndexItem:SetBannerIndexItemColor(color)
  self.ui.img_indexItem.color = color
end

return UINHomeBannerIndexItem
