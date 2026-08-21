_class("UIN30EntrustLine", UIController)
UIN30EntrustLine = UIN30EntrustLine

function UIN30EntrustLine:Constructor()
  self._dicTeam = nil
  self._lstTeam = nil
  self._widgetEventsDic = nil
  self._widgetEvents = nil
  self._widgetLinesDic = nil
  self._widgetLines = nil
  self._theMaxPos = nil
end

function UIN30EntrustLine:LoadDataOnEnter(TT, res, uiParams)
  EntrustComponent:HookClientData(109301805, UIN30Entrust.RefreshClientData)
  self._node = uiParams[1]
  self._isMatch = uiParams[2]
  self._isWinMatch = uiParams[3]
  if self._isWinMatch then
    local campaign = UIActivityCampaign.New()
    campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N30, ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST)
    campaign:ReLoadCampaignInfo_Force(TT, res)
  end
  self._node:EntrustData():NodeDetailsData(self._node)
end

function UIN30EntrustLine:OnShow(uiParams)
  self._bgLoader = self:GetUIComponent("RawImageLoader", "BG")
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._uiTeam = self:GetUIComponent("UISelectObjectPath", "uiTeam")
  self._txtBox = self:GetUIComponent("UILocalizationText", "txtBox")
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
  self._srContent = self._sr.content
  self._uiLines = self:GetUIComponent("UISelectObjectPath", "lines")
  self._uiEvents = self:GetUIComponent("UISelectObjectPath", "events")
  self._uiHeads = self:GetUIComponent("UISelectObjectPath", "heads")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._atlas = self:GetAsset("UIN30Entrust.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:InitCommonTopButton()
  self:EnterFullScreenBg(false)
  self:CreateEvents()
  self:CreateLines()
  self:CreateTeams()
  self:ContentSizeDelta()
  self:FlushEvents()
  self:FlushLines()
  self:FlushExplorBox()
  self:FlushTeam()
  self:InAnimation()
end

function UIN30EntrustLine:OnHide()
end

function UIN30EntrustLine:OnUpdate(deltaTimeMS)
end

function UIN30EntrustLine:OnActivityCloseEvent(id)
  local entrustData = self._node:EntrustData()
  local idCampaign = entrustData:EntrustComponentInfo().m_campaign_id
  if idCampaign == id then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(false, UIStateType.UIActivityN30MainController, UIStateType.UIMain, nil, idCampaign)
  end
end

function UIN30EntrustLine:BtnAnywhereOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN30EntrustLine:EventOnClick(event, go)
  local idEnd = event:ID()
  local idStart, moveTeam
  local PointPermitTeamID = event:Cfg().PointPermitTeamID
  if PointPermitTeamID ~= nil then
    for k, v in pairs(PointPermitTeamID) do
      local team = self._dicTeam[v]
      if team._isVisible then
        moveTeam = team
        idStart = team._idEvent
      end
    end
  end
  if idStart == nil then
    self:OnSplitOrMergeTeam(event, go)
    return
  end
  local reachable = self._node:GetReachable()
  local result = {}
  local openList = {idStart}
  while #openList ~= 0 do
    local loopList = openList
    openList = {}
    for k, v in pairs(loopList) do
      result[v] = v
      local dic = reachable[v]
      for dk, dv in pairs(dic) do
        if result[dv] == nil then
          table.insert(openList, dv)
        end
      end
    end
    if result[idEnd] ~= nil then
      break
    end
  end
  if result[idEnd] == nil then
    return
  end
  if event:IsLocked() then
    local lockedPointID = event:Cfg().LockedPointID
    local eventLocked = self._node:GetEvent(lockedPointID)
    local pointName = eventLocked:Cfg().PointName
    if pointName == nil then
      pointName = "前置名称未配置"
    else
      pointName = StringTable.Get(pointName)
    end
    local txtPopup = StringTable.Get("str_n30_entrust_event_locked", pointName)
    ToastManager.ShowToast(txtPopup)
  else
    self:StartTask(self.MoveTeamTask, self, moveTeam, event)
  end
end

function UIN30EntrustLine:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local bgAnimation = self:GetAnimationName()
    local lockName = "UIN30EntrustLine:Line_out"
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._animation:Play(bgAnimation[2])
      YIELD(TT, 633)
      self:UnLock(lockName)
      local entrustData = self._node:EntrustData()
      local idCampaign = entrustData:EntrustComponentInfo().m_campaign_id
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignSwitchState(true, UIStateType.UIN30Entrust, UIStateType.UIMain, {true}, idCampaign)
    end)
  end, function()
    self:ShowDialog("UIIntroLoader", "UIN30EntrustIntro")
  end, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, nil, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN30EntrustLine:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
