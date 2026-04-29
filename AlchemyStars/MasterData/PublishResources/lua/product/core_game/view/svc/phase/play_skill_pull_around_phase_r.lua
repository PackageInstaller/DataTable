require("play_skill_phase_base_r")
_class("PlaySkillPullAroundPhase", PlaySkillPhaseBase)
PlaySkillPullAroundPhase = PlaySkillPullAroundPhase

function PlaySkillPullAroundPhase:PlayFlight(TT, casterEntity, phaseParam)
  local pullAroundParam = phaseParam
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.PullAround)
  local beHitbackEntityID = result:GetTargetID()
  local targetPos = result:GetGridPos()
  local pieceChangeTable = result:GetGridElementChangeTable()
  local boardServiceRender = self._world:GetService("BoardRender")
  local targetEntity = self._world:GetEntityByID(beHitbackEntityID)
  local emptyGrids = {}
  for pos, pieceType in pairs(pieceChangeTable) do
    emptyGrids[#emptyGrids + 1] = boardServiceRender:CreateEmptyGridEffectEntity(pos)
  end
  local damageResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Damage)
  local skillID = skillEffectResultContainer:GetSkillID()
  if damageResult then
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(pullAroundParam:GetHitAnimationName()):SetHandleBeHitParam_DamageInfo(damageResult:GetDamageInfo(1)):SetHandleBeHitParam_DamagePos(damageResult:GetGridPos()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
    self:SkillService():HandleBeHit(TT, beHitParam)
  else
    targetEntity:SetAnimatorControllerTriggers({
      pullAroundParam:GetHitAnimationName()
    })
  end
  local gridPos = boardServiceRender:GetRealEntityGridPos(targetEntity)
  targetEntity:AddGridMove(pullAroundParam:GetMoveSpeed(), targetPos, gridPos)
  while targetEntity:GridMove() do
    YIELD(TT)
  end
  for i = 1, #emptyGrids do
    self._world:DestroyEntity(emptyGrids[i])
  end
  for pos, pieceType in pairs(pieceChangeTable) do
    boardServiceRender:ReCreateGridEntity(pieceType, pos, false)
  end
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:CanChangePieceToGray() then
    boardServiceRender:ReCreateGridEntity(PieceType.None, targetEntity:GridLocation().Position)
  end
end
