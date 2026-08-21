_class("UISeasonMainLevelList", UICustomWidget)
UISeasonMainLevelList = UISeasonMainLevelList

function UISeasonMainLevelList:OnShow(uiParams)
  self._active = true
  self:InitWidget()
  self:_SetShow(false)
end

function UISeasonMainLevelList:OnHide()
  self._active = false
  if self._player and self._player:IsPlaying() then
    self._player:Stop()
    self._player = nil
  end
end

function UISeasonMainLevelList:InitWidget()
  self.progress = self:GetUIComponent("UILocalizationText", "progress")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._root = self:GetGameObject("root")
  self._levelBtn = self:GetGameObject("LevelBtn")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._sliderNormal = self:GetUIComponent("Image", "SliderNormal")
  self._sliderHard = self:GetUIComponent("Image", "SliderHard")
  self._normal = self:GetUIComponent("UILocalizationText", "normal")
  self._hard = self:GetUIComponent("UILocalizationText", "hard")
  self._colors = {
    NormalText = Color(0.8235294117647058, 0.8235294117647058, 0.8235294117647058),
    NormalSelect = Color(0.27450980392156865, 0.15294117647058825, 0.043137254901960784),
    HardSelect = Color(0.22745098039215686, 0.09019607843137255, 0.06274509803921569),
    NormalProgress = "#ce9e41",
    HardProgress = "#cb5039"
  }
  local contentGrid = self:GetUIComponent("GridLayoutGroup", "Content")
  self._paddingTop = contentGrid.padding.top
  self._cellSizeY = contentGrid.cellSize.y
  self._cellSpaceY = contentGrid.spacing.y
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._viewPortHeight = self:GetUIComponent("RectTransform", "Viewport").rect.height
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self._titleBg = self:GetUIComponent("Image", "titleBg")
  self._atlas = self:GetAsset("UISeasonMain.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonMainLevelList:SetData(obj)
  self._seasonObj = obj
end

function UISeasonMainLevelList:_Init()
  if self._inited then
    return
  end
  Log.info("初始换关卡列表")
  self._inited = true
  self._uiModule = GameGlobal.GetUIModule(SeasonModule)
  local uiModule = GameGlobal.GetUIModule(SeasonModule)
  local points = uiModule:SeasonManager():SeasonMapManager():GetEventPointsByType(SeasonEventPointType.MainLevel, true)
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
  for i, level in ipairs(self._levels) do
    level:CheckUnlock()
  end
  if #self._levels ~= table.count(self._levels) then
    Log.exception("cfg_season_mission配置错误, group不是连续的")
  end
  self._levelWidgets = self.content:SpawnObjects("UISeasonMainLevelListItem", #self._levels)
  
  local function onSelect(data)
    self:_OnClickLevelItem(data)
  end
  
  for i, level in ipairs(self._levels) do
    self._levelWidgets[i]:SetData(level, onSelect)
  end
  self:AttachEvent(GameEventType.UISeasonOnLevelDiffChanged, self._OnDiffChanged)
end

function UISeasonMainLevelList:_OnDiffChanged(diff, onEnter)
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
  if self._curDiff == UISeasonLevelDiff.Normal then
    self._normal.color = self._colors.NormalSelect
    self._hard.color = self._colors.NormalText
    self._sliderNormal.color = Color(1, 1, 1, 1)
    self._sliderHard.color = Color(1, 1, 1, 0)
    self._bg:LoadImage("exp_s1_map_di12")
    self.progress:SetText(string.format("<color=%s>%s</color>/%s", self._colors.NormalProgress, passCount, #self._levels))
    self._titleBg.sprite = self._atlas:GetSprite("exp_s1_map_di04")
  elseif self._curDiff == UISeasonLevelDiff.Hard then
    self._normal.color = self._colors.NormalText
    self._hard.color = self._colors.HardSelect
    self._sliderNormal.color = Color(1, 1, 1, 0)
    self._sliderHard.color = Color(1, 1, 1, 1)
    self._bg:LoadImage("exp_s1_map_di13")
    self.progress:SetText(string.format("<color=%s>%s</color>/%s", self._colors.HardProgress, passCount, #self._levels))
    self._titleBg.sprite = self._atlas:GetSprite("exp_s1_map_di05")
  end
  self:_ScrollTo(unlockCount, onEnter)
end

function UISeasonMainLevelList:_OnClickLevelItem(data)
  if data:IsUnlock() then
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

function UISeasonMainLevelList:_SetShow(show)
  self._isShown = show
  self._root:SetActive(show)
  self._levelBtn:SetActive(not show)
  if show then
    if not self._inited then
      self:_Init()
    end
    local curDiff = self._uiModule:GetCurrentSeasonLevelDiff()
    self._curDiff = nil
    self:_OnDiffChanged(curDiff, true)
  end
end

function UISeasonMainLevelList:LevelBtnOnClick()
  self:_SetShow(true)
end

function UISeasonMainLevelList:CloseBtnOnClick()
  local tl = EZTL_Sequence:New({
    EZTL_PlayAnimation:New(self._anim, "uianim_UISeasonMainLevelList_out", "淡出"),
    EZTL_Callback:New(function()
      self:_SetShow(false)
    end)
  })
  self._player = EZTL_Player:New()
  self._player:Play(tl)
end

function UISeasonMainLevelList:DiffOnClick()
  local diff
  if self._curDiff == UISeasonLevelDiff.Normal then
    diff = UISeasonLevelDiff.Hard
  else
    diff = UISeasonLevelDiff.Normal
  end
  self._uiModule:SetCurrentSeasonLevelDiff(diff)
end

function UISeasonMainLevelList:_ScrollTo(index, onEnter)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentRect)
  local height = self._contentRect.rect.height
  local y = self._paddingTop + (self._cellSizeY + self._cellSpaceY) * (index - 1)
  y = Mathf.Clamp(y, 0, height - self._viewPortHeight)
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

function UISeasonMainLevelList:_OnEnterAnim(TT, index)
  self._anim:Play("uianim_UISeasonMainLevelList_in")
  if not self._active then
    return
  end
  local showCount = 6
  local from = Mathf.Clamp(index, index, #self._levels - showCount)
  for i = from, from + showCount do
    local level = self._levelWidgets[i]
    level:PrepareAnim()
  end
  for i = from, from + showCount do
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
end

function UISeasonMainLevelList:_OnSwitchDiffAnim(TT, index)
  local showCount = 6
  local from = Mathf.Clamp(index, index, #self._levels - showCount)
  for i = from, from + showCount do
    local level = self._levelWidgets[i]
    level:PrepareAnim()
  end
  for i = from, from + showCount do
    local level = self._levelWidgets[i]
    if not level then
      return
    end
    if not self._active then
      return
    end
    level:PlaySwitchAnim()
    YIELD(TT, 50)
  end
end
