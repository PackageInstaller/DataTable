local DictionaryFRPanel = class("DictionaryFRPanel", BasePanel)
DictionaryFRPanel._bIsMainPanel = false
DictionaryFRPanel._tbDefine = {
  {
    sPrefabPath = "Dictionary/DictionaryPanel.prefab",
    sCtrlName = "Game.UI.Dictionary.DictionaryCtrl"
  }
}

function DictionaryFRPanel:Awake()
  self.bStarTowerFastBattle = self:GetPanelParam()[1]
end

function DictionaryFRPanel:OnEnable()
end

function DictionaryFRPanel:OnDisable()
end

function DictionaryFRPanel:OnDestroy()
end

return DictionaryFRPanel
