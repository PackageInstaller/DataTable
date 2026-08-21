_class("SeasonTriggerBase", Object)
SeasonTriggerBase = SeasonTriggerBase

function SeasonTriggerBase:Constructor(root, cfg)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._seasonID = self._seasonModule:GetCurSeasonID()
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonManager = self._uiSeasonModule:SeasonManager()
  self._componentInfo = self._seasonModule:GetCurSeasonObj():GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._player = self._seasonManager:SeasonPlayerManager():GetPlayer()
  self._root = root
  self._cfg = cfg
  self._shape = nil
  self._type = self._cfg.Type
  self._state = SeasonTriggerState.Wait
  self._inSide = false
  self:_CreateShape()
end

function SeasonTriggerBase:Update(deltaTime)
  if self._state == SeasonTriggerState.Wait and self._shape and self._player and self._player:Transform() then
    if self._shape:OnCheck(self._player:Position()) then
      if not self._inSide then
        self._inSide = true
        if self:CheckCount() and self:Condition() then
          self:_OnTrigger()
        end
      end
    else
      self._inSide = false
    end
  end
end

function SeasonTriggerBase:CheckOverlapWithPlayer()
  if self._shape and self._player and self._player:Transform() then
    return self._shape:OnCheck(self._player:Position())
  end
end

function SeasonTriggerBase:Dispose()
  if self._shape then
    self._shape:Dispose()
    self._shape = nil
  end
  if self._syncTask then
    GameGlobal.TaskManager():KillTask(self._syncTask)
    self._syncTask = nil
  end
end

function SeasonTriggerBase:_OnTrigger()
  if self._type == SeasonTriggerType.Once then
    self._state = SeasonTriggerState.Finish
  end
  if self._cfg.Content and not self:FaultTolerant() then
    local id = self._cfg.Content.id
    local progress = self._cfg.Content.progress
    local seasonMapManger = self._seasonManager:SeasonMapManager()
    local eventPoint = seasonMapManger:GetEventPoint(id)
    if eventPoint then
      if self._cfg.Stop then
        self._seasonManager:SeasonPlayerManager():GetPlayer():Stop()
      end
      eventPoint:PlayExpress(progress, SeasonExpressTriggerType.Trigger, nil, function(id, progress)
        self:SyncTrigger(id, progress)
      end)
    end
  end
end

function SeasonTriggerBase:CheckCount()
  if self._type == SeasonTriggerType.Once then
    local clientInfo = self._componentInfo.m_client_info
    local key = tonumber(self._seasonID .. SeasonKey.Trigger .. self._cfg.ID)
    if clientInfo.ext[key] then
      return false
    else
      return true
    end
  elseif self._type == SeasonTriggerType.Count then
    local clientInfo = self._componentInfo.m_client_info
    local key = tonumber(self._seasonID .. SeasonKey.Trigger .. self._cfg.ID)
    if clientInfo.ext[key] then
      return clientInfo.ext[key] < self._cfg.Count
    else
      return true
    end
  end
  return true
end

function SeasonTriggerBase:Condition()
  local map
  if self._uiSeasonModule:IsBackTrack() then
    map = self._uiSeasonModule:GetTrackEventpointStatus()
  else
    map = self._componentInfo.m_stage_info
  end
  return self._seasonModule:CheckCondition(self._cfg.Condition, map)
end

function SeasonTriggerBase:_CreateShape()
  if self._cfg then
    local position = Vector3(self._cfg.Position[1], self._cfg.Position[2], self._cfg.Position[3])
    local rotation = self._cfg.Rotation
    local param = self._cfg.Param
    if self._cfg.Shape == SeasonTriggerShapeType.Rect then
      self._shape = SeasonShapeRect:New(self._root, self._cfg.ID, position, rotation, param)
    elseif self._cfg.Shape == SeasonTriggerShapeType.Circle then
      self._shape = SeasonShapeCircle:New(position, param)
    end
  end
end

function SeasonTriggerBase:SyncTrigger(eventPointID, progress)
  if (self._type == SeasonTriggerType.Once or self._type == SeasonTriggerType.Count) and self._cfg.Content and self._cfg.Content.id == eventPointID and self._cfg.Content.progress == progress then
    self._syncTask = GameGlobal.TaskManager():StartTask(function(TT)
      self:_SyncTrigger(TT)
    end, self)
  end
end

function SeasonTriggerBase:_SyncTrigger(TT)
  local clientInfo = self._componentInfo.m_client_info
  local key = tonumber(self._seasonID .. SeasonKey.Trigger .. self._cfg.ID)
  local count = 1
  if self._type == SeasonTriggerType.Count and clientInfo.ext[key] then
    count = clientInfo.ext[key] + count
  end
  local info = {}
  info[key] = count
  local req = self._seasonModule:HandleSeasonClientDataExt(TT, info)
  if req:GetSucc() then
    Log.info("SeasonTriggerBase sync trigger success.", key)
  end
end

function SeasonTriggerBase:FaultTolerant()
  if self._cfg.ID == 2 and self._componentInfo.m_stage_info[8002401] == 2 then
    self._player:ResetPosition()
    return true
  end
  return false
end
