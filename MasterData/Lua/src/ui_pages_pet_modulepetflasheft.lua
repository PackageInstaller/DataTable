local this = class("modulePetFlashEft", G_UIModuleBase)

function this.bind()
  return {active_specialEft = false}
end

function this:setModulePetFlashEftData(guid)
  self:setModulePetHasFlashEft(L_PetStore:judgePetHasSpecialGene(guid))
end

function this:setModulePetHasFlashEft(bFlash)
  if not self.isBind then
    return
  end
  self._curFrame = 0
  self.bind.active_specialEft = bFlash
  if bFlash then
    self.bindComponents.imgSpecialEft:Play()
  else
    self.bindComponents.imgSpecialEft:Stop()
  end
end

return this
