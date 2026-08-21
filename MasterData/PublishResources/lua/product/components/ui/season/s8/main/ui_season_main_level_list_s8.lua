_class("UISeasonMainLevelListS8", UICustomWidget)
UISeasonMainLevelListS8 = UISeasonMainLevelListS8

function UISeasonMainLevelListS8:OnShow(uiParams)
  self._active = true
  self:InitWidget()
  self:_SetShow(false)
  self:AttachEvent(GameEventType.BeforSeasonStoryLevelPlay, self._BeforeStoryPlay)
  self._anim:Play("uieff_UISeasonMainLevelListS8_LevelBtn_in")
end

function UISeasonMainLevelListS8:OnHide()
  self._active = false
  if self._player and self._player:IsPlaying() then
    self._player:Stop()
    self._player = nil
  end
  self:DetachEvent(GameEventType.BeforSeasonStoryLevelPlay, self._BeforeStoryPlay)
end

function UISeasonMainLevelListS8:InitWidget()
  self.progress = self:GetUIComponent("UILocalizationText", "progress")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._root = self:GetGameObject("root")
  self._levelBtn = self:GetGameObject("LevelBtn")
  self._levelBtnGroup = self:GetUIComponent("CanvasGroup", "LevelBtn")
  self._diffText = self:GetUIComponent("UILocalizationText", "DiffText")
  self._slider = self:GetUIComponent("RectTransform", "Slider")
  self._sliderImg = self:GetUIComponent("Image", "Slider")
  self._sliderBg = self:GetUIComponent("Image", "SliderBg")
  self._colors = {
    NormalText = Color(0.384, 0.333, 0.259),
    HardText = Color(0.416, 0.294, 0.184),
    NormalProgress = "#965D39",
    HardProgress = "#965D39"
  }
  local contentGrid = self:GetUIComponent("GridLayoutGroup", "Content")
  self._paddingTop = contentGrid.padding.top
  self._cellSizeY = contentGrid.cellSize.y
  self._cellSpaceY = contentGrid.spacing.y
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._viewPortHeight = self:GetUIComponent("RectTransform", "Viewport").rect.height
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._titleBg = self:GetUIComponent("Image", "Title")
  self._diffBg = self:GetUIComponent("Image", "DiffBg")
end

function UISeasonMainLevelListS8:SetData(obj)
  self._seasonObj = obj
end

function UISeasonMainLevelListS8:_Init()
  if self._inited then
    return
  end
  Log.info("初始换关卡列表")
  self._inited = true
  self._uiModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonManager = self._uiModule:SeasonManager()
end

function UISeasonMainLevelListS8:_BeforeStoryPlay()
  self._levelBtn:SetActive(true)
  self:_SetShow(false)
  self._levelBtnGroup.alpha = 1
end

