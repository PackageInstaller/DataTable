_class("UIN15ChessController", UIController)
UIN15ChessController = UIN15ChessController

function UIN15ChessController:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UIN15ChessController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_CHESS)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
    self._chess_cpt = self._campaign:GetComponent(ECampaignChessComponentID.ECAMPAIGN_CHESS_MISSION)
    self._chess_info = self._chess_cpt:GetComponentInfo()
    if not self._campaign:CheckComponentOpen(ECampaignChessComponentID.ECAMPAIGN_CHESS_MISSION) then
      res.m_result = self._campaign:CheckComponentOpenClientError(ECampaignChessComponentID.ECAMPAIGN_CHESS_MISSION)
      self._campModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  self._process = self._campModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_CHESS)
end

function UIN15ChessController:OnShow(uiParams)
  self:_InitParams(uiParams)
  self:_AttachEvents()
  self:_InitWidget()
  self:_Refresh()
  self:_OnShow()
end

function UIN15ChessController:_InitParams(uiParams)
  self._timerHolder = UITimerHolder:New()
  self._introState = false
  self._lastUIName = uiParams[1]
  if not self._lastUIName then
    self._lastUIName = UIStateType.UIMain
  end
  UIN15ChessController.NodeCfg = {
    [MatchType.MT_Chess] = {
      [1] = {
        normal = "N15_warchessxxg_normal",
        press = "N15_warchessxxg_normal",
        lock = "N15_warchessxxg_locking",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "N15_warchessxxg_star2",
        passStar = "N15_warchessxxg_star1"
      }
    }
  }
end

function UIN15ChessController:_OnShow()
  local lockName = "UIActivity_ChessMissionController_Enter"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
  self:_ClearNewFlag()
end

function UIN15ChessController:_ClearNewFlag()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    return
  end
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
    if res:GetSucc() then
    end
  end, self)
end

function UIN15ChessController:_SetRemainingTime(endTime)
  if not self._txt_desc then
    self._txt_desc = self:GetUIComponent("UILocalizationText", "_txt_desc")
  end
  local str = "str_chess_remain_time"
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local endtime = endTime
  remainTime = endtime - curtime
  self._txt_desc:SetText(StringTable.Get(str, N15ToolFunctions.GetRemainTime(remainTime, "f7155b")))
end

function UIN15ChessController:_InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  local cfg = Cfg.cfg_chess[1]
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, self._lastUIName, UIStateType.UIMain, nil, self._campaign._id)
  end, function()
    self:ShowDialog("UIChessIntro", cfg.ChessIntroTitle, cfg.ChessIntro)
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._intro = self:GetUIComponent("UILocalizationText", "intro")
  self._Img = self:GetUIComponent("RawImageLoader", "Img")
  self._introContent = self:GetUIComponent("UILocalizationText", "introContent")
  self._introObj = self:GetGameObject("introObj")
end

function UIN15ChessController:OnHide()
  UIN15ChessController.NodeCfg = nil
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIN15ChessController.super:Dispose()
end

function UIN15ChessController:_Refresh()
  self:FlushNodes()
  self:_SetTimeInfo()
  self:_RefCfgView()
end

function UIN15ChessController:_RefCfgView()
  local cfg = Cfg.cfg_chess[1]
  self._intro:SetText(StringTable.Get(cfg.ChessContent))
end

function UIN15ChessController:_SetTimeInfo()
  local endTime = self._chess_cpt:GetComponentInfo().m_close_time
  self:_SetRemainingTime(endTime)
end

