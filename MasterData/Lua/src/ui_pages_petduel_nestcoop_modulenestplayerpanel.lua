local this = class("moduleNestPlayerPanel", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local playerInfoList = {
  {"1P", "#384BA0"},
  {"2P", "#9B613F"},
  {"3P", "#00735A"}
}

function this.bind()
  return {
    moduleP1 = {
      moduleName = "pages/petDuel/nestCoop/moduleNestPlayerInfo"
    },
    moduleP2 = {
      moduleName = "pages/petDuel/nestCoop/moduleNestPlayerInfo"
    },
    moduleP3 = {
      moduleName = "pages/petDuel/nestCoop/moduleNestPlayerInfo"
    }
  }
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.Nest.Inside.ModuleNestPlayerPanel, CS.UnityEngine.GameObject)
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
