local UINWhiteDayInfoBtnUnlockItem = class("UINWhiteDayInfoBtnUnlockItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINWhiteDayInfoBtnUnlockItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__unloclLineSprite = self.ui.img_Icon.sprite
  UIUtil.AddButtonListener(self.ui.btn_unlockItem, self, self.__OnClickUnlockItem)
end

function UINWhiteDayInfoBtnUnlockItem:IntiInfoBtnUnlockItem(isLine, orderData)
  self.isLine = isLine
  self.orderData = orderData
  if isLine then
    self.ui.img_Icon.sprite = self.__unloclLineSprite
    self.ui.text:SetIndex(0)
  else
    local itemId = orderData:GetWDOrderItemId()
    self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(itemId)
    self.ui.text:SetIndex(1)
  end
end

function UINWhiteDayInfoBtnUnlockItem:__OnClickUnlockItem()
  if self.isLine then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7203))
  else
    local itemId = self.orderData:GetWDOrderItemId()
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      if win ~= nil then
        win:SetNotNeedAnyJump(true)
        win:InitCommonItemDetail(itemCfg)
      end
    end)
  end
end

function UINWhiteDayInfoBtnUnlockItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayInfoBtnUnlockItem
