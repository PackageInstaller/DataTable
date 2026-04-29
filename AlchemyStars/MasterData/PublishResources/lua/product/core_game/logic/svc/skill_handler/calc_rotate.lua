_class("SkillEffectCalc_Rotate", Object)
SkillEffectCalc_Rotate = SkillEffectCalc_Rotate

function SkillEffectCalc_Rotate:Constructor(world)
  self._world = world
end

function SkillEffectCalc_Rotate:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_Rotate:_CalculateSingleTarget(skillEffectCalcParam, targetEntityID)
  local defender = self._world:GetEntityByID(targetEntityID)
  local dir = defender:GridLocation().Direction
  local isClockwise = skillEffectCalcParam.skillEffectParam:IsClockwise()
  local dirNew = Vector2.zero
  if isClockwise then
    dirNew.x = dir.y
    dirNew.y = -dir.x
  else
    dirNew.x = -dir.y
    dirNew.y = dir.x
  end
  return SkillRotateEffectResult:New(targetEntityID, dir, dirNew)
end
