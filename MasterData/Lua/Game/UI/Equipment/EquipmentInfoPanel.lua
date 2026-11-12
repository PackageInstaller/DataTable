local EquipmentInfoPanel = class("EquipmentInfoPanel", BasePanel)
EquipmentInfoPanel._bIsMainPanel = false
EquipmentInfoPanel._tbDefine = {
  {
    sPrefabPath = "Equipment/EquipmentInfoPanel.prefab",
    sCtrlName = "Game.UI.Equipment.EquipmentInfoCtrl"
  }
}

function EquipmentInfoPanel:Awake()
end

function EquipmentInfoPanel:OnEnable()
end

function EquipmentInfoPanel:OnAfterEnter()
end

function EquipmentInfoPanel:OnDisable()
end

function EquipmentInfoPanel:OnDestroy()
end

function EquipmentInfoPanel:OnRelease()
end

return EquipmentInfoPanel
