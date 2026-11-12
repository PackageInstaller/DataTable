local BasePanel = require("GameCore.UI.BasePanel")
local CharacterRelationPanel = class("CharacterRelationPanel", BasePanel)
CharacterRelationPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharacterRelationPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharacterRelationCtrl"
  }
}

function CharacterRelationPanel:Awake()
end

function CharacterRelationPanel:OnEnable()
end

function CharacterRelationPanel:OnDisable()
end

function CharacterRelationPanel:OnDestroy()
end

function CharacterRelationPanel:OnRelease()
end

return CharacterRelationPanel
