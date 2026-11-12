local SideBanner = class("SideBanner", BasePanel)
SideBanner._sSortingLayerName = AllEnum.SortingLayerName.Overlay
SideBanner._bAddToBackHistory = false
SideBanner._tbDefine = {
  {
    sPrefabPath = "SideBanner/SideBannerPanel.prefab",
    sCtrlName = "Game.UI.SideBanner.SideBannerCtrl"
  }
}

function SideBanner:Awake()
end

function SideBanner:OnEnable()
end

function SideBanner:OnDisable()
end

function SideBanner:OnDestroy()
end

return SideBanner
