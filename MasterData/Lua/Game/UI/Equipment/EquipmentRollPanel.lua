local EquipmentRollPanel = class("EquipmentRollPanel", BasePanel)
EquipmentRollPanel._tbDefine = {
  {
    sPrefabPath = "Equipment/EquipmentRollPanel.prefab",
    sCtrlName = "Game.UI.Equipment.EquipmentRollCtrl"
  }
}

function EquipmentRollPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
    self.nSlotId = tbParam[2]
    self.nSelectGemIndex = tbParam[3]
    self.nEquipedGemIndex = tbParam[4]
    PlayerData.Equipment:CacheEquipmentSelect(self.nSlotId, self.nSelectGemIndex, self.nCharId)
  end
end

function EquipmentRollPanel:OnEnable()
end

function EquipmentRollPanel:OnAfterEnter()
end

function EquipmentRollPanel:OnDisable()
end

function EquipmentRollPanel:OnDestroy()
end

function EquipmentRollPanel:OnRelease()
end

return EquipmentRollPanel
