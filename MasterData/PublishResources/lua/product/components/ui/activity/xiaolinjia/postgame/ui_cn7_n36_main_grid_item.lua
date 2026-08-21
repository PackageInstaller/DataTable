_class("UICN7N36PostMainGridItem", Object)
UICN7N36PostMainGridItem = UICN7N36PostMainGridItem

function UICN7N36PostMainGridItem:Constructor(row, col, gameObject, isEmpty)
  self._row = row
  self._col = col
  self._gameObject = gameObject
  self._occupyObj = self._gameObject.transform:Find("occupy").gameObject
  self._greenObj = self._gameObject.transform:Find("green").gameObject
  self._redObj = self._gameObject.transform:Find("red").gameObject
  self._isEmpty = isEmpty
  self._occupy = isEmpty
  self._uiCustomEventListener = UICustomUIEventListener:New()
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(gameObject), UIEvent.Hovered, function(go)
    Log.debug("Hovered!!!!!!!!!!!!", self:GetX(), self:GetY())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN7N36PostGameBlockHovered, self)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(gameObject), UIEvent.BeginDrag, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN7N36PostGameBlockPress, self)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(gameObject), UIEvent.EndDrag, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN7N36PostGameBlockRelease, self)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(gameObject), UIEvent.Click, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN7N36PostGameBlockClick, self)
  end)
end

function UICN7N36PostMainGridItem:GetInstanceID()
  return self._gameObject:GetInstanceID()
end

function UICN7N36PostMainGridItem:SetOccupy(flag, atomicItemID, itemID)
  self._occupy = flag
  self._atomicItemID = atomicItemID
  self._itemID = itemID
  self._occupyObj:SetActive(self._occupy)
end

function UICN7N36PostMainGridItem:SetOccupyColor(flag)
  self._occupyObj:SetActive(flag)
end

function UICN7N36PostMainGridItem:ShowCheckColor(isPass)
  self._greenObj:SetActive(isPass)
  if not self._occupy then
    self._redObj:SetActive(not isPass)
  end
end

function UICN7N36PostMainGridItem:ClearCheckColor()
  self._greenObj:SetActive(false)
  self._redObj:SetActive(false)
end

function UICN7N36PostMainGridItem:GetAtomicItemID()
  return self._atomicItemID
end

function UICN7N36PostMainGridItem:GetItemID()
  return self._itemID
end

function UICN7N36PostMainGridItem:GetIsEmpty()
  return self._isEmpty
end

function UICN7N36PostMainGridItem:GetIsOccupy()
  return self._occupy
end

function UICN7N36PostMainGridItem:GetX()
  return self._row
end

function UICN7N36PostMainGridItem:GetY()
  return self._col
end

function UICN7N36PostMainGridItem:GetIsGuideBlock()
  return self._row == 2 and self._col == 2
end
