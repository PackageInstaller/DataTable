_class("UISeasonTalentEntry", UICustomWidget)
UISeasonTalentEntry = UISeasonTalentEntry

function UISeasonTalentEntry:OnShow(uiParams)
  self:GetComponents()
  self:AttachEvent(GameEventType.OnTalentTreeRedChange, self.OnTalentTreeRedChange)
  self:AttachEvent(GameEventType.OnOpenTalentLine, self.OnOpenTalentLine)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UISeasonTalentEntry:OnOpenTalentLine()
  local open = self:CheckOpen()
  if open then
    local lock = self:GetLockState()
    if not lock then
      self:ShowDialog("UISeasonTalentLineMission")
    end
  end
end

function UISeasonTalentEntry:GetComponents()
  self._newGo = self:GetGameObject("new")
  self._redGo = self:GetGameObject("red")
  self._go = self:GetGameObject("rect")
  self._lockGo = self:GetGameObject("lock")
end

function UISeasonTalentEntry:AfterUILayerChanged()
  local uiController = self.uiOwner
  local uiname = uiController:GetName()
  if GameGlobal.UIStateManager():IsTopUI(uiname) then
    self:OnTalentTreeRedChange()
  end
end

function UISeasonTalentEntry:OnTalentTreeRedChange()
  self:SetData()
end

function UISeasonTalentEntry:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UISeasonTalentEntry:InitTimer(sec)
  Log.debug("###[UISeasonTalentEntry] InitTimer sec:", sec)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  self._timer = GameGlobal.Timer():AddEvent(sec, function()
    self:ReLoadSeasonInfo()
  end)
end

function UISeasonTalentEntry:ReLoadSeasonInfo()
  Log.debug("###[UISeasonTalentEntry] start ReLoadSeasonInfo !")
  self:Lock("UISeasonTalentEntry:ReLoadSeasonInfo")
  GameGlobal.TaskManager():StartTask(self.OnReLoadSeasonInfo, self)
end

function UISeasonTalentEntry:OnReLoadSeasonInfo(TT)
  local res = GameGlobal.GetModule(SeasonModule):ForceRequestCurSeasonData(TT)
  self:UnLock("UISeasonTalentEntry:ReLoadSeasonInfo")
  if res and res:GetSucc() then
    self:SetData()
  end
end

function UISeasonTalentEntry:SetData()
  self._seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  local open = self:CheckOpen()
  self._go:SetActive(open)
  local lock = self:GetLockState()
  self._lockGo:SetActive(lock)
  if lock then
    self._line_component = self._seasonObj:GetComponent(self._componentId_LineMission)
    local unlockTime = self._line_component:GetComponentInfo().m_unlock_time
    local svrTime = math.floor(GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001)
    if unlockTime > svrTime then
      local sec = unlockTime - svrTime
      self:InitTimer(sec * 1000)
    end
  end
  if open then
    local new = self:CheckNew()
    local red = self:CheckRed()
    self._newGo:SetActive(new and not lock)
    self._redGo:SetActive(red and not new and not lock)
  end
end

function UISeasonTalentEntry:GetLockState()
  self._componentId_LineMission = ECCampaignSeasonComponentID.LINE_MISSION
  self._componentId_Tree = ECCampaignSeasonComponentID.TALENT_TREE
  self._line_component = self._seasonObj:GetComponent(self._componentId_LineMission)
  local unlock = self._line_component:GetComponentInfo().m_b_unlock
  if not unlock then
    local svrTime = math.floor(GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001)
    local unlockTime = self._line_component:GetComponentInfo().m_unlock_time
    local closeTime = self._line_component:GetComponentInfo().m_close_time
    local tips
    local iTimeIn = false
    if svrTime >= unlockTime and svrTime < closeTime then
      iTimeIn = true
    end
    if iTimeIn then
      local lockMission = self._line_component:GetComponentInfo().m_need_mission_id
      local cfg_mission = Cfg.cfg_season_mission[lockMission]
      local cfgName = ""
      if cfg_mission then
        cfgName = StringTable.Get(cfg_mission.Name)
      end
      tips = StringTable.Get("str_season_talent_tree_unlock_prelevel", cfgName)
    elseif svrTime < unlockTime then
      local lessTime = unlockTime - svrTime
      local timeStr = HelperProxy:GetInstance():Time2Tex(lessTime)
      tips = StringTable.Get("str_season_talent_tree_unlock_eta", timeStr)
    elseif svrTime >= closeTime then
      tips = StringTable.Get("str_activity_error_107")
    end
    return true, tips
  else
    return false
  end
end

function UISeasonTalentEntry:CheckOpen()
  return true
end

function UISeasonTalentEntry:BtnOnClick(go)
  local lock, lockTips = self:GetLockState()
  if lock then
    ToastManager.ShowToast(lockTips)
    return
  end
  self:ShowDialog("UISeasonTalentLineMission")
end

function UISeasonTalentEntry:CheckNew()
  local lineCom = self._seasonObj:GetComponent(self._componentId_LineMission)
  local new = UISeasonHelper.TalentTreeNew(nil, lineCom)
  return new
end

function UISeasonTalentEntry:CheckRed()
  local lineCom = self._seasonObj:GetComponent(self._componentId_LineMission)
  local treeCom = self._seasonObj:GetComponent(self._componentId_Tree)
  local red = UISeasonHelper.TalentTreeRed(nil, lineCom, treeCom)
  return red
end
