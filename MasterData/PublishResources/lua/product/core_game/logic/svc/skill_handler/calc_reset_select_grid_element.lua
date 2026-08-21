_class("SkillEffectCalc_ResetSelectGridElement", Object)
SkillEffectCalc_ResetSelectGridElement = SkillEffectCalc_ResetSelectGridElement

function SkillEffectCalc_ResetSelectGridElement:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_ResetSelectGridElement:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local realRange = {}
  local conditionSrcElement = skillEffectCalcParam.skillEffectParam:GetSelectConditionSrcElement()
  if type(conditionSrcElement) == "table" then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local utilData = self._world:GetService("UtilData")
    for i = 1, #skillEffectCalcParam.skillRange do
      local pos = skillEffectCalcParam.skillRange[i]
      local elementType = utilData:FindPieceElement(pos)
      if not boardServiceLogic:IsPosBlock(pos, BlockFlag.ChangeElement) and self:_CheckInTable(conditionSrcElement, elementType) then
        table.insert(realRange, pos)
      end
    end
  end
  return self._skillEffectService:CalcSkill_ResetGridElement(realRange, casterEntity, skillEffectCalcParam.skillEffectParam)
end

function SkillEffectCalc_ResetSelectGridElement:_CheckInTable(tableName, element)
  for _, v in pairs(tableName) do
    if v == element then
      return true
    end
  end
  return false
end
