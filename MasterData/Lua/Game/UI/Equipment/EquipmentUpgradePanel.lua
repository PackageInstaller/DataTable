local EquipmentUpgradePanel = class("EquipmentUpgradePanel", BasePanel)
EquipmentUpgradePanel._bIsMainPanel = false
EquipmentUpgradePanel._tbDefine = {
  {
    sPrefabPath = "Equipment/EquipmentUpgradePanel.prefab",
    sCtrlName = "Game.UI.Equipment.EquipmentUpgradeCtrl"
  }
}

function EquipmentUpgradePanel:Awake()
end

function EquipmentUpgradePanel:OnEnable()
end

function EquipmentUpgradePanel:OnAfterEnter()
end

function EquipmentUpgradePanel:OnDisable()
end

function EquipmentUpgradePanel:OnDestroy()
end

function EquipmentUpgradePanel:OnRelease()
end

return EquipmentUpgradePanel
