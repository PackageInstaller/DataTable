local CharPotentialPanel = class("CharPotentialPanel", BasePanel)
CharPotentialPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharPotentialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharPotentialCtrl"
  }
}

function CharPotentialPanel:Awake()
end

function CharPotentialPanel:OnEnable()
end

function CharPotentialPanel:OnDisable()
end

function CharPotentialPanel:OnDestroy()
end

return CharPotentialPanel
