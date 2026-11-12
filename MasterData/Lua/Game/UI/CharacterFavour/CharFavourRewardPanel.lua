local BasePanel = require("GameCore.UI.BasePanel")
local CharFavourRewardPanel = class("CharFavourRewardPanel", BasePanel)
CharFavourRewardPanel._bIsMainPanel = false
CharFavourRewardPanel._tbDefine = {
  {
    sPrefabPath = "CharacterFavour/CharFavourRewardPanel.prefab",
    sCtrlName = "Game.UI.CharacterFavour.CharFavourRewardCtrl"
  }
}

function CharFavourRewardPanel:Awake()
end

function CharFavourRewardPanel:OnEnable()
end

function CharFavourRewardPanel:OnDisable()
end

function CharFavourRewardPanel:OnDestroy()
end

function CharFavourRewardPanel:OnRelease()
end

return CharFavourRewardPanel
