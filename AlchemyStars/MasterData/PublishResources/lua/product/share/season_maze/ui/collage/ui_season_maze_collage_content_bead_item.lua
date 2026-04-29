_class("UISeasonMazeCollageContentBeadItem", UICustomWidget)
UISeasonMazeCollageContentBeadItem = UISeasonMazeCollageContentBeadItem

function UISeasonMazeCollageContentBeadItem:OnShow()
  self:InitWidget()
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonMazeCollageContentBeadItem:InitWidget()
  self.lockGo = self:GetGameObject("lock")
  self.newGo = self:GetGameObject("new")
  self.txtName = self:GetUIComponent("UILocalizationText", "name1")
  self.txtName2 = self:GetUIComponent("UILocalizationText", "name2")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.imgBg = self:GetUIComponent("Image", "colorBg")
  self.imgType = self:GetUIComponent("Image", "imgType")
  self._starGO = {}
  self._starGO[1] = self:GetGameObject("Star1")
  self._starGO[2] = self:GetGameObject("Star2")
  self._starGO[3] = self:GetGameObject("Star3")
  self._txtLock = self:GetUIComponent("UILocalizationText", "txtLock")
  self._gameObject = self:GetGameObject()
  self._gameObject:SetActive(false)
end

function UISeasonMazeCollageContentBeadItem:SetData(d, rowIndex, clickCb)
  self._gameObject:SetActive(false)
  self._data = d
  self._itemId = self._data:GetCfgId()
  self._clickCb = clickCb
  local cfg = self._data:GetCfg()
  local strName = StringTable.Get(cfg.Name)
  self.txtName:SetText(strName)
  self.txtName2:SetText(strName)
  self.icon:LoadImage(cfg.Icon)
  self.newGo:SetActive(self._data:GetNew())
  local bLock = not self._data:GetUnlock()
  self.lockGo:SetActive(bLock)
  if bLock then
    local preUnlock, level = self._data:GetPreConditionUnlock()
    if not preUnlock then
      self._txtLock:SetText(StringTable.Get("str_season_maze_enter_bead_book_lock_desc", level))
    else
      self._txtLock:SetText(StringTable.Get("str_season_maze_enter_handbook_cond_desc", self._data:GetUnLockLv()))
    end
  end
  self.imgType.sprite = self._atlas:GetSprite(self:_GetTypeSprite(cfg.Type))
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
  for key, value in ipairs(self._starGO) do
    value:SetActive(key < cfg.Lv)
  end
end

function UISeasonMazeCollageContentBeadItem:BeadItemOnClick()
  if self._data:GetNew() then
    self._data:SetNewAsRead()
    self.newGo:SetActive(false)
  end
  if self._clickCb then
    self._clickCb(self._itemId, self.lockGo.transform.position)
  end
end

function UISeasonMazeCollageContentBeadItem:_GetTypeSprite(type)
  if type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "thread_junei_zdz01"
  elseif type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "thread_junei_zdz02"
  elseif type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "thread_junei_zdz03"
  end
  return "thread_junei_zdz03"
end
