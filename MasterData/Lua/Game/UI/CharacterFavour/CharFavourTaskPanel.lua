local BasePanel = require("GameCore.UI.BasePanel")
local CharFavourTaskPanel = class("CharFavourTaskPanel", BasePanel)
CharFavourTaskPanel._bIsMainPanel = false
CharFavourTaskPanel._tbDefine = {
  {
    sPrefabPath = "CharacterFavour/CharFavourTaskPanel.prefab",
    sCtrlName = "Game.UI.CharacterFavour.CharFavourTaskCtrl"
  }
}

function CharFavourTaskPanel:Awake()
end

function CharFavourTaskPanel:OnEnable()
end

function CharFavourTaskPanel:OnDisable()
end

function CharFavourTaskPanel:OnDestroy()
end

function CharFavourTaskPanel:OnRelease()
end

return CharFavourTaskPanel
