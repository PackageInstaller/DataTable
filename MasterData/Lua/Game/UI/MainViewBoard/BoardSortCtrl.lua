local BoardSortCtrl = class("BoardSortCtrl", BaseCtrl)
BoardSortCtrl._mapNodeConfig = {
  itemChar = {
    sCtrlName = "Game.UI.MainViewBoard.BoardCharCtrl"
  },
  eventDrag = {
    sNodeName = "btnSortItem",
    sComponentName = "UIDrag",
    callback = "OnUIDrag_Drag"
  },
  trSortItem = {
    sNodeName = "btnSortItem",
    sComponentName = "RectTransform"
  },
  raySortItem = {
    sNodeName = "btnSortItem",
    sComponentName = "Empty4Raycast"
  },
  rayDragEvent = {
    sNodeName = "btnDragEvent",
    sComponentName = "Empty4Raycast"
  },
  btnSortItem = {
    sNodeName = "btnSortItem",
    sComponentName = "Button",
    callback = "OnBtnClick_SortItem"
  },
  goEmpty = {}
}
BoardSortCtrl._mapEventConfig = {
  [EventId.BoardItemDragStart] = "OnBoardItemDragStart",
  [EventId.BoardItemDragEnd] = "OnBoardItemDragEnd"
}
local item_spacing = 15.6
local item_Width = 170

local function clamp(x, min, max)
  return math.max(math.min(x, max), min)
end

function BoardSortCtrl:InitSortingOrder(nSortOrder, goDragMin, goDragMax)
  self.nInitSortingOrder = nSortOrder
  self.goDragMin = goDragMin
  self.goDragMax = goDragMax
end

function BoardSortCtrl:RefreshSortItem(nId, nIndex)
  self.bEmpty = nId == nil
  self.nId = nId
  self.nIndex = nIndex
  self.nItemHeight = self.gameObject:GetComponent("RectTransform").rect.height
  self.nItemWidth = self.gameObject:GetComponent("RectTransform").rect.width
  self._mapNode.goEmpty.gameObject:SetActive(nil == nId)
  self._mapNode.itemChar.gameObject:SetActive(nil ~= nId)
  self._mapNode.eventDrag:SetDragEnable(not self.bEmpty)
  if nil ~= nId then
    self._mapNode.itemChar:SetItemSortData(nId, nIndex)
  end
  if nil ~= self.tweener then
    self.tweener:Kill()
    self.tweener = nil
  end
  self._mapNode.trSortItem.localPosition = Vector3(0, 0, 0)
  self.itemCanvas = self.gameObject:GetComponent("Canvas")
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

function BoardSortCtrl:GetItemBtnInstanceId()
  return self._mapNode.rayDragEvent.gameObject:GetInstanceID()
end

function BoardSortCtrl:PlayItemMoveAnim(nIndex)
  local nEndPosX = (self.nItemWidth + item_spacing) * (nIndex - self.nIndex)
  local endPos = Vector2(nEndPosX, 0)
  self.tweener = self._mapNode.trSortItem:DOAnchorPos(endPos, 0.1):SetUpdate(true)
end

function BoardSortCtrl:SetItemPos(dragPos)
  local localPos = GameUIUtils.ScreenPointToLocalPoint(dragPos, self.gameObject.transform)
  localPos.x = clamp(localPos.x, self.nDragMinPosX, self.nDragMaxPosX)
  self._mapNode.trSortItem.localPosition = Vector3(localPos.x, self.nItemHeight * 0.25, 0)
end

function BoardSortCtrl:CalDragRange()
  if nil == self.nDragMinPosX or nil == self.nDragMaxPosX then
    local transform = self.gameObject:GetComponent("Transform")
    self.nDragMinPosX = transform:InverseTransformPoint(self.goDragMin.position).x + item_Width / 2
    self.nDragMaxPosX = transform:InverseTransformPoint(self.goDragMax.position).x - item_Width / 2
  end
end

function BoardSortCtrl:OnUIDrag_Drag(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nLastPointerInsId = nil
    self:CalDragRange()
    self:SetItemPos(mDrag.EventData.position)
    self._mapNode.raySortItem.enabled = false
    self._mapNode.rayDragEvent.enabled = false
    EventManager.Hit(EventId.BoardItemDragStart, self.gameObject:GetInstanceID())
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self:SetItemPos(mDrag.EventData.position)
    local pointerObj = mDrag.EventData.pointerCurrentRaycast
    if nil ~= pointerObj and nil ~= pointerObj.gameObject then
      local nPointerInsId = pointerObj.gameObject:GetInstanceID()
      if nPointerInsId ~= self.nLastPointerInsId then
        self.nLastPointerInsId = nPointerInsId
        EventManager.Hit(EventId.BoardItemDragging, self:GetItemBtnInstanceId(), nPointerInsId)
      end
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    EventManager.Hit(EventId.BoardSelectItem, self.nId)
    EventManager.Hit(EventId.BoardItemDragEnd)
    NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder)
    self._mapNode.raySortItem.enabled = true
    self._mapNode.rayDragEvent.enabled = true
  end
end

function BoardSortCtrl:OnBtnClick_SortItem()
  EventManager.Hit(EventId.BoardSelectItem, self.nId)
end

function BoardSortCtrl:OnBoardItemDragStart(objInsId)
  self._mapNode.rayDragEvent.gameObject:SetActive(true)
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, true)
  NovaAPI.SetCanvasSortingName(self.itemCanvas, AllEnum.SortingLayerName.UI)
  if self.gameObject:GetInstanceID() ~= objInsId then
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 1)
  else
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 2)
  end
end

function BoardSortCtrl:OnBoardItemDragEnd()
  NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 1)
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

return BoardSortCtrl
