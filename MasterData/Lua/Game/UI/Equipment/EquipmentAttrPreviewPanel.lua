local EquipmentAttrPreviewPanel = class("EquipmentAttrPreviewPanel", BasePanel)
EquipmentAttrPreviewPanel._bIsMainPanel = false
EquipmentAttrPreviewPanel._tbDefine = {
  {
    sPrefabPath = "Equipment/EquipmentAttrPreviewPanel.prefab",
    sCtrlName = "Game.UI.Equipment.EquipmentAttrPreviewCtrl"
  }
}

function EquipmentAttrPreviewPanel:Awake()
end

function EquipmentAttrPreviewPanel:OnEnable()
end

function EquipmentAttrPreviewPanel:OnAfterEnter()
end

function EquipmentAttrPreviewPanel:OnDisable()
end

function EquipmentAttrPreviewPanel:OnDestroy()
end

function EquipmentAttrPreviewPanel:OnRelease()
end

return EquipmentAttrPreviewPanel
