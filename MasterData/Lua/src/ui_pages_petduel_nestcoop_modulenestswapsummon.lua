local this = class("moduleNestSwapSummon", G_UIModuleBase)

function this.bind()
  return {
    active = nil,
    listPets = {
      moduleName = "pages/petDuel/nestCoop/cellNestSwapSummon"
    },
    txt_bottom = nil,
    txt_top = nil
  }
end

function this.methods()
  return {
    listPets = {
      onClick = function(self, guid)
        self:onClickPet(guid)
      end
    },
    onClickBg = function(self)
      if self.autoCancelTimer then
        Timer.remove(self.autoCancelTimer)
        self.autoCancelTimer = nil
      end
      C_KiboDuelSystemMgr:HandleSwapSummonCancel()
    end
  }
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.Nest.Inside.ModuleNestSwapSummon, CS.UnityEngine.GameObject)
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
