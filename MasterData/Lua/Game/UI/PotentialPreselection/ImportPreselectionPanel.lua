local BasePanel = require("GameCore.UI.BasePanel")
local ImportPreselectionPanel = class("ImportPreselectionPanel", BasePanel)
ImportPreselectionPanel._bIsMainPanel = false
ImportPreselectionPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
ImportPreselectionPanel._tbDefine = {
  {
    sPrefabPath = "PotentialPreselection/ImportPreselectionPanel.prefab",
    sCtrlName = "Game.UI.PotentialPreselection.ImportPreselectionCtrl"
  }
}

function ImportPreselectionPanel:Awake()
end

function ImportPreselectionPanel:OnEnable()
end

function ImportPreselectionPanel:OnDisable()
end

function ImportPreselectionPanel:OnDestroy()
end

function ImportPreselectionPanel:OnRelease()
end

return ImportPreselectionPanel
