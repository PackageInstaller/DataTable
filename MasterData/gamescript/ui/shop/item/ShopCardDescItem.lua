local ShopCardDescItem, Super = System.NewComponent("ShopCardDescItem")

function ShopCardDescItem:ctor(uiNode, name, desc)
  Super.ctor(self)
  if nil == uiNode then
    Logger.Debug("ShopCardDescItem nil: ")
  end
  self.ui = Item_Shop_DescResource(uiNode)
  self.name = name
  self.desc = desc
end

function ShopCardDescItem:OnBind(binder)
  binder:SetActive(self.ui.Text_Name, false)
  binder:SetText(self.ui.Text_Desc, StrUtils.SetWordEffectStr(self.desc))
end

return ShopCardDescItem
