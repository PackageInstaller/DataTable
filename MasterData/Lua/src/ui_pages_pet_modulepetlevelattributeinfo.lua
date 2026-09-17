local this = class("modulePetLevelAttributeInfo", G_UIModuleBase)

function this.bind()
  return {
    modulePetLevelInfo = {
      moduleName = "pages/pet/modulePetLevelInfo"
    },
    modulePetAttributeInfo = {
      moduleName = "pages/pet/modulePetAttributeInfo"
    },
    modulePetPixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    }
  }
end

function this.methods()
  return {
    onClick_detailsBtn = function(self)
      local pet = L_PetStore:getPetItem(self.petGuid)
      local affectByHero = false
      if not math.isEmpty(pet.hero_id) then
        affectByHero = true
      end
      L_UI:open("pageProperty", {
        petData = pet,
        switchMode = affectByHero,
        detailId = L_Const.propertyDetail.kiBo
      })
    end
  }
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:setShowPetGuid(petGuid)
  local modulePetAttributeInfo = self.modules.modulePetAttributeInfo
  modulePetAttributeInfo:setShowPetGuid(petGuid)
end

function this:refreshUI()
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:refreshUI()
  local modulePetAttributeInfo = self.modules.modulePetAttributeInfo
  modulePetAttributeInfo:refreshUI()
  local modulePetPixelIcon = self.modules.modulePetPixelIcon
  modulePetPixelIcon:setGuid(self.petGuid, true)
end

function this:onPetExpChange()
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:refreshUI()
  local modulePetAttributeInfo = self.modules.modulePetAttributeInfo
  modulePetAttributeInfo:refreshUI()
end

function this:onPetAttrFruitSelectNumChange(preUseFruitInfoList)
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  local modulePetAttributeInfo = self.modules.modulePetAttributeInfo
  modulePetAttributeInfo:refreshPreAddComprehensionExpUI(preUseFruitInfoList, modulePetLevelInfo:getCurrentLv())
end

function this:onPetExpItemSelectNumChange(selectInfo, preUseFruitInfoList)
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:onEvent_petExpChange(selectInfo)
  local modulePetAttributeInfo = self.modules.modulePetAttributeInfo
  modulePetAttributeInfo:refreshPreAddComprehensionExpUI(preUseFruitInfoList, modulePetLevelInfo:getCurrentLv())
end

function this:playPetFeedItemEffect(params)
  local modulePetPixelIcon = self.modules.modulePetPixelIcon
  modulePetPixelIcon:playPetFeedItemEffect(params)
end

return this