function UIN15ChessController:FlushNodes()
  local cmpID = self._chess_cpt:GetComponentCfgId()
  local extra_cfg = Cfg.cfg_component_line_mission_extra({ComponentID = cmpID})
  local extra_width = extra_cfg[1].MarginRight
  local missionCfgs_temp = Cfg.cfg_component_chess({ComponentID = cmpID})
  local missionCfgs = {}
  for _, cfg in pairs(missionCfgs_temp) do
    missionCfgs[cfg.MissionID] = cfg
  end
  self._allMissionCfgs = missionCfgs
  local unlockInfo = {}
  local firstMissionID
  for _, cfg in pairs(missionCfgs) do
    if unlockInfo[cfg.NeedMissionId] == nil then
      unlockInfo[cfg.NeedMissionId] = {}
    end
    unlockInfo[cfg.NeedMissionId][cfg.MissionID] = cfg
    if cfg.NeedMissionId == 0 then
      firstMissionID = cfg.MissionID
    end
  end
  local showMission = {}
  local levelCount, lineCount = 0, 0
  local lastMissionID = firstMissionID
  if next(self._chess_info.m_pass_mission_info) then
    for missionID, passInfo in pairs(self._chess_info.m_pass_mission_info) do
      if not showMission[missionID] then
        showMission[missionID] = missionCfgs[missionID]
        levelCount = levelCount + 1
      end
      if unlockInfo[missionID] then
        for id, cfg in pairs(unlockInfo[missionID]) do
          if not showMission[id] then
            showMission[id] = missionCfgs[id]
            levelCount = levelCount + 1
          end
          if cfg.NeedMissionId ~= 0 then
            lineCount = lineCount + 1
          end
        end
      end
    end
  else
    showMission[firstMissionID] = missionCfgs[firstMissionID]
    levelCount = 1
  end
  local flag = true
  while flag do
    lastMissionID = self:_GetLastMissionID(lastMissionID)
    if not showMission[lastMissionID] then
      flag = false
    end
  end
  if lastMissionID ~= 0 and lastMissionID then
    levelCount = levelCount + 1
    lineCount = lineCount + 1
    showMission[lastMissionID] = missionCfgs[lastMissionID]
  end
  self._nodesPool:SpawnObjects("UIN15ChessMapNode", levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects("UIN15ChessMapLine", lineCount)
  local lines = self._linesPool:GetAllSpawnList()
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    local last = false
    local func
    if lastMissionID == missionID then
      last = true
    else
      last = false
      
      function func(stageId, worldPos)
        self:_OnNodeClick(stageId, worldPos)
      end
    end
    local last2 = false
    if lastMissionID ~= 0 and lastMissionID and missionCfgs[lastMissionID].NeedMissionId == missionID and missionID ~= firstMissionID then
      last2 = true
    end
    uiNode:SetData(cfg, self._chess_info.m_pass_mission_info[missionID], func, last, last2)
    nodeIdx = nodeIdx + 1
    if cfg.NeedMissionId ~= 0 then
      local n1 = showMission[cfg.NeedMissionId]
      local n2 = cfg
      local line = lines[lineIdx]
      line:Flush(Vector2(n2.MapPosX, n2.MapPosY), Vector2(n1.MapPosX, n1.MapPosY))
      lineIdx = lineIdx + 1
    end
  end
  local top = -99999999
  for _, cfg in pairs(showMission) do
    top = math.max(top, cfg.MapPosY)
  end
  local high = math.abs(top + extra_width)
  high = math.max(self._safeAreaSize.y, high)
  self._contentRect.sizeDelta = Vector2(self._contentRect.sizeDelta.x, high)
  self._contentRect.anchoredPosition = Vector2(0, self._safeAreaSize.y - high)
end

function UIN15ChessController:_GetLastMissionID(missionID)
  for id, cfg in pairs(self._allMissionCfgs) do
    if cfg.NeedMissionId == missionID then
      return id
    end
  end
  return nil
end

function UIN15ChessController:_OnNodeClick(stageId, worldPos)
  local pos = self._allMissionCfgs[stageId].MapPosY
  local curPos = self._contentRect.anchoredPosition.y
  local areaHeight = 125
  local targetPos
  local down, top = -curPos + areaHeight, -curPos + self._safeAreaSize.y - areaHeight
  if pos < down then
    targetPos = curPos + down - pos
  elseif pos > top then
    targetPos = curPos + top - pos
  end
  self._scrollRect:StopMovement()
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
  if targetPos then
    local _moveTime = 0.5
    self._tweener = self._contentRect:DOAnchorPosY(targetPos, _moveTime)
    local moveLockName = "UIActivityLineMissionController_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, _moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos.position)
    end)
  else
    self:_EnterStage(stageId, worldPos.position)
  end
end

function UIN15ChessController:_EnterStage(stageId, worldPos)
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._shot:CleanRenderTexture()
  local rt = self._shot:RefreshBlurTexture()
  local scale = 1.3
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local offset = -(Vector2(screenPos.x, screenPos.y) - Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2)
  local autoFightShow = false
  local pointComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  self:ShowDialog("UIActivityLevelStage", stageId, self._chess_info.m_pass_mission_info[stageId], self._chess_cpt, rt, offset, self._safeAreaSize.x, self._safeAreaSize.y, scale, autoFightShow, pointComponent, true, true)
end

function UIN15ChessController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN15ChessController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
