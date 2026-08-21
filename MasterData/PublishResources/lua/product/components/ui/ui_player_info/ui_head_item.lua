_class("UIHeadItem", UICustomWidget)
UIHeadItem = UIHeadItem

function UIHeadItem:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnPlayerChangeHeadItemClick, self.OnPlayerChangeHeadItemClick)
  self:AttachEvent(GameEventType.HideHeadRedPoint, self.HideHeadRedPoint)
end

function UIHeadItem:SetData(idx, headitem, isOpen, canUnLock, currid, callback)
  self:_GetComponents()
  if headitem then
    self._uiRoot:SetActive(true)
    self._idx = idx
    self._headItem = headitem
    self._headid = self._headItem.m_nImageID
    self._callback = callback
    self._isOpen = isOpen
    self._canUnLock = canUnLock
    self._isSelect = self._headid == currid
    self:_OnValue()
  else
    self._uiRoot:SetActive(false)
  end
end

function UIHeadItem:OnHide()
end

function UIHeadItem:_GetComponents()
  self._uiRoot = self:GetGameObject("icon")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._lock = self:GetGameObject("lock")
  self._select = self:GetGameObject("select")
  self._goRedPoint = self:GetGameObject("UICommonRedPoint")
end

function UIHeadItem:_OnValue()
  local cfg_head = Cfg.cfg_role_head_image[self._headid]
  if cfg_head then
    self._icon:LoadImage(cfg_head.Icon)
    HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._iconRect, cfg_head.Tag)
  else
    Log.fatal("###playerinfo - cfg_role_head_image is nil ! id ", self._headid)
  end
  self:Select(self._isSelect)
  self:CheckLockState()
  self:FlushRed()
end

function UIHeadItem:FlushRed()
  local red = false
  if not self._isOpen and self._canUnLock then
    red = true
  end
  self._goRedPoint:SetActive(red)
end

function UIHeadItem:bgOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end

function UIHeadItem:HideHeadRedPoint(id)
  if id == self._headid then
    self._goRedPoint:SetActive(false)
  end
end

function UIHeadItem:OnPlayerChangeHeadItemClick(headid)
  self._isSelect = headid == self._headid
  self:Select(self._isSelect)
end

function UIHeadItem:CheckLockState()
  local lock = true
  if self._isOpen then
    lock = false
  elseif self._canUnLock then
    lock = false
  end
  self._lock:SetActive(lock)
end

function UIHeadItem:Select(select)
  self._select:SetActive(select)
end
