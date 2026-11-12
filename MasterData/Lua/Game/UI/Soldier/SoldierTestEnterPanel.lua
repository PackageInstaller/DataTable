local SoldierTestEnterPanel = class("SoldierTestEnterPanel", BasePanel)
SoldierTestEnterPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierTestEnterPanel.prefab",
    sCtrlName = "Game.UI.Soldier.SoldierTestEnterCtrl"
  }
}

function SoldierTestEnterPanel:Awake()
end

function SoldierTestEnterPanel:OnEnable()
end

function SoldierTestEnterPanel:OnAfterEnter()
end

function SoldierTestEnterPanel:OnDisable()
end

function SoldierTestEnterPanel:OnDestroy()
end

function SoldierTestEnterPanel:OnRelease()
end

return SoldierTestEnterPanel
