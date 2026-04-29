_class("SeasonMapEventPointTask", SeasonMapEventPointBase)
SeasonMapEventPointTask = SeasonMapEventPointTask

function SeasonMapEventPointTask:Constructor(owner, cfgMission, cfgEventPoint)
  self._seasonMapTask = owner
  self._seasonTaskModule = GameGlobal.GetModule(SeasonTaskModule)
  self._player = self._uiSeasonModule:SeasonManager():SeasonPlayerManager():GetPlayer()
  if not self._cfgMission.BackTrackID then
    Log.exception("season task eventpoint backtrack id is nil.", self._id)
  end
end

function SeasonMapEventPointTask:QuestID()
  return self._cfgMission.QuestID
end

function SeasonMapEventPointTask:Update(deltaTime)
  self.super.Update(self, deltaTime)
  if self._player then
    local show = self._show
    local range = self:RangeShow()
    if range and 0 < range then
      self:SetRangeShow(range >= Vector3.Distance(self._player:RealPosition(), self:Position()))
      if show ~= self._show then
        self._uiSeasonModule:SeasonManager():SeasonUIManager():UI():RefreshFunction(self)
      end
    end
  end
end

function SeasonMapEventPointTask:IsFinish()
  local map = self._seasonTaskModule:GetConditionMap()
  if map[self._curProgress] then
    return self:IsLastProgress(map[self._curProgress])
  else
    return false
  end
end

function SeasonMapEventPointTask:_CalcCurProgressExpress()
  if not self._isUnlock then
    self:ExpressShow(false)
    return
  end
  local map = GameGlobal.GetModule(SeasonTaskModule):GetConditionMap(self._componentInfo.m_stage_info)
  if map and map[self._id] then
    self._curProgress = map[self._id]
  end
  for progress, _condition in pairs(self._conditions) do
    if _condition and _condition:OnCheck(map) and progress > self._curProgress and self._progressExpress[progress] then
      self._curProgress = progress
    end
  end
  self._curProgressExpress = self._progressExpress[self._curProgress]
  if self._curProgressExpress then
    local result, content = self._curProgressExpress:ContainExpress(SeasonExpressType.Show)
    if result and content ~= nil and (not content.id or content.id == self._id) then
      self._expressShow = content.show
    end
  end
  self:ExpressShow(self._expressShow)
end

function SeasonMapEventPointTask:SyncProgress(progress)
  local map = self._seasonTaskModule:GetConditionMap()
  if map and map[self._id] and map[self._id] == progress then
    if self._curProgressExpress:NeedCount() then
      TaskManager:GetInstance():StartTask(function(TT)
        self:_RecordExpressCount(TT, progress)
      end, self)
    end
    return
  end
  Log.debug("SeasonMapEventPointTask play all expresses end.", self._id, progress)
  GameGlobal.UIStateManager():Lock("SeasonMapEventPointTask")
  TaskManager:GetInstance():StartTask(function(TT)
    local info = {
      quest_id = self:QuestID(),
      event_infos = {
        [self._id] = {
          event_id = self._id,
          status = progress
        }
      }
    }
    local res = self._seasonTaskModule:ReqSubmitClientInfo(TT, info)
    if res:GetSucc() and self._uiSeasonModule:InSeasaonRunning() then
      if self._curProgressExpress:NeedCount() then
        self:_RecordExpressCount(TT, progress)
      end
      self:_OnSyncSuccess(progress)
      if self._endCallBack then
        self._endCallBack(self._id, progress)
        self._endCallBack = nil
      end
      self:_SyncQuestNum(TT, progress)
    else
      Log.error("SeasonMapEventPointTask sync progress fail!", self._id, progress)
    end
    GameGlobal.UIStateManager():UnLock("SeasonMapEventPointTask")
  end, self)
end

function SeasonMapEventPointTask:_SyncQuestNum(TT, progress)
  if self:IsLastProgress(progress) then
    self._seasonMapTask:TrySyncQuestNum(TT, self:QuestID())
  end
end

function SeasonMapEventPointTask:BackTrackAble()
  if self._cfgMission.BackTrackID then
    return self._cfgMission.BackTrackID == self._uiSeasonModule:GetSeasonID()
  else
    return false
  end
end
