local EquipmentSucBarPanel = class("EquipmentSucBarPanel", BasePanel)
EquipmentSucBarPanel._bIsMainPanel = false
EquipmentSucBarPanel._tbDefine = {
  {
    sPrefabPath = "SuccessBarEx/EquipmentSucBarPanel.prefab",
    sCtrlName = "Game.UI.SuccessBarEx.EquipmentSucBarCtrl"
  }
}

function EquipmentSucBarPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapData = tbParam[1]
    self.callback = tbParam[2]
  end
end

function EquipmentSucBarPanel:OnEnable()
end

function EquipmentSucBarPanel:OnDisable()
end

function EquipmentSucBarPanel:OnDestroy()
end

return EquipmentSucBarPanel
