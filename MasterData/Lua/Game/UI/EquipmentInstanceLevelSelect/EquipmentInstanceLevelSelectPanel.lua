local EquipmentInstanceLevelSelectPanel = class("EquipmentInstanceLevelSelectPanel", BasePanel)
EquipmentInstanceLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "EquipmentInstanceLevelSelect/EquipmentInstanceLevelSelect.prefab",
    sCtrlName = "Game.UI.EquipmentInstanceLevelSelect.EquipmentInstanceLevelSelectCtrl"
  }
}

function EquipmentInstanceLevelSelectPanel:Awake()
end

function EquipmentInstanceLevelSelectPanel:OnEnable()
end

function EquipmentInstanceLevelSelectPanel:OnDisable()
end

function EquipmentInstanceLevelSelectPanel:OnDestroy()
end

function EquipmentInstanceLevelSelectPanel:OnRelease()
end

return EquipmentInstanceLevelSelectPanel
