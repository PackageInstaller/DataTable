local BattleResultMaskPanel = class("BattleResultMaskPanel", BasePanel)
BattleResultMaskPanel._bIsMainPanel = false
BattleResultMaskPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
BattleResultMaskPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleResultMaskPanel.prefab",
    sCtrlName = "Game.UI.BattleResult.BattleResultMaskCtrl"
  }
}

function BattleResultMaskPanel:Awake()
end

function BattleResultMaskPanel:OnEnable()
end

function BattleResultMaskPanel:OnDisable()
end

function BattleResultMaskPanel:OnDestroy()
end

return BattleResultMaskPanel
