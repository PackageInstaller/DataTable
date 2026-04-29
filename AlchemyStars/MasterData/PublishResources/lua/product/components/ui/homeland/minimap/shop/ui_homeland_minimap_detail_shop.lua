_class("UIHomelandMinimapDetailShop", UIHomelandMinimapDetailBase)
UIHomelandMinimapDetailShop = UIHomelandMinimapDetailShop

function UIHomelandMinimapDetailShop:OnShow()
end

function UIHomelandMinimapDetailShop:OnHide()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "Skin")
  self.imgIcon:DestoryLastImage()
end

function UIHomelandMinimapDetailShop:OnClose()
  UIHomelandMinimapDetailShop.super.OnClose(self)
end

function UIHomelandMinimapDetailShop:OnInitDone()
  self:_SetSkin()
  self:_SetShop()
end

function UIHomelandMinimapDetailShop:_SetSkin()
  local iconData = self:GetIconData()
  if not iconData then
    return
  end
  local building = self:GetIconData():GetParam()
  local skinID = building:SkinID()
  local cfgSkin = Cfg.cfg_item_architecture_skin[skinID]
  UIWidgetHelper.SetLocalizationText(self, "NameTxt", StringTable.Get(cfgSkin.SkinName))
  UIWidgetHelper.SetLocalizationText(self, "ContentTxt", StringTable.Get(cfgSkin.Des))
  UIWidgetHelper.SetRawImage(self, "Skin", cfgSkin.SkinIcon)
  self._nameTxt = self:GetUIComponent("UILocalizationText", "NameTxt")
  self._titleRect = self:GetUIComponent("RectTransform", "Title")
  if self._titleRect then
    local titleWidth = self._nameTxt.preferredWidth
    if 350 < titleWidth then
      titleWidth = 350
    end
    self._titleRect.sizeDelta = Vector2(titleWidth, self._titleRect.sizeDelta.y)
  end
  local ContentTxtRect = self:GetUIComponent("RectTransform", "ContentTxt")
  if ContentTxtRect then
    ContentTxtRect.anchoredPosition = Vector2(0, 0)
  end
end

function UIHomelandMinimapDetailShop:_SetShop()
  local homeLandModule = GameGlobal.GetModule(HomelandModule)
  local shop_info = homeLandModule.m_homeland_info.shop_info
  self._infos = self:_GetListData(shop_info)
  local objs = UIWidgetHelper.SpawnObjects(self, "Shop", "UIHomelandShopTabOrderListItem", #self._infos)
  for i, v in ipairs(objs) do
    v:SetData(i, self._infos[i])
  end
  local check = UIHomelandShopHelper.CheckOrderSubmit()
  self:GetGameObject("_txtSubmitHint"):SetActive(check)
end

function UIHomelandMinimapDetailShop:_GetListData(shop_info)
  local tb = {}
  for i, v in pairs(shop_info.goods_info) do
    tb[i + 1] = v
  end
  return tb
end

function UIHomelandMinimapDetailShop:CloseBtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailShop:ConfirmBtnOnClick(go)
  self:CloseBtnOnClick(go)
end

function UIHomelandMinimapDetailShop:GetCloseAnimtionName()
  return "UIHomelandMinimapDetailShop_out"
end
