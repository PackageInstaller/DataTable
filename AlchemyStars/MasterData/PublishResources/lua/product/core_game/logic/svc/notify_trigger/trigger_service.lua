_class("TriggerService", BaseService)
TriggerService = TriggerService

function TriggerService:Constructor(world)
  self._listeners = {}
  self._factory = TriggerFactory:New()
end

function TriggerService:ClearTriggers()
  self._listeners = {}
end

function TriggerService:Initialize()
  self._showLog = self._world:RunAtClient()
end

function TriggerService:CreateTrigger(triggerOwner, triggerCond, world)
  return self._factory:CreateTrigger(triggerOwner, triggerCond, world)
end

function TriggerService:Notify(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local notifyEntityID = 0
  if notifyEntity then
    notifyEntityID = notifyEntity:GetID()
  end
  local canNotify = self:_CheckEntityCanNotify(notifyEntity, notify)
  if not canNotify then
    Log.debug("[TriggerService] Notify is Forbidden, entityID=", notifyEntityID, " notifyType=", notify:GetNotifyType())
    return
  end
  self:SaveConvertInfo(notify)
  if self._showLog then
    Log.debug("TriggerService Notify ", notify:GetNotifyType(), GetEnumKey("NotifyType", notify:GetNotifyType()), " NotifyEntity=", notifyEntityID)
  end
  local detailLogger = self._world:GetDetailMatchLogger()
  detailLogger:BeginNotify(notify)
  local notifyType = notify:GetNotifyType()
  local listeners = self._listeners[notifyType]
  if not listeners then
    detailLogger:EndNotify(notify)
    return
  end
  local triggers = {}
  for i, combinedTrigger in ipairs(listeners) do
    if combinedTrigger:IsActive() and self:IsNotifyCanTrigger(notify, combinedTrigger) then
      combinedTrigger:OnNotifyWrapper(notify)
      if combinedTrigger:IsSatisfied(notify) then
        table.insert(triggers, combinedTrigger)
      end
    end
  end
  local needDetailLog = false
  if 0 < #triggers then
    needDetailLog = true
  end
  if needDetailLog then
    detailLogger:BeginTriggerSuccess(triggers)
  end
  for i, trigger in ipairs(triggers) do
    detailLogger:RecordTriggerSuccess(trigger)
    trigger:OnTrigger(notify)
  end
  if needDetailLog then
    detailLogger:EndTriggerSuccess()
  end
  local nt = notify:GetSubordinateNotify()
  if nt then
    self:Notify(nt)
  end
  detailLogger:EndNotify(notify)
end

function TriggerService:Attach(trigger)
  local notifyTypeList = trigger:GetNotifyType()
  for k, notifyType in ipairs(notifyTypeList) do
    local listeners = self._listeners[notifyType]
    if not listeners then
      listeners = {}
      self._listeners[notifyType] = listeners
    end
    listeners[#listeners + 1] = trigger
  end
end

function TriggerService:Detach(trigger)
  local notifyTypeList = trigger:GetNotifyType()
  for k, notifyType in ipairs(notifyTypeList) do
    local listeners = self._listeners[notifyType]
    if not listeners then
      Log.error("detach trigger error, not attached!")
      return
    end
    table.removev(listeners, trigger)
  end
end

function TriggerService:IsNotifyCanTrigger(notify, combinedTrigger)
  if notify:GetNotifyType() == NotifyType.MonsterDead or notify:GetNotifyType() == NotifyType.AddControlBuffEnd or notify:GetNotifyType() == NotifyType.HitBackEnd or notify:GetNotifyType() == NotifyType.TractionEnd then
    return true
  end
  local triggerList = combinedTrigger:GetTriggers()
  for _, trigger in ipairs(triggerList) do
    local entity = trigger:GetOwnerEntity()
    if entity then
      return not entity:BuffComponent():IsBuffFreeze()
    end
  end
  return true
end

function TriggerService:_CheckEntityCanNotify(notifyEntity, notify)
  if not notifyEntity then
    return true
  end
  local notifyType = notify:GetNotifyType()
  local buffSvc = self._world:GetService("BuffLogic")
  if buffSvc:IsPetNotifyTypeDisable(notifyEntity, notifyType) then
    return false
  end
  return true
end

function TriggerService:GetPlayerMoveEndPosByNotify(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posTeam = teamEntity:GridLocation().Position
  local curMovePos = posTeam
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    curMovePos = notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.Teleport or notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:HasPet() then
      notifyEntity = notifyEntity:Pet():GetOwnerTeamEntity()
    end
    if teamEntity:GetID() == notifyEntity:GetID() then
      curMovePos = notify:GetPosNew()
    end
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd and notify:GetDefenderId() == teamEntity:GetID() then
    curMovePos = notify:GetPosEnd()
  elseif notify:GetNotifyType() == NotifyType.TractionEnd and notify:GetDefenderId() == teamEntity:GetID() then
    curMovePos = notify:GetPosEnd()
  end
  return curMovePos
end

function TriggerService:GetPlayerMoveBeginPosByNotify(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posTeam = teamEntity:GridLocation().Position
  local moveBeginPos = posTeam
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    moveBeginPos = notify:GetOldPos()
  elseif notify:GetNotifyType() == NotifyType.Teleport or notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:HasPet() then
      notifyEntity = notifyEntity:Pet():GetOwnerTeamEntity()
    end
    if teamEntity:GetID() == notifyEntity:GetID() then
      moveBeginPos = notify:GetPosOld()
    end
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd and notify:GetDefenderId() == teamEntity:GetID() then
    moveBeginPos = notify:GetPosStart()
  elseif notify:GetNotifyType() == NotifyType.TractionEnd and notify:GetDefenderId() == teamEntity:GetID() then
    moveBeginPos = notify:GetPosStart()
  end
  return moveBeginPos
end

function TriggerService:SaveConvertInfo(notify)
end
