require("base_ins_r")
_class("PlayTargetFallToDeathInstruction", BaseInstruction)
PlayTargetFallToDeathInstruction = PlayTargetFallToDeathInstruction

function PlayTargetFallToDeathInstruction:Constructor(paramList)
  self._fallTime = tonumber(paramList.fallTime)
  self._fallDistance = tonumber(paramList.fallDistance)
  self._finishWaitTime = tonumber(paramList.finishWaitTime) or 500
end

function PlayTargetFallToDeathInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  local damageResCount = #damageResultArray
  if damageResCount <= 0 then
    return
  end
  local targetEntityID = damageResultArray[1]:GetTargetID()
  if targetEntityID == nil or targetEntityID < 0 then
    return
  end
  local damageInfo = damageResultArray[1]:GetDamageInfo(1)
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local targetObject = targetEntity:View():GetGameObject()
  local targetTransform = targetObject.transform
  local curPos = targetTransform.position
  local targetPos = curPos + Vector3(0, -self._fallDistance, 0)
  local dotween = targetTransform:DOMove(targetPos, self._fallTime / 1000, false)
  YIELD(TT, self._fallTime)
  local playDamageSvc = world:GetService("PlayDamage")
  playDamageSvc:UpdateTargetHPBar(TT, targetEntity, damageInfo)
  YIELD(TT, self._finishWaitTime)
end
