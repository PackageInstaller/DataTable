local EquipmentRenamePanel = class("EquipmentRenamePanel", BasePanel)
EquipmentRenamePanel._bIsMainPanel = false
EquipmentRenamePanel._tbDefine = {
  {
    sPrefabPath = "Equipment/EquipmentRenamePanel.prefab",
    sCtrlName = "Game.UI.Equipment.EquipmentRenameCtrl"
  }
}

function EquipmentRenamePanel:Awake()
end

function EquipmentRenamePanel:OnEnable()
end

function EquipmentRenamePanel:OnDisable()
end

function EquipmentRenamePanel:OnDestroy()
end

return EquipmentRenamePanel
