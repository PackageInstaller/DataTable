_class("SkillEffectCalc_SacrificeTraps", Object)
SkillEffectCalc_SacrificeTraps = SkillEffectCalc_SacrificeTraps

function SkillEffectCalc_SacrificeTraps:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SacrificeTraps:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local trapID = param:GetTrapID()
  local utilSvc = self._world:GetService("UtilData")
  local triggerSvc = self._world:GetService("Trigger")
  local traps = {}
  for _, pos in ipairs(skillEffectCalcParam.skillRange) do
    local entities = utilSvc:GetTrapsAtPos(pos)
    for _, entity in ipairs(entities) do
      local trapComponent = entity:Trap()
      if trapID[trapComponent:GetTrapID()] then
        triggerSvc:Notify(NTMinosAbsorbTrap:New(entity))
        table.insert(traps, entity:GetID())
      end
    end
  end
  local result = SkillEffectResultSacrificeTraps:New(traps)
  return {result}
end
