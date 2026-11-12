local PlayerGuideData = class("PlayerGuideData")
local TimerManager = require("GameCore.Timer.TimerManager")
PanelId = require("GameCore.UI.PanelId")

function PlayerGuideData:Init()
  self.isProcessing = false
  self.openPanelId = 0
  EventManager.Add("OnEvent_PanelOnEnableById", self, self.OnEvent_PanelOnEnableById)
  EventManager.Add("Guide_CloseDisposablePanel", self, self.OnEvent_CloseDisposablePanel)
  EventManager.Add("Event_MainViewPopUpEnd", self, self.Event_PopUpEndCheckMainView)
  EventManager.Add("Guide_CloseWorldClassPopUp", self, self.OnEvent_UpdateWorldClass)
  EventManager.Add("Guide_PassiveCheck_Msg", self, self.Event_PassiveCheckMsg)
  self.runGroupId = 0
  self.runStepId = 0
  self._guideInitiativeTableData = {}
  self._guidePassiveTableData = {}
  self.tabGuideNewbie = {}
  self:HandleTableMsg()
end

function PlayerGuideData:UnInit()
  EventManager.Remove("OnEvent_PanelOnEnableById", self, self.OnEvent_PanelOnEnableById)
  EventManager.Remove("Guide_CloseDisposablePanel", self, self.OnEvent_CloseDisposablePanel)
  EventManager.Remove("Event_MainViewPopUpEnd", self, self.Event_PopUpEndCheckMainView)
  EventManager.Remove("Guide_CloseWorldClassPopUp", self, self.OnEvent_UpdateWorldClass)
  EventManager.Remove("Guide_PassiveCheck_Msg", self, self.Event_PassiveCheckMsg)
end

function PlayerGuideData:HandleTableMsg()
  local function foreach(guideData)
    if guideData.GuideDetectionType == GameEnum.guideDetectionType.InitiativeCheck then
      self._guideInitiativeTableData[guideData.Id] = guideData
    else
      self._guidePassiveTableData[guideData.Id] = guideData
    end
  end
  
  if self._guideInitiativeTableData == nil then
    self._guideInitiativeTableData = {}
  end
  if self._guidePassiveTableData == nil then
    self._guidePassiveTableData = {}
  end
  ForEachTableLine(DataTable.GuideGroup, foreach)
end

function PlayerGuideData:SetGuideNewbie(newbie)
  if newbie == nil then
    return
  end
  for i, v in pairs(newbie) do
    self.tabGuideNewbie[v.GroupId] = v.StepId
  end
end

function PlayerGuideData:GetGuideNewbie(groupId)
  if self.tabGuideNewbie[groupId] then
    return self.tabGuideNewbie[groupId]
  end
  return 0
end

function PlayerGuideData:GetGuideState()
  return self.isProcessing
end

function PlayerGuideData:CheckInGuideGroup(nId)
  return self.isProcessing and self.runGroupId == nId
end

function PlayerGuideData:SetPlayerLearnReq(groupId, stepId, type, season)
  self.tabGuideNewbie[groupId] = stepId
  if stepId == -1 then
    local function callallback()
      if stepId == -1 and not self.isProcessing and groupId ~= 1 then
        self:CheckHaveGuideData()
      end
    end
    
    if type and type == AllEnum.GuideType.Dorm then
      HttpNetHandler.SendMsg(NetMsgId.Id.dorm_learn_req, {GroupId = groupId, StepId = stepId}, nil, callallback)
    elseif type and type == AllEnum.GuideType.Soldier then
      HttpNetHandler.SendMsg(NetMsgId.Id.soldier_learn_req, {
        Season = season,
        GroupId = groupId,
        StepId = stepId
      }, nil, callallback)
    else
      HttpNetHandler.SendMsg(NetMsgId.Id.player_learn_req, {GroupId = groupId, StepId = stepId}, nil, callallback)
    end
  end
end

function PlayerGuideData:OnEvent_PanelOnEnableById(_panelId)
  if EditorSettings and EditorSettings.bJumpGuide then
    return
  end
  if PopUpManager.IsQueueOccupied() then
    if _panelId ~= PanelId.MainView then
      self.openPanelId = _panelId
      self:_ReleaseLoginGuideQueue()
    end
    return
  end
  if _panelId == PanelId.MainView then
    return
  end
  self.openPanelId = _panelId
  if self.isProcessing then
    return
  end
  self:CheckHaveGuideData()
end

function PlayerGuideData:OnEvent_CloseDisposablePanel(nPanelId)
  if self.openPanelId == nPanelId then
    self.openPanelId = PanelManager.GetCurPanelId()
  end
end

function PlayerGuideData:Event_PopUpEndCheckMainView()
end

function PlayerGuideData:OnEvent_UpdateWorldClass()
  if EditorSettings and EditorSettings.bJumpGuide then
    return
  end
  if PopUpManager.IsQueueOccupied() then
    return
  end
  if self.isProcessing then
    return
  end
  self:CheckHaveGuideData()
end

