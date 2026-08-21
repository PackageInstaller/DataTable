_class("PopStarMatchPet", MatchPet)
PopStarMatchPet = PopStarMatchPet

function PopStarMatchPet:GetNormalSkill()
  return nil
end

function PopStarMatchPet:GetPetActiveSkill(grade, awakening)
  local tmpID = self:GetTemplateID()
  local petCfg = Cfg.cfg_popstar_pet_list[tmpID]
  if not petCfg then
    Log.error("PopStarPet cfg_popstar_pet_list err: pet template id = ", tmpID)
  end
  return petCfg.SkillId
end

function PopStarMatchPet:GetPetExtraActiveSkill(grade, awakening)
  return nil
end

function PopStarMatchPet:GetPetPassiveSkill(grade, awakening)
  return nil
end

function PopStarMatchPet:GetPetChainSkills(grade, awakening)
  return nil
end

function PopStarMatchPet:GetChainSkillInfo(grade, awakening)
  return {}
end
