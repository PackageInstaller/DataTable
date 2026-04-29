_class("PlaySkillCostFeatureStepPointInstruction", BaseInstruction)
PlaySkillCostFeatureStepPointInstruction = PlaySkillCostFeatureStepPointInstruction

function PlaySkillCostFeatureStepPointInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local rsvcFeature = world:GetService("FeatureRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SkillCostFeatureStepPoint)
  if not resultArray then
    return
  end
  for _, result in ipairs(resultArray) do
    local oldVal = result:GetOldVal()
    local curVal = result:GetCurVal()
    local costVal = result:GetCostVal()
    rsvcFeature:NotifyStepPointChange(curVal, oldVal)
    local teamEntity = world:Player():GetCurrentTeamEntity()
    local nt = NTFeatureStepPointSkillCost:New(teamEntity, curVal, oldVal, costVal)
    world:GetService("PlayBuff"):PlayBuffView(TT, nt)
  end
end
