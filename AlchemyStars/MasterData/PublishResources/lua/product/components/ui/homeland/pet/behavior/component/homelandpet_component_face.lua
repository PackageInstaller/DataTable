require("homelandpet_component_base")
_class("HomelandPetComponentFace", HomelandPetComponentBase)
HomelandPetComponentFace = HomelandPetComponentFace

function HomelandPetComponentFace:Constructor(componentType, pet, behavior)
  HomelandPetComponentFace.super.Constructor(self, componentType, pet, behavior)
end

function HomelandPetComponentFace:OnExcute()
  self.state = HomelandPetComponentState.Success
end