function PlayerGuideData:_ReleaseLoginGuideQueue()
  if self._fnLoginGuideDone == nil then
    return
  end
  local fnLoginGuideDone = self._fnLoginGuideDone
  self._fnLoginGuideDone = nil
  fnLoginGuideDone()
end

function PlayerGuideData:RunLoginGuide(callback)
  if EditorSettings and EditorSettings.bJumpGuide then
    if callback ~= nil then
      callback()
    end
    return
  end
  self._fnLoginGuideDone = callback
  self.openPanelId = PanelId.MainView
  self:CheckHaveGuideData()
  if not self.isProcessing then
    self._fnLoginGuideDone = nil
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerGuideData:NoteDormAbort(nGroupId)
  self._mapDormAbortCd = self._mapDormAbortCd or {}
  self._mapDormAbortCd[nGroupId] = TimerManager.GetUnscaledTime() + 3
  self._nDormAbortFrame = CS.UnityEngine.Time.frameCount
  self._nDormAbortGroup = nGroupId
end

function PlayerGuideData:_DormBlocked(nGroupId)
  if self._nDormAbortGroup == nGroupId and self._nDormAbortFrame == CS.UnityEngine.Time.frameCount then
    return true
  end
  local nCd = self._mapDormAbortCd and self._mapDormAbortCd[nGroupId]
  if nCd ~= nil and nCd > TimerManager.GetUnscaledTime() then
    return true
  end
  return false
end

function PlayerGuideData:CheckHaveGuideData()
  if self.isProcessing then
    return
  end
  for i, v in pairs(self._guideInitiativeTableData) do
    if (self.tabGuideNewbie[v.Id] == nil or self.tabGuideNewbie[v.Id] ~= -1) and v.IsActive then
      local bGuide = true
      if v.GuidePrepose ~= nil and bGuide then
        bGuide = self:CheckGuidePrePose(v.GuidePrepose, v.PreposeParams)
      end
      if v.GuidePrepose2 ~= nil and bGuide then
        bGuide = self:CheckGuidePrePose(v.GuidePrepose2, v.PreposeParams2)
      end
      bGuide = bGuide and self:CheckGuidePost(v) and self:CheckGuidetrigger(v)
      if bGuide and not self:_DormBlocked(v.Id) then
        self.runGroupId = v.Id
        self.runStepId = self.tabGuideNewbie[v.Id] or 0
        self:OpenGuidePanel()
        break
      end
    end
  end
end

function PlayerGuideData:CheckGuidePrePose(nPoseType, param)
  if nPoseType == GameEnum.guideprepose.PreGuide then
    local _prepose = decodeJson(param)
    local _tmpGId = _prepose[1]
    if self.tabGuideNewbie[_tmpGId] and self.tabGuideNewbie[_tmpGId] == -1 then
      return true
    end
  elseif nPoseType == GameEnum.guideprepose.FinishDungeon then
    local _prepose = decodeJson(param)
    local nStar = PlayerData.Mainline:GetMianlineLevelStar(_prepose[1])
    if type(nStar) == "number" then
      return true
    end
  elseif nPoseType == GameEnum.guideprepose.WorldClass then
    local _prepose = decodeJson(param)
    local nWorldClass = PlayerData.Base:GetWorldClass()
    if nWorldClass >= _prepose[1] then
      return true
    end
  elseif nPoseType == GameEnum.guideprepose.UnlockFunction then
    local _prepose = decodeJson(param)
    local funId = _prepose[1]
    if PlayerData.Base:CheckFunctionUnlock(funId, false) then
      return true
    end
  elseif nPoseType == GameEnum.guideprepose.HoldItem then
    local _prepose = decodeJson(param)
    local _itemId = _prepose[1]
    local _itemCount = _prepose[2]
    local hasCount = PlayerData.Item:GetItemCountByID(_itemId)
    if _itemCount <= hasCount then
      return true
    end
  elseif nPoseType == GameEnum.guideprepose.FinishStarTowerQuest then
    local _prepose = decodeJson(param)
    local _taskId = _prepose[1]
    local tbCore, tbNormal = PlayerData.Quest:GetStarTowerQuestData()
    for i1, v1 in pairs(tbCore) do
      if v1.nTid == _taskId and v1.nStatus > 0 then
        return true
      end
    end
    for i1, v1 in pairs(tbNormal) do
      if v1.nTid == _taskId and v1.nStatus > 0 then
        return true
      end
    end
  elseif nPoseType == GameEnum.guideprepose.UnFinishCharacterPlot then
    local _prepose = decodeJson(param)
    local data = ConfigTable.GetData("Plot", _prepose[1])
    local charid = data.Char
    local isFinish = PlayerData.Char:IsCharPlotFinish(charid, _prepose[1])
    if isFinish == false then
      return true
    end
  elseif nPoseType == (GameEnum.guideprepose.FinishDormQuest or 8) then
    local _prepose = decodeJson(param)
    local mapQuest = PlayerData.Quest:GetDormQuestDataById(_prepose[1])
    if mapQuest ~= nil and mapQuest.nStatus == 2 then
      return true
    end
  elseif nPoseType == (GameEnum.guideprepose.FinishDormQuestGroup or 9) then
    local _prepose = decodeJson(param)
    local nGroupId = _prepose[1]
    local nCurGroup, nGroupState = PlayerData.PlayerDormData:GetDormQuestDataWithGroup()
    if nGroupState == 1 and nCurGroup == nGroupId then
      return true
    end
    local bAllDone = true
    local nCount = 0
    
    local function foreachQuest(mapData)
      if mapData.DormQuestGroup == nGroupId then
        nCount = nCount + 1
        local mapQuest = PlayerData.Quest:GetDormQuestDataById(mapData.Id)
        if mapQuest == nil or mapQuest.nStatus ~= 2 then
          bAllDone = false
        end
      end
    end
    
    ForEachTableLine(DataTable.DormQuest, foreachQuest)
    if 0 < nCount and bAllDone then
      return true
    end
  else
    return true
  end
