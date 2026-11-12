local FormationPanel = class("FormationPanel", BasePanel)
FormationPanel._tbDefine = {
  {
    sPrefabPath = "MainlineFormationEx/MainlineFormationScenePanel.prefab",
    sCtrlName = "Game.UI.FormationEx.FormationCtrl"
  }
}

function FormationPanel:Awake()
  EventManager.Add("EnterModule", self, self.OnEvent_EnterModule)
end

function FormationPanel:OnEnable(bPlayFadeIn)
end

function FormationPanel:OnDisable()
end

function FormationPanel:OnDestroy()
  EventManager.Remove("EnterModule", self, self.OnEvent_EnterModule)
end

function FormationPanel:OnEvent_EnterModule(moduleMgr, sExitModuleName, sEnterModuleName)
  if sEnterModuleName == "AdventureModuleScene" then
    self.bAddBuild = false
  end
end

return FormationPanel
