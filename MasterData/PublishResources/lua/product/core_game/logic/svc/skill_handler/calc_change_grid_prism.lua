_class("SkillEffectCalc_ChangeGridPrism", Object)
SkillEffectCalc_ChangeGridPrism = SkillEffectCalc_ChangeGridPrism

function SkillEffectCalc_ChangeGridPrism:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ChangeGridPrism:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local change = skillParam:GetChangeType()
  local gridEffectType = skillParam:GetGridEffectType()
  local centerPos = skillEffectCalcParam.centerPos
  local boardCmpt = self._world:GetBoardEntity():Board()
  if change == "add" then
    boardCmpt:SetBoardPieceEffectType(centerPos, gridEffectType, skillEffectCalcParam.casterEntityID)
  elseif change == "remove" then
    boardCmpt:RemoveBoardPieceEffectType(centerPos)
  end
  return SkillEffectResultChangeGridPrism:New()
end
