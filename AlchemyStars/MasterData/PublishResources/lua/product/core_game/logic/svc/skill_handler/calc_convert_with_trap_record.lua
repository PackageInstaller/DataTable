_class("SkillEffectCalc_ConvertWithTrapRecord", Object)
SkillEffectCalc_ConvertWithTrapRecord = SkillEffectCalc_ConvertWithTrapRecord

function SkillEffectCalc_ConvertWithTrapRecord:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ConvertWithTrapRecord:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  if not casterEntity then
    return
  end
  local trapCmpt = casterEntity:Trap()
  if not trapCmpt then
    return
  end
  local pos = casterEntity:GridLocation().Position
  local boardServiceLogic = self._world:GetService("BoardLogic")
  if boardServiceLogic:IsPosBlock(pos, BlockFlag.ChangeElement) then
    return
  end
  local color = trapCmpt:GetRecordPieceType()
  local skillConvertEffectResult = SkillConvertGridElementEffectResult:New({pos}, color)
  skillConvertEffectResult:SetNotifyBuff(false)
  return skillConvertEffectResult
end
