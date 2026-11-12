local BasePanel = require("GameCore.UI.BasePanel")
local CharAdvancePreviewInfoPanel = class("CharAdvancePreviewInfoPanel", BasePanel)
CharAdvancePreviewInfoPanel._bIsMainPanel = false
CharAdvancePreviewInfoPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharAdvancePreviewInfoPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharAdvancePreviewInfoCtrl"
  }
}

function CharAdvancePreviewInfoPanel:Awake()
end

function CharAdvancePreviewInfoPanel:OnEnable()
end

function CharAdvancePreviewInfoPanel:OnDisable()
end

function CharAdvancePreviewInfoPanel:OnDestroy()
end

function CharAdvancePreviewInfoPanel:OnRelease()
end

return CharAdvancePreviewInfoPanel