end

function UIN30EntrustLine:CreateEvents()
  local eventIds = {}
  local cfgNode = self._node:GetCfg()
  if cfgNode.EventID ~= nil then
    eventIds = cfgNode.EventID
  end
  local theMaxX = 0
  local theMaxY = 0
  local count = #eventIds
  self._widgetEvents = self._uiEvents:SpawnObjects("UIN30EntrustLineNode", count)
  self._widgetEventsDic = {}
  for k, v in pairs(eventIds) do
    local ui = self._widgetEvents[k]
    self._widgetEventsDic[v] = ui
    local event = self._node:GetEvent(v)
    ui:SetEvent(event)
    local pos = Vector2.zero
    local cfgEvent = event:Cfg()
    local pointPos = cfgEvent.PointPos
    if pointPos ~= nil and 2 <= #pointPos then
      pos.x = pointPos[1]
      pos.y = pointPos[2]
    end
    theMaxX = math.max(theMaxX, math.abs(pos.x))
    theMaxY = math.max(theMaxY, math.abs(pos.y))
    UIN30Entrust:ResetCellSize(ui:GetGameObject(), Vector2(225, 223))
    ui:GetGameObject().transform.anchoredPosition = pos
  end
  self._theMaxPos = Vector2(theMaxX, theMaxY)
end

function UIN30EntrustLine:CreateLines()
  local lineIds = {}
  local cfgNode = self._node:GetCfg()
  if cfgNode.LineID ~= nil then
    lineIds = cfgNode.LineID
  end
  local count = #lineIds
  self._widgetLines = self._uiLines:SpawnObjects("UIN30EntrustLineLine", count)
  self._widgetLinesDic = {}
  for k, v in pairs(lineIds) do
    local ui = self._widgetLines[k]
    self._widgetLinesDic[v] = ui
    local line = self._node:GetLine(v)
    ui:SetLine(line)
    local cfgLine = line:Cfg()
    local preEvent = self._widgetEventsDic[cfgLine.LeftEventID]
    local nxtEvent = self._widgetEventsDic[cfgLine.RightEventID]
    local go = ui:GetGameObject()
    UIN30Entrust:ResetCellSize(go, Vector2(120, 12))
    go.transform.pivot = Vector2(0, 0.5)
    ui:SetPos(preEvent, nxtEvent)
  end
end

function UIN30EntrustLine:CreateTeams()
  local entrustData = self._node:EntrustData()
  local component = entrustData:EntrustComponent()
  local allTeam = Cfg.cfg_campaign_entrust_team({
    ComponentID = component:GetComponentCfgId()
  })
  self._lstTeam = {}
  self._dicTeam = {}
  for k, v in pairs(allTeam) do
    local newTeam = UIN30EntrustTeamData:New(v)
    self._dicTeam[v.LineID] = newTeam
    table.insert(self._lstTeam, newTeam)
  end
  table.sort(self._lstTeam, function(a, b)
    return a._cfg.LineID < b._cfg.LineID
  end)
  local count = #self._lstTeam
  local widgetTeam = self._uiTeam:SpawnObjects("UIN30EntrustLineTeam", count)
  local widgetHead = self._uiHeads:SpawnObjects("UIN30EntrustLineTeamHead", count)
  for k, v in pairs(self._lstTeam) do
    v._uiTeam = widgetTeam[k]
    v._uiHead = widgetHead[k]
    v._uiTeam:SetTeam(v)
    v._uiHead:SetTeam(v)
    UIN30Entrust:ResetCellSize(v._uiHead:GetGameObject(), Vector2(150, 150))
  end
end

function UIN30EntrustLine:ContentSizeDelta()
  if self._bgLoader then
    local idNode = self._node:ID()
    local idImage = idNode - 101700
    local bgName = string.format("n30_wt_map_s%d", idImage)
    self._bgLoader:LoadImage(bgName)
  end
