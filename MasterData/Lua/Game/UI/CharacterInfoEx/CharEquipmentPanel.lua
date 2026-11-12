local BasePanel = require("GameCore.UI.BasePanel")
local CharEquipmentPanel = class("CharEquipmentPanel", BasePanel)
CharEquipmentPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharEquipmentPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharEquipmentCtrl"
  }
}

function CharEquipmentPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
  end
end

function CharEquipmentPanel:OnEnable()
end

function CharEquipmentPanel:OnDisable()
end

function CharEquipmentPanel:OnDestroy()
end

function CharEquipmentPanel:OnRelease()
end

return CharEquipmentPanel
