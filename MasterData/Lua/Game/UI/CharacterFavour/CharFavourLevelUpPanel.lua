local BasePanel = require("GameCore.UI.BasePanel")
local CharFavourLevelUpPanel = class("CharFavourLevelUpPanel", BasePanel)
CharFavourLevelUpPanel._bIsMainPanel = false
CharFavourLevelUpPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
CharFavourLevelUpPanel._tbDefine = {
  {
    sPrefabPath = "CharacterFavour/CharFavourLevelUpPanel.prefab",
    sCtrlName = "Game.UI.CharacterFavour.CharFavourLevelUpCtrl"
  }
}

function CharFavourLevelUpPanel:Awake()
end

function CharFavourLevelUpPanel:OnEnable()
end

function CharFavourLevelUpPanel:OnDisable()
end

function CharFavourLevelUpPanel:OnDestroy()
end

function CharFavourLevelUpPanel:OnRelease()
end

return CharFavourLevelUpPanel
