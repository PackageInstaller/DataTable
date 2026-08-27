local UINWarChessCoinItem = class("UINWarChessCoinItem", UIBaseNode)
local base = UIBaseNode

function UINWarChessCoinItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINWarChessCoinItem:InitWarchessStoreCoinItem(itemCfg, MoneyIconId, buyPrice, GetCount, clickFunc)
  self.clickFunc = clickFunc
  self.itemCfg = itemCfg
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.ui.tex_Count.text = GetCount
  self.MoneyIconId = MoneyIconId
  self.buyPrice = math.ceil(buyPrice)
  self.ui.tex_Money.text = tostring(self.buyPrice)
  self.ui.img_Money.sprite = CRH:GetSprite(MoneyIconId)
end

function UINWarChessCoinItem:SetStoreCoinItemSelect(selected)
  if selected then
    self.ui.img_OnSelect.transform:SetParent(self.transform)
    self.ui.img_OnSelect.transform.anchoredPosition = Vector2.zero
  end
end

function UINWarChessCoinItem:UpdateSellOutActive(bSellOut)
  self.ui.img_SellOut:SetActive(bSellOut)
end

function UINWarChessCoinItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self)
  end
end

function UINWarChessCoinItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessCoinItem
