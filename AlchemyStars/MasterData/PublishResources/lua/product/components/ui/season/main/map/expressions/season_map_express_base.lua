_class("SeasonMapExpressBase", Object)
SeasonMapExpressBase = SeasonMapExpressBase

function SeasonMapExpressBase:Constructor(cfg, eventPoint)
  self._cfg = cfg
  self._eventPoint = eventPoint
  self._state = SeasonExpressState.NotStart
  self._content = nil
  self._param = nil
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._componentInfo = self._seasonModule:GetCurSeasonObj():GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._isSyncExpress = false
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
end

function SeasonMapExpressBase:BTrackPermanen()
  return self._eventPoint:BTrackPermanen()
end

function SeasonMapExpressBase:ExpressType()
  return self._cfg.ExpressType
end

function SeasonMapExpressBase:Content()
  return self._content
end

function SeasonMapExpressBase:Update(deltaTime)
end

function SeasonMapExpressBase:Dispose()
  self._param = nil
  self:_KillSyncTask()
end

function SeasonMapExpressBase:Play(param)
  self._param = param
  self._isSyncExpress = false
  if self._content ~= nil then
    if self:NoRepeat() then
      if self:IsPlayed() then
        self:Next()
      else
        self._isSyncExpress = true
        self:OnPlay()
      end
    else
      self:OnPlay()
    end
  end
end

function SeasonMapExpressBase:OnPlay()
end

function SeasonMapExpressBase:_Next()
  self._eventPoint:PlayNextExpress(self._param)
end

function SeasonMapExpressBase:Reset()
  self._state = SeasonExpressState.NotStart
  self:_KillSyncTask()
end

function SeasonMapExpressBase:State()
  return self._state
end

function SeasonMapExpressBase:_KillSyncTask()
  if self._syncTask then
    GameGlobal.TaskManager():KillTask(self._syncTask)
    self._syncTask = nil
  end
end

function SeasonMapExpressBase:NoRepeat()
  return self._cfg.NoRepeat == true
end

function SeasonMapExpressBase:IsPlayed()
  if self._cfg.NoRepeat == true then
    local id = self._eventPoint:GetID()
    local progress = self._eventPoint:CurProgress()
    local index = self._eventPoint:GetCurExpressIndex()
    if id and progress and index then
      local key = id .. progress .. index
      local clientInfo = self._componentInfo.m_client_info
      return clientInfo.ext[tonumber(key)] == 1
    end
  end
  return false
end

function SeasonMapExpressBase:SyncExpress(callBack)
  self._syncTask = GameGlobal.TaskManager():StartTask(function(TT)
    self:_SyncExpress(TT, callBack)
  end, self)
end

function SeasonMapExpressBase:_SyncExpress(TT, callBack)
  local info = {}
  local id = self._eventPoint:GetID()
  local progress = self._eventPoint:CurProgress()
  local index = self._eventPoint:GetCurExpressIndex()
  local reqId
  if id and progress and index then
    local key = id .. progress .. index
    reqId = tonumber(key)
    info[reqId] = 1
    if self._eventPoint:GroupID() > 0 then
      local cfgs = Cfg.cfg_season_mission({
        GroupID = self._eventPoint:GroupID()
      })
      if cfgs then
        for _, cfg in pairs(cfgs) do
          if cfg.ID ~= self._eventPoint:GetID() then
            key = cfg.ID .. progress .. index
            info[tonumber(key)] = 1
          end
        end
      end
    end
    if self._uiSeasonModule:IsBackTrack() then
      if self:BTrackPermanen() and reqId then
        local reqInfo = EvenPointInfo:New()
        reqInfo.event_id = reqId
        reqInfo.status = info[reqId]
        local req = GameGlobal.GetModule(SeasonTaskModule):ReqSubmitEventPointInfo(TT, reqInfo)
        if req:GetSucc() then
          if callBack then
            callBack()
          end
          Log.info("SeasonMapExpressBase sync express success.", id, progress, index)
        else
          self._eventPoint:InterruptExpress()
        end
      end
    else
      local req = self._seasonModule:HandleSeasonClientDataExt(TT, info)
      if req:GetSucc() then
        if callBack then
          callBack()
        end
        Log.info("SeasonMapExpressBase sync express success.", id, progress, index)
      else
        self._eventPoint:InterruptExpress()
      end
    end
  end
end

function SeasonMapExpressBase:Next()
  if self._isSyncExpress then
    self:SyncExpress(function()
      self._state = SeasonExpressState.Over
      self:_Next()
    end)
  else
    self._state = SeasonExpressState.Over
    self:_Next()
  end
end
