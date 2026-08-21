_class("BuffViewRide", BuffViewBase)
BuffViewRide = BuffViewRide

function BuffViewRide:IsNotifyMatch(notify)
  if notify then
    if notify:GetNotifyType() == NotifyType.MonsterTurnAfterAddBuffRound or notify:GetNotifyType() == NotifyType.BuffLoad or notify:GetNotifyType() == NotifyType.MonsterTurnAfterDelayedAddBuffRound then
      return true
    end
    local buffResult = self:GetBuffResult()
    if notify:GetNotifyType() == NotifyType.NormalEachAttackEnd then
      local n = notify
      return buffResult:GetNotifyPos() == n:GetAttackPos() and buffResult:GetTargetPos() == n:GetTargetPos() and buffResult:GetNotifyEntity() == n:GetAttackerEntity()
    end
    if notify:GetNotifyType() == NotifyType.TrapEachAttackEnd then
      local n = notify
      return buffResult:GetNotifyPos() == n:GetAttackPos() and buffResult:GetTargetPos() == n:GetTargetPos() and buffResult:GetNotifyEntity() == n:GetAttackerEntity()
    end
    if notify:GetNotifyType() == NotifyType.ActiveSkillAttackEnd or notify:GetNotifyType() == NotifyType.TrapActiveSkillEnd or notify:GetNotifyType() == NotifyType.BuffCastSkillAttackEnd then
      return buffResult:GetNotifyEntity() == notify:GetNotifyEntity()
    end
    if notify:GetNotifyType() == NotifyType.SingleChainSkillAttackFinish then
      return buffResult:GetNotifyEntity() == notify:GetNotifyEntity() and buffResult:GetNotifyChainSkillTimeIndex() == notify:GetChainSkillTimeIndex() and buffResult:GetNotifyChainSkillStageIndex() == notify:GetChainSkillStageIndex()
    end
  end
  return false
end

function BuffViewRide:PlayView(TT)
  local buffResult = self:GetBuffResult()
  if buffResult:HasPlayed() then
    return
  end
  buffResult:SetPlayed(true)
  local rideID = buffResult:GetRideEntityID()
  local mountID = buffResult:GetMountEntityID()
  local rideEntity = self._world:GetEntityByID(rideID)
  local gridLocRes = buffResult:GetDataGridLocationResult()
  local rideSvc = self._world:GetService("RideRender")
  if mountID then
    rideSvc:ReplaceRideRender(rideID, mountID, gridLocRes)
    return
  end
  local fromTrap = false
  if rideEntity:HasRideRender() then
    local rideCmpt = rideEntity:RideRender()
    local oriMountID = rideCmpt:GetMountID()
    if oriMountID == mountID then
      return
    end
    local oriMountEntity = self._world:GetEntityByID(oriMountID)
    if not oriMountEntity then
      Log.debug("BuffViewRide oriMountEntity is nil, id = ", oriMountID)
    end
    if oriMountEntity:HasTrapRender() then
      fromTrap = true
    end
    rideSvc:RemoveRideRender(rideID, oriMountID)
  end
  local pos = gridLocRes:GetGridLocResultBornPos()
  local offset = gridLocRes:GetGridLocResultBornOffset()
  rideSvc:SetNoRidePos(rideID, pos + offset, fromTrap)
end
