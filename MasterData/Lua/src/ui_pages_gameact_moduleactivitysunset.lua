local this = class("moduleActivitySunSet", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {id = 0}
end

function this:open()
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleActivitySunSet, CS.UnityEngine.GameObject)
  self.moduleSunSet = addModule(self.parent.csharpPage, self.parent.csharpPage, self.bindComponents.moduleActivitySunSet.gameObject)
end

function this:setActId(id)
  self.data.id = id
  self.moduleSunSet:SetActId(self.data.id)
end

return this
