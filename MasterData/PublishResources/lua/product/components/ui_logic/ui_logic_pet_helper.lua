_class("UILogicPetHelper", Object)
UILogicPetHelper = UILogicPetHelper

function UILogicPetHelper:Constructor()
end

function UILogicPetHelper.ShowSkillEnergy(skillTriggerType)
  return skillTriggerType ~= SkillTriggerType.LegendEnergy and skillTriggerType ~= SkillTriggerType.BuffLayer and skillTriggerType ~= SkillTriggerType.ColorPalette and skillTriggerType ~= SkillTriggerType.AlchemyEnergy
end
