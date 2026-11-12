local SubSkillDisplayPanel = class("SubSkillDisplayPanel", BasePanel)
SubSkillDisplayPanel._bIsMainPanel = false
SubSkillDisplayPanel._tbDefine = {
  {
    sPrefabPath = "Battle/SubSkillDisplay_forActor2dEditor.prefab"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}
if RUNNING_ACTOR2D_EDITOR ~= true then
  table.remove(SubSkillDisplayPanel._tbDefine, 1)
end

function SubSkillDisplayPanel:Awake()
end

function SubSkillDisplayPanel:OnEnable()
end

function SubSkillDisplayPanel:OnAfterEnter()
end

function SubSkillDisplayPanel:OnDisable()
end

function SubSkillDisplayPanel:OnDestroy()
end

function SubSkillDisplayPanel:OnRelease()
end

return SubSkillDisplayPanel
