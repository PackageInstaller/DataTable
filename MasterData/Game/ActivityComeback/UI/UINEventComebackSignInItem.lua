local UINEventComebackSignInItem = class("UINEventComebackSignInItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINEventComebackSignInItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.__OnClickReview)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINEventComebackSignInItem:InitCombackSingIn(awardCfg, clickEvent)
  self._day = awardCfg.day
  self._clickEvent = clickEvent
  self.ui.img_Date:SetIndex(self._day - 1)
  self._rewardPool:HideAll()
  for i, itemId in ipairs(awardCfg.awardIds) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg.type ~= eItemType.BattlePassPoint then
      local itemCount = awardCfg.awardCounts[i]
      local item = self._rewardPool:GetOne()
      item:InitItemWithCount(itemCfg, itemCount)
    end
  end
end

function UINEventComebackSignInItem:RefreshCombackSignItemState(curDay, isAllowReceive)
  local isPicked = curDay > self._day
  for _, item in ipairs(self._rewardPool.listItem) do
    item:SetPickedUIActive(isPicked)
  end
  if isPicked then
    self.ui.obj_Received:SetActive(true)
    self.ui.obj_NotReceive:SetActive(false)
    self.ui.btn_Receive.gameObject:SetActive(false)
    self.ui.img_NotReceive.gameObject:SetActive(true)
    local color = self.ui.img_NotReceive.color
    color.a = 0.3
    self.ui.img_NotReceive.color = color
    self.ui.bottom:SetIndex(0)
    return
  end
  self.ui.obj_Received:SetActive(false)
  local canReceive = self._day == curDay and isAllowReceive
  self.ui.obj_NotReceive:SetActive(not canReceive)
  self.ui.btn_Receive.gameObject:SetActive(canReceive)
  self.ui.bottom:SetIndex(canReceive and 1 or 0)
  self.ui.img_NotReceive.gameObject:SetActive(not canReceive)
  if not canReceive then
    local color = self.ui.img_NotReceive.color
    color.a = 1
    self.ui.img_NotReceive.color = color
  end
end

function UINEventComebackSignInItem:__OnClickReview()
  if self._clickEvent ~= nil then
    self._clickEvent(self._day)
  end
end

return UINEventComebackSignInItem
