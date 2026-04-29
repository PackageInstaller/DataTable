_class("SkillEffectCalc_PetSacrificeSuperGridTraps", Object)
SkillEffectCalc_PetSacrificeSuperGridTraps = SkillEffectCalc_PetSacrificeSuperGridTraps

function SkillEffectCalc_PetSacrificeSuperGridTraps:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_PetSacrificeSuperGridTraps:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local fakeTriggerTrapSkillID = 500202
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local trapID = param:GetTrapID()
  local utilSvc = self._world:GetService("UtilData")
  local triggerSvc = self._world:GetService("Trigger")
  local traps = {}
  local trapEntitys = {}
  local extraGrids = {}
  for _, pos in ipairs(skillEffectCalcParam.skillRange) do
    local findSuperGrid = false
    local entities = utilSvc:GetTrapsAtPos(pos)
    for _, entity in ipairs(entities) do
      local trapComponent = entity:Trap()
      if trapID[trapComponent:GetTrapID()] then
        table.insert(traps, entity:GetID())
        table.insert(trapEntitys, entity)
        findSuperGrid = true
      end
    end
    if not findSuperGrid then
      table.insert(extraGrids, pos)
    end
  end
  for index, entity in ipairs(trapEntitys) do
    triggerSvc:Notify(NTPetMinosAbsorbTrap:New(entity, casterEntity))
    local fakeNt = NTTrapSkillStart:New(entity, fakeTriggerTrapSkillID, teamEntity)
    fakeNt:SetIsActiveSkillFake(true)
    triggerSvc:Notify(fakeNt)
  end
  local result = SkillEffectResultPetSacrificeSuperGridTraps:New(traps)
  result:SetExtraGrids(extraGrids)
  return {result}
end
