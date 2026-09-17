local this = class("moduleActivityHeroTrial", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {id = 0, param = 0}
end

function this:open()
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleActivityHeroTrial, CS.UnityEngine.GameObject)
  self.moduleTrial = addModule(self.parent.csharpPage, self.parent.csharpPage, self.bindComponents.moduleActivityHeroTrial.gameObject)
end

function this:setActId(id)
  self.data.id = id
  self.moduleTrial:SetActId(self.data.id)
end

function this:setActParam(param)
  self.data.param = param
  self.moduleTrial:SetActParam(self.data.param)
end

return this
