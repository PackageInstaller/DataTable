local StarTowerBuildBriefPanel = class("StarTowerBuildBriefPanel", BasePanel)
StarTowerBuildBriefPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBuild/StarTowerBuildBriefPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildBriefCtrl"
  }
}

function StarTowerBuildBriefPanel:Awake()
  self.mapCacheFilter = {}
  self.tbOption = {
    AllEnum.ChooseOption.Char_Element
  }
  PlayerData.Filter:CacheFilterByOption(self.tbOption)
  PlayerData.Filter:Reset(self.tbOption)
end

function StarTowerBuildBriefPanel:OnEnable()
end

function StarTowerBuildBriefPanel:OnDisable()
end

function StarTowerBuildBriefPanel:OnDestroy()
  PlayerData.Filter:ResetCacheFilter()
end

function StarTowerBuildBriefPanel:OnRelease()
end

return StarTowerBuildBriefPanel