end

function PlayerGuideData:CheckGuidePost(data)
  if data.GuidePost == GameEnum.guidepost.UnDoneGuide then
    local _prepose = decodeJson(data.PostParams)
    local _tmpGId = _prepose[1]
    if self.tabGuideNewbie[_tmpGId] == nil or self.tabGuideNewbie[_tmpGId] ~= -1 then
      return true
    end
    return false
  else
    return true
  end
end

function PlayerGuideData:CheckGuidetrigger(data)
  if data.TowerState then
    local bState = PlayerData.State.mapStarTowerState and PlayerData.State.mapStarTowerState.Id ~= 0
    if bState then
      return false
    end
  end
  if data.GuideTrigger == GameEnum.guidetrigger.PreGuide then
    local _triggerParams = decodeJson(data.TriggerParams)
    if self.tabGuideNewbie[_triggerParams[1]] and self.tabGuideNewbie[_triggerParams[1]] == -1 then
      return true
    end
  elseif data.GuideTrigger == GameEnum.guidetrigger.WorldClass then
    local _triggerParams = decodeJson(data.TriggerParams)
    local nWorldClass = PlayerData.Base:GetWorldClass()
    if nWorldClass >= _triggerParams[1] then
      return true
    end
  elseif data.GuideTrigger == GameEnum.guidetrigger.OpenInterface then
    local _triggerParams = decodeJson(data.TriggerParams)
    if _triggerParams[1] == self.openPanelId then
      return true
    end
  elseif data.GuideTrigger == GameEnum.guidetrigger.FinishLastStep then
    return true
  elseif data.GuideTrigger == GameEnum.guidetrigger.FinishDungeon then
    local _triggerParams = decodeJson(data.TriggerParams)
    local nStar = PlayerData.Mainline:GetMianlineLevelStar(_triggerParams[1])
    if type(nStar) == "number" then
      return true
    end
  elseif data.GuideTrigger == GameEnum.guidetrigger.UnlockFunction then
    local _triggerParams = decodeJson(data.TriggerParams)
    local funId = _triggerParams[1]
    if PlayerData.Base:CheckFunctionUnlock(funId, false) then
      return true
    end
  else
    return true
  end
end

function PlayerGuideData:OpenGuidePanel()
  print("[新手引导]当前触发的引导组Id:" .. tostring(self.runGroupId))
  self.isProcessing = true
  EventManager.Hit("Event_ActiveGuidePanel")
end

function PlayerGuideData:FinishCurrentGroup(isCheck)
  print("[新手引导]引导结束，引导组Id:" .. tostring(self.runGroupId))
  self.isProcessing = false
  if isCheck then
    self:CheckHaveGuideData()
  end
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  DormGuideAdapter.OnGuideReleased()
  if not self.isProcessing then
    self:_ReleaseLoginGuideQueue()
  end
end

function PlayerGuideData:Event_PassiveCheckMsg(msg)
  if EditorSettings and EditorSettings.bJumpGuide then
    return
  end
  if self.isProcessing then
    if msg == "Guide_DormEnter" or msg == "Guide_DormEnterRoom2" then
      local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
      DormGuideAdapter.NotePassive(msg)
    end
    return
  end
  for i, v in pairs(self._guidePassiveTableData) do
    if (self.tabGuideNewbie[v.Id] == nil or self.tabGuideNewbie[v.Id] ~= -1) and v.IsActive and v.PassiveMsg == msg then
      local bGuide = true
      if v.GuidePrepose ~= nil and bGuide then
        bGuide = self:CheckGuidePrePose(v.GuidePrepose, v.PreposeParams)
      end
      if v.GuidePrepose2 ~= nil and bGuide then
        bGuide = self:CheckGuidePrePose(v.GuidePrepose2, v.PreposeParams2)
      end
      bGuide = bGuide and self:CheckGuidePost(v) and self:CheckGuidetrigger(v)
      if bGuide and not self:_DormBlocked(v.Id) then
        self.runGroupId = v.Id
        self.runStepId = self.tabGuideNewbie[v.Id] or 0
        self:OpenGuidePanel()
        break
      end
    end
  end
end

function PlayerGuideData:CheckGuideFinishById(id)
  if self.tabGuideNewbie[id] == nil or self.tabGuideNewbie[id] ~= -1 then
    return false
  end
  return true
end

return PlayerGuideData
