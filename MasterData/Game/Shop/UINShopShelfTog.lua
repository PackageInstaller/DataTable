local UINShopShelfTog = class("UINShopShelfTog", UIBaseNode)
local base = UIBaseNode

function UINShopShelfTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_ShelfType, self, self.OnValueChage)
  self.__RedDotEvent = BindCallback(self, self.RefreshShelfTogReddot)
end

function UINShopShelfTog:InitOnlyTitleShelfTog(titleName)
  self.__isOnlyTitle = true
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(titleName)
  self.refreshGoodsCallback = nil
  self.ui.img_Select.gameObject:SetActive(false)
  self.ui.tex_Name.color = self.ui.color_unSelect
  self.ui.obj_RedDot:SetActive(false)
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
end

function UINShopShelfTog:InitShelfTog(shopId, pageId, refreshGoodsCallback, pageCount)
  self.__isOnlyTitle = false
  self.pageId = pageId
  self.shopId = shopId
  self.pageCount = pageCount
  self.refreshGoodsCallback = refreshGoodsCallback
  local pageCfg = ConfigData.shop_page[self.pageId]
  if pageCfg == nil then
    error("can't get pageCfg with pageId:" .. tostring(pageId) .. " shopId:" .. tostring(shopId))
    return
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(pageCfg.page)
  self:RefreshShelfTogReddot()
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
  RedDotController:AddListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
end

function UINShopShelfTog:OnValueChage(bool)
  if self.__isOnlyTitle then
    return
  end
  if bool and not self._inSetSelected and ConfigData.shop_page[self.pageId] ~= nil then
    local auId = ConfigData.shop_page[self.pageId].click_audio
    if auId == 0 then
      auId = 1060
    end
    AudioManager:PlayAudioById(auId)
    if self.refreshGoodsCallback ~= nil then
      self.refreshGoodsCallback(self.shopId, self.pageId)
    end
  end
  if bool and self.pageCount > 1 then
    self.ui.img_Select.gameObject:SetActive(true)
    self.ui.tex_Name.color = self.ui.color_selected
  else
    self.ui.img_Select.gameObject:SetActive(false)
    self.ui.tex_Name.color = self.ui.color_unSelect
  end
end

function UINShopShelfTog:SetSelected(bool, autoSelectShelfId)
  self._inSetSelected = true
  if self.ui.tog_ShelfType.isOn == bool then
    self:OnValueChage(bool)
  else
    self.ui.tog_ShelfType.isOn = bool
  end
  if bool and self.refreshGoodsCallback ~= nil then
    self.refreshGoodsCallback(self.shopId, self.pageId, autoSelectShelfId)
  end
  self._inSetSelected = false
end

function UINShopShelfTog:RefreshShelfTogReddot()
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopId, self.pageId)
  self.ui.obj_RedDot:SetActive(ok and shopNode:GetRedDotCount() > 0)
end

function UINShopShelfTog:OnDelete()
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
  base.OnDelete(self)
end

return UINShopShelfTog
