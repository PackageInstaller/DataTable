_class("SkillEffectCalc_TransferTarget", Object)
SkillEffectCalc_TransferTarget = SkillEffectCalc_TransferTarget

function SkillEffectCalc_TransferTarget:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_TransferTarget:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  local gridPos = skillEffectCalcParam.gridPos
  for _, targetID in ipairs(targets) do
    local targetEntity = self._world:GetEntityByID(targetID)
    if targetEntity then
      local result = SkillEffectResultTransferTarget:New(targetID, gridPos)
      if result then
        table.insert(results, result)
      end
    end
  end
  return results
end
