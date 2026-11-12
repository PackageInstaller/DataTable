local BuildModifierNotePanel = class("BuildModifierNotePanel", BasePanel)
BuildModifierNotePanel._tbDefine = {
  {
    sPrefabPath = "BuildFunction/BuildModifierMusicPanel.prefab",
    sCtrlName = "Game.UI.BuildModifier.Note.BuildModifierNoteCtrl"
  }
}

function BuildModifierNotePanel:Awake()
  self.bHasData = false
end

function BuildModifierNotePanel:OnEnable()
end

function BuildModifierNotePanel:OnAfterEnter()
end

function BuildModifierNotePanel:OnDisable()
end

function BuildModifierNotePanel:OnDestroy()
end

function BuildModifierNotePanel:OnRelease()
end

return BuildModifierNotePanel