function UISeasonMainLevelListS8:_OnDiffChanged(diff, onEnter)
  if not self._isShown then
    Log.info("难度改变但当前未显示，不处理:", diff)
    return
  end
  if self._curDiff == diff then
    Log.info("当前难度无需切换:", diff)
    return
  end
  Log.info("难度切换:", diff)
  self._curDiff = diff
  local passCount = 0
  local unlockCount = 0
  for i, level in ipairs(self._levels) do
    if level:IsPassDiff(self._curDiff) then
      passCount = passCount + 1
    end
    if level:IsUnlock() then
      unlockCount = unlockCount + 1
    end
  end
  for _, ui in ipairs(self._levelWidgets) do
    ui:RefreshByDiff(self._curDiff)
  end
  local atlas = self:GetAsset("UIS8Scene.spriteatlas", LoadType.SpriteAtlas)
  if self._curDiff == UISeasonLevelDiff.Normal then
    self._diffText:SetText(StringTable.Get("str_season_stage_diff_normal"))
    self.progress:SetText(string.format("<color=%s>%s</color>/%s", self._colors.NormalProgress, passCount, #self._levels))
  elseif self._curDiff == UISeasonLevelDiff.Hard then
    self._diffText:SetText(StringTable.Get("str_season_stage_diff_hard"))
    self.progress:SetText(string.format("<color=%s>%s</color>/%s", self._colors.HardProgress, passCount, #self._levels))
  end
  self:_ScrollTo(unlockCount, onEnter)
end

function UISeasonMainLevelListS8:_OnClickLevelItem(data)
  if data:IsUnlock() then
    if UISeasonHelper.TEST then
      local cfg = data:GetMissionCfgByDiff(self._curDiff)
      Log.warn("通过测试功能直接打开赛季关卡详情:", self._curDiff, cfg.ID)
      UISeasonHelper.TestShowUIStage(cfg.ID)
      return
    end
    Log.info("聚焦关卡路点:", data:GetCurMissionID())
    local cfg = data:GetMissionCfgByDiff(self._curDiff)
    self._uiModule:SeasonManager():AutoMoveToEventPoint(cfg.ID)
  else
    local cfg = data:GetMissionCfgByDiff(self._curDiff)
    local id = tonumber(cfg.NeedMission)
    local name = StringTable.Get(Cfg.cfg_season_mission[id].Name)
    ToastManager.ShowToast(StringTable.Get("str_season_level_pre_condition_tip", name))
  end
end

function UISeasonMainLevelListS8:_SetShow(show)
  self._isShown = show
  self._root:SetActive(show)
  if show then
    if not self._inited then
      self:_Init()
    end
    self:_Refresh()
    local curDiff = UISeasonLevelDiff.Normal
    self._curDiff = nil
    self:_OnDiffChanged(curDiff, true)
  end
end

function UISeasonMainLevelListS8:LevelBtnOnClick()
  self:StartTask(function(TT)
    self:Lock("uieff_UISeasonMainLevelListS8_DetailIn")
    self._levelBtn:SetActive(true)
    self._anim:Play("uieff_UISeasonMainLevelListS8")
    self:_SetShow(true)
    YIELD(TT, 725)
    self:UnLock("uieff_UISeasonMainLevelListS8_DetailIn")
  end, self)
end

function UISeasonMainLevelListS8:CloseBtnOnClick()
  self:StartTask(function(TT)
    self:Lock("uieff_UISeasonMainLevelListS8_end")
    self._levelBtn:SetActive(true)
    self._anim:Play("uieff_UISeasonMainLevelListS8_out")
    YIELD(TT, 725)
    self:_SetShow(false)
    self:UnLock("uieff_UISeasonMainLevelListS8_end")
  end, self)
end

function UISeasonMainLevelListS8:_Refresh()
  local points = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.MainLevel, true)
  local pointStorys = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.MainStory, true)
  local mode = self._seasonManager:SeasonMapManager():Mode()
  local tmp = {}
  for _, point in ipairs(points) do
    local cfgMode = point:GetMissionCfg().Mode
    if not cfgMode or table.icontains(cfgMode, mode) then
      tmp[#tmp + 1] = point
    end
  end
  for _, point in ipairs(pointStorys) do
    local cfgMode = point:GetMissionCfg().Mode
    if not cfgMode or table.icontains(cfgMode, mode) then
      tmp[#tmp + 1] = point
    end
  end
  points = tmp
  local obj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  local lineCpt = obj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._levels = {}
  for _, point in ipairs(points) do
    local cfg = point:GetMissionCfg()
    local group = cfg.GroupID
    local data = self._levels[group]
    if not data then
      data = UISeasonLevelData:New(group, point, lineCpt)
      self._levels[group] = data
    else
      data:AddDiffLevel(point)
    end
  end
  self._levels = table.toArray(self._levels)
  table.sort(self._levels, function(a, b)
    return a:GroupID() < b:GroupID()
  end)
  for i, level in ipairs(self._levels) do
    level:SetIndex(i)
    level:CheckUnlock()
  end
  if #self._levels ~= table.count(self._levels) then
    Log.exception("cfg_season_mission 配置错误, group不是连续的")
  end
  self._levelWidgets = self.content:SpawnObjects("UISeasonMainLevelListItemS8", #self._levels)
  
  local function onSelect(data)
    self:_OnClickLevelItem(data)
  end
  
  for i, level in ipairs(self._levels) do
    self._levelWidgets[i]:SetData(level, onSelect)
  end
end

function UISeasonMainLevelListS8:DiffOnClick()
  local diff
  if self._curDiff == UISeasonLevelDiff.Normal then
    diff = UISeasonLevelDiff.Hard
  else
    diff = UISeasonLevelDiff.Normal
  end
  self._uiModule:SetCurrentSeasonLevelDiff(diff)
end

function UISeasonMainLevelListS8:_ScrollTo(index, onEnter)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentRect)
  local height = self._contentRect.rect.height
  index = math.max(index, 1)
  local y = self._paddingTop + (self._cellSizeY + self._cellSpaceY) * (index - 1)
  y = Mathf.Clamp(y, 0, math.max(height - self._viewPortHeight, 0))
  self._contentRect.anchoredPosition = Vector2(0, y)
  if self._player and self._player:IsPlaying() then
    self._player:Stop()
    self._player = nil
  end
  if onEnter then
    self:StartTask(self._OnEnterAnim, self, index)
  else
    self:StartTask(self._OnSwitchDiffAnim, self, index)
  end
end

function UISeasonMainLevelListS8:_OnEnterAnim(TT, index)
  self:Lock("UISeasonMainLevelListS8_OnEnterAnim")
  if not self._active then
    return
  end
  local showCount = 6
  local from, to
  if showCount >= #self._levels then
    from = 1
    to = #self._levels
  else
    from = Mathf.Clamp(index, index, #self._levels - showCount)
    to = from + showCount
  end
  for i = from, to do
    local level = self._levelWidgets[i]
    level:PrepareAnim()
  end
  for i = from, to do
    local level = self._levelWidgets[i]
    if not (level and self._active) then
      break
    end
    level:PlayEnterAnim()
    YIELD(TT, 50)
  end
  self._levelBtn:SetActive(false)
  self:UnLock("UISeasonMainLevelListS8_OnEnterAnim")
end

function UISeasonMainLevelListS8:_OnSwitchDiffAnim(TT, index)
  self:Lock("UISeasonMainLevelListS8_OnSwitchDiffAnim")
  local showCount = 6
  local from, to
  if showCount >= #self._levels then
    from = 1
    to = #self._levels
  else
    from = Mathf.Clamp(index, index, #self._levels - showCount)
    to = from + showCount
  end
  for i = from, to do
    local level = self._levelWidgets[i]
    level:PrepareAnim()
  end
  for i = from, to do
    local level = self._levelWidgets[i]
    if not level then
      return
    end
    if not self._active then
      return
    end
    level:PlayEnterAnim()
    YIELD(TT, 50)
  end
  self._levelBtn:SetActive(false)
  if self._curDiff == UISeasonLevelDiff.Normal then
    self._anim:Play("uieff_UISeasonMainLevelListS3_switch_out")
  elseif self._curDiff == UISeasonLevelDiff.Hard then
    self._anim:Play("uieff_UISeasonMainLevelListS3_switch_in")
  end
  self:UnLock("UISeasonMainLevelListS8_OnSwitchDiffAnim")
end

function UISeasonMainLevelListS8:PlayEnterAnim()
end
