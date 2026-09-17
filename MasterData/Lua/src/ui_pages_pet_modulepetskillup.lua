local this = class("modulePetSkillUp", G_UIModuleBase)

function this.bind()
  return {
    skillList = {
      moduleName = "pages/Pet/cellPetSkillUpItem"
    }
  }
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
end

function this:refreshUI(isPreLevel)
  if not self.petGuid then
    return
  end
  local pet = L_PetStore:getPetItem(self.petGuid)
  if not pet then
    return
  end
  local skillInfo = L_PetStore:getPetSkills(pet, false, false, true)
  if not skillInfo then
    return
  end
  for _, v in pairs(skillInfo) do
    local realLv = tonumber(v.skillLv:match("%d+"))
    local curLv = ""
    local nextLv = ""
    if isPreLevel == true then
      curLv = tostring(realLv - 1)
      nextLv = tostring(realLv)
    else
      curLv = tostring(realLv)
      nextLv = tostring(realLv + 1)
    end
    v.skillLv = curLv
    v.skillNextLv = nextLv
  end
  self.bind.skillList:clear()
  self.bind.skillList:insert_array(skillInfo)
end

function this:playStarUpEffect()
  self.bindComponents.animation:Play("anim_modulePetAttrUp_starup")
end

return this