end

function UIN30EntrustLine:FlushEvents()
  for k, v in pairs(self._widgetEventsDic) do
    v:FlushUi()
  end
end

function UIN30EntrustLine:FlushLines()
  for k, v in pairs(self._widgetLines) do
    v:FlushUi()
  end
end

function UIN30EntrustLine:FlushExplorBox()
  local totalBox = self._node:GetTotalBox()
  local completeBox = self._node:GetCompleteBox()
  local strExplor = string.format("<color=#fcfcfc>%d</color>/%d", completeBox, totalBox)
  self._txtBox:SetText(strExplor)
end

function UIN30EntrustLine:FlushTeam()
  for k, v in pairs(self._dicTeam) do
    v._isVisible = false
    v._isPass = false
  end
  local entrustData = self._node:EntrustData()
  local entrustInfo = entrustData:EntrustComponentInfo()
  local missionInfo = entrustInfo.mission_infos[self._node:ID()]
  local teamEvents = missionInfo.team_events
  local teamCount = 0
  for k, v in pairs(teamEvents) do
    teamCount = teamCount + 1
  end
  if teamCount == 0 then
    local dicEvents = self._node:GetAllEvents()
    for k, v in pairs(dicEvents) do
      local eventType = v:EventType()
      local paramTeamID = v:ParamTeamID()
      if eventType == EntrustEventType.EntrustEventType_Start and paramTeamID ~= nil then
        local teamData = self._dicTeam[paramTeamID]
        teamData._isVisible = true
        teamData._idEvent = v:ID()
      end
    end
  else
    for k, v in pairs(teamEvents) do
      local teamData = self._dicTeam[k]
      teamData._isVisible = true
      teamData._idEvent = v
    end
  end
  local rewardedEvents = self._node:GetRewardedEvents()
  for k, v in pairs(rewardedEvents) do
    local event = self._node:GetEvent(k)
    local eventType = event:EventType()
    local PointPermitTeamID
    if eventType == EntrustEventType.EntrustEventType_End then
      PointPermitTeamID = event:Cfg().PointPermitTeamID
    end
    if PointPermitTeamID ~= nil then
      for tk, tv in pairs(PointPermitTeamID) do
        local teamData = self._dicTeam[tv]
        teamData._isPass = true
      end
    end
  end
  for k, v in pairs(self._dicTeam) do
    v._uiTeam:FlushUi()
    v._uiHead:FlushUi()
  end
end

function UIN30EntrustLine:GetAnimationName()
  if self._animNames == nil then
    self._animNames = {
      [101701] = {
        "uieff_N30_EntrustLine_01_in",
        "uieff_N30_EntrustLine_01_out"
      },
      [101702] = {
        "uieff_N30_EntrustLine_02_in",
        "uieff_N30_EntrustLine_02_out"
      },
      [101703] = {
        "uieff_N30_EntrustLine_03_in",
        "uieff_N30_EntrustLine_03_out"
      },
      [101704] = {
        "uieff_N30_EntrustLine_04_in",
        "uieff_N30_EntrustLine_04_out"
      },
      [101705] = {
        "uieff_N30_EntrustLine_05_in",
        "uieff_N30_EntrustLine_05_out"
      },
      [101706] = {
        "uieff_N30_EntrustLine_06_in",
        "uieff_N30_EntrustLine_06_out"
      }
    }
  end
  return self._animNames[self._node:ID()]
end

