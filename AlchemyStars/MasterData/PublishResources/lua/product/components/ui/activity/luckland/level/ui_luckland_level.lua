_class("UILuckLandLevel", UIController)
UILuckLandLevel = UILuckLandLevel

function UILuckLandLevel:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandLevel:OnShow(uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._component = uiParams[1]
  self._componentInfo = self._component:GetComponentInfo()
  self._lineDatas = {}
  self._interval = 0
  self._preLineType = LuckLandLineType.None
  self._curLineType = LuckLandLineType.None
  self:_InitWidget()
  self:_OnValue()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self._canPlayAnimation = true
end

function UILuckLandLevel:_InitWidget()
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self:_SetCommonTopButton()
  self._lines = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodes = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._btnsGO = {}
  self._choiceGO = {}
  self._lockGO = {}
  self._timeText = {}
  self._redGO = {}
  self._choiceAnimation = {}
  self._lockAnimation = {}
  for key, value in pairs(LuckLandLineType) do
    if value ~= LuckLandLineType.None then
      self._btnsGO[value] = self:GetGameObject("Btn" .. value)
      self._choiceGO[value] = self:GetGameObject("Choice" .. value)
      self._lockGO[value] = self:GetGameObject("Lock" .. value)
      self._timeText[value] = self:GetUIComponent("UILocalizationText", "Time" .. value)
      self._redGO[value] = self:GetGameObject("Red" .. value)
      self._choiceAnimation[value] = self:GetUIComponent("Animation", "Choice" .. value)
      self._lockAnimation[value] = self:GetUIComponent("Animation", "Lock" .. value)
      if value ~= LuckLandLineType.One then
        self._choiceAnimation[value]:Play("uieff_UILuckLandLevel_Choice_out")
      end
    end
  end
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandLevel:_OnValue()
  self:_RefreshRemainTime()
  self:_LevelDataClassify()
  self:_RefreshLevelByType(LuckLandLineType.One, false, true)
end

function UILuckLandLevel:AfterUILayerChanged()
  self:_RefreshLevelByType(self._curLineType, true, false)
end

function UILuckLandLevel:_RefreshLevelByType(levelType, force, isClick)
  if self._curLineType == levelType and not force then
    return
  end
  self._preLineType = self._curLineType
  self._curLineType = levelType
  local curLineData = self._lineDatas[levelType]
  if curLineData then
    local count = table.count(curLineData)
    self._nodes:SpawnObjects("UILuckLandLevelItem", count)
    self._lines:SpawnObjects("UILuckLandLevelLine", count - 1)
    self._nodeWidgets = self._nodes:GetAllSpawnList()
    self._lineWidgets = self._lines:GetAllSpawnList()
    for i = 1, count do
      local unlock, timeUnlock = self:IsUnlock(curLineData[i])
      self._nodeWidgets[i]:SetData(curLineData[i], i, self._component, unlock, self._canPlayAnimation)
    end
    for i = 1, count - 1 do
      local nextNode = self._nodeWidgets[i + 1]
      self._lineWidgets[i]:SetData(i, nextNode and nextNode:IsUnlock() and not nextNode:IsInitial(), self._canPlayAnimation)
    end
    self._canPlayAnimation = false
  end
  self:_SwitchBtns(isClick)
end

function UILuckLandLevel:OnUpdate(deltaTime)
  self._interval = self._interval + deltaTime
  if self._interval >= 1000 then
    self._interval = 0
    self:_RefreshRemainTime()
  end
end

function UILuckLandLevel:_RefreshRemainTime()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._componentInfo.m_close_time
  if curTime < endTime then
    self._remainTime:SetText(StringTable.Get("str_activity_common_remainingtime_3", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
  else
    self._remainTime:SetText(StringTable.Get("str_activity_common_notice_content"))
  end
end

function UILuckLandLevel:_SetCommonTopButton()
  local function closeCallback()
    self:_CloseByAnimation()
  end
  
  local function helpCallBack()
    self:ShowDialog("UIIntroLoader", "UILuckLandLevel")
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "BackBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, helpCallBack, nil, false)
end

function UILuckLandLevel:_CloseByAnimation()
  self:StartTask(function(TT)
    self:Lock("UILuckLandLevel")
    self._animation:Play("uieff_UILuckLandLevel_out")
    if self._nodeWidgets then
      for _, widget in pairs(self._nodeWidgets) do
        widget:PlayAnimation(false)
      end
    end
    if self._lineWidgets then
      for _, widget in pairs(self._lineWidgets) do
        widget:PlayAnimation(false)
      end
    end
    YIELD(TT, 333)
    self:CloseDialog()
    self:UnLock("UILuckLandLevel")
  end)
end

function UILuckLandLevel:_LevelDataClassify()
  local cfgs = Cfg.cfg_component_luck_land({
    ComponentID = self._component:GetComponentCfgId()
  })
  if cfgs then
    for _, cfg in pairs(cfgs) do
      if not self._lineDatas[cfg.Line] then
        self._lineDatas[cfg.Line] = {}
      end
      table.insert(self._lineDatas[cfg.Line], cfg)
    end
  end
  for _, lineDatas in pairs(self._lineDatas) do
    table.sort(lineDatas, function(a, b)
      return a.MissionID < b.MissionID
    end)
  end
end

function UILuckLandLevel:Btn1OnClick(go)
  self:_OnClickBtn(LuckLandLineType.One)
end

function UILuckLandLevel:Btn2OnClick(go)
  self:_OnClickBtn(LuckLandLineType.Two)
end

function UILuckLandLevel:Btn3OnClick(go)
  self:_OnClickBtn(LuckLandLineType.Three)
end

function UILuckLandLevel:Btn4OnClick(go)
  self:_OnClickBtn(LuckLandLineType.Four)
end

function UILuckLandLevel:_OnClickBtn(lineType)
  local isUnlock, timeUnlock, id, time = self:_CheckLineIsUnlock(lineType)
  if isUnlock and timeUnlock then
    self:_RefreshLevelByType(lineType, false, true)
  elseif not timeUnlock then
    ToastManager.ShowToast(StringTable.Get("str_luckland_road_time_locked_tips"))
  else
    local cfg = Cfg.cfg_luckland_client_mission[id]
    if cfg then
      ToastManager.ShowToast(StringTable.Get("str_luckland_road_level_locked", StringTable.Get(cfg.Name)))
    end
  end
end

function UILuckLandLevel:_SwitchBtns(isClick)
  for key, value in pairs(LuckLandLineType) do
    if value ~= LuckLandLineType.None then
      local unlock, timeUnlock, id, time = self:_CheckLineIsUnlock(value)
      if isClick then
        if value == self._curLineType and self._choiceAnimation[value] then
          self._choiceAnimation[value]:Play("uieff_UILuckLandLevel_Choice_in")
        end
        if value == self._preLineType and self._choiceAnimation[value] then
          self._choiceAnimation[value]:Play("uieff_UILuckLandLevel_Choice_out")
        end
      end
      if not timeUnlock then
        local curTime = self._svrTimeModule:GetServerTime() * 0.001
        local endTime = time
        if curTime < endTime then
          self._timeText[value]:SetText(StringTable.Get("str_luckland_road_time_locked", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
        end
      else
        self._timeText[value]:SetText("")
      end
      self._redGO[value]:SetActive(false)
      if unlock and timeUnlock then
        if self._curLineType == value then
          LocalDB.SetInt("LuckLandLevel_Unlock_Line_" .. GameGlobal.GetModule(RoleModule):GetPstId() .. value, 1)
        end
        local r = LocalDB.GetInt("LuckLandLevel_Unlock_Line_" .. GameGlobal.GetModule(RoleModule):GetPstId() .. value, 0) <= 0
        if r then
          self._redGO[value]:SetActive(true)
        end
        local played = LocalDB.GetInt("LuckLandLevel_Unlock_Line_Lock_" .. GameGlobal.GetModule(RoleModule):GetPstId() .. value, 0)
        if played <= 0 then
          if self._lockAnimation[value] then
            self._lockAnimation[value]:Play("uieff_Anim_UILuckLandLevel_Lock_out")
            LocalDB.SetInt("LuckLandLevel_Unlock_Line_Lock_" .. GameGlobal.GetModule(RoleModule):GetPstId() .. value, 1)
          else
            self._lockGO[value]:SetActive(false)
          end
        else
          self._lockGO[value]:SetActive(false)
        end
      else
        self._lockGO[value]:SetActive(true)
      end
    end
  end
end

function UILuckLandLevel:_CheckLineIsUnlock(lineType)
  local lineData = self._lineDatas[lineType]
  if lineData[1] then
    return self:IsUnlock(lineData[1])
  end
  return false, false, 0, 0
end

function UILuckLandLevel:IsUnlock(cfg)
  local preMissionUnlock = false
  local timeUnlock = false
  local needMissionID = 0
  local time = 0
  if cfg then
    needMissionID = cfg.NeedMissionId
    time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    preMissionUnlock = needMissionID <= 0 or self._componentInfo.m_pass_mission_info[needMissionID] ~= nil
    timeUnlock = self:_IsUnlock(cfg.UnlockTime)
  end
  return preMissionUnlock, timeUnlock, needMissionID, time
end

function UILuckLandLevel:_IsUnlock(UnlockTime)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local unlockTime = loginModule:GetTimeStampByTimeStr(UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  return unlockTime <= curTime
end
