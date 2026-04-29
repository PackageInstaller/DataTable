_class("UIHeadBgItem", UICustomWidget)
UIHeadBgItem = UIHeadBgItem

function UIHeadBgItem:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnPlayerChangeHeadBgItemClick, self.OnPlayerChangeHeadBgItemClick)
end

function UIHeadBgItem:SetData(idx, headbgid, currid, callback)
  self:_GetComponents()
  if headbgid then
    self._uiRoot:SetActive(true)
    self._idx = idx
    self._headbgid = headbgid
    self._callback = callback
    self._isSelect = currid == self._headbgid
    self:_OnValue()
  else
    self._uiRoot:SetActive(false)
  end
end

function UIHeadBgItem:OnHide()
  self:DetachEvent(GameEventType.OnPlayerChangeHeadBgItemClick, self.OnPlayerChangeHeadBgItemClick)
end

function UIHeadBgItem:_GetComponents()
  self._uiRoot = self:GetGameObject("icon")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._select = self:GetGameObject("select")
end

function UIHeadBgItem:_OnValue()
  local cfg_head_bg = Cfg.cfg_player_head_bg[self._headbgid]
  if cfg_head_bg then
    self._icon:LoadImage(cfg_head_bg.Icon)
  else
    Log.fatal("###playerinfo - cfg_player_head_bg is nil ! id ", self._headbgid)
  end
  self:Select(self._isSelect)
end

function UIHeadBgItem:bgOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end

function UIHeadBgItem:OnPlayerChangeHeadBgItemClick(headbgid)
  self._isSelect = headbgid == self._headbgid
  self:Select(self._isSelect)
end

function UIHeadBgItem:Select(select)
  self._select:SetActive(select)
end
