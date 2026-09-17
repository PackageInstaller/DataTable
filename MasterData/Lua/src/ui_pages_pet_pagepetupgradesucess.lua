local this = class("pagePetUpgradeSucess", G_UIPageBase)
local StageImgPath = "UI/Atlas/HeroTalentRankNum/tex_role_talent_bg_numA0%s.png"

function this.bind()
  return {
    imgStage = "",
    moduleSkillList = {
      moduleName = "pages/Pet/modulePetSkillUp"
    }
  }
end

function this.methods()
  return {
    onClick_closePage = function(self)
      if L_UI:checkPageOpen(self.pageName) then
        L_UI:close(self.pageName)
      end
    end
  }
end

function this:open(options)
  self.petGuid = options and options.petGuid
  if not self.petGuid then
    return
  end
  local pet = L_PetStore:getPetItem(self.petGuid)
  if not pet then
    return
  end
  self.bind.imgStage = string.format(StageImgPath, tostring(pet.stage))
  self.modules.moduleSkillList:setShowPetGuid(self.petGuid)
  self.modules.moduleSkillList:refreshUI(true)
end

return this
