_class("SkillEffectCalc_AddMoveScopeRecordCmpt", Object)
SkillEffectCalc_AddMoveScopeRecordCmpt = SkillEffectCalc_AddMoveScopeRecordCmpt

function SkillEffectCalc_AddMoveScopeRecordCmpt:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AddMoveScopeRecordCmpt:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local battleCmpt = self._world:BattleStat()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local results = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local centerPos = skillEffectCalcParam:GetCenterPos()
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  local utilData = self._world:GetService("UtilData")
  for _, targetID in ipairs(targets) do
    local e = self._world:GetEntityByID(targetID)
    if e then
      local entityCenterPos = e:GetGridPosition()
      local offSet = Vector2(centerPos.x - entityCenterPos.x, centerPos.y - entityCenterPos.y)
      local result = SkillEffectResultAddMoveScopeRecordCmpt:New(targetID, offSet)
      table.insert(results, result)
    end
  end
  return results
end