function UIN30EntrustLine:InAnimation()
  if self._isMatch then
    return
  end
  for k, v in pairs(self._widgetEventsDic) do
    v:GetGameObject():SetActive(false)
  end
  for k, v in pairs(self._widgetLinesDic) do
    v:GetGameObject():SetActive(false)
  end
  for k, v in pairs(self._dicTeam) do
    v._uiTeam:GetGameObject():SetActive(false)
    v._uiHead:GetGameObject():SetActive(false)
  end
  local lockName = "UIN30EntrustLine:InAnimation - inTeam"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(self._lstTeam) do
      if v._isVisible then
        v._uiTeam:GetGameObject():SetActive(true)
        v._uiTeam:PlayAnimation("uieff_N30_EntrustLineTeam_in")
        YIELD(TT, 80)
      end
    end
    self:UnLock(lockName)
  end)
  local bgAnimation = self:GetAnimationName()
  local lockName = "UIN30EntrustLine:InAnimation - inBg"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play(bgAnimation[1])
    YIELD(TT, 700)
    self:UnLock(lockName)
  end)
  local lockName = "UIN30EntrustLine:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local lookup = {}
    local sequence = self._node:GetSequence()
    for k, v in pairs(sequence) do
      local left = {}
      local right = {}
      for kv, vv in pairs(v) do
        if lookup[vv.LeftEventID] == nil then
          table.insert(left, vv.LeftEventID)
        end
        if lookup[vv.RightEventID] == nil then
          table.insert(right, vv.RightEventID)
        end
      end
      local countVisible = 0
      if 0 < #left then
        for kv, vv in pairs(left) do
          lookup[vv] = vv
          local ui = self._widgetEventsDic[vv]
          local event = self._node:GetEvent(vv)
          if event:IsVisible() then
            countVisible = countVisible + 1
            ui:FlushUi()
            ui:PlayAnimation("uieff_N30_EntrustLineNode")
          end
        end
        if 0 < countVisible then
          YIELD(TT, 80)
        end
      end
      countVisible = 0
      for kv, vv in pairs(v) do
        local ui = self._widgetLinesDic[vv.LineID]
        local line = self._node:GetLine(vv.LineID)
        if line:IsVisible() then
          countVisible = countVisible + 1
          ui:FlushUi()
          ui:PlayAnimation("uieff_N30_EntrustLineLine")
        end
      end
      if 0 < countVisible then
        YIELD(TT, 80)
      end
      countVisible = 0
      if 0 < #right then
        for kv, vv in pairs(right) do
          lookup[vv] = vv
          local ui = self._widgetEventsDic[vv]
          local event = self._node:GetEvent(vv)
          if event:IsVisible() then
            countVisible = countVisible + 1
            ui:FlushUi()
            ui:PlayAnimation("uieff_N30_EntrustLineNode")
          end
        end
        if 0 < countVisible then
          YIELD(TT, 80)
        end
      end
    end
    for k, v in pairs(self._dicTeam) do
      v._uiHead:FlushUi()
    end
    self:UnLock(lockName)
  end)
end

function UIN30EntrustLine:GetAtlas()
  return self._atlas
end

function UIN30EntrustLine:GetStepOnTeam(idEvent)
  for k, v in pairs(self._dicTeam) do
    if v._isVisible and v._idEvent == idEvent then
      return v
    end
  end
  return nil
end

function UIN30EntrustLine:MoveTeamTask(TT, moveTeam, eventTarget)
  local lockName = "UIN30EntrustLine:MoveTeamTask"
  self:Lock(lockName)
  local entrustData = self._node:EntrustData()
  local component = entrustData:EntrustComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local teamevents = {}
  for k, v in pairs(self._dicTeam) do
    if v._isVisible then
      teamevents[k] = v._idEvent
    end
  end
  teamevents[moveTeam._cfg.LineID] = eventTarget:ID()
  component:HandleMoveCompleteEvent(TT, res, self._node:ID(), teamevents)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= res.m_result then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:ShowErrorToast(res.m_result, true)
    local idCampaign = entrustData:EntrustComponentInfo().m_campaign_id
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, idCampaign)
  else
    moveTeam._idEvent = eventTarget:ID()
    moveTeam._uiHead:GetGameObject():SetActive(false)
    for k, v in pairs(self._dicTeam) do
      v._uiHead:FlushUi()
    end
    YIELD(TT, 800)
  end
  self:UnLock(lockName)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS == res.m_result then
    eventTarget:OnArrived(self)
  end
end

function UIN30EntrustLine:CompleteEvent(idEvent, cbSuccess)
  self:StartTask(self.CompleteEventTask, self, idEvent, cbSuccess)
end

function UIN30EntrustLine:CompleteEventTask(TT, idEvent, cbSuccess)
  local lockName = "UIN30EntrustLine:CompleteEventTask"
  self:Lock(lockName)
  local entrustData = self._node:EntrustData()
  local component = entrustData:EntrustComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  component:HandleCompleteEvent(TT, res, self._node:ID(), idEvent)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= res.m_result then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:ShowErrorToast(res.m_result, true)
    local idCampaign = entrustData:EntrustComponentInfo().m_campaign_id
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, idCampaign)
  else
    self._node:EntrustData():NodeDetailsData(self._node)
  end
  self:UnLock(lockName)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS == res.m_result and cbSuccess ~= nil then
    cbSuccess()
  end
