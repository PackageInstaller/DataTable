local DormInteractiveAffinityPanel = class("DormInteractiveAffinityPanel", BasePanel)
DormInteractiveAffinityPanel._bIsMainPanel = false
DormInteractiveAffinityPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormCharInteractivePanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormInteractive.DormInteractiveAffinityCtrl"
  }
}

function DormInteractiveAffinityPanel:Awake()
end

function DormInteractiveAffinityPanel:OnEnable()
end

function DormInteractiveAffinityPanel:OnAfterEnter()
end

function DormInteractiveAffinityPanel:OnDisable()
end

function DormInteractiveAffinityPanel:OnDestroy()
end

function DormInteractiveAffinityPanel:OnRelease()
end

return DormInteractiveAffinityPanel
