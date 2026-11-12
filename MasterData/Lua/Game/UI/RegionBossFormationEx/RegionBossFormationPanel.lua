local RegionBossFormationPanel = class("RegionBossFormationPanel", BasePanel)
RegionBossFormationPanel._tbDefine = {
  {
    sPrefabPath = "RegionBossFormationEx/RegionBossFormationPanel.prefab",
    sCtrlName = "Game.UI.RegionBossFormationEx.RegionBossFormationCtrl"
  }
}

function RegionBossFormationPanel:Awake()
  local nId = PlayerData.RogueBoss:GetRegionBossId()
end

function RegionBossFormationPanel:OnEnable(bPlayFadeIn)
end

function RegionBossFormationPanel:OnDisable()
end

function RegionBossFormationPanel:OnDestroy()
end

return RegionBossFormationPanel
