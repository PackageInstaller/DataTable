local PotentialPreselectionPanel = class("PotentialPreselectionPanel", BasePanel)
PotentialPreselectionPanel._tbDefine = {
  {
    sPrefabPath = "PotentialPreselection/PotentialPreselectionListPanel.prefab",
    sCtrlName = "Game.UI.PotentialPreselection.PotentialPreselectionCtrl"
  }
}

function PotentialPreselectionPanel:Awake()
  self.mapCacheFilter = {}
  self.tbOption = {
    AllEnum.ChooseOption.Char_Element
  }
  PlayerData.Filter:CacheFilterByOption(self.tbOption)
  PlayerData.Filter:Reset(self.tbOption)
end

function PotentialPreselectionPanel:OnEnable()
end

function PotentialPreselectionPanel:OnDisable()
end

function PotentialPreselectionPanel:OnDestroy()
  PlayerData.Filter:ResetCacheFilter()
end

return PotentialPreselectionPanel
