local DiamondShopItemComponent, Super = System.NewComponent("DiamondShopItemComponent")

function DiamondShopItemComponent:ctor(obj, cfg, callBack)
  Super.ctor(self)
  self.ui = UI_Shop_Item_Buy_DiamondResource(obj)
  self.cfg = cfg
  self.clickFunc = callBack
end

function DiamondShopItemComponent:OnBind(binder)
  self.binder = binder
  local itemCfg = ItemDataUtils.GetItemConfig(self.cfg.ItemID)
  binder:SetImage(self.ui.Icon_Article, itemCfg.Icon)
  binder:SetText(self.ui.Text_Diamond_Count, self.cfg.Num)
  binder:SetText(self.ui.Text_Money, self.cfg.Price)
  binder:BindButtonClick(self.ui.Btn_Bg, System.fn(self, self.OnClick))
end

function DiamondShopItemComponent:OnClick()
  if self.clickFunc then
    self.clickFunc(self.cfg)
  end
end

function DiamondShopItemComponent:SetText(nameText)
  self.binder:SetText(self.ui.Text_Title, nameText)
end

function DiamondShopItemComponent:SetIcon(iconPath)
  self.binder:SetImage(self.ui.Image_Icon, iconPath)
end

function DiamondShopItemComponent:SetActiveState(active)
  self.binder:SetActive(self.ui.Group_Noactive, not active)
end

return DiamondShopItemComponent
