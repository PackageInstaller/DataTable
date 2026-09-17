local this = class("modulePetFeedInfoBox", G_UIModuleBase)
local _petLevelTpl = L_GameTpl:getPetLevelTpl()
local _petFavorabilityTpl = L_GameTpl:getPetFavorabilityTpl()
local _petTpl = L_GameTpl:getPetTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()

function this.bind()
  return {
    modulePetFeedName = {
      moduleName = "pages/pet/new/modulePetFeedName"
    },
    modulePetNewSimpleTags = {
      moduleName = "pages/pet/new/modulePetNewSimpleTags"
    },
    modulePetBoxRating = {
      moduleName = "pages/pet/new/modulePetBoxRating"
    },
    modulePetLevelInfo = {
      moduleName = "pages/pet/modulePetLevelInfo"
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
  local modulePetFeedName = self.modules.modulePetFeedName
  modulePetFeedName:setGuid(petGuid)
  local modulePetNewSimpleTags = self.modules.modulePetNewSimpleTags
  modulePetNewSimpleTags:setGuid(petGuid, false, false, true)
  local modulePetBoxRating = self.modules.modulePetBoxRating
  modulePetBoxRating:setGuid(petGuid)
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:setShowPetGuid(petGuid)
  self:SetPetImgAndBg(self.petGuid)
end

function this:SetPetImgAndBg(petGuid)
  local pet = L_PetStore:getPetItem(petGuid)
  local tpl = _petTpl:getTplById(pet.id)
  local syncType = CS.Azur.Gameplay.UI.ELImageLoadType.ForceSync
  self.bindComponents.petCard:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 5, pet:isSpecialPet()), false, syncType)
  self.bindComponents.bgIcon:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 3, pet:isSpecialPet()), false, syncType)
end

function this:refreshUI()
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:refreshUI()
end

function this:playPetLevelUpAnim(params, callback, upCallback)
  local pet = L_PetStore:getPetItem(self.petGuid)
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  local maxExp = _petLevelTpl:getExp(_petLevelTpl:getTplById(pet.lv))
  local maxLimitLevel = L_PetStore:getPetMaxLevel(true)
  local maxLevel = L_PetStore:getPetMaxLevel(false)
  local ratio = 0
  if maxLevel <= pet.lv then
    ratio = 1
  elseif maxLimitLevel > pet.lv then
    ratio = pet.exp / (maxExp * 1.0)
  end
  if params.isPetLevelUp then
    self.bindComponents.anim:Play("anim_petfeed_feed_show")
    modulePetLevelInfo:playLvUpDoTween(ratio, false, callback, upCallback)
    L_AudioUtil.playSound("Play_SFX_System_UI_Qibo_Level_LevelUp")
  else
    modulePetLevelInfo:playLvUpDoTween(ratio, false, callback, upCallback)
  end
end

function this:onPetExpChange()
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:refreshUI()
end

function this:onPetAttrFruitSelectNumChange(preUseFruitInfoList)
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
end

function this:onPetExpItemSelectNumChange(selectInfo, preUseFruitInfoList)
  local modulePetLevelInfo = self.modules.modulePetLevelInfo
  modulePetLevelInfo:onEvent_petExpChange(selectInfo)
end

function this:playRatingFx()
  local modulePetBoxRating = self.modules.modulePetBoxRating
  if modulePetBoxRating and modulePetBoxRating.playLevelUpFx then
    modulePetBoxRating:playLevelUpFx()
  end
end

return this
