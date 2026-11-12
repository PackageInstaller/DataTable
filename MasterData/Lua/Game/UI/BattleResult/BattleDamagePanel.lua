local BattleDamagePanel = class("BattleDamagePanel", BasePanel)
BattleDamagePanel._bIsMainPanel = false
BattleDamagePanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleDamagePanel.prefab",
    sCtrlName = "Game.UI.BattleResult.BattleDamageCtrl"
  }
}

function BattleDamagePanel:Awake()
end

function BattleDamagePanel:OnEnable()
end

function BattleDamagePanel:OnAfterEnter()
end

function BattleDamagePanel:OnDisable()
end

function BattleDamagePanel:OnDestroy()
end

function BattleDamagePanel:OnRelease()
end

return BattleDamagePanel
