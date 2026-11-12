local NoteSkillPanel = class("NoteSkillPanel", BasePanel)
NoteSkillPanel._bIsMainPanel = false
NoteSkillPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
NoteSkillPanel._tbDefine = {
  {
    sPrefabPath = "NoteSkill/NoteSkillPanel.prefab",
    sCtrlName = "Game.UI.NoteSkill.NoteSkillCtrl"
  }
}

function NoteSkillPanel:Awake()
end

function NoteSkillPanel:OnEnable()
end

function NoteSkillPanel:OnDisable()
end

function NoteSkillPanel:OnDestroy()
end

return NoteSkillPanel
