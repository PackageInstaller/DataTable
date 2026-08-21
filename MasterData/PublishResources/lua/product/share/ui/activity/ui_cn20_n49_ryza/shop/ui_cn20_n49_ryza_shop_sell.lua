_class("UICN20N49Ryza_ShopSell", UIController)
UICN20N49Ryza_ShopSell = UICN20N49Ryza_ShopSell

function UICN20N49Ryza_ShopSell:OnShow(uiParams)
  local res = uiParams[1]
  self._item = res.item_earn
  self._money = res.tip_earn
  self._all = res.item_earn + res.tip_earn
  self._itemid = res.star_item
  self._callback = uiParams[2]
  self:InitWidgets()
  self:RefreshUI()
end

function UICN20N49Ryza_ShopSell:InitWidgets()
  self._allTex = self:GetUIComponent("UILocalizationText", "allTex")
  self._itemTex = self:GetUIComponent("UILocalizationText", "itemTex")
  self._moneyTex = self:GetUIComponent("UILocalizationText", "moneyTex")
  self._itemName = self:GetUIComponent("UILocalizationText", "itemName")
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "item")
end

function UICN20N49Ryza_ShopSell:RefreshUI()
  self._allTex:SetText(self._all)
  self._itemTex:SetText(self._item)
  self._moneyTex:SetText(self._money)
  if self._itemid and self._itemid > 0 then
    local item = self._itemPool:SpawnObject("UICN20N49Ryza_ShopCell")
    local data = UICN20N49RyzaItemData:New()
    data.id = self._itemid
    local price, color = UICN20N49Ryza_Shop.GetItemPriceColor(self._itemid)
    data.color = color
    data.price = nil
    data.count = nil
    item:SetData(1, data)
    local cfg = Cfg.cfg_item[self._itemid]
    if cfg then
      self._itemName:SetText(StringTable.Get(cfg.Name))
    end
  end
end

function UICN20N49Ryza_ShopSell:BgOnClick(go)
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end
