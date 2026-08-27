local UINCharDungeonShopPage = class("UINCharDungeonShopPage", UIBaseNode)
local base = UIBaseNode

function UINCharDungeonShopPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_pageItem, self, self.OnPageValueChanged)
end

function UINCharDungeonShopPage:InitCharDungeonShopPage(shopId, unlock, valueEvent)
  self.__shopId = shopId
  self.__unlock = unlock or false
  self.__valueEvent = valueEvent
  self:RefreshShopPageInfo()
end

function UINCharDungeonShopPage:RefreshCharDungeonUnlock(unlock)
  self.__unlock = unlock or false
  self:RefreshShopPageInfo()
end

function UINCharDungeonShopPage:SetDungeonShopPageIsOn(isOn)
  self.ui.tog_pageItem.isOn = isOn
end

function UINCharDungeonShopPage:SetCharDungeonShopPageReddot(active)
  self.ui.blueDot_Page:SetActive(active)
end

function UINCharDungeonShopPage:RefreshShopPageInfo()
  local shopCfg = ConfigData.shop[self.__shopId]
  if shopCfg == nil then
    error("shop cfg is null,id:" .. tostring(self.__shopId))
    return
  end
  self.ui.tex_PageName.text = LanguageUtil.GetLocaleText(shopCfg.name)
  self.ui.img_IsLock:SetActive(not self.__unlock)
  self.__isRecommend = shopCfg.is_recommended
  self:SetShopRecommend(self.__isRecommend)
end

function UINCharDungeonShopPage:GetCharDungeonShopId()
  return self.__shopId
end

function UINCharDungeonShopPage:GetCharDungeonUnlock()
  return self.__unlock
end

function UINCharDungeonShopPage:IsItemRecommendShop()
  return self.__isRecommend
end

function UINCharDungeonShopPage:OnPageValueChanged(value)
  self.ui.obj_PageSelect:SetActive(value)
  if self.__valueEvent ~= nil then
    self.__valueEvent(self, value)
  end
  if not self.__unlock then
    return
  end
  local col = value and Color.white or self.ui.col_Unsel
  self.ui.tex_PageName.color = col
  self.ui.img_Icon.color = col
end

function UINCharDungeonShopPage:SetShopRecommend(active)
  if self.ui.obj_RecommendIcon == nil then
    return
  end
  self.ui.obj_RecommendIcon:SetActive(active)
end

function UINCharDungeonShopPage:SetSelectColor(color)
  self.ui.img_PageSelect.color = color
end

function UINCharDungeonShopPage:OnDelete()
  base.OnDelete(self)
end

return UINCharDungeonShopPage
