local this = class("moduleKiBoDescription", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.PetDuel.ModuleKiBoDescription, CS.UnityEngine.GameObject)
  self.transferModule = addModule(self.parent.csharpPage, self.parent.csharpPage, self.gameObject)
end

function this:initModule(petInfo)
  self.transferModule:InitModule(petInfo)
end

return this