end

function UIN30EntrustLine:HideAllEvents(rewarded_events)
  local preLinks = self._node:GetPreLinks()
  local dicEvents = self._node:GetAllEvents()
  local dicLines = self._node:GetAllLines()
  if rewarded_events == nil then
    rewarded_events = {}
    self._node._rewarded_events = rewarded_events
    for k, v in pairs(dicEvents) do
      if v:EventType() == EntrustEventType.EntrustEventType_Start then
        rewarded_events[k] = k
      end
    end
  end
  for k, v in pairs(dicEvents) do
    v._isVisible = false
    v._isLocked = false
    v._isPass = false
    local preDic = preLinks[k]
    if rewarded_events[k] ~= nil then
      v._isVisible = true
    elseif preDic == nil then
      if v:EventType() == EntrustEventType.EntrustEventType_Start then
        v._isVisible = true
      end
    else
      for vk, vv in pairs(preDic) do
        if rewarded_events[vv] ~= nil then
          v._isVisible = true
          break
        end
      end
    end
  end
  for k, v in pairs(dicLines) do
    v._isVisible = false
    local cfgLine = v:Cfg()
    v._isVisible = rewarded_events[cfgLine.LeftEventID] ~= nil
  end
end

function UIN30EntrustLine:CompleteEventTask_TestCase(TT, idEvent, cbSuccess)
  local rewarded_events = self._node:GetRewardedEvents()
  rewarded_events[idEvent] = idEvent
  self:HideAllEvents(rewarded_events)
  self._node:GetEvent(idEvent)._isPass = true
  if cbSuccess ~= nil then
    cbSuccess()
  end
end

function UIN30EntrustLine:OnEventFinish(lstEventId)
  self:StartTask(self.OnEventFinishTask, self, lstEventId)
end

function UIN30EntrustLine:OnEventFinishTask(TT, lstEventId)
  local lockName = "UIN30EntrustLine:OnEventFinishTask"
  self:Lock(lockName)
  local lookup = {}
  for k, v in pairs(lstEventId) do
    lookup[v] = v
  end
  local lineIds = {}
  if self._node:GetCfg().LineID ~= nil then
    lineIds = self._node:GetCfg().LineID
  end
  local unlocked = {}
  local cacheLine = Cfg.cfg_campaign_entrust_line
  for k, v in pairs(lineIds) do
    local cfgLine = cacheLine[v]
    if lookup[cfgLine.LeftEventID] ~= nil then
      table.insert(unlocked, cfgLine)
    end
  end
  self:FlushEvents()
  self:FlushLines()
  self:FlushExplorBox()
  self:FlushTeam()
  for k, v in pairs(unlocked) do
    local ui = self._widgetLinesDic[v.LineID]
    ui:PlayAnimation("uieff_N30_EntrustLineLine")
    local ui = self._widgetEventsDic[v.RightEventID]
    ui:GetGameObject():SetActive(false)
  end
  YIELD(TT, 80)
  for k, v in pairs(unlocked) do
    local ui = self._widgetEventsDic[v.RightEventID]
    ui:GetGameObject():SetActive(true)
    ui:PlayAnimation("uieff_N30_EntrustLineNode")
  end
  self:UnLock(lockName)
  if #lstEventId == 1 then
    local event = self._node:GetEvent(lstEventId[1])
    local teamSpecialPoint = event:Cfg().TeamSpecialPoint
    if teamSpecialPoint ~= nil and teamSpecialPoint[1][1] == 1 then
      self:StartTask(self.SplitTeamTask, self, event, teamSpecialPoint[2][1], teamSpecialPoint[2][2])
    elseif event:EventType() == EntrustEventType.EntrustEventType_End then
      self:CheckFinishPopup()
    end
  elseif #lstEventId == 2 then
    local event1 = self._node:GetEvent(lstEventId[1])
    local event2 = self._node:GetEvent(lstEventId[2])
    local tsp1 = event1:Cfg().TeamSpecialPoint
    local tsp2 = event2:Cfg().TeamSpecialPoint
    if event1:EventType() == EntrustEventType.EntrustEventType_Transfer then
      self:StartTask(self.OnEventTransTask, self, event1)
    elseif tsp1 ~= nil and tsp1[1][1] == 2 and tsp2 ~= nil and tsp2[1][1] == 2 then
      self:StartTask(self.MergeTeamTask, self, event1, event2, tsp1[2][1], tsp2[2][1])
    end
  end
