local base = UIBaseNode
local UINReinforceCardNormalItem = class("UINReinforceCardNormalItem", base)
local UINReinforceCardDataItem = require("Game.Reinforce.UI.CardSet.Card.UINReinforceCardDataItem")
local UINRfCardSetRoomItem = require("Game.Reinforce.UI.CardSet.UINRfCardSetRoomItem")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local cs_EventTriggerListener = CS.EventTriggerListener

function UINReinforceCardNormalItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickRoot)
  self.cardDataItem = UINReinforceCardDataItem.New()
  self.cardDataItem:Init(self.ui.card)
end

function UINReinforceCardNormalItem:InitCardNormalItem(card, index, isFinally, resloader, clickCallback)
  self._rfCardData = card
  self.isFinally = isFinally
  self.index = index
  self.resloader = resloader
  self.clickCallback = clickCallback
  self:RefreshNormalItem()
end

function UINReinforceCardNormalItem:InitCardNormalItemEvent(startDragFunc, dragFunc, endDragFunc, pointEnterFunc, pointExitFunc)
  local pageChangeEventTrigger = cs_EventTriggerListener.Get(self.ui.item)
  pageChangeEventTrigger:onBeginDrag("+", startDragFunc)
  pageChangeEventTrigger:onEndDrag("+", endDragFunc)
  pageChangeEventTrigger:onDrag("+", dragFunc)
  pageChangeEventTrigger:onEnter("+", pointEnterFunc)
  pageChangeEventTrigger:onExit("+", pointExitFunc)
end

function UINReinforceCardNormalItem:SetNormalMask(bool)
  self.ui.obj_Mask:SetActive(bool)
  self:SetDrawRaycastOpen(not bool)
end

function UINReinforceCardNormalItem:GetNormalItemTexture()
  return self.cardDataItem:GetRfCdBgTexture()
end

function UINReinforceCardNormalItem:ResetCardData(card)
  self._rfCardData = card
  self:RefreshNormalItem()
end

function UINReinforceCardNormalItem:RefreshNormalItem()
  self:RefreshCardNormal()
  self:RefreshCardUpData()
end

function UINReinforceCardNormalItem:RefreshCardNormal()
  self.ui.obj_line:SetActive(not self.isFinally)
  self.cardDataItem:InitCardDataItem(self._rfCardData, self.resloader)
end

function UINReinforceCardNormalItem:RefreshCardUpData()
  self._roomItemPool = self._roomItemPool or UIItemPool.New(UINRfCardSetRoomItem, self.ui.roomItem, false)
  self._roomItemPool:HideAll()
  self.ui.tex_Order:SetIndex(0, string.format("%02d", self.index))
  local tagIndex = 2
  local isSupport = false
  self.ui.obj_roomNoSet:SetActive(self._rfCardData == nil)
  if self._rfCardData then
    if self._rfCardData:GetRfCdType() == eReinforce.eRfCardType.System then
      tagIndex = 0
      self:InitRfCdRoomSys()
    else
      tagIndex = 1
      self:InitRfCdRoomFac()
      isSupport = self._rfCardData:GetIsSupport()
    end
  end
  self.ui.tex_Tag:SetIndex(tagIndex)
  self.ui.img_Bar.color = self._rfCardData and self.ui.col_select or self.ui.col_notSelect
  self.ui.img_TagBg.color = self._rfCardData and self.ui.col_select or self.ui.col_notSelect
  self.ui.obj_FriendSupport:SetActive(tagIndex == 1)
  self.ui.obj_FriendIcon:SetActive(isSupport)
end

function UINReinforceCardNormalItem:GetCardInfiniteCoe()
  if self._rfCardData == nil then
    return nil
  end
  return self._rfCardData:GetRfCdInfiniteCoe()
end

function UINReinforceCardNormalItem:GetCurRoomGroup()
  if self._rfCardData == nil then
    return nil
  end
  return self._rfCardData:GetRfCdRoomGroup()
end

function UINReinforceCardNormalItem:InitRfCdEmptyRoom()
  if self._rfCardData == nil then
  end
end

function UINReinforceCardNormalItem:SetDrawRaycastOpen(bool)
  self.ui.draw_item.raycastTarget = bool
end

function UINReinforceCardNormalItem:InitRfCdRoomSys()
  local curRoomList = self._rfCardData:GetRfCdRoomGroup()
  local maxRoomList = self._rfCardData:GetRfCdRoomGroupMax()
  if self._rfCardData == nil or #maxRoomList == 0 then
    for i = 1, 2 do
      local roomItem = self._roomItemPool:GetOne()
      roomItem:InitRfCardSetRoomItem(i, 0, self.resloader, false)
    end
    return
  end
  for i = 1, 2 do
    local isLock = curRoomList[i] == nil
    local roomItem = self._roomItemPool:GetOne()
    roomItem:InitRfCardSetRoomItem(i, maxRoomList[i] or 0, self.resloader, isLock)
  end
end

function UINReinforceCardNormalItem:InitRfCdRoomFac()
  local curRoomList = self._rfCardData:GetRfCdRoomGroup()
  if self._rfCardData == nil or #curRoomList == 0 then
    for i = 1, 2 do
      local roomItem = self._roomItemPool:GetOne()
      roomItem:InitRfCardSetRoomItem(i, 0, self.resloader, false)
    end
    return
  end
  for i = 1, 2 do
    local isLock = curRoomList[i] == nil
    local roomItem = self._roomItemPool:GetOne()
    roomItem:InitRfCardSetRoomItem(i, curRoomList[i] or 0, self.resloader, isLock)
  end
end

function UINReinforceCardNormalItem:PlayItemTween(delay, constTime)
  return self.ui.item_group:DOFade(0, constTime):SetDelay(delay):From()
end

function UINReinforceCardNormalItem:OnClickRoot()
  if self.clickCallback then
    self.clickCallback()
  end
end

function UINReinforceCardNormalItem:OnDelete()
end

return UINReinforceCardNormalItem
