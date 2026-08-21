require("ui_side_enter_center_content_base")
_class("UIActivityN4CC", UISideEnterCenterContentBase)
UIActivityN4CC = UIActivityN4CC

function UIActivityN4CC:DoInit()
  self._campaign = self._data
  self._context = UIActivityN4ConText:New()
  self._context:SetComponent(self._campaign)
  self.componentId = self._context:GetComponentId()
  self.componentInfo = self._context:GetComponentInfo()
  self.component = self._context:GetComponent()
  self:_Init()
  self:InitWidget()
end

function UIActivityN4CC:_Init()
  self._levelsData = {}
  self.levelNum = 4
  local cfgs = Cfg.cfg_component_challenge_mission({
    ComponentID = self.componentId
  })
  if not cfgs or #cfgs < 1 then
    Log.error("UIActivityN4CC cfg_component_challenge_mission don't have data with ComponnetID ", self.componentId)
    return
  end
  for k, cfg in pairs(cfgs) do
    local levelIndex = cfg.LeveIndex
    local levelData = self._levelsData[levelIndex]
    if not levelData then
      levelData = {}
      self._levelsData[levelIndex] = levelData
    end
    levelData[cfg.HardID] = cfg
  end
end

function UIActivityN4CC:DoShow(uiParams)
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self._spine:LoadSpine("n4cn_kv_1_spine_idle")
  self:RefreshLevels(true)
  self:StartCheckActivityEnd()
  self:_CheckGuide()
end

function UIActivityN4CC:_CheckGuide()
  self:Lock("UIActivityN4CC")
  self:StartTask(function(TT)
    YIELD(TT, 1000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISideEnterCenterController_N4CC)
    YIELD(TT, 33)
    local guideModule = GameGlobal.GetModule(GuideModule)
    if guideModule:IsGuideProcess(8114001) then
      self._guideLevel1BtnGo:SetActive(true)
    end
    self:UnLock("UIActivityN4CC")
  end, self)
end

function UIActivityN4CC:DoHide()
  self:CancelTimer()
end

function UIActivityN4CC:DoDestroy()
end

function UIActivityN4CC:InitWidget()
  self.countCown = self:GetUIComponent("UILocalizationText", "countCown")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._guideLevel1BtnGo = self:GetGameObject("guideLevel1Btn")
  self._guideLevel1BtnGo:SetActive(false)
  self.levels = {}
  for i = 1, self.levelNum do
    local levelPool = self:GetUIComponent("UISelectObjectPath", "level" .. i)
    local levelWidget = levelPool:SpawnObject("UIActivityN4CCLevelItem")
    levelWidget:SetVisible(false)
    table.insert(self.levels, levelWidget)
  end
end

function UIActivityN4CC:CancelTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIActivityN4CC:RefreshLevels(playEnterAni)
  if #self._levelsData ~= self.levelNum then
    Log.error("UIActivityN4CC level num err with componentId ", self.componentId)
    return
  end
  for i = 1, self.levelNum do
    local levelWidget = self.levels[i]
    local data = self._levelsData[i]
    levelWidget:SetData(data, self._context, function(data, hasNew)
      self:_HandleItemClick(data, hasNew)
    end)
  end
  if playEnterAni then
    self:StartTask(function(TT)
      for i = 1, self.levelNum do
        local levelWidget = self.levels[i]
        levelWidget:PlayEnterAni()
        YIELD(TT, 60)
      end
    end)
  end
end

function UIActivityN4CC:_HandleItemClick(data, hasNew)
  self:StartTask(function(TT)
    self:Lock("UIActivityN4CC:Level_click_ani")
    if hasNew then
      local ids = {}
      for k, cfg in pairs(data) do
        table.insert(ids, cfg.CampaignMissionId)
      end
      local asyncRes = AsyncRequestRes:New()
      self.component:HandleChallengeClearNewReq(TT, asyncRes, ids)
    end
    self:ShowDialog("UIActivityN4LevelEffController", data, self._context, function()
      self:ShowDialog("UIActivityN4CCLevelDetailController", data, self._context, function()
        self:OnDetailClose()
      end)
    end)
    self:UnLock("UIActivityN4CC:Level_click_ani")
  end)
end

function UIActivityN4CC:OnDetailClose()
  if self._activityEnd then
    return
  end
  self:RefreshLevels()
end

function UIActivityN4CC:HelpBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN4_CC_Intro")
end

function UIActivityN4CC:GuideLevel1BtnOnClick(go)
  local data = self._levelsData[1]
  self:_HandleItemClick(data, true)
end

function UIActivityN4CC:StartCheckActivityEnd()
  self._activityEnd = self:CheckAndRefreshTime()
  if not self._activityEnd then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self._activityEnd = self:CheckAndRefreshTime()
      if self._activityEnd then
        self:CancelTimer()
      end
    end)
  end
end

function UIActivityN4CC:CheckAndRefreshTime()
  local time = self.componentInfo.m_close_time
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  if time < now then
    local timeStr = StringTable.Get("str_activity_finished")
    self.countCown:SetText(timeStr)
    self._timeStr = timeStr
    return true
  else
    local timeStr = HelperProxy:GetInstance():FormatTime_3(time - now)
    if self._timeStr ~= timeStr then
      self.countCown:SetText(StringTable.Get("str_crisis_contract_activity_remain_time", timeStr))
      self._timeStr = timeStr
    end
    return false
  end
end
