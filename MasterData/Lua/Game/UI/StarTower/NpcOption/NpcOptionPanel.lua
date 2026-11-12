local NpcOptionPanel = class("NpcOptionPanel", BasePanel)
NpcOptionPanel._bIsMainPanel = false
NpcOptionPanel._tbDefine = {
  {
    sPrefabPath = "StarTower/NpcOptionPanel.prefab",
    sCtrlName = "Game.UI.StarTower.NpcOption.NpcOptionCtrl"
  }
}

function NpcOptionPanel:Awake()
end

function NpcOptionPanel:OnEnable()
end

function NpcOptionPanel:OnAfterEnter()
end

function NpcOptionPanel:OnDisable()
end

function NpcOptionPanel:OnDestroy()
end

function NpcOptionPanel:OnRelease()
end

return NpcOptionPanel
