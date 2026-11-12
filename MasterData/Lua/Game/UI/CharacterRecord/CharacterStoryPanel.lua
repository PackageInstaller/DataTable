local BasePanel = require("GameCore.UI.BasePanel")
local CharacterStoryPanel = class("CharacterStoryPanel", BasePanel)
CharacterStoryPanel._bIsMainPanel = false
CharacterStoryPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharacterStoryPanel.prefab",
    sCtrlName = "Game.UI.CharacterRecord.CharacterStoryCtrl"
  }
}

function CharacterStoryPanel:Awake()
end

function CharacterStoryPanel:OnEnable()
end

function CharacterStoryPanel:OnDisable()
end

function CharacterStoryPanel:OnDestroy()
end

function CharacterStoryPanel:OnRelease()
end

return CharacterStoryPanel
