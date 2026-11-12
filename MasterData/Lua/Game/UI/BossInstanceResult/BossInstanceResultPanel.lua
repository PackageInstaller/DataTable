local BossInstanceResultPanel = class("BossInstanceResultPanel", BasePanel)
BossInstanceResultPanel._bAddToBackHistory = false
BossInstanceResultPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleResultPanel.prefab",
    sCtrlName = "Game.UI.BossInstanceResult.BossInstanceResultCtrl"
  }
}

function BossInstanceResultPanel:Awake()
end

function BossInstanceResultPanel:OnEnable()
end

function BossInstanceResultPanel:OnDisable()
end

function BossInstanceResultPanel:OnDestroy()
end

return BossInstanceResultPanel