end

function UIN30EntrustLine:OnInteractFinish(lstEventId)
  local lockName = "UIN30EntrustLine:OnInteractFinish"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(lstEventId) do
      local ui = self._widgetEventsDic[v]
      ui:PlayAnimation("uieff_N30_EntrustLineNode_in")
    end
    YIELD(TT, 667)
    self:UnLock(lockName)
    self:StartTask(self.OnEventFinishTask, self, lstEventId)
  end)
end

function UIN30EntrustLine:OnSplitOrMergeTeam(eventClick, go)
  local preLinks = self._node:GetPreLinks()
  local openEvents = {
    eventClick:ID()
  }
  local preDic = {}
  while 0 < #openEvents do
    local loopEvents = openEvents
    openEvents = {}
    for k, v in pairs(loopEvents) do
      local preEvents = preLinks[v]
      if preEvents ~= nil then
        for sk, sv in pairs(preEvents) do
          preDic[sk] = sk
          table.insert(openEvents, sk)
        end
      end
    end
  end
  local retry = false
  local event1, event2
  for k, v in pairs(preDic) do
    local event = self._node:GetEvent(k)
    local teamSpecialPoint = event:Cfg().TeamSpecialPoint
    if teamSpecialPoint ~= nil and teamSpecialPoint[1][1] == 1 then
      self:StartTask(self.SplitTeamTask, self, event, teamSpecialPoint[2][1], teamSpecialPoint[2][2])
      retry = true
      break
    elseif teamSpecialPoint ~= nil and teamSpecialPoint[1][1] == 2 then
      if event1 == nil then
        event1 = event
      else
        event2 = event
      end
    end
    if event1 ~= nil and event2 ~= nil then
      local tsp1 = event1:Cfg().TeamSpecialPoint
      local tsp2 = event2:Cfg().TeamSpecialPoint
      self:StartTask(self.MergeTeamTask, self, event1, event2, tsp1[2][1], tsp2[2][1])
      retry = true
      break
    end
  end
  if retry then
    self:StartTask(function(TT)
      while GameGlobal.UIStateManager():IsLocked() do
        YIELD(TT)
      end
      self:EventOnClick(eventClick, go)
    end)
  end
end

function UIN30EntrustLine:SplitTeamTask(TT, event, idSplit1, idSplit2)
  local lockName = "UIN30EntrustLine:SplitTeamTask"
  self:Lock(lockName)
  local entrustData = self._node:EntrustData()
  local component = entrustData:EntrustComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local eventSplit1 = self._node:GetEvent(idSplit1)
  local eventSplit2 = self._node:GetEvent(idSplit2)
  local idTeam1 = eventSplit1:Cfg().PointPermitTeamID[1]
  local idTeam2 = eventSplit2:Cfg().PointPermitTeamID[1]
  local teamevents = {}
  teamevents[idTeam1] = idSplit1
  teamevents[idTeam2] = idSplit2
  component:HandleMoveCompleteEvent(TT, res, self._node:ID(), teamevents)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= res.m_result then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:ShowErrorToast(res.m_result, true)
    local idCampaign = entrustData:EntrustComponentInfo().m_campaign_id
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, idCampaign)
  else
    self:FlushTeam()
    local teamData
    for k, v in pairs(self._lstTeam) do
      if v._isVisible then
        teamData = v
      end
    end
    teamData._uiTeam:PlayAnimation("uieff_N30_EntrustLineTeam_in")
    YIELD(TT, 600)
  end
  self:UnLock(lockName)
end

