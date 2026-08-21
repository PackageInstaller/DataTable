_class("UISeasonMazeCollageContentRelicItem", UICustomWidget)
UISeasonMazeCollageContentRelicItem = UISeasonMazeCollageContentRelicItem

function UISeasonMazeCollageContentRelicItem:OnShow()
  self:InitWidget()
end

function UISeasonMazeCollageContentRelicItem:InitWidget()
  self.lockGo = self:GetGameObject("lock")
  local relickPool = self:GetUIComponent("UISelectObjectPath", "relicItem")
  self._relectItem = relickPool:SpawnObject("UISeasonMazeRelicItem")
  self._relectItem:DisableAnimation()
  self._txtLock = self:GetUIComponent("UILocalizationText", "txtLock")
  self._txtname = self:GetUIComponent("UILocalizationText", "txtname")
  self._redGo = self:GetGameObject("red")
  self._tipPosTrans = self:GetGameObject("tipPos").transform
  self._gameObject = self:GetGameObject()
  self._gameObject:SetActive(false)
end

function UISeasonMazeCollageContentRelicItem:SetData(d, rowIndex, clickCb)
  self._gameObject:SetActive(false)
  self._data = d
  self._itemId = self._data:GetCfgId()
  self._clickCb = clickCb
  local item = Cfg.cfg_item[self._itemId]
  self._txtname:SetText(StringTable.Get(item.Name))
  self._relectItem:SetData(0, self._itemId, function(index)
    self:OnItemClicked(index)
  end, false)
  self._redGo:SetActive(self._data:GetNew())
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

function UISeasonMazeCollageContentRelicItem:OnItemClicked(index)
  if self._data:GetNew() then
    self._data:SetNewAsRead()
    self._redGo:SetActive(false)
  end
  if self._clickCb then
    self._clickCb(self._itemId, self._tipPosTrans.position)
  end
end
