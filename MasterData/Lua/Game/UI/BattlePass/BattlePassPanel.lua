local BattlePassPanel = class("BattlePassPanel", BasePanel)
BattlePassPanel._tbDefine = {
  {
    sPrefabPath = "BattlePass/BattlePassPanel.prefab",
    sCtrlName = "Game.UI.BattlePass.BattlePassCtrl"
  }
}

function BattlePassPanel:Awake()
end

function BattlePassPanel:OnEnable()
end

function BattlePassPanel:OnAfterEnter()
end

function BattlePassPanel:OnDisable()
end

function BattlePassPanel:OnDestroy()
end

function BattlePassPanel:OnRelease()
end

return BattlePassPanel
