local DormMainMenuPanel = class("DormMainMenuPanel", BasePanel)
DormMainMenuPanel._bIsMainPanel = false
DormMainMenuPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormMainMenuPanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormMainMenuCtrl"
  }
}

function DormMainMenuPanel:Awake()
end

function DormMainMenuPanel:OnEnable()
end

function DormMainMenuPanel:OnAfterEnter()
end

function DormMainMenuPanel:OnDisable()
end

function DormMainMenuPanel:OnDestroy()
end

function DormMainMenuPanel:OnRelease()
end

return DormMainMenuPanel
