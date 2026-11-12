local RaidPanel = class("RaidPanel", BasePanel)
RaidPanel._bIsMainPanel = false
RaidPanel._tbDefine = {
  {
    sPrefabPath = "Raid/RaidPanel.prefab",
    sCtrlName = "Game.UI.Raid.RaidCtrl"
  }
}

function RaidPanel:Awake()
end

function RaidPanel:OnEnable()
end

function RaidPanel:OnDisable()
end

function RaidPanel:OnDestroy()
end

return RaidPanel
