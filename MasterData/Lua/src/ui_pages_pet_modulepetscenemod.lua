local module = class("modulePetSceneMod", G_UIModuleBase)

function module.bind()
  return {}
end

function module.methods()
  return {
    dragBegin = function(self, pos)
      self.deltaX = 0
      self.modEuler = L_Vector3.new(0, self.modEuler.y + self.deltaX, 0)
      L_PetManager:setScenePetRot(self.modEuler)
      self.oldDragX = pos.x
    end,
    drag = function(self, pos)
      self.deltaX = (self.oldDragX - pos.x) * 0.3
      self.modEuler = L_Vector3.new(0, self.modEuler.y + self.deltaX, 0)
      L_PetManager:setScenePetRot(self.modEuler)
      self.oldDragX = pos.x
    end,
    dragEnd = function(self, pos)
      self.deltaX = (self.oldDragX - pos.x) * 0.3
      self.modEuler = L_Vector3.new(0, self.modEuler.y + self.deltaX, 0)
      L_PetManager:setScenePetRot(self.modEuler)
      self.oldDragX = pos.x
    end,
    onClick = function(self)
      if self.parent and self.parent.clickPetInteract then
        self.parent:clickPetInteract()
      end
    end
  }
end

function module:created(...)
  module.super.created(self, ...)
end

function module:open()
  self.modEuler = L_Vector3.zero
  self.deltaX = 0
  self.oldDragX = 0
end

function module:close()
end

function module:show()
  L_PetManager:setSceneArtActive(true)
  if self.savedWeatherTime and self.savedWeatherTimeTick then
    C_RealWeather.SetTime(self.savedWeatherTime)
    C_RealWeather.SetTimeTick(self.savedWeatherTimeTick)
  end
end

function module:hide()
  self.savedWeatherTime = C_RealWeather.GetTimeOfDay()
  self.savedWeatherTimeTick = C_RealWeather.GetTimeTick()
  L_PetManager:setSceneArtActive(false)
end

function module:refreshPetMod(configId, isSpecial, isFlash, callback, petSkinInfo, petStarColorId)
  L_PetManager:asyncLoadPetModel(configId, isSpecial, isFlash, nil, callback, petSkinInfo, petStarColorId)
end

function module:refreshBlackPet(configId)
  L_PetManager:loadBlackPetModel(configId)
end

function module:disableMod()
end

function module:setCameraOffset(offset)
  L_PetManager:setCameraNodeRotOffset(offset)
end

function module:setCameraPosOffset(offset)
  L_PetManager:setCameraNodePosOffset(offset)
end

return module