function UIN30EntrustLine:MergeTeamTask(TT, event1, event2, idMerge1, idMerge2)
  if idMerge1 ~= idMerge2 then
    Log.error("cfg_campaign_entrust_event 队伍合并配置错误! id --> ", event1:ID(), event2:ID())
    return
  end
  local lockName = "UIN30EntrustLine:MergeTeamTask"
  self:Lock(lockName)
  local entrustData = self._node:EntrustData()
  local component = entrustData:EntrustComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local eventMerge = self._node:GetEvent(idMerge1)
  local idTeamMerge = eventMerge:Cfg().PointPermitTeamID[1]
  local teamevents = {}
  teamevents[idTeamMerge] = idMerge2
  component:HandleMoveCompleteEvent(TT, res, self._node:ID(), teamevents)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= res.m_result then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:ShowErrorToast(res.m_result, true)
    local idCampaign = entrustData:EntrustComponentInfo().m_campaign_id
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, idCampaign)
  else
    local visible = {}
    local teamData
    for k, v in pairs(self._lstTeam) do
      if v._isVisible then
        visible[v._cfg.LineID] = v
        teamData = v
      end
    end
    self:FlushTeam()
    for k, v in pairs(self._dicTeam) do
      v._uiTeam:GetGameObject():SetActive(visible[k] ~= nil)
    end
    teamData._uiTeam:PlayAnimation("uieff_N30_EntrustLineTeam_up")
    YIELD(TT, 400)
    for k, v in pairs(self._dicTeam) do
      v._uiTeam:GetGameObject():SetActive(visible[k] == nil)
    end
  end
  self:UnLock(lockName)
end

function UIN30EntrustLine:CheckFinishPopup()
  if not self._node:IsPass() then
    return
  end
  if self._node:GetExplor() == 1 then
    return
  end
  local EventType = EntrustEventType.EntrustEventType_Invalid
  local event = N30EntrustEvent:CreateEvent(self._node, {EventType = EventType})
  self:ShowDialog("UIN30EntrustEvent", event)
end

function UIN30EntrustLine:OnEventTrans(event)
  self:StartTask(self.OnEventTransTask, self, event)
end

function UIN30EntrustLine:OnEventTransTask(TT, event)
  local lockName = "UIN30EntrustLine:OnEventTransTask"
  self:Lock(lockName)
  local entrustData = self._node:EntrustData()
  local component = entrustData:EntrustComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local moveTeam
  for k, v in pairs(self._dicTeam) do
    if v._idEvent == event:ID() then
      moveTeam = v
      break
    end
  end
  local teamevents = {}
  for k, v in pairs(self._dicTeam) do
    if v._isVisible then
      teamevents[k] = v._idEvent
    end
  end
  if moveTeam ~= nil then
    local cfg = event:Cfg()
    teamevents[moveTeam._cfg.LineID] = cfg.TargetID
  end
  component:HandleMoveCompleteEvent(TT, res, self._node:ID(), teamevents)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= res.m_result then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:ShowErrorToast(res.m_result, true)
    local idCampaign = entrustData:EntrustComponentInfo().m_campaign_id
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, idCampaign)
  elseif moveTeam ~= nil then
    local cfg = event:Cfg()
    moveTeam._idEvent = cfg.TargetID
    moveTeam._uiHead:GetGameObject():SetActive(false)
  end
  YIELD(TT, 100)
  for k, v in pairs(self._dicTeam) do
    v._uiHead:FlushUi()
  end
  self:UnLock(lockName)
end

_class("UIN30EntrustLineNode", UICustomWidget)
UIN30EntrustLineNode = UIN30EntrustLineNode

function UIN30EntrustLineNode:Constructor()
end

