local RogueBossSelectPanel = class("RogueBossSelectPanel", BasePanel)
RogueBossSelectPanel._tbDefine = {
  {
    sPrefabPath = "FRLevelSelectEx/RogueBossSelect.prefab",
    sCtrlName = "Game.UI.FixedRoguelikeLevelSelectEx.RogueBossSelectCtrl"
  }
}

function RogueBossSelectPanel:Awake()
end

function RogueBossSelectPanel:OnEnable()
end

function RogueBossSelectPanel:OnDisable()
end

function RogueBossSelectPanel:OnDestroy()
end

function RogueBossSelectPanel:OnRelease()
end

return RogueBossSelectPanel
