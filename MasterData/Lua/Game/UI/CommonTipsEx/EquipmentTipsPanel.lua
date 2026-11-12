local EquipmentTipsPanel = class("EquipmentTipsPanel", BasePanel)
EquipmentTipsPanel._bIsMainPanel = false
EquipmentTipsPanel._bAddToBackHistory = false
EquipmentTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
EquipmentTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/EquipmentTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.EquipmentTipsCtrl"
  }
}

function EquipmentTipsPanel:Awake()
end

function EquipmentTipsPanel:OnEnable()
end

function EquipmentTipsPanel:OnDisable()
end

function EquipmentTipsPanel:OnDestroy()
end

function EquipmentTipsPanel:OnRelease()
end

return EquipmentTipsPanel
