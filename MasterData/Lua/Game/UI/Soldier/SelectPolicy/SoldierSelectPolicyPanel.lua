local SoldierSelectPolicyPanel = class("SoldierSelectPolicyPanel", BasePanel)
SoldierSelectPolicyPanel._bIsMainPanel = false
SoldierSelectPolicyPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierSelectPolicyPanel.prefab",
    sCtrlName = "Game.UI.Soldier.SelectPolicy.SoldierSelectPolicyCtrl"
  }
}

function SoldierSelectPolicyPanel:Awake()
end

function SoldierSelectPolicyPanel:OnEnable()
end

function SoldierSelectPolicyPanel:OnAfterEnter()
end

function SoldierSelectPolicyPanel:OnDisable()
end

function SoldierSelectPolicyPanel:OnDestroy()
end

function SoldierSelectPolicyPanel:OnRelease()
end

return SoldierSelectPolicyPanel
