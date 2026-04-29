_class("SkillEffectCalc_ScorpionHitBack", Object)
SkillEffectCalc_ScorpionHitBack = SkillEffectCalc_ScorpionHitBack

function SkillEffectCalc_ScorpionHitBack:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_ScorpionHitBack:DoSkillEffectCalculator(skillEffectCalcParam)
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
  local targetEntityID = targetIDList[1]
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  local skillRange = skillEffectCalcParam.skillRange
  local endPos, dir = self._skillEffectService:CalcHitbackEffect(attackerPos, attackerDir, attackerBodyArea, targetEntityID, HitBackDirectionType.Scorpion, HitBackType.PushAway, 100, HitBackCalcType.Instant, ignorePlayerBlock, nil, attacker, skillRange, nil, false, nil, HitBackInteractnWithBoardType.None, skillEffectParam:GetSkillType(), {})
  local hitBackDis = 1
  local resultList = {}
  while targetEntity:GetGridPosition() ~= endPos do
    local hitBackEffectResult = self._skillEffectService:CalcHitbackEffectResult(attackerPos, attackerDir, attackerBodyArea, targetEntityID, HitBackDirectionType.Scorpion, HitBackType.PushAway, hitBackDis, HitBackCalcType.Instant, ignorePlayerBlock, nil, attacker, skillRange, nil, false, nil, HitBackInteractnWithBoardType.None, skillEffectParam:GetSkillType(), {})
    table.insert(resultList, hitBackEffectResult)
  end
  return resultList
end
