local this = class("moduleKiboList", G_UIModuleBase)

function this.bind()
  return {
    playerList = {
      moduleName = "pages/petDuel/cellKiBoOnDuel"
    },
    enemyList = {
      moduleName = "pages/petDuel/cellKiBoOnDuel"
    }
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.PetDuel.ModuleKiBoList, CS.UnityEngine.GameObject)
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
