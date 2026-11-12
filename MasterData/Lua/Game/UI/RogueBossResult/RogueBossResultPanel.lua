local RogueBossResultPanel = class("RogueBossResultPanel", BasePanel)
RogueBossResultPanel._bAddToBackHistory = false
RogueBossResultPanel._tbDefine = {
  {
    sPrefabPath = "RogueBossResult/RogueBossResultPanel.prefab",
    sCtrlName = "Game.UI.RogueBossResult.RogueBossResultCtrl"
  }
}

function RogueBossResultPanel:Awake()
end

function RogueBossResultPanel:OnEnable()
end

function RogueBossResultPanel:OnDisable()
end

function RogueBossResultPanel:OnDestroy()
end

return RogueBossResultPanel
