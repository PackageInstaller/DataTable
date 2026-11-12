local BattleResultPanel = class("BattleResultPanel", BasePanel)
BattleResultPanel._bAddToBackHistory = false
BattleResultPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleResultPanel.prefab",
    sCtrlName = "Game.UI.BattleResult.BattleResultCtrl"
  }
}

function BattleResultPanel:Awake()
end

function BattleResultPanel:OnEnable()
end

function BattleResultPanel:OnDisable()
end

function BattleResultPanel:OnDestroy()
end

return BattleResultPanel
