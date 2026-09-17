local this = class("moduleNestCountdown", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.Nest.Inside.ModuleNestCountdown, CS.UnityEngine.GameObject)
  self.transferModule = addModule(self.parent.csharpPage, self.parent.csharpPage, self.gameObject)
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