function UIN30EntrustLineNode:OnShow(uiParams)
  self._imgBg = self:GetUIComponent("Image", "imgBg")
  self._imgIcon = self:GetUIComponent("Image", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN30EntrustLineNode:OnHide()
end

function UIN30EntrustLineNode:SetEvent(event)
  self._event = event
  self._txtName.gameObject:SetActive(false)
  self._txtName:SetText(self._event:DebugName())
end

function UIN30EntrustLineNode:ButtonOnClick(go)
  self:RootUIOwner():EventOnClick(self._event, go)
end

function UIN30EntrustLineNode:FlushUi()
  self:GetGameObject():SetActive(self._event:IsVisible())
  local atlas = self:RootUIOwner():GetAtlas()
  local bgName = self._event:GetIconBgName()
  if bgName ~= nil then
    self._imgBg.gameObject:SetActive(true)
    self._imgBg.sprite = atlas:GetSprite(bgName)
  else
    self._imgBg.gameObject:SetActive(false)
  end
  local iconName = self._event:GetIconName()
  if iconName ~= nil then
    self._imgIcon.gameObject:SetActive(true)
    self._imgIcon.sprite = atlas:GetSprite(iconName)
  else
    self._imgIcon.gameObject:SetActive(false)
  end
end

function UIN30EntrustLineNode:PlayAnimation(animName)
  self._animation:Play(animName)
end

_class("UIN30EntrustLineLine", UICustomWidget)
UIN30EntrustLineLine = UIN30EntrustLineLine

function UIN30EntrustLineLine:Constructor()
end

function UIN30EntrustLineLine:OnShow(uiParams)
  self._rect = self:GetGameObject().transform
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN30EntrustLineLine:OnHide()
end

function UIN30EntrustLineLine:SetLine(line)
  self._line = line
end

function UIN30EntrustLineLine:SetPos(preEvent, nxtEvent)
  self._preEvent = preEvent
  self._nxtEvent = nxtEvent
  local from = preEvent:GetGameObject().transform.anchoredPosition
  local to = nxtEvent:GetGameObject().transform.anchoredPosition
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end

function UIN30EntrustLineLine:FlushUi()
  self:GetGameObject():SetActive(self._line:IsVisible())
end

function UIN30EntrustLineLine:PlayAnimation(animName)
  self._animation:Play(animName)
end

_class("UIN30EntrustTeamData", Object)
UIN30EntrustTeamData = UIN30EntrustTeamData

function UIN30EntrustTeamData:Constructor(cfg)
  self._cfg = cfg
  self._uiTeam = nil
  self._uiHead = nil
  self._isVisible = false
  self._isPass = false
  self._idEvent = nil
end

_class("UIN30EntrustLineTeam", UICustomWidget)
UIN30EntrustLineTeam = UIN30EntrustLineTeam

function UIN30EntrustLineTeam:Constructor()
end

function UIN30EntrustLineTeam:OnShow(uiParams)
  self._uiFinish = self:GetUIComponent("RectTransform", "uiFinish")
  self._imgIcon = self:GetUIComponent("Image", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN30EntrustLineTeam:OnHide()
end

function UIN30EntrustLineTeam:SetTeam(team)
  self._team = team
end

function UIN30EntrustLineTeam:FlushUi()
  self:GetGameObject():SetActive(self._team._isVisible)
  if self._team._isVisible then
    local atlas = self:RootUIOwner():GetAtlas()
    self._uiFinish.gameObject:SetActive(self._team._isPass)
    self._imgIcon.sprite = atlas:GetSprite(self._team._cfg.TeamIcon)
    local order = StringTable.Get(self._team._cfg.TeamOrder)
    local nameValue = string.format("<size=52><color=#FFE125>%s</color></size>", order)
    nameValue = nameValue .. StringTable.Get(self._team._cfg.TeamName)
    self._txtName:SetText(nameValue)
  end
end

function UIN30EntrustLineTeam:PlayAnimation(animName)
  self._animation:Play(animName)
end

_class("UIN30EntrustLineTeamHead", UICustomWidget)
UIN30EntrustLineTeamHead = UIN30EntrustLineTeamHead

function UIN30EntrustLineTeamHead:Constructor()
end

function UIN30EntrustLineTeamHead:OnShow(uiParams)
  self._imgIcon = self:GetUIComponent("Image", "imgIcon")
end

function UIN30EntrustLineTeamHead:OnHide()
end

function UIN30EntrustLineTeamHead:SetTeam(team)
  self._team = team
end

function UIN30EntrustLineTeamHead:FlushUi()
  self:GetGameObject():SetActive(self._team._isVisible)
  if self._team._isVisible then
    local atlas = self:RootUIOwner():GetAtlas()
    local uiEvent = self:RootUIOwner()._widgetEventsDic[self._team._idEvent]
    self._imgIcon.sprite = atlas:GetSprite(self._team._cfg.TeamHeadIcon)
    self:GetGameObject().transform.anchoredPosition = uiEvent:GetGameObject().transform.anchoredPosition
  end
end
