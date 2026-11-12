local SoldierTechPanel = class("SoldierTechPanel", BasePanel)
SoldierTechPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Technology/SoldierTechnologyPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Technology.SoldierTechCtrl"
  }
}

function SoldierTechPanel:Awake()
end

function SoldierTechPanel:OnEnable()
end

function SoldierTechPanel:OnAfterEnter()
end

function SoldierTechPanel:OnDisable()
end

function SoldierTechPanel:OnDestroy()
end

function SoldierTechPanel:OnRelease()
end

return SoldierTechPanel
