_class("UIHomelandBackpackBox", UIController)
UIHomelandBackpackBox = UIHomelandBackpackBox

function UIHomelandBackpackBox:OnShow(uiParams)
  self:AttachEvent(GameEventType.CloseUIBackPackBox, self.btnCloseOnClick)
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  local Content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._item = uiParams[1]
  self._count = uiParams[2]
  self.txtName:SetText(StringTable.Get(self._item:GetTemplate().Name))
  local lst = self:GetItemList(self._item:GetTemplateID())
  self._itemList = {}
  for i, item in ipairs(lst) do
    local ra = RoleAsset:New()
    ra.assetid = item[1]
    ra.count = item[2]
    self._itemList[i] = ra
  end
  local len = table.count(self._itemList)
  Content:SpawnObjects("UIItemHomeland", len)
  local uiItems = Content:GetAllSpawnList()
  for i, uiItem in ipairs(uiItems) do
    if i <= len then
      uiItem:Flush(self._itemList[i], function()
        self:ShowUIBackPackBoxGain(i)
      end, true)
    end
  end
end

function UIHomelandBackpackBox:OnHide()
  self:DetachEvent(GameEventType.CloseUIBackPackBox, self.btnCloseOnClick)
end

function UIHomelandBackpackBox:btnCloseOnClick()
  self:CloseDialog()
end

function UIHomelandBackpackBox:ShowUIBackPackBoxGain(idx)
  self:ShowDialog("UIHomelandBackPackBoxGain", self._item:GetID(), self._count, self._itemList[idx], idx - 1)
end

function UIHomelandBackpackBox:GetItemList(itemGiftID)
  local cfgItemGift = Cfg.cfg_item_gift[itemGiftID]
  if not cfgItemGift then
    return 0
  end
  local lst = cfgItemGift.ItemList
  return lst
end
