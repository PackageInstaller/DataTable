local EquipmentInstanceResultPanel = class("EquipmentInstanceResultPanel", BasePanel)
EquipmentInstanceResultPanel._bAddToBackHistory = false
EquipmentInstanceResultPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleResultPanel.prefab",
    sCtrlName = "Game.UI.BattleResult.EquipmentInstanceResultCtrl"
  }
}

function EquipmentInstanceResultPanel:Awake()
end

function EquipmentInstanceResultPanel:OnEnable()
end

function EquipmentInstanceResultPanel:OnDisable()
end

function EquipmentInstanceResultPanel:OnDestroy()
end

return EquipmentInstanceResultPanel
