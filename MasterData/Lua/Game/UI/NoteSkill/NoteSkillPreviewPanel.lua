local NoteSkillPreviewPanel = class("NoteSkillPreviewPanel", BasePanel)
NoteSkillPreviewPanel._bIsMainPanel = false
NoteSkillPreviewPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
NoteSkillPreviewPanel._tbDefine = {
  {
    sPrefabPath = "NoteSkill/NoteSkillPreviewPanel.prefab",
    sCtrlName = "Game.UI.NoteSkill.NoteSkillPreviewCtrl"
  }
}

function NoteSkillPreviewPanel:Awake()
end

function NoteSkillPreviewPanel:OnEnable()
end

function NoteSkillPreviewPanel:OnDisable()
end

function NoteSkillPreviewPanel:OnDestroy()
end

return NoteSkillPreviewPanel
