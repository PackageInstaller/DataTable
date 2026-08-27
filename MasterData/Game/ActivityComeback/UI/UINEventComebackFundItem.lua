local UINEventComebackFundItem = class("UINEventComebackFundItem", UIBaseNode)
local base = UIBaseNode
local UINEventComebackFundRewardItem = require("Game.ActivityComeback.UI.UINEventComebackFundRewardItem")

function UINEventComebackFundItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.__OnClickItem)
  self._rewardPool = UIItemPool.New(UINEventComebackFundRewardItem, self.ui.itemWithLock)
  self.ui.itemWithLock:SetActive(false)
end

function UINEventComebackFundItem:InitCombackFundItem(fundItemCfg, targetItemId, targetItemCount, clickEvent)
  self._targetItemCount = targetItemCount
  self._fundLevel = fundItemCfg.level
  self._clickEvent = clickEvent
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(targetItemId)
  self.ui.tex_Count.text = tostring(targetItemCount)
  self._rewardPool:HideAll()
  for i, itemId in ipairs(fundItemCfg.base_item_ids) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = fundItemCfg.base_item_nums[i]
    local item = self._rewardPool:GetOne()
    item:InitFundRewardItem(itemCfg, itemCount)
  end
  for i, itemId in ipairs(fundItemCfg.senior_item_ids) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = fundItemCfg.senior_item_nums[i]
    local item = self._rewardPool:GetOne()
    item:InitFundRewardItem(itemCfg, itemCount)
  end
end

function UINEventComebackFundItem:RefreshConbackFundItemState(isUnlock, isTarget, isReveice)
  local bottomLight = isTarget and not isReveice
  self.ui.bottom:SetIndex(bottomLight and 1 or 0)
  if not isUnlock then
    self.ui.obj_Locked:SetActive(true)
    self.ui.tex_Received.gameObject:SetActive(false)
    self.ui.tex_Received:SetIndex(0)
    self.ui.btn_NotReceive.gameObject:SetActive(false)
    self.ui.btn_Receive.gameObject:SetActive(false)
    return
  end
  self.ui.obj_Locked:SetActive(false)
  self.ui.btn_NotReceive.gameObject:SetActive(not isTarget)
  self.ui.btn_Receive.gameObject:SetActive(isTarget and not isReveice)
  if isTarget and isReveice then
    self.ui.tex_Received.gameObject:SetActive(true)
    self.ui.tex_Received:SetIndex(1)
  else
    self.ui.tex_Received.gameObject:SetActive(false)
  end
  for i, item in ipairs(self._rewardPool.listItem) do
    item:SetPickedUIActive(isReveice)
    item:SetRewardLockState(not isUnlock or not isTarget)
  end
end

function UINEventComebackFundItem:GetConbackFundLevel()
  return self._fundLevel
end

function UINEventComebackFundItem:GetTargetItemCount()
  return self._targetItemCount
end

function UINEventComebackFundItem:__OnClickItem()
  if self._clickEvent ~= nil then
    self._clickEvent(self._fundLevel)
  end
end

return UINEventComebackFundItem
