_class("SkillEffectCalc_HitBackAndDamage", Object)
SkillEffectCalc_HitBackAndDamage = SkillEffectCalc_HitBackAndDamage

function SkillEffectCalc_HitBackAndDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_HitBackAndDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attackerPos = attacker:GridLocation().Position
  local attackerDir = attacker:GridLocation().Direction
  local attackerBodyArea = attacker:BodyArea()
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  if #targetIDList == 1 and targetIDList[1] == -1 then
    return {}
  end
  local ignorePlayerBlock = skillEffectParam:GetIgnorePlayerBlock()
  local excludeCasterPos = skillEffectParam:ExcludeCasterPos()
  local beAttackEntityID = targetIDList[1]
  local targetEntity = self._world:GetEntityByID(beAttackEntityID)
  local skillRange = skillEffectCalcParam.skillRange
  local endPos, dir = self._skillEffectService:CalcHitbackEffect(attackerPos, attackerDir, attackerBodyArea, beAttackEntityID, HitBackDirectionType.Cross, HitBackType.PushAway, 100, HitBackCalcType.Instant, ignorePlayerBlock, excludeCasterPos, attacker, skillRange, nil, false, nil, HitBackInteractnWithBoardType.None, skillEffectParam:GetSkillType(), {})
  local hitBackCount = 1
  local hitBackDis = 1
  local startPos = targetEntity:GetGridPosition()
  local resultList = {}
  local skillEffectCalc = SkillEffectCalc_Damage:New(self._world)
  while targetEntity:GetGridPosition() ~= endPos do
    local damageCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam:GetCasterEntityID(), skillEffectCalcParam:GetTargetEntityIDs(), skillEffectParam, skillEffectCalcParam:GetSkillID(), skillEffectCalcParam:GetSkillRange(), skillEffectCalcParam:GetAttackPos(), targetEntity:GetGridPosition())
    local damageResultList = skillEffectCalc:DoSkillEffectCalculator(damageCalcParam)
    table.appendArray(resultList, damageResultList)
    local hitBackEffectResult = self._skillEffectService:CalcHitbackEffectResult(attackerPos, attackerDir, attackerBodyArea, beAttackEntityID, HitBackDirectionType.Cross, HitBackType.PushAway, hitBackDis, HitBackCalcType.Instant, ignorePlayerBlock, excludeCasterPos, attacker, skillRange, nil, false, nil, HitBackInteractnWithBoardType.None, skillEffectParam:GetSkillType(), {})
    table.insert(resultList, hitBackEffectResult)
  end
  local damageCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam:GetCasterEntityID(), skillEffectCalcParam:GetTargetEntityIDs(), skillEffectParam, skillEffectCalcParam:GetSkillID(), skillEffectCalcParam:GetSkillRange(), skillEffectCalcParam:GetAttackPos(), targetEntity:GetGridPosition())
  local damageResultList = skillEffectCalc:DoSkillEffectCalculator(damageCalcParam)
  table.appendArray(resultList, damageResultList)
  return resultList
end
