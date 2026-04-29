require("base_ins_r")
_class("PlayConductDamageInstruction", BaseInstruction)
PlayConductDamageInstruction = PlayConductDamageInstruction

function PlayConductDamageInstruction:Constructor(paramList)
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._hitAnimName = paramList.hitAnimName
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._chainEffectID = tonumber(paramList.chainEffectID)
end

function PlayConductDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ConductDamage)
  if not results then
    return
  end
  for _, result in ipairs(results) do
    self:PlaySingleResult(TT, casterEntity, phaseContext, result)
  end
end

function PlayConductDamageInstruction:PlaySingleResult(TT, casterEntity, phaseContext, result)
  local atomDataArray = result:GetAtomDataArray()
  if #atomDataArray == 0 then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  local lastBeginnerID = result:GetCenterTargetID()
  local eCenterEntity = world:GetEntityByID(lastBeginnerID)
  fxsvc:CreateBeHitEffect(self._hitEffectID, eCenterEntity)
  local playSkillService = world:GetService("PlaySkill")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  for _, atom in ipairs(atomDataArray) do
    local damageResult = atom:GetDamageResult()
    local targetID = damageResult:GetTargetID()
    local eLast = world:GetEntityByID(lastBeginnerID)
    local eTarget = world:GetEntityByID(targetID)
    if eLast:HasView() and eTarget:HasView() then
      local goLast = eLast:View():GetGameObject()
      local goTarget = eTarget:View():GetGameObject()
      if goLast and tostring(goLast) ~= "null" and goTarget and tostring(goTarget) ~= "null" then
        local eLineFx = fxsvc:CreateEffect(self._chainEffectID, eLast)
        YIELD(TT)
        if eLineFx and eLineFx:View() and eLineFx:View():GetGameObject() then
          local goLine = eLineFx:View():GetGameObject()
          local csLineRenderer = goLine:GetComponentInChildren(typeof(UnityEngine.LineRenderer))
          csLineRenderer.useWorldSpace = true
          csLineRenderer:SetPosition(0, goLast.transform.position)
          csLineRenderer:SetPosition(1, goTarget.transform.position)
        end
      end
    end
    local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(eTarget):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageResult:GetDamageInfo(1)):SetHandleBeHitParam_DamagePos(damageResult:GetGridPos()):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
    playSkillService:HandleBeHit(TT, beHitParam)
    lastBeginnerID = targetID
  end
end
