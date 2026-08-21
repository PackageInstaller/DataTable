require("play_skill_phase_base_r")
_class("PlaySkillPhaseMultiGridEffect", PlaySkillPhaseBase)
PlaySkillPhaseMultiGridEffect = PlaySkillPhaseMultiGridEffect

function PlaySkillPhaseMultiGridEffect:PlayFlight(TT, casterEntity, phaseParam)
  local gridEff = phaseParam:GetGridEff()
  local hitAnim = phaseParam:GetHitAnim()
  local hitEff = phaseParam:GetHitEff()
  local interval = phaseParam:GetInterval()
  local random = phaseParam:GetRandom()
  local expectionGrid = phaseParam:GetExpectionGrid()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  for i, v in ipairs(gridDataArray) do
    local grid = v
    local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, grid)
    if damageResult then
      self:_ShowDamage(damageResult, skillEffectResultContainer, hitAnim, hitEff, casterEntity, grid, phaseParam:HitTurnToTarget(), skillID)
    end
  end
  local effService = self._world:GetService("Effect")
  local grids = self:RemoveExpectionGrid(castPos, gridDataArray, expectionGrid)
  local idx = self:Shuffle(random, table.count(grids))
  for i, v in ipairs(idx) do
    local pos = grids[v]
    effService:CreateWorldPositionEffect(gridEff, pos)
    YIELD(TT, interval)
  end
end

function PlaySkillPhaseMultiGridEffect:Shuffle(random, count)
  local idx = {}
  for i = 1, count do
    table.insert(idx, i)
  end
  if not random then
    return idx
  end
  local tab = {}
  local randomSvc = self._world:GetService("RandomRender")
  while true do
    local n = randomSvc:RenderRand(1, table.count(idx))
    if idx[n] then
      table.insert(tab, idx[n])
      table.remove(idx, n)
      if table.count(idx) == 0 then
        break
      end
    end
  end
  return tab
end

function PlaySkillPhaseMultiGridEffect:RemoveExpectionGrid(castPos, gridDataArray, expectionGrid)
  local grids = {}
  for i, v in ipairs(gridDataArray) do
    local isExpectionGrid = false
    for j, vj in ipairs(expectionGrid) do
      if v.x == castPos.x + vj.x and v.y == castPos.y + vj.y then
        isExpectionGrid = true
      end
    end
    if not isExpectionGrid then
      table.insert(grids, v)
    end
  end
  return grids
end

function PlaySkillPhaseMultiGridEffect:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local skillService = self:SkillService()
    local targetDamage = damageResult:GetDamageInfo(1)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(skillService.HandleBeHit, skillService, beHitParam)
  end
end
