local this = class("cellPetStationedInModuleHomeCenterPet", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local REST_TIMER_INTERVAL = 1
local PetGifIconPath = "UI/Icon/PetPixelIcon/tex_icon_pet_%s_%d.png"
local MaxPetGifFrame = 8

function this.bind()
  return {
    active_self = false,
    img_pet = "",
    active_petStateDesignated = false,
    active_petStateRest = false,
    active_petStateHungry = false,
    active_petStateWork = false,
    modulesPetFlashEft = {
      type = "toggleModule",
      modulePetFlashEft = {
        moduleName = "pages/pet/modulePetFlashEft",
        assetName = "UI/Pages/Pet/modulePetFlashEft"
      }
    },
    togglePetFlashEft = ""
  }
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:refreshData(petStationedData)
  self.UIData = {}
  self.UIData.petGuid = petStationedData.petGuid
  self.UIData.petId = petStationedData.petId
  local csPetData = L_PetStore:getCsPetData(self.UIData.petGuid)
  self.UIData.isDesignated = L_PetStore:getPetIsDesignated(csPetData)
  self.UIData.isHungry = L_PetStore:getPetSatietyVal(csPetData) == 0 and L_PetStore:getPetCanteenId(csPetData) == 0
  self.UIData.isRest = L_PetStore:getPetSatietyVal(csPetData) ~= 0 and L_PetStore:getWorkBuildingGuid(csPetData) == 0
  self.UIData.isWorking = L_PetStore:getWorkBuildingGuid(csPetData) ~= 0 and L_PetStore:getPetAutoWorkStatus(csPetData) == L_Const.PetFSMStateType.PFST_WORK
  self.UIData.restTimerDeltaTime = 0
  self.UIData.randomRestTagAppearanceDeltaTime = 0
  self.UIData.curPetGifFrame = 1
  local petId = self.UIData.petId
  local petGuid = self.UIData.petGuid
  local petTpl = _petTpl:getTplById(petId)
  local petItem = L_PetStore:getPetItem(petGuid)
  local isSpecial = petItem:isSpecialPet()
  local initFrameIcon = _petTpl:getPetPixelIcon(petTpl, isSpecial)
  self.UIData.petGifPixelIconIdStr = string.match(initFrameIcon, "%a*%d+")
  self:refreshPetFlashEft(petItem)
end

function this:refreshUI()
  self:playPetGif()
  L_TimerManager:newOrResetTimer(self, "petGif", function()
    self:playPetGif()
  end, 0.1, -1)
  if self.UIData.isWorking then
    self:showWorkingEffect()
    self.bind.active_petStateWork = true
  else
    self:stopWorkingEffect()
    self.bind.active_petStateWork = false
  end
  self.bind.active_petStateDesignated = self.UIData.isDesignated
  if self.UIData.isRest then
    L_TimerManager:newOrResetTimer(self, "showOrHideImgRest", function()
      self:showOrHideImgRest()
    end, REST_TIMER_INTERVAL, -1)
  else
    L_TimerManager:stopTimer(self, "showOrHideImgRest")
    self.UIData.restTimerDeltaTime = 0
    self.UIData.randomRestTagAppearanceDeltaTime = 0
  end
  if self.UIData.isHungry then
    self.bind.active_petStateHungry = true
  else
    self.bind.active_petStateHungry = false
  end
end

function this:showSelf()
  self.bind.active_self = true
end

function this:hideSelf()
  self.bind.active_self = false
end

function this:clearTimer()
  L_TimerManager:clearTimer(self)
end

function this:playPetGif()
  local singlePetIconPath = string.format(PetGifIconPath, self.UIData.petGifPixelIconIdStr, self.UIData.curPetGifFrame)
  self.bind.img_pet = singlePetIconPath
  self.UIData.curPetGifFrame = self.UIData.curPetGifFrame % MaxPetGifFrame + 1
end

function this:showOrHideImgRest()
  self.UIData.restTimerDeltaTime = self.UIData.restTimerDeltaTime + REST_TIMER_INTERVAL
  if self.UIData.randomRestTagAppearanceDeltaTime == 0 then
    self.UIData.restTimerDeltaTime = 0
    self.UIData.randomRestTagAppearanceDeltaTime = self:getRandomRestTagAppearanceDeltaTime()
  end
  if self.UIData.restTimerDeltaTime >= self.UIData.randomRestTagAppearanceDeltaTime then
    self.UIData.restTimerDeltaTime = 0
    self.UIData.randomRestTagAppearanceDeltaTime = 0
    self.bind.active_petStateRest = not self.bind.active_petStateRest
  end
end

function this:refreshPetFlashEft(petItem)
  if petItem == nil then
    self.bind.togglePetFlashEft = ""
    return
  end
  local bFlash = petItem:hasFlashGene()
  if bFlash then
    self.bind.togglePetFlashEft = "modulePetFlashEft"
    self.modules.modulesPetFlashEft.modulePetFlashEft:setModulePetHasFlashEft(true)
  else
    self.bind.togglePetFlashEft = ""
  end
end

function this:showWorkingEffect()
end

function this:stopWorkingEffect()
end

function this:getRandomRestTagAppearanceDeltaTime()
  local minDeltaTime = 3
  local maxDeltaTime = 5
  return math.random(minDeltaTime, maxDeltaTime)
end

return this
