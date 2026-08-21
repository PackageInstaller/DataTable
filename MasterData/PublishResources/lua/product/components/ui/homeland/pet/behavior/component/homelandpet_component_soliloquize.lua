require("homelandpet_component_base")
_class("HomelandPetComponentSoliloquize", HomelandPetComponentBase)
HomelandPetComponentSoliloquize = HomelandPetComponentSoliloquize

function HomelandPetComponentSoliloquize:OnExcute()
  self.state = HomelandPetComponentState.Success
end
