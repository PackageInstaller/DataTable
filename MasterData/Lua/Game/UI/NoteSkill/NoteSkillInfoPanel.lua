local NoteSkillInfoPanel = class("NoteSkillInfoPanel", BasePanel)
NoteSkillInfoPanel._bIsMainPanel = false
NoteSkillInfoPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
NoteSkillInfoPanel._tbDefine = {
  {
    sPrefabPath = "NoteSkill/NoteSkillInfoPanel.prefab",
    sCtrlName = "Game.UI.NoteSkill.NoteSkillInfoCtrl"
  }
}

function NoteSkillInfoPanel:Awake()
end

function NoteSkillInfoPanel:OnEnable()
end

function NoteSkillInfoPanel:OnDisable()
end

function NoteSkillInfoPanel:OnDestroy()
end

return NoteSkillInfoPanel
