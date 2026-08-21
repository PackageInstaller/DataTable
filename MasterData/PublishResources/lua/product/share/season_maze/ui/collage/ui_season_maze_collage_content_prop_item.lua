_class("UISeasonMazeCollageContentPropItem", UICustomWidget)
UISeasonMazeCollageContentPropItem = UISeasonMazeCollageContentPropItem

function UISeasonMazeCollageContentPropItem:OnShow()
  self:InitWidget()
end

function UISeasonMazeCollageContentPropItem:InitWidget()
  self.lockGo = self:GetGameObject("lock")
  self.newGo = self:GetGameObject("new")
  self.txtName = self:GetUIComponent("UILocalizationText", "name1")
  self.txtName2 = self:GetUIComponent("UILocalizationText", "name2")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.imgBg = self:GetUIComponent("Image", "colorBg")
  self._txtLock = self:GetUIComponent("UILocalizationText", "txtLock")
  self._gameObject = self:GetGameObject()
  self._gameObject:SetActive(false)
end

function UISeasonMazeCollageContentPropItem:SetData(d, rowIndex, clickCb)
  self._gameObject:SetActive(false)
  self._data = d
  self._itemId = self._data:GetCfgId()
  self._clickCb = clickCb
  local cfg = self._data:GetCfg()
  self.icon:LoadImage(cfg.Icon)
  local strName = StringTable.Get(cfg.Name)
  self.txtName:SetText(strName)
  self.txtName2:SetText(strName)
  self.newGo:SetActive(self._data:GetNew())
  local bLock = not self._data:GetUnlock()
  self.lockGo:SetActive(bLock)
  if bLock then
    self._txtLock:SetText(StringTable.Get("str_season_maze_enter_handbook_cond_desc", self._data:GetUnLockLv()))
  end
  if rowIndex and rowIndex < 3 then
    local delta = rowIndex * 70
    if delta == 0 then
      self._gameObject:SetActive(true)
    else
      local timerEvent = GameGlobal.Timer():AddEventTimes(delta, TimerTriggerCount.Once, function()
        self._gameObject:SetActive(true)
      end)
    end
  else
    self._gameObject:SetActive(true)
  end
end

function UISeasonMazeCollageContentPropItem:PropItemOnClick()
  if self._data:GetNew() then
    self._data:SetNewAsRead()
    self.newGo:SetActive(false)
  end
  if self._clickCb then
    self._clickCb(self._itemId, self.lockGo.transform.position)
  end
end
