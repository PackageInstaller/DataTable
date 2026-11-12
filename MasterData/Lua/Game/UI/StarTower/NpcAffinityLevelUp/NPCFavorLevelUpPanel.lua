local BasePanel = require("GameCore.UI.BasePanel")
local NPCFavorLevelUpPanel = class("NPCFavorLevelUpPanel", BasePanel)
NPCFavorLevelUpPanel._bIsMainPanel = false
NPCFavorLevelUpPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
NPCFavorLevelUpPanel._tbDefine = {
  {
    sPrefabPath = "StarTower/NPCFavourLevelUpPanel.prefab",
    sCtrlName = "Game.UI.StarTower.NpcAffinityLevelUp.NPCFavorLevelUpCtrl"
  }
}

function NPCFavorLevelUpPanel:Awake()
end

function NPCFavorLevelUpPanel:OnEnable()
end

function NPCFavorLevelUpPanel:OnDisable()
end

function NPCFavorLevelUpPanel:OnDestroy()
end

function NPCFavorLevelUpPanel:OnRelease()
end

return NPCFavorLevelUpPanel
