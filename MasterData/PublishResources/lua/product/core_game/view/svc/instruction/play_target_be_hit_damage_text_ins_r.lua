require("base_ins_r")
_class("PlayTargetBeHitDamageTextInstruction", BaseInstruction)
PlayTargetBeHitDamageTextInstruction = PlayTargetBeHitDamageTextInstruction

function PlayTargetBeHitDamageTextInstruction:Constructor(paramList)
end

function PlayTargetBeHitDamageTextInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playDamageService = world:GetService("PlayDamage")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  local damageResult = damageResultArray[curDamageIndex]
  local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
  if not damageInfo then
    return
  end
  local damageGridPos = damageResult:GetGridPos()
  local skillID = skillEffectResultContainer:GetSkillID()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local damageShowType = playDamageService:SingleOrGrid(skillID)
  damageInfo:SetShowType(damageShowType)
  damageInfo:SetRenderGridPos(damageGridPos)
  playDamageService:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo)
  local mtrAni = targetEntity:MaterialAnimationComponent()
  if mtrAni then
    mtrAni:PlayHit()
  end
end
