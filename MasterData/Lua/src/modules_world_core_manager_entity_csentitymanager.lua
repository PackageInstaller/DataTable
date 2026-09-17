local this = class("csEntityManager")

function this:getHeroPetData(petInfo)
  if petInfo == nil then
    return nil
  end
  local petData = C_InjectData.PetData()
  local battleProperty = L_PetStore:getBattleStructPropertyNew(petInfo.guid)
  if #battleProperty <= 0 then
    local property = L_PetStore:getPetProperty(petInfo)
    battleProperty = property.battlStructProperty
  end
  petData.name = petInfo.pet_name
  petData.level = petInfo.lv
  petData.petId = petInfo.petId or petInfo.config_id
  petData.rank = petInfo.rank
  petData.wearSkinId = petInfo.wear_skin_id
  petData.starColorId = petInfo.colorMatId
  petData.colorParam = petInfo:isSpecialPet()
  petData.flashParam = petInfo:hasFlashGene()
  local inherentSkills = L_PetStore:getPetPropertyInherentSkills(petInfo.guid)
  if 0 < #inherentSkills then
    petData.inherentSkills = inherentSkills
  else
    if petInfo.skills ~= nil then
      petInfo.inherent_skills = petInfo.skills
    end
    if petInfo.inherent_skills ~= nil then
      local skillData = {}
      for _, v in ipairs(petInfo.inherent_skills) do
        local skill = {}
        skill.skillId = v.skill_id
        skill.level = v.skill_level
        skill.skillSlot = v.skill_slot
        skill.type = L_Const.ModuleGamingType.MGT_WORLD_BATTLE
        table.insert(skillData, skill)
      end
      petData.inherentSkills = skillData
    end
  end
  local geneSkills = L_PetStore:getPetPropertyGeneSkills(petInfo.guid)
  if 0 < #geneSkills then
    petData.geneSkills = geneSkills
  elseif petInfo.gene_skills ~= nil then
    local skillData = {}
    for _, v in ipairs(petInfo.gene_skills) do
      local skill = {}
      skill.skillId = v.skill_id
      skill.level = v.skill_level
      skill.type = L_Const.ModuleGamingType.MGT_WORLD_BATTLE
      table.insert(skillData, skill)
    end
    petData.geneSkills = skillData
  end
  petData.attrs = battleProperty
  return petData
end

return this
