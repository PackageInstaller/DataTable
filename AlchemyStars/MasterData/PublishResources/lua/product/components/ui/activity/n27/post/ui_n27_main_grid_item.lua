_class("UIN27MainGridItem", Object)
UIN27MainGridItem = UIN27MainGridItem

function UIN27MainGridItem:Constructor(row, col, gameObject)
  self._row = row
  self._col = col
  self._gameObject = gameObject
  self._occupyObj = self._gameObject.transform:Find("occupy").gameObject
  self._greenObj = self._gameObject.transform:Find("green").gameObject
  self._redObj = self._gameObject.transform:Find("red").gameObject
  self._occupy = false
  self._uiCustomEventListener = UICustomUIEventListener:New()
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(gameObject), UIEvent.Hovered, function(go)
    Log.debug("Hovered!!!!!!!!!!!!", self:GetX(), self:GetY())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN27PostGameBlockHovered, self)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(gameObject), UIEvent.Press, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN27PostGameBlockPress, self)
  end)
  self._uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(gameObject), UIEvent.Release, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN27PostGameBlockRelease, self)
  end)
end

function UIN27MainGridItem:SetOccupy(flag, atomicItemID, itemID)
  self._occupy = flag
  self._atomicItemID = atomicItemID
  self._itemID = itemID
  self._occupyObj:SetActive(self._occupy)
end

function UIN27MainGridItem:SetOccupyColor(flag)
  self._occupyObj:SetActive(flag)
end

function UIN27MainGridItem:ShowCheckColor(isPass)
  self._greenObj:SetActive(isPass)
  if not self._occupy then
    self._redObj:SetActive(not isPass)
  end
end

function UIN27MainGridItem:ClearCheckColor()
  self._greenObj:SetActive(false)
  self._redObj:SetActive(false)
end

function UIN27MainGridItem:GetAtomicItemID()
  return self._atomicItemID
end

function UIN27MainGridItem:GetItemID()
  return self._itemID
end

function UIN27MainGridItem:GetIsOccupy()
  return self._occupy
end

function UIN27MainGridItem:GetX()
  return self._row
end

function UIN27MainGridItem:GetY()
  return self._col
end
