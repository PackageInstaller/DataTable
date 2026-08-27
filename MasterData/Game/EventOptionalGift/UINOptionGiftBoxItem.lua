local UINOptionGiftBoxItem = class("UINOptionGiftBoxItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINOptionGiftBoxItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.empty, self, self.OnClickSelect)
  self._item = UINBaseItemWithCount.New()
  self._item:Init(self.ui.uINBaseItemWithCount)
  self._item:Hide()
  self.OnClickSelectCallback = BindCallback(self, self.OnClickSelect)
end

function UINOptionGiftBoxItem:InitOptionGiftSelect(index, giftInfo, selectCallback)
  self._giftInfo = giftInfo
  self._index = index
  self._selectCallback = selectCallback
  self:RefreshOptionGiftSelect()
end

function UINOptionGiftBoxItem:RefreshOptionGiftSelect()
  local params = self._giftInfo:GetSelfSelectGiftParams()
  if params == nil or params[self._index] == nil then
    self.ui.empty.gameObject:SetActive(true)
    self._item:Hide()
    return
  end
  self.ui.empty.gameObject:SetActive(false)
  local itemId = params[self._index].param
  local itemCfg = ConfigData.item[itemId]
  local customCfg = self._giftInfo:GetSelectGiftCustomCfg()
  local index = table.indexof(customCfg.param1, itemId)
  local itemCount = customCfg.param2[index]
  self._item:Show()
  self._item:InitItemWithCount(itemCfg, itemCount, self.OnClickSelectCallback)
  self._item:CloseGreatRewardLoopFx()
  self._item:CloseQualityFx()
end

function UINOptionGiftBoxItem:OnClickSelect()
  if self._selectCallback ~= nil then
    self._selectCallback(self._index, self)
  end
end

return UINOptionGiftBoxItem
