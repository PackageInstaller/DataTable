_class("SkillEffectCalc_SetGridMaintainColorForSupply", Object)
SkillEffectCalc_SetGridMaintainColorForSupply = SkillEffectCalc_SetGridMaintainColorForSupply

function SkillEffectCalc_SetGridMaintainColorForSupply:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SetGridMaintainColorForSupply:DoSkillEffectCalculator(skillEffectCalcParam)
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local attackPos = skillEffectCalcParam.attackPos
  local targetElementType = boardComponent:GetPieceType(attackPos)
  local casterEntityId = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityId)
  if casterEntity then
    local buffCmpt = casterEntity:BuffComponent()
    if buffCmpt then
      local buffRecordPieceType = buffCmpt:GetBuffValue("MaintainColorPieceType")
      if buffRecordPieceType then
        targetElementType = buffRecordPieceType
      end
    end
  end
  Log.debug("SkillEffectCalc_SetGridMaintainColorForSupply targetElementType: ", targetElementType, " attackPos: ", attackPos)
  if targetElementType == PieceType.None then
    return
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local battleCmpt = self._world:BattleStat()
  local skillRangePosList = {}
  local skillRangePos = skillEffectCalcParam.skillRange
  for k, v in pairs(skillRangePos) do
    table.insert(skillRangePosList, v)
  end
  local skillConvertEffectResult = SkillEffectResultSetGridMaintainColorForSupply:New(skillRangePosList, targetElementType)
  return skillConvertEffectResult
end
