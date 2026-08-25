local BattleCardShotcutDragDropMgr = NewClass("BattleCardShotcutDragDropMgr")
local Input = CS.UnityEngine.Input
local GetMouseButton = CS.UnityEngine.Input.GetMouseButton
local WorldToScreenPoint = CS.UnityEngine.RectTransformUtility.WorldToScreenPoint
local Vec2Temp = CS.UnityEngine.Vector2(0, 0)

function BattleCardShotcutDragDropMgr:ctor()
  self.draggingCardItem = nil
end

function BattleCardShotcutDragDropMgr:IsMouseButtonDown()
  return GetMouseButton(0) or GetMouseButton(1)
end

function BattleCardShotcutDragDropMgr:GetCardInitScerrnPositionPosition(cardItem)
  if not cardItem then
    return
  end
  local cardUI = cardItem.cardUI
  local uid = cardItem:GetUid()
  local newPos = cardUI:GetCardPosAndAngle(uid)
  local savePos = cardItem.rootRectTransform.anchoredPosition
  cardItem:SetPos(newPos)
  local worldPoint = cardItem.rootRectTransform.position
  local uiCamera = CameraManager:GetUICamera()
  local screenPoint = WorldToScreenPoint(uiCamera, worldPoint)
  cardItem:SetPos(savePos)
  return screenPoint
end

function BattleCardShotcutDragDropMgr:GetDraggingCardItem()
  return self.draggingCardItem
end

function BattleCardShotcutDragDropMgr:ReplaceDragCard(cardItem)
  if cardItem == self.draggingCardItem or not self:IsCardItemValid() then
    return
  end
  self:BeginDragCard(cardItem)
end

function BattleCardShotcutDragDropMgr:BeginDragCard(cardItem)
  if self:IsCardItemValid() then
    self:StopDragCard()
  else
    UpdateBeat.Instance:Remove(self.Update, self)
  end
  self.draggingCardItem = cardItem
  local pos = self:GetCardInitScerrnPositionPosition(cardItem)
  local pointerData = self:UpdatePointerData(pos)
  if not cardItem:OnPointerDown(pointerData) then
    self.draggingCardItem = nil
    return
  end
  cardItem:OnBeginDrag(pointerData)
  UpdateBeat.Instance:Add(self.Update, self)
end

function BattleCardShotcutDragDropMgr:StopDragCard()
  UpdateBeat.Instance:Remove(self.Update, self)
  if self:IsCardItemValid() then
    local pos = self:GetCardInitScerrnPositionPosition(self.draggingCardItem)
    local pointerData = self:UpdatePointerData(pos)
    self:_EndDragCard(pointerData, true)
  end
  self.draggingCardItem = nil
end

function BattleCardShotcutDragDropMgr:_EndDragCard(pointerData, canceled)
  UpdateBeat.Instance:Remove(self.Update, self)
  if self:IsCardItemValid() then
    self.draggingCardItem:OnEndDrag(pointerData)
    self.draggingCardItem:OnPointerUp(pointerData, canceled)
  end
  self.draggingCardItem = nil
end

function BattleCardShotcutDragDropMgr:Update()
  if not self:IsCardItemValid() then
    self.draggingCardItem = nil
    UpdateBeat.Instance:Remove(self.Update, self)
    return
  end
  local mousePosition = Input.mousePosition
  Vec2Temp.x = mousePosition.x
  Vec2Temp.y = mousePosition.y
  local pointerData = self:UpdatePointerData(Vec2Temp)
  self.draggingCardItem:OnDrag(pointerData)
  if GetMouseButton(0) then
    self:_EndDragCard(pointerData, false)
  elseif GetMouseButton(1) then
    self:_EndDragCard(pointerData, true)
  end
  mousePosition = nil
end

function BattleCardShotcutDragDropMgr:IsCardItemValid()
  return self.draggingCardItem ~= nil and nil ~= self.draggingCardItem.ui and not IsNil(self.draggingCardItem.ui.uiNode)
end

function BattleCardShotcutDragDropMgr:Dispose()
  self.draggingCardItem = nil
  self.shortCutKey = nil
  self.pointerEventData = nil
  UpdateBeat.Instance:Remove(self.Update, self)
end

function BattleCardShotcutDragDropMgr:CreatePointerData()
  if self.pointerEventData then
    return self.pointerEventData
  end
  self.pointerEventData = CS.UnityEngine.EventSystems.PointerEventData(CS.UnityEngine.EventSystems.EventSystem.current)
  return self.pointerEventData
end

function BattleCardShotcutDragDropMgr:UpdatePointerData(pos)
  local pointerEventData = self:CreatePointerData()
  if pointerEventData then
    pointerEventData.position = pos
  end
  return pointerEventData
end

BattleCardShotcutDragDropMgr.Instance = BattleCardShotcutDragDropMgr()
return BattleCardShotcutDragDropMgr
