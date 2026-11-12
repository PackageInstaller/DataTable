local BasePanel = require("GameCore.UI.BasePanel")
local AffinityRewardPanel = class("AffinityRewardPanel", BasePanel)
AffinityRewardPanel._bIsMainPanel = false
AffinityRewardPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBook/NpcAffinityRewardPanel.prefab",
    sCtrlName = "Game.UI.StarTowerBook.Affinity.AffinityRewardCtrl"
  }
}

function AffinityRewardPanel:Awake()
end

function AffinityRewardPanel:OnEnable()
end

function AffinityRewardPanel:OnDisable()
end

function AffinityRewardPanel:OnDestroy()
end

function AffinityRewardPanel:OnRelease()
end

return AffinityRewardPanel
