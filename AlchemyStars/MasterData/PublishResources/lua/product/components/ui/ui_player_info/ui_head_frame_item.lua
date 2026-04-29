_class("UIHeadFrameItem", UICustomWidget)
UIHeadFrameItem = UIHeadFrameItem

function UIHeadFrameItem:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnPlayerChangeHeadFrameItemClick, self.OnPlayerChangeHeadFrameItemClick)
  self:AttachEvent(GameEventType.HideHeadFrameRedPoint, self.HideHeadFrameRedPoint)
end

function UIHeadFrameItem:SetData(idx, cfg_frame, isOpen, canUnLock, currid, callback)
  self:_GetComponents()
  if cfg_frame then
    self._uiRoot:SetActive(true)
    self._bg:SetActive(true)
    self._idx = idx
    self._isOpen = isOpen
    self._canUnLock = canUnLock
    self._cfg_frame = cfg_frame
    self._frameid = cfg_frame.ID
    self._callback = callback
    self._isSelect = self._frameid == currid
    self:_OnValue()
  else
    self._uiRoot:SetActive(false)
    self._bg:SetActive(false)
  end
end

function UIHeadFrameItem:OnHide()
end

function UIHeadFrameItem:_GetComponents()
  self._uiRoot = self:GetGameObject("icon")
  self._bg = self:GetGameObject("bg")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._lock = self:GetGameObject("lock")
  self._select = self:GetGameObject("select")
  self._default = self:GetGameObject("default")
  self._goRedPoint = self:GetGameObject("UICommonRedPoint")
end

function UIHeadFrameItem:_OnValue()
  self._icon:LoadImage(self._cfg_frame.Icon)
  self:Select(self._isSelect)
  self:CheckLockState()
  self._default:SetActive(self._idx == 1)
  self:FlushRed()
end

function UIHeadFrameItem:FlushRed()
  local red = false
  if not self._isOpen and self._canUnLock then
    red = true
  end
  self._goRedPoint:SetActive(red)
end

function UIHeadFrameItem:bgOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end

function UIHeadFrameItem:HideHeadFrameRedPoint(id)
  if id == self._frameid then
    self._goRedPoint:SetActive(false)
  end
end

function UIHeadFrameItem:OnPlayerChangeHeadFrameItemClick(id)
  self._isSelect = id == self._frameid
  self:Select(self._isSelect)
end

function UIHeadFrameItem:CheckLockState()
  local lock = true
  if self._isOpen then
    lock = false
  elseif self._canUnLock then
    lock = false
  end
  self._lock:SetActive(lock)
end

function UIHeadFrameItem:Select(select)
  self._select:SetActive(select)
end
