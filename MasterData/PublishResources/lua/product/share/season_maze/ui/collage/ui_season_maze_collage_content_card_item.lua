_class("UISeasonMazeCollageContentCardItem", UICustomWidget)
UISeasonMazeCollageContentCardItem = UISeasonMazeCollageContentCardItem

function UISeasonMazeCollageContentCardItem:OnShow()
  self:InitWidget()
end

function UISeasonMazeCollageContentCardItem:InitWidget()
  self.lockGo = self:GetGameObject("lock")
  self.redGo = self:GetGameObject("red")
  local cardPool = self:GetUIComponent("UISelectObjectPath", "cardItem")
  self._cardItem = cardPool:SpawnObject("UISeasonMazeCardItem")
  self._txtLock = self:GetUIComponent("UILocalizationText", "txtLock")
  self._tipPosTrans = self:GetGameObject("tipPos").transform
  self._gameObject = self:GetGameObject()
  self._gameObject:SetActive(false)
end

function UISeasonMazeCollageContentCardItem:SetData(d, rowIndex, clickCb)
  self._gameObject:SetActive(false)
  self._data = d
  self._itemId = self._data:GetCfgId()
  self._clickCb = clickCb
  self._cardItem:SetData(0, self._itemId, function(p)
    self:OnItemClicked()
  end)
  local bLock = not self._data:GetUnlock()
  self.lockGo:SetActive(bLock)
  if bLock then
    self._txtLock:SetText(StringTable.Get("str_season_maze_enter_handbook_cond_desc", self._data:GetUnLockLv()))
  end
  self.redGo:SetActive(self._data:GetNew())
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

function UISeasonMazeCollageContentCardItem:OnItemClicked()
  if self._data:GetNew() then
    self._data:SetNewAsRead()
    self.redGo:SetActive(false)
  end
  if self._clickCb then
    self._clickCb(self._itemId, self._tipPosTrans.position)
  end
end
