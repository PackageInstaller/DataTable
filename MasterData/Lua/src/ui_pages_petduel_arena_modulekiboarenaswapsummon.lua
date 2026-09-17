local this = class("moduleKiboArenaSwapSummon", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  if not self.transferModule then
    local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
    local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.KiboDuelArena.ModuleKiboArenaSwapSummon, CS.UnityEngine.GameObject)
    self.transferModule = addModule(self.parent.csharpPage, self.parent.csharpPage, self.gameObject)
  end
end

function this:open()
  self.gameObject:SetActive(false)
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
